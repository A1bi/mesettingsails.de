class BonusController < ApplicationController
  before_action :prepare_formats, except: :redeem
  
  def redeem
    code = BonusCode.where(code: params[:code]).first
    response = {
      ok: code.present? && code.redeem
    }
    response[:download_token] = code.download_token if response[:ok]
    render json: response
  end
  
  def download
    code = BonusCode.by_valid_download_token(params[:download_token])
    if code
      code.downloads = code.downloads + 1
      code.save
      send_file song_path(params[:format].to_i), disposition: :attachment
    else
      redirect_to bonus_path
    end
  end
  
  protected
  
  def prepare_formats
    @formats = [
      ["MP3", "mp3"], ["AAC", "m4a"], ["ALAC", "m4a", "lossless"], ["FLAC", "flac"], ["WAV", "wav"]
    ]
  end
  
  def song_path(format_index)
    format = @formats[format_index]
    filename = "Birds#{format[2] ? "-" + format[2] : ""}.#{format[1]}"
    path = Rails.root.join("media", "songs", filename)
  end
  helper_method :song_path
end