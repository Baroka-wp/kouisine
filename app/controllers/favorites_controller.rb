class FavoritesController < ApplicationController
  def create
   favorite = current_user.favorites.create(recette_id: params[:recette_id])
   redirect_to recettes_path
 end
 def destroy
   favorite = current_user.favorites.find_by(id: params[:id]).destroy
   redirect_to recettes_path
 end
end
