class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :author
      t.string :subject
      t.text :text
      t.string :question

      t.timestamps
    end
  end
end
