# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  created_at             :datetime
#  updated_at             :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  name                   :string(255)
#  gender                 :string(255)
#  bio                    :text
#  phone                  :string(255)
#  website                :string(255)
#  avatar                 :integer
#

class User < ActiveRecord::Base
	GENDER = {
    :male => "male",
    :female => "female"
  } 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  acts_as_reader

  ACTIVITIES_PER_PAGE = 5

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def activities(params = {:page => 1})
    Activity.joins("INNER JOIN comments 
                    ON activities.recipient_id = comments.id")
            .joins("INNER JOIN photos 
                    ON comments.photo_id = photos.id")
            .joins("INNER JOIN users 
                    ON photos.user_id = users.id")
            .order("activities.created_at desc")
            .where("users.id = ?", id)
            .where("activities.owner_type = ?", "User") 
            .select("activities.*, 
                    photos.id as photo_id,
                    photos.caption as photo_caption")
            .paginate(:page => params[:page], :per_page => ACTIVITIES_PER_PAGE)
  end

  def crop_photo(photo, crop_x, crop_y, crop_w, crop_h)
    photo = Photo.find_by_id_and_user_id(photo.id, id)
    photo.data_crop_x = crop_x
    photo.data_crop_y = crop_y
    photo.data_crop_w = crop_w
    photo.data_crop_h = crop_h
    photo.data = photo.data.file
    photo.save
    photo
  end
end
