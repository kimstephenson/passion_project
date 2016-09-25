helpers do
  def zipcode_to_citystate(zipcode)
    data = JSON.parse(open("https://www.zipcodeapi.com/rest/#{ENV["ZIP_CODE_KEY"]}/info.json/#{zipcode}/degrees").read)
    {city: data["city"], state: data["state"]}
  end
end