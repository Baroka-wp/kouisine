class CreateRecettes < ActiveRecord::Migration[6.1]
  def change
    create_table :recettes do |t|
      t.string :name
      t.text :description
      t.string :recette_img
      t.string :origin
      t.string :video
      t.string :preparation
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
