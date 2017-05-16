class UserMailer < ApplicationMailer
   default from: 'amy.ishikawa1996@gmail.com'
 
  def booking_email(user)
    @user = user
    @url  = 'http://example.com/login'
    # byebug
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end

