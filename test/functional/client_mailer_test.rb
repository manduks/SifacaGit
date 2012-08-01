require 'test_helper'

class ClientMailerTest < ActionMailer::TestCase
  test "pdf_delivery" do
    mail = ClientMailer.pdf_delivery
    assert_equal "Pdf delivery", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
