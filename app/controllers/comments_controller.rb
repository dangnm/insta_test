class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @photo = Photo.where(:id => params[:comment][:photo_id]).first
    @comment = Photo::NewCommentNotifier
                .new(@photo).add_comment(current_user, 
                                         params[:comment][:message])
    @comments = Comment.photo_comments(@photo, :page => 1)
    respond_to do |format|
      format.js
    end
  end

  def show_more_comments
    @photo = Photo.where(:id => params[:photo_id]).first
    @comments = Comment.photo_comments(@photo, :page => params[:page])
    @page = params[:page].to_i + 1
    respond_to do |format|
      format.js
    end
  end
end
