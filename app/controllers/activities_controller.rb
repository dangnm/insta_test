class ActivitiesController < ApplicationController
  def index
    @activities = current_user.activities
    respond_to do |format|
      format.js
    end
  end
end
