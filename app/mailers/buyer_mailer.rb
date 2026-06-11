class BuyerMailer < ApplicationMailer
  # Sent when an admin approves a buyer's account (OffDeal's "we'll notify you
  # when approved").
  def approved
    @user = params[:user]
    mail(to: @user.email_address, subject: "Your AcquireTMT buyer account is approved")
  end
end
