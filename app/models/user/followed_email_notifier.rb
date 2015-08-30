class User < ActiveRecord::Base
  class FollowedEmaiNotifier < Decorator 
    def follow!(other_user)
      super
      UserMailer.follower(other_user, self).deliver
    end
  end
end