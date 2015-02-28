class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.string :name
      t.text :description
      t.string :address
      t.text :ps
      t.date :date

      t.timestamps
    end
  end
end
