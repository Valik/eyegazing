class AddLandingToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :landing, :boolean, default: false
    add_index :videos, :landing
  end
end
