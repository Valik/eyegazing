$(document).ready ->

  $('.albums #upload_form input#photo_form_file').change ->
    form = $(this).closest('form')
    formData = new FormData()
    $input = $(this)
    $.each $input[0].files, ( indx, elem ) ->
      formData.append('photo_form[file][]', elem)

    form.submit (e) ->
      e.preventDefault()
      window.throbber.appendTo( form[0] ).start()
      $.ajax form.prop('action'),
        asynchronous: true
        type: 'POST'
        dataType: 'json'
        data: formData
        contentType: false
        processData: false
        cache: false
        success: (data) ->
          $input.val('')
          $.each data.photos, ( indx, elem ) ->
            if $('.albums .photos-row').length is 0
              $('.albums .content h1.title').after( "<div class='photos-row'></div>" )

            $last_photos_row = $('.albums .photos-row').last()
            if $last_photos_row.children().length < 4
              $last_photos_row.append(
                "<div class='photo-container'><div class='photo'><div class='photo-inner-container'><a class='fancybox' rel='gallery1' href='#{elem.full}'><img src='#{elem.thumb}' alt=''/></div></div></div></div>"
              )
            else
              $last_photos_row
                .after(
                  "<div class='photos-row'></div>"
                )
                .next().append(
                  "<div class='photo-container'><div class='photo'><div class='photo-inner-container'><a class='fancybox' rel='gallery1' href='#{elem.full}'><img src='#{elem.thumb}' alt=''/></div></div></div></div>"
                )
          form.find( 'canvas' ).remove()

    form.submit()
    form.unbind()

  $( '.albums .form-video' )
    .on 'submit', (e) ->
      window.throbber.appendTo( $( this )[0] ).start()
    .on 'ajax:success', ( e,data,xhr ) ->
      $( this ).find( 'canvas' ).remove()
      window.flash_show data
      $( this ).find( 'input' ).val( '' )
      if $('.albums .photos-row').length is 0
        $('.albums .content h1.title').after( "<div class='photos-row'></div>" )

      $last_photos_row = $('.albums .photos-row').last()
      if $last_photos_row.children().length < 4
        $last_photos_row.append(
          "<div class='photo-container video-container'><div class='photo'><div class='photo-inner-container'><img alt='' src='#{data.video.thumb}'/> <div class='play'> <div class='triangle'/> </div> <div class='video' data-link='#{data.video.link}'/></div></div></div></div>"
        )
      else
        $last_photos_row
          .after(
            "<div class='photos-row'></div>"
          )
          .next().append(
            "<div class='photo-container video-container'><div class='photo'><div class='photo-inner-container'><img alt='' src='#{data.video.thumb}'/> <div class='play'> <div class='triangle'/> </div> <div class='video' data-link='#{data.video.link}'/></div></div></div></div>"
          )



  $('.albums .photo-container > a.delete')
    .on 'ajax:success', (e,data,xhr) ->
      switch data.status
         when 'photo-deleted', 'video-deleted'
          $(this).parent().remove()
          window.flash_show(data)
         when 'error' then window.flash_show(data)

  $( '.albums .videos .photo-container .photo' )
    .on 'click', ( e ) ->
      $( 'body' ).prepend(
        "<div id='overlay'/><div class='embed-video'>#{$( this ).find( '.video' ).data( 'link' )}</div>"
      )
      $( '#overlay' )
        .on 'click', ( e ) ->
          $( '.embed-video' ).remove()
          $( this ).remove()

  $('.albums .photo-container > a.photo-update')
    .on 'click', (e) ->
      photo_data = $(this).data()
      unless $('.albums > .content > .photos').children('.edit-inline-form')[0]
        $('.albums > .content > .photos').prepend(
          "<div class='edit-inline-form'>
            <input class='string optional' id='photo_name' maxlength='255' name='photo[name]' placeholder='Заголовок...' size='255' type='text'>
            <input id='photo_commit' name='commit' remote='true' type='submit' value='Сохранить'>
            <a>Закрыть</a>
          </div>"
        )
      $edit_inline_form = $('.albums > .content > .photos > .edit-inline-form')
      $edit_inline_form.find('input#photo_name').val(photo_data.name)

      $edit_inline_form.find('input#photo_commit').on 'click', (e) ->
        $.ajax "/photos/#{photo_data.id}",
          dataType: 'json'
          type: 'PATCH'
          data: { name: $edit_inline_form.find('input#photo_name').val() }
          success: (data) ->
            if data.status is 'success'
              photo = $(".albums > .content > .photos .photo-#{data.id}")
              photo.children('.title').text(data.name)
            window.flash_show(data)
            $edit_inline_form.remove()

      $edit_inline_form.children('a').on 'click', (e) -> $edit_inline_form.remove()


