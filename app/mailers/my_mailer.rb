class MyMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.my_mailer.mail1.subject
  #
  def mail1 
    @greeting = "Hi"

    mail to: "ahmed.khaled94@hotmail.com" , from: 'no-rep' , subject: 'testing'
  end
end
