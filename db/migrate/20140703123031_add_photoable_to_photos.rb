class AddPhotoableToPhotos < ActiveRecord::Migration
  def change
    add_reference :photos, :photoable, polymorphic: true, index: true
  end
end
