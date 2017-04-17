# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Player.delete_all
Address.delete_all
Course.delete_all
Hole.delete_all

def get_address
  fake_address = Faker::Address
  Address.new(
      :street_1 => "#{fake_address.secondary_address}, #{fake_address.street_address}",
      :street_2 => fake_address.street_name,
      :city => fake_address.unique.city,
      :state => fake_address.unique.state,
      :post_code => fake_address.postcode,
      :country => fake_address.country,
      :location => "#{fake_address.latitude},#{fake_address.longitude}"
  )
end

courses = []

10.times do
  hole_count = [9, 18].sample
  hole_par = [4, 4, 5, 3, 4, 4, 5, 4, 3].shuffle
  hole_par = [hole_par.shuffle, hole_par.shuffle]


  puts '[INFO] Creating address'
  address = get_address

  puts '[INFO] Creating course'
  course = Course.new(
              :name => "#{address.state} Golf Club",
              :address => address,
              :total_holes => hole_count,
              :par => hole_count == 18 ? 72 : 9
          )
  puts '[INFO] Saving course'
  course.save!

  courses.push(course)

  par_range = { 3 => 170, 4 => 300, 5 => 450 }

  (0..hole_count - 1).each do |i|
    puts "[INFO] Creating hole #{i} of #{hole_count}"
    par = hole_par[i / 9][i % 9]
    Hole.create!(
            :course => course,
            :par => par,
            :hole_no => i + 1,
            :stroke_index => (5..9).to_a.sample,
            :length => Faker::Number.between(par_range[par] - 50, par_range[par] + 50)
    )
  end
end

players = []
10.times do |i|
  puts "[INFO] Creating player #{i}"

  first_name = Faker::Name.unique.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.free_email("#{first_name}.#{last_name}")

  address = get_address
  address.save!

  player = Player.create!(
      :username => first_name.downcase,
      :first_name => first_name,
      :last_name => last_name,
      :email => email,
      :password => '123',
      :date_of_birth => Faker::Date.between(70.years.ago, 7.years.ago),
      :account_created => Faker::Date.between(1.months.ago, Date.today),
      :address => address
  )

  players << player
end


courses[0, 4].each do |course|
  puts "[INFO] Looping through course: #{course.name}"
  (0..20).each do |r|
    shuffled_players = players.shuffle

    puts "[INFO] Creating rounds #{r} of 20"
    round = Round.create!(
             :course => course,
             :start => Faker::Date.between(2.years.ago, 1.months.ago)
    )

    (0..rand(3)).each do |g|
      round.players << shuffled_players[0]
      shuffled_players = shuffled_players[1, shuffled_players.size]
    end

    round.save!

    course.holes.each do |h|
      round.players.each do |p|
        rand_shot = {3 => rand(2..6), 4 => rand(3..8), 5 => rand(3..9)}
        rand_putts = rand 1..3
        Score.create!(
                 :round => round,
                 :player => p,
                 :hole => h,
                 :shots => rand_shot[h.par],
                 :putts => rand_putts,
        )
      end
    end

  end
end
