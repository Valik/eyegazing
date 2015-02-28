class AddPublishedAtToRecalls < ActiveRecord::Migration
  def change
    add_column :recalls, :published_at, :datetime
    add_index :recalls, :published_at
    Recall.all.each{ |r| r.update_attribute(:published_at, r.created_at)}
  end
end
