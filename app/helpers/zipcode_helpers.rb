require 'httparty'

helpers do
  def zipcodes_in_range(zipcode)
    response = HTTParty.get("https://www.zipcodeapi.com/rest/#{ENV["ZIP_CODE_KEY"]}/radius.json/#{zipcode}/#{params[:distance]}/mile")
    JSON.parse(response.to_json)
  end

  def search_for_users
    data = zipcodes_in_range(current_user.zip_code)
    zip_code_info = data["zip_codes"]
    users = []
    distances = {}
    zip_code_info.each do |hash|
      users += User.where(zip_code: hash["zip_code"])
      distances[hash["zip_code"]] = hash["distance"]
    end
    if params[:instrument] != "all instruments"
    users = users.select { |user| user.instruments.include? Instrument.find_by(name: params[:instrument]) }
    end
    if params[:genre] != "all genres"
    users = users.select { |user| user.genres.include? Genre.find_by(name: params[:genre]) }
    end
    users_distances = {}
    users.each {|user| users_distances[user] = distances[user.zip_code]  }
    users_distances.sort_by(&:last).to_h
  end
end