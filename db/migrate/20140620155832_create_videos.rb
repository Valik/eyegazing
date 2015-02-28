class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :link
      t.string :name
      t.boolean :video_main

      t.timestamps
    end
  end
end
