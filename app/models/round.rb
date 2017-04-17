class Round < ApplicationRecord
  belongs_to :course
  has_many :players, through: :groups
  has_many :groups
  has_many :scores

  def is_round_in_progress
    self.start > self.end
  end
end
