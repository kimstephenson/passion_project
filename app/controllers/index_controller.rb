get '/' do
 erb :index
end

get '/search' do
  erb :'/users/_searchform'
end
