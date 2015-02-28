class PaymentsController < ApplicationController

  # require 'rest_client'

  respond_to :html

  YANDEX_REDIRECT_URI = 'http://eyegazing.ru/payments/code'
  AMOUNT_OF_TICKET = '1000.00'

  def index
  end

  def pay_with_yandex_money
    api = YandexMoney::Api.new(
      client_id: ENV['YANDEX_CLIENT_ID'],
      redirect_uri: YANDEX_REDIRECT_URI,
      scope: "account-info operation-history payment-p2p.limit(1,750)"
    )
    auth_url = api.client_url
    redirect_to auth_url
  end

  def pay_with_card
    begin
      api = YandexMoney::Api.new(client_id: ENV['YANDEX_CLIENT_ID'])
      instance_id = api.get_instance_id # returns string, contains instance id

      api = YandexMoney::Api.new(
        client_id: ENV['YANDEX_CLIENT_ID'],
        instance_id: instance_id
      )

      response = api.request_external_payment({
        pattern_id: "p2p",
        to: ENV['RECIPIENT_WALLET'],
        amount_due: AMOUNT_OF_TICKET,
        message: "Оплата билета Свиданий без Слов. В сумму включена комиссия"
      })
      if response.status == "success"
        request_id = response.request_id
        api = YandexMoney::Api.new(instance_id: instance_id)
        result = api.process_external_payment({
          request_id: request_id,
          ext_auth_success_uri: "http://eyegazing.ru/payments/success",
          ext_auth_fail_uri: "http://eyegazing.ru/payments/fail"
        })
        redirect_to "#{result[:acs_uri]}?cps_context_id=#{result[:acs_params]['cps_context_id']}&paymentType=#{result[:acs_params]['paymentType']}"
      else
        redirect_to failed_payment_path
      end
    rescue
      redirect_to failed_payment_path
    end
  end

  def code
    api = YandexMoney::Api.new(
      client_id: ENV['YANDEX_CLIENT_ID'],
      redirect_uri: YANDEX_REDIRECT_URI
    )
    api.code = params[:code] # obtained code
    access_token = api.obtain_token ENV['YANDEX_CLIENT_SECRET']

    api = YandexMoney::Api.new(token: access_token) # TOKEN is obtained token
    account_info = api.account_info
    balance = account_info.balance # and so on

    request_options = {
        "pattern_id" => "p2p",
        "to" => ENV['RECIPIENT_WALLET'],
        "amount_due" => AMOUNT_OF_TICKET,
        "comment" => "Оплата билета Свидания без Слов. EyeGazing.ru",
        "message" => "Билет оплачен с кошелька: #{account_info.account}.",
        "label" => "EyeGazing.ru"
    };
    request_result = api.request_payment(request_options)
    # check status

    process_payment = api.process_payment({
        request_id: request_result.request_id,
        money_source: 'wallet'
    })
    # check result
    if process_payment.status == "success"
      redirect_to succeed_payment_path
    else
      redirect_to failed_payment_path
    end
  end

  def success
    flash[:notice] = 'Ты успешно оплатил свой билет. Жду твой email с темой "Оплатил билет", именем и фамилией.'
    redirect_to payments_path
  end

  def fail
    flash[:error] = 'При обработке оплаты произошла ошибка. Попробуй снова или свяжись со мной напрямую.'
    redirect_to payments_path
  end

end