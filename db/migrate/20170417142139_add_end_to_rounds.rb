class AddEndToRounds < ActiveRecord::Migration[5.0]
  def change
    add_column :rounds, :end, :datetime, null: false, default: 0
  end
end
