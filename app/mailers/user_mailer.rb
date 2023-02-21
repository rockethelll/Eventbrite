class UserMailer < ApplicationMailer
  default from: 'no-reply@monsite.fr'

  def welcome_email(user)
    @user = user
    mail(from: 'boite_poubelle@yopmail.com', to: 'rockethell@yopmail.com',
         subject: 'This is a nice welcome email')
  end
end
