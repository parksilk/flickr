class CreateAlbumsTable < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string  :title
      t.text    :description
      t.integer :user_id

      t.timestamps
    end
  end
end
