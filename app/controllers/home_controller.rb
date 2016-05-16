class HomeController < ApplicationController
  helper_method :champion_uri 
    
  def index
    @summoner = Summoner.all
    @jnu = Jnu.all


  end
  
  def school
    @@summoner = Summoner.where(:summoner => params[:name]).take
    
    #대학별 db에 뿌려줄 함수 만들기
    def school_name(school2)
        @name = school2.find(@@summoner.id)
        @name_all = school2.all.order('total_point DESC') #학교내에서 개인 순위_total point로 정렬
        @name_name = @name_all.index(@name_all.find {|x| x.summoner_id == @name.summoner_id}) #프로필 밑에 본인이 몇위인지 가져오는것
        @main_image = @name.champion #프로필 챔피언 이미지 가져오기
        
        #전공별 순위 불러 오기
        major_rank_hash = Hash.new 
        major_rank_count = school2.group(:major) #데이터 있는 전공이름 불러오기
        major_rank_count.each do |x|
            major_rank_count = school2.group(:major).count["#{x.major}"].to_f #전공 해당 데이터 수
            major_rank = school2.group(:major).sum(:total_point)["#{x.major}"]./major_rank_count # 전공 total_point
            major_rank_hash["#{x.major}"] = major_rank #해쉬에 담기
        end 
        @major_rank_final = major_rank_hash.sort_by {|k,v| v}.reverse #크기가 큰 순서로 정렬  
        
        #전공별 개인 순위 불러 오기
        @rank_in_major = school2.where(:major => @name.major).order('total_point DESC')
        
        
    end
    
    #챔피언 이미지 뿌려주기
    def champion_uri(image2)
        case image2 #@name.champion
        when "1"
            @image = "/lol_img/Annie.png" #애니
        when "2"
            울라프
        when "3"
            갈리오
        when "4"
            트페
        when "5"
            신짜오
        when "6"
            우르곳
        when "7"
            르블랑
        when "8"
            블라디
        when "9"
            피들
        when "10"
            케일
        when "11"
            마이
        when "12"
            @image = "/lol_img/Alistar.png" #알리스타
        when "13"
            라이즈
        when "14"
            사이온
        when "15"
            @image = "/lol_img/Sivir.png" #시비르
        when "16"
            소라카
        when "17"
            @image = "/lol_img/Teemo.png" #티모
        when "18"
         
        when "19"
            워웍
        when "20"
            누누
        when "21"
            미포
        when "22"
            애쉬
        when "23"
            트린다미어
        when "24"
            잭스
        when "25"
            모르가나
        when "26"
            질리언
        when "27"
            신지드
        when "28"
            이블린
        when "29"
            트위치
        when "30"
            카서스
        when "31"
            초가스
        when "32"
            아무무
        when "33"
            람머스
        when "34"
            애니비아
        when "35"
            샤코
        when "36"
            문도
        when "37"
            소나
        when "38"
            카사딘
        when "39"
            이렐리아
        when "40"
            잔나
        when "41"
            갱플
        when "42"
            코르키
        when "43"
            카르마
        when "44"
            타릭
        when "45"
            베이카
        when "48"
            트런들
        when "50"
            스웨인
        when "51"
            @image = "/lol_img/Caitlyn.png" #케이틀린
        when "53"
            블츠
        when "54"
            @image = "/lol_img/Malphite.png" #말파
        when "55"
            카타
        when "56"
            녹턴
        when "57"
            마오카이
        when "58"
            레넥톤
        when "59"
            자르반
        when "60"
            엘리스
        when "61"
            오리아나
        when "62"
            오공
        when "63"
            브랜드
        when "64"
            @image = "/lol_img/LeeSin.png" #리신
        when "67"
            @image = "/lol_img/Vayne.png" #베인
        when "68"
            럼블
        when "69"
            카시오페아
        when "72"
            스카너
        when "74"
            딩거
        when "75"
            나서스
        when "76"
            @image = "/lol_img/Nidalee.png" #니달리
        when "77"
            우디르
        when "78"
            뽀삐
        when "79"
            그라가스
        when "80"
            판테온
        when "81"
            이즈리얼
        when "82"
            모데카이저
        when "83"
            요릭
        when "84"
            @image = "/lol_img/Akali.png" #아칼리
        when "85"
            케넨
        when "86"
            가렌
        when "89"
            레오나
        when "90"
            말자하
        when "91"
            탈론
        when "92"
            리븐
        when "96"
            코그모
        when "98"
            쉔
        when "99"
             @image = "/lol_img/Lux.png" #럭스
        when "101"
            제라스
        when "102"
            쉬바나
        when "103"
            아리
        when "104"
            그브
        when "105"
            피즈
        when "106"
            볼베
        when "107"
            렝가
        when "110"
            바루스
        when "111"
            @image = "/lol_img/Nautilus.png" #노틸러스
        when "112"
            빅토르
        when "113"
            세주아니
        when "114"
            @image = "/lol_img/Fiora.png" #피오라
        when "115"
            직스
        when "117"
            룰루
        when "119"
            드레이븐
        when "120"
            헤카림
        when "121"
            카직스
        when "122"
            다리
        when "126"
            제이스
        when "127"
            리산드라
        when "131"
            다이애나
        when "133"
            퀸
        when "134"
            신드라
        when "136"
            아우렐리온
        when "143"
            자이라
        when "150"
            나르
        when "154"
            자크
        when "157"
            야스오
        when "161"
            벨코즈
        when "201"
            브라움
        when "202"
            진
        when "203"
            킨드레드
        when "222"
            징크스
        when "223"
            탐켄치
        when "236"
            @image = "/lol_img/Lucian.png" #루시안
        when "238"
            제드
        when "245"
            에코
        when "254"
            바이
        when "266"
        when "300"
            아트록스 #수정
        when "267"
            나미
        when "268"
            아지르
        else
        end
    end
    
    case @@summoner.university 
    when "전남대"
        
        school_name(Jnu)  
     
         
    when "인하대"
 
    
    end
    
  end
  
  def sign #회원가입
  
      unless Summoner.where(:summoner => params[:summoner]).present? #회원가입 유/무 확인
      
            
            #소환사 고유 id 불러오기
            name = URI.encode(params[:summoner].gsub(/\s+/, "").downcase)
            name_uri = "https://kr.api.pvp.net/api/lol/kr/v1.4/summoner/by-name/#{name}?api_key=0827b90b-3e3b-44db-aca4-ac10ebce0f1c"
            source = name_uri
            resp = Net::HTTP.get_response(URI.parse(source))
            data = resp.body
            result = JSON.parse(data)
            unless result["status"].present? #등록이 되어있으면!
            
                    result2 = result[params[:summoner].gsub(/\s+/, "").downcase]['id'] #소환사 id
                
                    #소환사 정보 불러오기
                    information_uri = "https://kr.api.pvp.net/api/lol/kr/v2.5/league/by-summoner/#{result2}/entry?api_key=0827b90b-3e3b-44db-aca4-ac10ebce0f1c"
                    source2 = information_uri
                    resp2 = Net::HTTP.get_response(URI.parse(source2))
                    data3 = resp2.body
                    result3 = JSON.parse(data3)
                    
                unless result3["status"].present? #언랭이면!
                
                    #숙련된 챔피언 불러오기
                    name_uri = "https://kr.api.pvp.net/championmastery/location/KR/player/#{result2}/champions?api_key=0827b90b-3e3b-44db-aca4-ac10ebce0f1c"
                    source2 = name_uri
                    resp = Net::HTTP.get_response(URI.parse(source2))
                    data2 = resp.body
                    result_champion2 = JSON.parse(data2)
                    result_champion = result_champion2[0]["championId"]
                    summoner = Summoner.new
                    summoner.summoner = params[:summoner] #소환사 이름_in summoner
                    summoner.summoner_number = result2 #소환사 id_in summoner
                    summoner.university = params[:university_major].split[0] #대학_in summoner
                    summoner.save
                    
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
                      jnu.summoner = params[:summoner]
                      jnu.tier = tier_info
                      jnu.division = division_info
                      jnu.point = point_info
                      jnu.win = win_info
                      jnu.loose = loose_info
                      jnu.total_point = tier_point + division_point + point_info
                      jnu.summoner_number = result2
                      jnu.university = params[:university_major].split[0] 
                      jnu.major = params[:university_major].split[1] 
                      jnu.admission = params[:admission]
                      jnu.sex = params[:sex]
                      jnu.champion = result_champion 
                      jnu.save 
                      
                    when "인하대"
                
                      
                    when "서울대"
                      
                    else
                      
                    end
                    
                    redirect_to '/'
                else #소환사가 언랭일때!
                    redirect_to '/'
                end #소환사가 언랭일때 unless문 종료
            else #소환사 id가 lol에 등록이 안되어있을때!
              redirect_to '/'
            end #소환사 id가 lol에 등록이 안되어있을때 unless문 종료
            
      else #unless의 else(회원가입이 되어있으면)
        redirect_to '/'
        
      end #unless 끝
    
  end #sign 컨트롤러 끝
  
  
  def update #최신정보 업데이트
    
    summoner = Jnu.find(params[:name])
    tier_info = summoner.tier
    division_info = summoner.division
    
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
    
    #숙련된 챔피언 가져오기
    name_uri = "https://kr.api.pvp.net/championmastery/location/KR/player/#{summoner.summoner_number}/champions?api_key=0827b90b-3e3b-44db-aca4-ac10ebce0f1c"
    source2 = name_uri
    resp = Net::HTTP.get_response(URI.parse(source2))
    data2 = resp.body
    result_champion2 = JSON.parse(data2)
    result_champion = result_champion2[0]["championId"]
    
    case summoner.university 
    when "전남대"   
      
      jnu = Jnu.find(summoner.id)
      jnu.tier = tier_info
      jnu.division = division_info
      jnu.point = point_info
      jnu.win = win_info
      jnu.loose = loose_info
      jnu.total_point = tier_point + division_point + point_info
      jnu.champion = result_champion
      
      jnu.save
      
      
    when "인하대"   
    
    else
      
    end
    
    redirect_to :back
  end
  
end
