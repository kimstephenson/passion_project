get '/users' do
  #display list of all users(maybe with specific parameters?)
  #add routes for users of specific location, instrument, or genre
end

get '/users/new' do
  #form for creating account
end

post '/users' do
  #submit users creation form
  #redirect
end

get '/users/:id' do
  #specific user's profile page
end

get '/users/:id/edit' do
  #form to edit your profile when logged in
end

put '/users/:id'
  #edit your profile
  #redirect
end

delete '/users/:id'
  #delete your own profile when logged in
end
