Rails.application.routes.draw do
  root to: redirect("https://mesettingsails.bandpage.com/")
  
  controller :bonus, as: :bonus, path: :bonus do
    get "/", action: :index
    post "/", action: :redeem
    get "download/:download_token/:format", action: :download, as: :download
  end
end
