class ClientMailer < ActionMailer::Base
  default from: "waldix86@gmail.com"

  def pdf_delivery(client, folio, user)
    @client = client
    @folio = folio
    @user = user
    mail to: client.email, subject: "Factura Electronica"
  end
end
