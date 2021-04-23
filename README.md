# README
## version
ruby 2.6.5 rails 6.0.3 postgresql : 13.0.1
## Apropos
Kouisine est une application de partage de recette de cuisine entre les utiisateur. Pour participer au rayonnement de la culture Beninoise.

* ## Liste des fonctions
- [ ] fonction d'enregistrement des utilisateurs (nom, email, mot de passe)
 - [ ] login function ( email , password)
    - [ ] resume des recettes publiees par un utilisateur
    - [ ] un utilisateur peut avoir des recettes favories
- [ ] CRUD pour les recettes
- [ ] Random recette (Recette du jour)
- [ ] page de details des recttes( image, description, ingredients, temps de preparation, video youtube)

* ## template :
https://www.uidesigndaily.com/posts/sketch-website-section-day-1228

* ## Catalogue conceptuel

# App schema
### Model : recette

belongs_to:user
has_many:favorites

| Colums | Description |
| --- | ----------- |
| name | string |
| description | string |
| recette_img | string |
| origin | string |
| categorie | string |
| ingredients | string |
| video | string |
| preparation | string |



### Model : User

has_many:recette
has_many:favorite

| Colums | Description |
| --- | ----------- |
| name | string |
| email | string |

| password_digest | string |

### Model favorites

has_many:tasks
| Colums | Description |
| --- | ----------- |
| user_id | integer |
| recette_id | integer |


https://docs.google.com/spreadsheets/d/1JXuHmEZwnLmIf3_dxLm9HMIyPFHt1mraqfHc7UOj7yE/edit?usp=sharing

* ## Gem to use
* carrierwave
* mini_magick
* devise
