class Photo < ActiveRecord::Base
  class NewCommentNotifier < Decorator 
    def add_comment(commenter, message)
      comment = super
      comment.create_activity(action: :create, 
                              owner: comment.user,
                              recipient: comment)
    end
  end
end