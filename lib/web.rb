set :haml, {:format => :html4}

get '/' do
  @sites = Site.all :order => [:name.asc]
  haml :index
end

get '/new' do
  haml :new
end

post '/create' do
  site = Site.new
  site.attributes = {
    :name   => params[:name],
    :repo   => params[:repo],
    :folder => params[:folder]
  }
  site.save
  
  redirect '/'
end

get '/edit/:id' do
  @site = Site.get! params[:id]
  haml :edit
end

post '/update/:id' do
  @site = Site.get! params[:id]
  @site.update_attributes(
    :name   => params[:name],
    :repo   => params[:repo],
    :folder => params[:folder]
  )
  
  redirect '/'
end

post '/git' do
  push = JSON.parse params[:payload]
  
  Site.all(:name => push['repository']['name']).each do |site|
    site.deploy
  end
end
