class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name, index: true, default: ''
      t.string :title, default: ''
      t.text :content, default: ''
      t.text :ps, default: ''
      t.string :sidebar_title, default: ''

      t.timestamps
    end
    Page.create( name: '/parties' )
    Page.create( name: '/', sidebar_title: 'Видео-отзывы' )
    Page.create( name: '/свидания-без-слов', sidebar_title: 'Видео-отзывы' )
    Page.create( name: '/подать-заявку' )
    Page.create( name: '/правила-свиданий-без-слов' )
    Page.create( name: '/что-тебя-ожидает' )
    Page.create( name: '/фото-и-видео-отчёты-и-отзывы-с-прошедших-свиданий-без-слов' )
  end
end
