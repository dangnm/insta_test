class UserMailer < ActionMailer::Base
  add_template_helper(MailsHelper)
  include MailsHelper

  default from: "from@example.com"

  def follower(followed_user, follower)
    @followed_user = followed_user
    @follower = follower
    mail(
      :from => "minhdang.net@gmail.com>",
      :to => @followed_user.email,
      :subject => "You have been followed by #{@follower.email}"
    )
  end
end
