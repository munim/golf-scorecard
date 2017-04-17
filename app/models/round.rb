class Round < ApplicationRecord
  belongs_to :course
  has_many :players, through: :groups
  has_many :groups
  has_many :scores
#  has_many :players, through: :groups
end