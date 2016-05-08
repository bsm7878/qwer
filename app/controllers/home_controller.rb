class HomeController < ApplicationController
  def index
    @summoner = Summoner.all
    @jnu = Jnu.all
     
    
    
  end
  
  def school
    summoner = Summoner.where(:summoner => params[:name]).take
    @jnu = Jnu.find(summoner.id)
    @jnu_all = Jnu.all.order('total_point DESC') 
  end
  
  def sign #회원가입
  
  unless Summoner.where(:summoner => params[:summoner]).present? #회원가입 유/무 확인
    #소환사 고유 id 불러오기
    name = URI.encode(params[:summoner])
    name_uri = "https://kr.api.pvp.net/api/lol/kr/v1.4/summoner/by-name/#{name}?api_key=0827b90b-3e3b-44db-aca4-ac10ebce0f1c"
    source = name_uri
    resp = Net::HTTP.get_response(URI.parse(source))
    data = resp.body
    result = JSON.parse(data)
    result2 = result[params[:summoner]]['id']
  
    summoner = Summoner.new
    summoner.summoner = params[:summoner]
    summoner.summoner_number = result2
    summoner.university = params[:university_major].split[0]
    summoner.major = params[:university_major].split[1]
    summoner.admission = params[:admission]
    summoner.sex = params[:sex]
    summoner.save
    
    #대학별 db에 저장하기
    information_uri = "https://kr.api.pvp.net/api/lol/kr/v2.5/league/by-summoner/#{result2}/entry?api_key=0827b90b-3e3b-44db-aca4-ac10ebce0f1c"
    source2 = information_uri
    resp2 = Net::HTTP.get_response(URI.parse(source2))
    data2 = resp2.body
    result3 = JSON.parse(data2)
    tier_info = result3["#{result2}"][0]['tier'] #티어
    division_info = result3["#{result2}"][0]['entries'][0]['division'] #티어_단계
    point_info = result3["#{result2}"][0]['entries'][0]['leaguePoints'] #포인트
    win_info = result3["#{result2}"][0]['entries'][0]['wins'] #win
    loose_info = result3["#{result2}"][0]['entries'][0]['losses'] #loose
    
    if tier_info == "BRONZE"
        tier_point = 100
    elsif tier_info == "SILVER"
        tier_point = 600
    elsif tier_info == "GOLD"
        tier_point = 1100
    elsif tier_info == "PLATINUM"
        tier_point = 1600
    elsif tier_info == "DIAMOND"
        tier_point = 2100
    elsif tier_info == "MASTER"
        tier_point = 2600
    elsif tier_info == "CHALLENGER"
        tier_point = 3100
    else
        
    end
      
    if division_info == "I"
        division_point = 400
    elsif division_info == "II"
        division_point = 300
    elsif division_info == "III"
        division_point = 200
    elsif division_info == "IV"
        division_point = 100
    elsif division_info == "V"
        division_point = 0
    end
    
    case params[:university_major].split[0] 
    when "전남대"
      id2 = Summoner.where(:summoner_number => result2).take
      jnu = Jnu.new
      jnu.summoner_id = id2.id
      jnu.tier = tier_info
      jnu.division = division_info
      jnu.point = point_info
      jnu.win = win_info
      jnu.loose = loose_info
      jnu.total_point = tier_point + division_point + point_info
      jnu.save
      
    when "인하대"   
      redirect_to '/'
    else
      redirect_to '/'
    end
    
    redirect_to '/'
    
    else
    redirect_to '/'
    
  end
    
  end
  
  def update #최신정보 업데이트
    summoner = Summoner.find(params[:name])
   
    case summoner.university 
    when "전남대"   
      information_uri = "https://kr.api.pvp.net/api/lol/kr/v2.5/league/by-summoner/#{summoner.summoner_number}/entry?api_key=0827b90b-3e3b-44db-aca4-ac10ebce0f1c"
      source = information_uri
      resp = Net::HTTP.get_response(URI.parse(source))
      data = resp.body
      result = JSON.parse(data)
      tier_info = result["#{summoner.summoner_number}"][0]['tier'] #티어
      division_info = result["#{summoner.summoner_number}"][0]['entries'][0]['division'] #티어_단계
      point_info = result["#{summoner.summoner_number}"][0]['entries'][0]['leaguePoints'] #포인트
      win_info = result["#{summoner.summoner_number}"][0]['entries'][0]['wins'] #win
      loose_info = result["#{summoner.summoner_number}"][0]['entries'][0]['losses'] #loose
      
      if tier_info == "BRONZE"
        tier_point = 100
      elsif tier_info == "SILVER"
        tier_point = 600
      elsif tier_info == "GOLD"
        tier_point = 1100
      elsif tier_info == "PLATINUM"
        tier_point = 1600
      elsif tier_info == "DIAMOND"
        tier_point = 2100
      elsif tier_info == "MASTER"
        tier_point = 2600
      elsif tier_info == "CHALLENGER"
        tier_point = 3100
      else
        
      end
      
      if division_info == "I"
        division_point = 400
      elsif division_info == "II"
        division_point = 300
      elsif division_info == "III"
        division_point = 200
      elsif division_info == "IV"
        division_point = 100
      elsif division_info == "V"
        division_point = 0
      else
    
      end
      
      jnu = Jnu.find(summoner.id)
      jnu.tier = tier_info
      jnu.division = division_info
      jnu.point = point_info
      jnu.win = win_info
      jnu.loose = loose_info
      jnu.total_point = tier_point + division_point + point_info
      jnu.save
      redirect_to '/'
    when "인하대"   
      puts 
    else
      puts "it was something else"
    end
    
  end
  
end
