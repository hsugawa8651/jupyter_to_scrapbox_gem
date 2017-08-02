# coding: utf-8

require 'JSON'
require 'gyazo'

module Gyazo

  class Client

    def upload_image(imagedata,params={})
      url = "https://upload.gyazo.com/api/upload"
      time = params[:time] || params[:created_at] || Time.now
      res = HTTMultiParty.post url, {
        :query => {
          :access_token => @access_token,
          :imagedata => imagedata,
          :created_at => time.to_i,
          :referer_url => params[:referer_url] || params[:url] || '',
          :title =>  params[:title] || '',
          :desc =>  params[:desc] || ''
        },
        :header => {
          'User-Agent' => @user_agent
        }
      }
      raise Gyazo::Error, res.body unless res.code == 200
      return JSON.parse res.body
    end
  end
end
