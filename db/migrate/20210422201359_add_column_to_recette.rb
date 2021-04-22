class AddColumnToRecette < ActiveRecord::Migration[6.1]
  def change
     add_column :recettes, :categorie, :string
     add_column :recettes, :ingredients, :string
  end
end
