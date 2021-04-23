#- [ ] TASK 1 : creer l'application

* `$ rails new kouisine -d postgresql`
* `$ rails db:create`

#- [ ] TASK 2 : CRUD USER
USER MODEL

* `$ rails g model User name:string email:string password_digest:string`
* `rails db:migrate`

#### app/models/user.rb
* ajouter les validations
* mettre l'index sur le email pour garantir son unicite
  `$ rails g migration add_index_to_users_email`
   db/migration/la migration
     `add_index :users, :email, unique: true`
     `$ rails db:migrate`

* mettre en place le systeme de hashage du mot de passe
en utilisation la `gem 'bcrypt'` et en appelant la la methode has_secure_password dans le models/user

#### /Gemfile
ajouter
`gem'bcrypt', '3.1.11'`

`$ bundle install`


* faire `$ rails c `pour entrer dans la console et creer un nouvelle utilisateur

`$ rails c`
`> User.create(name: "test01", email: "test01@example.com", password: "test66")`


USER CONTROLLER

`$ rails g controller users`
* ajouter dans le controller la logique

* creer les routes

#### config/routes.rb
`ressources :users, only: [:new, :show, :destroy, edit]`

* creer les vues
####vues/users/new.html.erb
####vues/users/show.html.erb


#- [ ] TASK 3: session logged_in
* Creer la fonction de connection en utilisant les cookies de session

SESSION CONTROLLER
`$ rails g controller session new`

SESSIONS ROUTES
`resources :sessions, only: [:new, :create, :destroy]`

SESSIONS VUE
vue/sessions/new.html.erb

* mise en place du systeme de connexion

app/controllers/application_controller.rb

`protect_from_forgery with: :exception`
`include SessionsHelper`

*creer le helper
app/helper/session_helper

def current_user
    @current_user ||= User.find_by(id: session[:user_id])
end

: ajouter a sessions_controller la logique

`if user && user.authenticate(params[:session][:password])`
  `session[:user_id] = user.id`
  `redirect_to user_path(user.id)`
`else`
  `flash.now[:danger] = 'connection echouee'`
  `render:new`
`end`


* ajouter les bouton login et logout
vue/layout/application.html.erb


<% if logged_in? %>
  <%= link_to "Profile", user_path(current_user.id) %>
  <%= link_to "Logout", session_path(current_user.id), method: :delete %>
<% else %>
  <%= link_to "S'incrire", new_user_path %>
  <%= link_to "Se connecter", new_session_path %>
<% end %>

* mettre en place la deconnexion
controller/sessions_controller

def destroy
    session.delete(:user_id)
end

* restreindre l'acces a certaines partie du site si l'utilisateur n'est pas connecter
il faut creer une fontion rediriger automatiquement vers la connection

controller/application_controller

before_action :login_required
  private
  def login_required
    redirect_to new_session_path unless current_user
  end


  controllers/ UsersController et controllers/sessions_controller
  pour ne pas verifier s'il est connecte
  ajouter `skip_before_action :login_required, only: [:new, :create]`
  (difference entre befors_action et skip_before_action)



#- [ ] TASK 4: : RECETTE CRUD
*RECETTE MODELS
$ rails g model Recette name:string description:text recette_img:string origin:string
categorie:string, ingredients:string, video:string preparation:string user:references

$ rails db:migrate


* les validation pour les CreateRecettes
models/recettes.rb


RECETTE CONTROLLERS
`$ rails g controller recettes index`

controllers/recettes_controller

RECETTE ROUTES
* creer les routes pour recettes


RECETTE VUES
* creer les vues
      *index
      *show
      *new
      *edit
      *_form

    ajouter les boutton pour supprimer et modifier dans show.html.erb
    ajouter le bouton new dans vue/layout/application.html.erb
    faire un test avec https://www.themealdb.com/api/json/v1/1/random.php


    si un user est conneceter il peut modifier les recettes des autres. pour prevenir ca,
    creer la fonction check user


#- [ ] TASK 5: FAVORITES association many to many
* creer un model qui va stocker les id des recettee favorite et les associer a l'id du users


$ rails g model favorite user_id:integer recette_id:integer
$ rails db:migrate

* modifier les association dans user models et recette models

$ rails g controller favorites

* creer les routes
config/routes

`resources :favorites, only: [:create, :destroy]`


* faire apparaitre le boutton favorites
dans vue/recette/recette.html.erb

* ecrire la logique de favorite
* creer un favorite def create
* creer un favorite def destroy


#- [ ] TASK 6: : Deployer sur heroku
'$ brew tap heroku/brew && brew install heroku'

* "loggin to heroku"

`$ heroku login`

* conmpile the assets of projet, verify to be in the projet repositoring

`$ rails assets:precompile RAILS_ENV=production`

* push the projet in github, verify the repositoring exist on github

`$ git add -A`
` $ git commit -m "projet commit"`

* create the application on heroku

`$ heroku create`

* Add Heroku build pack

`$ heroku buildpacks:set heroku/ruby`
`$ heroku buildpacks:add --index 1 heroku/nodejs`

* deply to heroku
`$ git push heroku master `

* Migrate database
`$ heroku run rails db:migrate`

* "Pour supprimer la base de données sur heroku, si vous utilisez SHARED_DATABASE_URL :"

`$ heroku pg:reset DATABASE_URL`

* Maintenant recréer la base de données :

`$ heroku run rake db:migrate`

"peupler la base de données avec vos données de graine:"

`$ heroku run rake db:seed`
