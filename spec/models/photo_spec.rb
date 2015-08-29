# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  caption    :string(255)
#  data       :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe '#my_photos' do
    before do
      stub_const("Photo::PHOTOS_PER_PAGE", 9)
    end
    let!(:user1) { create(:user, :email => 'test@test.com')}
    let!(:user2) { create(:user, :email => 'test2@test.com')}
    let!(:photos1) { create_list(:photo, 10, :user => user1)}
    let!(:photos2) { create_list(:photo, 5, :user => user2)}
    it "returns user photos" do
      photos_1_page_1 = Photo.my_photos(user1, {:page => 1})
      photos_1_page_2 = Photo.my_photos(user1, {:page => 2})
      expect(photos_1_page_1.to_a.size).to eq(9)
      expect(photos_1_page_2.to_a.size).to eq(1)
    end 
  end
end
