# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  photo_id   :integer
#  message    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  include SimpleHashtag::Hashtaggable
  belongs_to :user
  belongs_to :photo
  hashtaggable_attribute :message

  COMMENTS_PER_PAGE = 4

  def self.photo_comments(photo, params = {:page => 1})
    Comment.where(:photo_id => photo.try(:id))
           .paginate(:page => params[:page], :per_page => COMMENTS_PER_PAGE)
           .order(created_at: :desc).reverse
  end
end
