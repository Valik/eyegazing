class AddDefaultNameToPhotos < ActiveRecord::Migration
  def up
    change_column :photos, :name, :string, default: ''
  end

  def down
    change_column :photos, :name, :string, default: nil
  end
end
