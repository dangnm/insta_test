class User < ActiveRecord::Base
  class FollowedEmaiNotifier < Decorator 
    def follow!(other_user)
      super
      begin
        UserMailer.follower(other_user, self).deliver
      rescue => e
        Rails.logger.error e.message
      end
    end
  end
end