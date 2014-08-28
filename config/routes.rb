Rails.application.routes.draw do
  root to: redirect("https://mesettingsails.bandpage.com/")
  
  get "bonus" => "bonus#index"
end
