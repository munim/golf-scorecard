class Score < ApplicationRecord
  belongs_to :hole
  belongs_to :player
  belongs_to :round

end