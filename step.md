* `$ rails new kouisine -d postgresql`
* `$ rails db:create`

### ETAPE 1 CRUD USER
* `$ rails g model User name:string email:string password_digest:string`
* `rails db:migrate`

aller dans le fichier app/models/user.rb
ajouter les validations
    `validates :name, presence: true, length: { maximum: 30}`
    `before_validation { email.downcase! }`
    `validates :email, presence: true, length: { maximum: 255},`
                    ``format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }`
    `validates :password, presence: true, length: { minimum: 6 }`



mettre l'index sur le email pour garantir son unicite

`$ rails g migration add_index_to_users_email`
aller dans le fichier db/migration/la migration

modifier
    `def change`
     `add_index :users, :email, unique: true`
    `end`

`$ rails db:migrate`


mettre en place le systeme de hashage/ cryptage du mot de passe
en utilisation la gem 'bcrypt' et en appelant la la methode has_secure_password dans le models/user

/Gemfile
ajouter
`gem'bcrypt', '3.1.11'`
`$ bundle install`


faire `$ rails c `pour entrer dans la console et creer un nouvelle utilisateur

`$ rails c`
`> User.create(name: "test01", email: "test01@example.com", password: "test66")`


* Creer un controller pour user

`$ rails g controller users`
* ajouter dans le controller la logique


* creer les routes

config/routes.rb
`ressources :users, only: [:new, :show, :destroy, edit]`

* creer une vue
new.html.erb

* creer une vue pour le profil
show.html.erb


##ETAPE 2 : session logged_in

* Creer la fonction de connection en utilisant les cookies de session
* ## creer un controller de session

`$ rails g controller session new`


* le routage
`resources :sessions, only: [:new, :create, :destroy]`

* creer une vue pour new connection
vue/sessions/new.html.erb


### mise en place du systeme de connexion
app/controllers/application_controller.rb

`protect_from_forgery with: :exception`
`include SessionsHelper`


*creer le helper
app/helper/session_helper

`def current_user`
    `@current_user ||= User.find_by(id: session[:user_id])`
`end`

ajouter a sessions_controller la logique

`if user && user.authenticate(params[:session][:password])`
  `session[:user_id] = user.id`
  `redirect_to user_path(user.id)`
`else`
  `flash.now[:danger] = 'connection echouee'`
  `render:new`
`end`


ajouter les bouton login et logout
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

nous allons restreindre l'acces a certaines partie du site si l'utilisateur n'est pas connecter
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



## ETAPE 3 : RECETTE CRUD
$ rails g model Recette name:string description:text recette_img:string origin:string
categorie:string, ingredients:string, video:string preparation:string user:references

$ rails db:migrate


les validation pour les CreateRecettes
models/recettes.rb

le CRUD dans le controllers recettes
`$ rails g controller recettes index`

controllers/recettes_controller


* creer les routes pour recettes

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


# ETAPE 4 : categorie des recettes
$ `rails g migration AddColumnToRecette`

modifier la migration
`add_column :recettes, :categorie, :string`

$ `rails db:migrate`
