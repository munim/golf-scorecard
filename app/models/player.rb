class Player < ApplicationRecord
  belongs_to :address
  has_many :rounds, through: :groups
  has_many :player_sign_in_histories
  has_many :scores
  has_many :groups

  def get_in_progress_rounds
    self.rounds.where
  end
end
