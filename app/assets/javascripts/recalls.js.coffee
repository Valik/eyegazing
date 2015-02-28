$( document ).ready ->

  $recalls = $( '.recalls.recalls-moderation > .content > .recalls-list > .body > .recall' )
  $recalls.find( 'a.show' )
    .on 'ajax:beforeSend', (xhr, settings) ->
      settings.abort() if $( this ).siblings().is( '.text-showed' )
    .on 'ajax:success', (e,data,xhr) ->
      $( this ).parent().siblings().find( '.text-showed' ).slideUp( 'fast', (e) ->
        $( this ).remove() )
      $( this ).parent().append("<div class='text-showed'>#{data.text}</div>")
      $( this ).siblings( '.text-showed' ).slideDown( 'fast' )


  $recalls.find( '.published > input#published' )
    .on 'change', ( e ) ->
      $.ajax
        url: "/recalls/#{$( this ).siblings().val()}"
        type: 'patch'
        dataType: 'json'
        data: { recall: { published: $(this).is(':checked') } }
        success: ( data ) ->
          window.flash_show( data )

  $recalls.find( 'a.delete' )
    .on 'ajax:success', ( e,data,xhr ) ->
      $( this ).parent().parent().slideUp( 'fast', () ->
        $( this ).remove() )

  $recalls.find( '> .date' )
    .on 'click', (e) ->
      $old_date = $(this)
      unless $('.recalls > .content > .recalls-list').children('.edit-inline-form')[0]
        # <div class='input datepicker required recall_date'>
        #   <input aria-required='true' class='datepicker required hasDatepicker' id='recall_date' name='recall[date]' placeholder='Выберите дату...' required='required' type='text'>
        #   <input class='date-alt' id='recall_date' name='recall[date]' type='hidden' value=''>
        # </div>
        $('.recalls > .content > .recalls-list').prepend(
          "<div class='edit-inline-form'>
            <input class='string optional' id='recall_date' maxlength='255' name='recall[date]' placeholder='Заголовок...' size='255' type='text'>
            <input id='recall_commit' name='commit' remote='true' type='submit' value='Сохранить'>
            <a>Закрыть</a>
          </div>"
        )
      $edit_inline_form = $('.recalls > .content > .recalls-list > .edit-inline-form')
      $edit_inline_form.find('input#recall_date').val $old_date.text()
      $edit_inline_form.find('input#recall_date').datepicker()

      $edit_inline_form.find('input#recall_commit').off 'click'
      $edit_inline_form.find('input#recall_commit').on 'click', (e) ->
        $.ajax "/recalls/#{$old_date.data('id')}",
          dataType: 'json'
          type: 'PATCH'
          data: { recall: { published_at: $edit_inline_form.find('input#recall_date').val() } }
          success: (data) ->
            if data.status is 'recall-updated' then $old_date.text(data.date)
            window.flash_show(data)
            $edit_inline_form.remove()

      $edit_inline_form.children('a').on 'click', (e) ->
        $edit_inline_form.remove()


