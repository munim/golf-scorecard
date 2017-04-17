class
InitialSchema < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :username, limit: 16, null: false
      t.string :first_name, limit: 20
      t.string :last_name, limit: 20
      t.string :email, limit: 50, null: false
      t.string :password
      t.date :date_of_birth
      t.datetime :account_created
      t.references :address
      
      t.timestamps
    end

    add_index :players, :username, unique: true
    add_index :players, :email, unique: true

    create_table :player_sign_in_histories do |t|
      t.references :player
      t.datetime :sign_in_time
      t.datetime :sign_out_time
      t.string :ip, limit: 15
    end

    create_table :addresses do |t|
      t.string :street_1
      t.string :street_2
      t.string :city
      t.string :state
      t.string :post_code
      t.string :country
      t.string :location
    end

    create_table :courses do |t|
      t.string :name
      t.references :address
      t.integer :total_holes, limit: 1
      t.integer :par, limit: 1
    end

    create_table :holes do |t|
      t.references :course
      t.integer :hole_no, limit: 1
      t.integer :par, limit: 1
      t.integer :stroke_index, limit: 1
      t.integer :length, limit: 2
    end

    create_table :rounds do |t|
      t.datetime :start, null: false
      t.references :course
    end

    create_join_table :players, :rounds, table_name: :groups

    create_table :scores do |t|
      t.references :round
      t.references :player
      t.references :hole
      t.integer :shots, limit: 1
      t.integer :putts, limit: 1
      t.datetime :input_time
    end
  end
end
