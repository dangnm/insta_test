class AddWidthToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :width, :integer
  end
end
