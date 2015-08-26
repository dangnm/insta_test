class CommentsController < ApplicationController
	def create
		@photo_id = params[:comment][:photo_id]
		@comments = Comment.where(:photo_id => params[:comment][:photo_id])
		@comment = Comment.new(
			ActiveSupport::HashWithIndifferentAccess.new(params[:comment]))
		@comment.save
		respond_to do |format|
			format.js
		end
	end
end
