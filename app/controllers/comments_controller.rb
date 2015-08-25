class CommentsController < ApplicationController
	def create
		@comment = Comment.new(
			ActiveSupport::HashWithIndifferentAccess.new(params[:comment]))
		@comment.save
		redirect_to root_path
	end
end
