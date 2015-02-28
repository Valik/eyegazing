$ ->
  $('.welcome.pay ol > li a')
    .on 'click', (e) ->
      if $(this).data('content')?
        $('body').prepend("<div id='overlay'/>")
        $('.welcome.pay').prepend(
          "<div class='pay-description' style='display:none;'>#{$(this).data('content')}
            <a title='Close' class='fancybox-item fancybox-close'></a>
          </div>"
        )
        $('.pay-description').show(250)
        $('#overlay, .pay-description > .fancybox-item.fancybox-close').on 'click', ->
          $('#overlay, .pay-description').remove()
        $form = $('.pay-description form')
        if $form.length
          $form.find('input[name="authenticity_token"]').val $("meta[name='csrf-token']").attr("content")

          $form.on 'submit', (e) ->
            $amount = $(this).find('input.amount')
            if $amount.val().length
              $amount.val $amount.val().replace(",",".")
            else
              $(this).find('input.amount').css 'border', '1px solid red'
              e.preventDefault()
            return

