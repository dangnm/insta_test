class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true
      t.references :photo, index: true
      t.string :message

      t.timestamps
    end
  end
end
