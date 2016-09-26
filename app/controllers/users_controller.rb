get '/users' do
  data = zipcodes_in_range(current_user.zip_code)
  zip_code_info = data["zip_codes"]
  @users = []
  @distances = {}
  zip_code_info.each do |hash|
    @users += User.where(zip_code: hash["zip_code"])
    @distances[hash["zip_code"]] = hash["distance"]
  end
  if params[:instrument] != ""
    @users = @users.select { |user| user.instruments.include? Instrument.find_by(name: params[:instrument]) }
  end
  if params[:genre] != ""
    @users = @users.select { |user| user.genres.include? Genre.find_by(name: params[:genre]) }
  end
  if request.xhr?
    erb(:'/users/index', layout: false, locals: {users: @user, distances: @distances})
  else
    erb :'/users/index'
  end
end

get '/users/new' do
  erb :'/users/new'
end

post '/users' do
  if params[:password] != params[:confirm_pw]
    @errors = ["Passwords must match"]
    return erb :'/users/new'
  end
  user = User.new(params[:user])
  zipdata = zipcode_to_citystate(params[:user]["zip_code"])
  user.city = zipdata[:city]
  user.state = zipdata[:state]
  user.password = params[:password]
  if user.save
    session[:user_id] = user.id
    redirect "/users/#{user.id}"
  else
    @errors = user.errors.full_messages
    erb :'/users/new'
  end
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :'/users/show'
end

get '/users/:id/edit' do
  #form to edit your profile when logged in
end

put '/users/:id' do
  #edit your profile
  #redirect
end

delete '/users/:id' do
  #delete your own profile when logged in
end
