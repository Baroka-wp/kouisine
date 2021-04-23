class Recette < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :preparation, presence: true
  validates :origin, presence: true

  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
end
