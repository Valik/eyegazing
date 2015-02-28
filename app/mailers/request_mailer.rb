class RequestMailer < ActionMailer::Base
  require 'open-uri'
  default from: "noreply@eyegazing.ru"

  def request_email(request)
  	@request = request
    attachments['photo_name'] = open(@request.photo.photo_url.split('?')[0]).read if @request.try(:photo)
    mail(to: 'eyegaz@gmail.com', subject: 'Новая заявка на сайте EyeGazing.ru')
  end

end
