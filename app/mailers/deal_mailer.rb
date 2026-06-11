class DealMailer < ApplicationMailer
  # Sent to a buyer when a newly listed deal matches their acquisition mandate.
  def new_match
    @user = params[:user]
    @deal = params[:deal]
    mail(to: @user.email_address,
         subject: "New TMT deal matching your mandate — #{@deal.title}")
  end
end
