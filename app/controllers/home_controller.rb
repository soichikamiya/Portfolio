class HomeController < ApplicationController
#railsの自動require機能で下記は無くてもOK
require 'net/http'
require 'uri'
require 'json'

  def top
    nextdate = Time.now.hour + 9
    #天気予報API
    uri_osaka = URI.parse("http://weather.livedoor.com/forecast/webservice/json/v1?city=270000")
    result_osaka = JSON.parse(Net::HTTP.get(uri_osaka))
    @title_osaka = result_osaka["title"]
    @dateLabel_osaka = result_osaka["forecasts"][0]["dateLabel"]
    @date_osaka = result_osaka["forecasts"][0]["date"]
    @telop_osaka = result_osaka["forecasts"][0]["telop"]
    @image_osaka = result_osaka["forecasts"][0]["image"]["url"]
    @datelabel_tmr_osaka = result_osaka["forecasts"][1]["dateLabel"]
    @date_tmr_osaka = result_osaka["forecasts"][1]["date"]
    @telop_tmr_osaka = result_osaka["forecasts"][1]["telop"]
    @image_tmr_osaka = result_osaka["forecasts"][1]["image"]["url"]
    if nextdate.to_i.in?([24,25,26,27,28])
      @max_temp_tmr_osaka = result_osaka["forecasts"][0]["temperature"]["max"]["celsius"]
      @min_temp_tmr_osaka = result_osaka["forecasts"][0]["temperature"]["min"]["celsius"]
    else
      @max_temp_tmr_osaka = result_osaka["forecasts"][1]["temperature"]["max"]["celsius"]
      @min_temp_tmr_osaka = result_osaka["forecasts"][1]["temperature"]["min"]["celsius"]
    end
    
    uri_tokyo = URI.parse('http://weather.livedoor.com/forecast/webservice/json/v1?city=130010')
    result_tokyo = JSON.parse(Net::HTTP.get(uri_tokyo))
    @title_tokyo = result_tokyo["title"]
    @dateLabel_tokyo = result_tokyo["forecasts"][0]["dateLabel"]
    @date_tokyo = result_tokyo["forecasts"][0]["date"]
    @telop_tokyo = result_tokyo["forecasts"][0]["telop"]
    @image_tokyo = result_tokyo["forecasts"][0]["image"]["url"]
    @datelabel_tmr_tokyo = result_tokyo["forecasts"][1]["dateLabel"]
    @date_tmr_tokyo = result_tokyo["forecasts"][1]["date"]
    @telop_tmr_tokyo = result_tokyo["forecasts"][1]["telop"]
    @image_tmr_tokyo = result_tokyo["forecasts"][1]["image"]["url"]
    if nextdate.to_i.in?([24,25,26,27,28])
      @max_temp_tmr_tokyo = result_tokyo["forecasts"][0]["temperature"]["max"]["celsius"]
      @min_temp_tmr_tokyo = result_tokyo["forecasts"][0]["temperature"]["min"]["celsius"]
    else
      @max_temp_tmr_tokyo = result_tokyo["forecasts"][1]["temperature"]["max"]["celsius"]
      @min_temp_tmr_tokyo = result_tokyo["forecasts"][1]["temperature"]["min"]["celsius"]
    end
    
    uri_fukuoka = URI.parse('http://weather.livedoor.com/forecast/webservice/json/v1?city=400010')
    result_fukuoka = JSON.parse(Net::HTTP.get(uri_fukuoka))
    @title_fukuoka = result_fukuoka["title"]
    @dateLabel_fukuoka = result_fukuoka["forecasts"][0]["dateLabel"]
    @date_fukuoka = result_fukuoka["forecasts"][0]["date"]
    @telop_fukuoka = result_fukuoka["forecasts"][0]["telop"]
    @image_fukuoka = result_fukuoka["forecasts"][0]["image"]["url"]
    @datelabel_tmr_fukuoka = result_fukuoka["forecasts"][1]["dateLabel"]
    @date_tmr_fukuoka = result_fukuoka["forecasts"][1]["date"]
    @telop_tmr_fukuoka = result_fukuoka["forecasts"][1]["telop"]
    @image_tmr_fukuoka = result_fukuoka["forecasts"][1]["image"]["url"]
    if nextdate.to_i.in?([24,25,26,27,28])
      @max_temp_tmr_fukuoka = result_fukuoka["forecasts"][0]["temperature"]["max"]["celsius"]
      @min_temp_tmr_fukuoka = result_fukuoka["forecasts"][0]["temperature"]["min"]["celsius"]
    else
      @max_temp_tmr_fukuoka = result_fukuoka["forecasts"][1]["temperature"]["max"]["celsius"]
      @min_temp_tmr_fukuoka = result_fukuoka["forecasts"][1]["temperature"]["min"]["celsius"]
    end    
  end
  
  def about
    #郵便番号API
    # hash形式でパラメタ文字列を指定し、URL形式にエンコード
    params = URI.encode_www_form({zipcode: '594-1111'})
    # URIを解析し、hostやportをバラバラに取得できるようにする
    uri = URI.parse("http://zipcloud.ibsnet.co.jp/api/search?#{params}")
    # リクエストパラメタを、インスタンス変数に格納
    @query = uri.query
    # 新しくHTTPセッションを開始し、結果をresponseへ格納
    response = Net::HTTP.start(uri.host, uri.port) do |http|
      # 接続時に待つ最大秒数を設定
      http.open_timeout = 5
      # 読み込み一回でブロックして良い最大秒数を設定
      http.read_timeout = 10
      # ここでWebAPIを叩いている
      # Net::HTTPResponseのインスタンスが返ってくる
      http.get(uri.request_uri)
    end
    # 例外処理の開始
    begin
      # responseの値に応じて処理を分ける
      case response
      # 成功した場合
      when Net::HTTPSuccess
        # responseのbody要素をJSON形式で解釈し、hashに変換
        @result = JSON.parse(response.body)
        # 表示用の変数に結果を格納
        @zipcode = @result["results"][0]["zipcode"]
        @address1 = @result["results"][0]["address1"]
        @address2 = @result["results"][0]["address2"]
        @address3 = @result["results"][0]["address3"]
      # 別のURLに飛ばされた場合
      when Net::HTTPRedirection
        @message = "Redirection: code=#{response.code} message=#{response.message}"
      # その他エラー
      else
        @message = "HTTP ERROR: code=#{response.code} message=#{response.message}"
      end
    # エラー時処理
    rescue IOError => e
      @message = "e.message"
    rescue TimeoutError => e
      @message = "e.message"
    rescue JSON::ParserError => e
      @message = "e.message"
    rescue => e
      @message = "e.message"
    end
  end
  
  def about_ajax
    #Ajax使用
    @title = params[:title]
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def web
  end
  
  def contact
  end
end
