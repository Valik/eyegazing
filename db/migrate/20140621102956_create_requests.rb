class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :name
      t.integer :age
      t.string :email
      t.date :party_date
      t.string :vk
      t.text :answer

      t.timestamps
    end
  end
end
