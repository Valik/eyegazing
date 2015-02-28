class AddMetaDescriptionToPages < ActiveRecord::Migration
  def change
    add_column :pages, :meta_description, :text, default: ''
    Page.create( name: '/informacionnaja-stranica' )
  end
end
