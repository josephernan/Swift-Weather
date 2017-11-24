class HomeController < AuthenticatedController
  def index
    @themes = ShopifyAPI::Theme.find(:all, :params => {:limit => 10})
    @theme_id = params[:theme_id]
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
    #@theme_id = params[:theme_id]
  end

  def update
  end

  def destroy
  end

end
