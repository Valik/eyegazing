$(document).ready ->
  $.each $('.articles .article > .text > .body'), (index, element) ->
    html = $(element).html()
    article_id = html.match /\{{article=(\d+)}}/
    if article_id?
      $(element).html(
        html.replace(/{{article=\d+}}/,
          "... <div class='read-all'><a data-method='get' data-remote='true' data-type='json' href='/articles/#{article_id[1]}'>Читать полностью</a></div>"
        )
      )
      $(element).find('.read-all > a')
        .on 'ajax:success', (e,data,xhr) ->
          $(this).parent().remove()
          $(element).html(
            data.article.text
          )