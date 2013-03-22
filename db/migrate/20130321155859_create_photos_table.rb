class CreatePhotosTable < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string  :title
      t.text    :description
      t.string  :photo_string
      t.integer :album_id

      t.timestamps
    end
  end
end
