class ProfileController < ApplicationController
  def index
  	@photos = Photo.where(:user_id => current_user.id)
  end

  def edit
  	@user = current_user
  	respond_to do |format|
			format.js
		end
  end
end
