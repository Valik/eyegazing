$ ->
  $('.flash > .flash-body').delay(5000).fadeOut 400, () ->
    $('.flash').css('z-index', '-1').unbind()
  $('.flash .close').click ->
    $('.flash').fadeOut 400, () ->
      $('.flash').css('z-index', '-1')

  window.flash_show = (data) ->
    border = "1px solid "
    if data.status.match /error/
      border += "red"
    else if data.status.match /created|updated/
      border += "green"
    else
      border += "rgba(238, 143, 72, .8)"
    border += "!important"

    $('.flash').css('z-index', '10000').show()
      .html("<div class='flash-body' style='border:#{border};'><div class='text'>#{data.status_text}</div><div class='close close-small'><div class='x'/><div class='y'/></div></div>")

    fadeFlash = () ->
      $('.flash').fadeOut 400, () ->
        $(this).css('z-index', '-1').unbind()
    timer = setTimeout( fadeFlash, 5000 )

    $('.flash .close').click ->
      clearTimeout(timer)
      $(this).parent().parent().fadeOut 400, () ->
        $(this).css('z-index', '-1')

  $('.fancybox').fancybox
    openEffect: 'none'
    closeEffect: 'none'

  window.throbber = Throbber({
    color: 'rgba(255, 255, 255, 1)'
    size: 30
    fade: 200
    padding: 15
  })

  $( '.welcome .video.video-main' ).find( 'img, .play' )
    .on 'click', ( e ) ->
      $video_main = $( '.welcome .video.video-main' )
      $video_main.addClass('playing')
      $video_main.find('.play').hide()
      $video_main.append "<div class='main-embed-video'>#{$( this ).siblings( '.video' ).data( 'link' )}</div>"


  $( '.welcome .video-small' )
    .on 'click', ( e ) ->
      $main_video = $( '.welcome .video.video-main iframe' )
      if $main_video.parent().parent().parent().hasClass 'playing'
        src = $main_video.attr 'src'
        $main_video.attr 'src', ''
      $( 'body' ).prepend(
        "<div id='overlay'/><div class='embed-video'>#{$( this ).find( '.video' ).data( 'link' )}</div>"
      )
      $( '#overlay' )
        .on 'click', ( e ) ->
          $( '.embed-video' ).remove()
          $( this ).remove()
          if $main_video.parent().parent().parent().hasClass 'playing'
            $main_video.attr 'src', src


  window.validateEmail = (email) ->
    re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    return re.test(email)

  $('.welcome.landing form')
    .on 'submit', (e) ->
      $.each $(this).find('input').not('#b_4bf0869d20f3e9481c368cd3b_fbe2cbfa25'), (indx) ->
        if $(this).attr('id') is 'EMAIL'
          match = window.validateEmail $(this).val()
          if match
            $(this).css 'border-color', 'rgba( 217,217,217,1 )'
          else
            $(this).css 'border-color', 'red'
            e.preventDefault()
        else if $(this).val() is ''
          $(this).css 'border-color', 'red'
          e.preventDefault()
        else
          $(this).css 'border-color', 'rgba( 217,217,217,1 )'
