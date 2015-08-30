module MailsHelper
  def user_name_or_email user
    return user.email if user.name.blank?
    user.name
  end
end