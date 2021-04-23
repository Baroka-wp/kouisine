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
### Model : Task
"Task.new(task_name:string task_details:text task_statut:string task_priority:string)"

belongs_to:user
has_many:labels

| Colums | Description |
| --- | ----------- |
| task_name | string |
| task_detail | string |
| task_statut | string |
| task_priority | string |

### Model User
"User.new(name:string email:string password_digest:string image:text)"
has_many:tasks
| Colums | Description |
| --- | ----------- |
| name | string |
| email | string |
| image | text |
| password_digest | string |

### Model label
"Label.new(label_name:string)"
has_many:tasks
| Colums | Description |
| --- | ----------- |
| name | string |


https://docs.google.com/spreadsheets/d/1JXuHmEZwnLmIf3_dxLm9HMIyPFHt1mraqfHc7UOj7yE/edit?usp=sharing

* ## Gem to use
* carrierwave
* mini_magick
* devise
