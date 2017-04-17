class Course < ApplicationRecord
  has_many :rounds
  has_many :players, through: :groups
  has_many :holes
  belongs_to :address
end