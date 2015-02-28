class CreateRecalls < ActiveRecord::Migration
  def change
    create_table :recalls do |t|
      t.string :name
      t.string :email
      t.text :text
      t.boolean :published

      t.timestamps
    end
  end
end
