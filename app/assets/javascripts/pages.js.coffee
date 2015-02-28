$( document ).ready ->
  # window.wrap_zoom_on_image = (img) ->
  #   img = if typeof img isnt 'undefined'
  #     $(img)
  #   else
  #     $( 'img' )
  #   img
  #     .wrap( "<div class='zoom-on-img'></div>" )
  #     .after( "<div class='zoom-tool'/>" )
  #   $( '.zoom-on-img' )
  #     .on 'click', (e) ->
  #       $.getJSON "/photos/#{$(this).find('img').attr('src').match(/\/uploads\/photo\/photo\/(\d+)\//)[1]}", (data) ->
  #         src = data.photo_url
  #         $( 'body' ).prepend( "<div class='img-zoomed'><img src='#{ src }' style='max-width: 900px; max-height: 800px;'/></div>" )
  #         $('body .img-zoomed > img').css 'margin-left', "-#{ $('body .img-zoomed > img').width()/2 }px"
  #         $( 'body' ).prepend( "<div id='overlay' />" )
  #         $( '.img-zoomed' )
  #           .on 'click', (e) ->
  #             $( this ).remove()
  #             $( '#overlay' ).remove()
  #         $( '#overlay' )
  #           .on 'click', (e) ->
  #             $( this ).remove()
  #             $( '.img-zoomed' ).remove()
  # window.wrap_zoom_on_image()

