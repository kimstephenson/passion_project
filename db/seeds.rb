User.destroy_all
Instrument.destroy_all
Genre.destroy_all

instruments = ["Piano", "Bass", "Drums", "Guitar", "Vocals", "Saxophone", "Trumpet", "Trombone", "Violin", "Cello", "Keyboard", "Banjo", "Percussion"].sort
genres = ["Rock", "Pop", "R&B", "Hip-Hop", "Jazz", "Funk", "Folk", "Country", "Punk", "Metal", "Classical", "Latin", "Reggae", "Electronic"].sort

instruments.each do |i|
  Instrument.create(name: i)
end

genres.each do |g|
  Genre.create(name: g)
end

20.times do
  user = User.new(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email)
  user.password = "password"
  user.zip_code = ["90037", "90302", "90018", "90210", "90723"].sample
  user.city_state
  2.times { user.instruments << Instrument.all.sample }
  2.times { user.genres << Genre.all.sample }
  user.save
end
