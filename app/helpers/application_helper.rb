module ApplicationHelper

  include AutoHtml

  def js(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end

  def title_for(title)
    if title.empty?
      'Свидания без слов в Питере'
    else
      "#{title} | Свидания без слов в Питере"
    end
  end

  def meta_description_for(meta_description)
    # title, keywords, separator
    display_meta_tags({ description: meta_description })
  end

end
