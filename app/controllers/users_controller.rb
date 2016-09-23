get '/users' do
  data = JSON.parse(open("https://www.zipcodeapi.com/rest/KCU6dzg4gdRJy4xhUBqypOe3w2nAhTX2wS9KrpOIDGscKZtFBUd1Is4fvrPNlNPS/radius.json/#{current_user.zip_code}/#{params[:distance]}/mile").read)
  zip_code_info = data["zip_codes"]
  users_in_range = []
  zip_code_info.each do |hash|
    users_in_range += User.where(zip_code: hash["zip_code"])
  end
  p users_in_range
  #display how far away user is?
  #get instrument & genre params
  erb :'/users/index'
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
  user.password = params[:password]
  if user.save
    session['user'] = user.id
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
