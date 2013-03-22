get '/' do
  # sign up, sign in, all photos view
  @photos = Photo.all
  erb :index
end

get '/users/:user_id' do
  @user = User.find(params[:user_id])
  @albums = Album.where('user_id = ?', params[:user_id])

  erb :profile
end

# IMAGE UPLOAD

get '/albums/:album_id/upload' do
  erb :uploader
end      
    
post '/albums/:album_id/upload' do 
  p = Photo.new
  p.title = params[:title]
  p.description = params[:description]
  p.album_id = params[:album_id]
  p.photo_string = params['myfile']
  p.save!
  
  redirect back
end

# ALBUMS

get '/albums/:album_id' do
  @album = Album.find(params[:album_id])
  @photos = Photo.where('album_id = ?', params[:album_id])

  erb :album
end


get '/albums/:album_id/:photo_id' do
  @photo = Photo.find(params[:photo_id])

  erb :photo
end

get '/albums/:album_id/carousel' do
  # A carousel of images of that album
  @photos = Photo.where('album_id = ?', params[:album_id])

  erb :carousel
end

get '/users/:user_id/new_album' do
  if session[:id] == params[:user_id].to_i
    @user = User.find(params[:user_id])
    erb :new_album
  else 
    redirect '/'
  end
end

post '/users/:user_id/new_album' do
  puts "&" * 100
  @user = params[:user_id]
  @album = Album.create(title: params[:title], description: params[:description], user_id: @user)
  redirect "users/#{@user}"
end

# SIGN UP

get '/signup' do
  erb :signup
end

post '/signup' do
  @user = User.new(params[:user])
  unless @user.save
    erb :signup
  else
    session[:id] = @user.id

    Album.create title: "Your new album",
                 description: "Upload your photos here!",
                 user_id: @user.id

    redirect "/users/#{@user.id}"
  end

end

# SIGN IN

get '/signin' do
  erb :signin
end

post '/signin' do
  @user = User.find_by_email(params[:user]["email"])
  if User.authenticate(params[:user])
     session[:id] = @user.id

     redirect "/users/#{@user.id}"
  else
     @error = "You need a proper (and unique) email and password"
     erb :signin
  end
end

# SIGN OUT

get '/signout' do
  session.clear
  redirect '/'
end
