require 'Faker'

User.destroy_all

instruments = ["piano", "bass", "drums", "guitar", "vocals", "saxophone", "trumpet", "trombone", "violin", "cello", "keyboard", "banjo"].sort
genres = ["rock", "pop", "r&b", "hip-hop", "jazz", "funk", "folk", "country", "punk", "metal", "classical", "latin"].sort

instruments.each do |i|
  Instrument.create(name: i)
end

genres.each do |g|
  Genre.create(name: g)
end

10.times do
  user = User.new(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email)
  user.password = "password"
  user.zip_code = ["90037", "90302", "90018", "90210", "90723"].sample
  user.city_state
  2.times { user.instruments << Instrument.all.sample }
  2.times { user.genres << Genre.all.sample }
  user.save
end
