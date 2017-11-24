class ThemesController < AuthenticatedController
  def index
    theme_id = params[:theme_id]
    Dir.foreach('public/theme_files/assets') do |filename|
      next if filename == '.' or filename == '..'
      file = File.open("public/theme_files/assets/#{filename}", "rb")
      contents = file.read
      asset = ShopifyAPI::Asset.new(:theme_id => theme_id)
      asset.theme_id = theme_id
      if filename.match(/^.*\.liquid/)
        asset.value = contents
      else
        asset.attach(contents)
      end
      asset.key = "assets/#{filename}"
      asset.save
    end
    Dir.foreach('public/theme_files/templates') do |filename|
      next if filename == '.' or filename == '..'
      file = File.open("public/theme_files/templates/#{filename}", "rb")
      contents = file.read
      asset = ShopifyAPI::Asset.new(:theme_id => theme_id)
      asset.theme_id = theme_id
      if filename.match(/^.*\.liquid/)
        asset.value = contents
      else
        asset.attach(contents)
      end
      asset.key = "templates/#{filename}"
      asset.save
    end
    redirect_to controller: 'home', action: 'index', theme_id: theme_id
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end
       
  def update
  end
     
  def destroy
  end
           
end
