class Shop < ActiveRecord::Base
  include ShopifyApp::Shop
  after_create :init_webhooks

  def init_webhooks
    shopify_session
   
    topics = ["app/uninstalled", "shop/update"]

    topics.each do |topic|
      ShopifyAPI::Webhook.create(:format => "json", :topic => topic, :address => "https://natparksdev.pagekite.me/webhooks/#{topic}")
    end
  end

  def shopify_session
    shop_session = ShopifyAPI::Session.new(self.shopify_domain, self.shopify_token)
    ShopifyAPI::Base.activate_session(shop_session)
  end
end
