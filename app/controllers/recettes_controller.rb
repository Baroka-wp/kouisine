class RecettesController < ApplicationController
  skip_before_action :login_required, only: [:index, :show]
  before_action :set_recette, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update, :destroy]
  def index
    @recettes = Recette.all
    @user = User.all

  end

  def new
    @recette = Recette.new
  end

  def create
    #@recette = Recette.new (recette_params)
    #@recette.user_id = current_user.id
      @recette =current_user.recettes.build(recette_params)
      if @recette.save
      flash[:success] = 'recette publie avec succes !'
      redirect_to recettes_path
    else
      render :new
    end
  end

  def show
    if logged_in?
      favorite = current_user.favorites.find_by(recette_id: @recette.id)
    end

    if @recette.ingredients != nil
      @str_ingredients = @recette.ingredients
      @tableau_des_ingredients = @str_ingredients.split(',')
    end
  end

  def edit
  end

  def update
    if @recette.update(recette_params)
      flash[:success] = 'Recette mise a jour !'
      redirect_to recettes_path
    else
      render :edit
    end
  end

  def destroy
    @recette.destroy
    flash[:success] = 'recette supprimee!'
    redirect_to recettes_path
  end

  private

  def recette_params
    params.require(:recette).permit(:name,:description,:recette_img,:categorie,:ingredients, :origin, :video , :preparation)
  end

  def set_recette
   @recette = Recette.find(params[:id])
  end

  def check_user
   if current_user.id != @recette.user_id
     redirect_to recette_path
   end
  end

end
