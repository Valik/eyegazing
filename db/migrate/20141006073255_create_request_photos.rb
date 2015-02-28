class CreateRequestPhotos < ActiveRecord::Migration
  def change
    create_table :request_photos do |t|
      t.string :photo
      t.references :request, index: true

      t.timestamps
    end
    Photo.transaction do
      photos = Photo.where(photoable_type: 'Request')
      photos.each do |photo|
        RequestPhoto.create(request_id: photo.photoable_id, photo: photo.photo)
        photo.destroy
      end
    end
  end
end
