class AddHeightToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :height, :integer
  end
end
