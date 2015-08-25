class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :user, index: true
      t.string :caption
      t.column :data, :oid, :null => true
      t.timestamps
    end
  end
end
