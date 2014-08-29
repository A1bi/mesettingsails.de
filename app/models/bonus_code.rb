class BonusCode < ActiveRecord::Base
  include RandomUniqueAttribute
  
  has_random_unique_token :code, 6
  
  def self.by_valid_download_token(token)
    self.where(download_token: token, voided: false).where("download_token_expiration > ?", Time.now).first
  end
  
  def redeem
    return false if voided
    
    set_random_unique_token(:download_token)
    self.download_token_expiration = Time.now + 15.minutes
    save
  end
end