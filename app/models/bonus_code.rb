class BonusCode < ActiveRecord::Base
  include RandomUniqueAttribute
  
  has_random_unique_token :code, 6
  
  def self.download_token_valid?(token)
    self.where(download_token: token, voided: false).where("download_token_expiration > ?", Time.now).any?
  end
  
  def redeem
    return false if voided
    
    set_random_unique_token(:download_token)
    self.download_token_expiration = Time.now + 15.minutes
    self.downloads = self.downloads + 1
    save
  end
end