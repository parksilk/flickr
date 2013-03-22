get '/' do
  # sign up, sign in, all photos view
  @photos = Photo.all
  erb :index
end

get '/albums/:album_id' do
  # show albums, link to carousel and upload
  @photos = Photo.where('album_id = ?', params[:album_id])
end

get '/users/:user_id' do
  # Show user's page, with albums
  @user = User.find(params[:user_id])
  @albums = Album.where('user_id = ?', params[:user_id])
end

get '/albums/:album_id/:photo_id' do
  # Show a single photo
  @photo = Photo.where('album_id = ?', params[:album_id])[params[:photo_id] + 1]
end

get '/albums/:album_id/carousel' do
  # A carousel of images of that album
  @photos = Photo.where('album_id = ?', params[:album_id])
end

get "/album/:album_id/upload" do
  erb :uploader
end      
    
post "/album/:album_id/upload" do 
  p = Photo.new
  p.title = params[:title]
  p.description = params[:description]
  p.album_id = params[:album_id]
  p.photo_string = params['myfile']
  p.save!
  
  redirect back
end

post "/signup" do
  puts "!!!!!!! #{params}"
  @user = User.new(params[:user])
  puts @user.valid?
  unless @user.save
    erb :signup
  else
    session[:id] = @user.id
    redirect "/profile/#{@user.id}"
  end  
end

get "/signup" do
  erb :signup
end
