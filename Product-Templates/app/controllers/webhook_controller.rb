class WebhookController < AuthenticatedController

  skip_before_filter :verify_authenticity_token

  def app_uninstalled
    themes = ShopifyAPI::Theme.find(:all)
    themes.each do |theme|
      Dir.foreach('public/theme_files/assets') do |filename|
        next if filename == '.' or filename == '..'
        asset = ShopifyAPI::Asset.find(:all, :params => {:key => "assets/#{filename}", :theme_id => theme})
        asset.destroy
      end
      Dir.foreach('public/theme_files/templates') do |filename|
        next if filename == '.' or filename == '..'
        asset = ShopifyAPI::Asset.find(:all, :params => {:key => "templates/#{filename}", :theme_id => theme})
        asset.destroy
      end
    end
    shop = Shop.find_by_shopify_domain(ShopifyAPI::Shop.current.domain)
    shop.destroy
  end

  def shop_updated
  end

  private

  def verify_webhook
    data = request.body.read.to_s
    #hmac_header = request.headers['HTTP_X_SHOPIFY_HMAC_SHA256']
    digest  = OpenSSL::Digest::Digest.new('sha256')
    calculated_hmac = Base64.encode64(OpenSSL::HMAC.digest(digest, SyncApp::Application.config.shopify.secret, data)).strip
    unless calculated_hmac == hmac_header
      head :unauthorized
    end
    
    request.body.rewind
  end  
end
