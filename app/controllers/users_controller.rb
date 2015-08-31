class UsersController < ApplicationController
  before_action :authenticate_user!
  def update
  	@user = User.find_by_id(params[:id])
    @user.update_user(params[:user])
  	redirect_to profile_index_path
  end
end
