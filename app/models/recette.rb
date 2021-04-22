class Recette < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :preparation, presence: true
  validates :origin, presence: true
  
  belongs_to :user
end
