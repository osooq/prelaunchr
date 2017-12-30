class UserMailer < ActionMailer::Base
  default from: "Osooq.fr <welcome@osooq.fr>"

  def signup_email(user)
    @user = user
    @twitter_message = "#Osooq arrive! Dit le a tes amis et gagne avec @osooq."

    mail(:to => user.email, :subject => "Merci d'avoir rejoins osooq!")
  end
end
