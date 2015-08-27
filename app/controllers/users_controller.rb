class UsersController < ApplicationController
  before_action :authenticate_user!
  def update
  	@user = User.find_by_id(params[:id])
    @user.avatar = params[:user][:avatar]
  	@user.name = params[:user][:name]
  	@user.gender = params[:user][:gender]
  	@user.bio = params[:user][:bio]
  	@user.phone = params[:user][:phone]
  	@user.website = params[:user][:website]
  	@user.save

  	redirect_to profile_index_path
  end
end
