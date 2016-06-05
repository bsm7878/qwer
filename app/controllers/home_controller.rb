class HomeController < ApplicationController
  helper_method :champion_uri 
    
  def index


  end
  
  
  def school
    @@summoner = Summoner.where(:summoner => params[:name].gsub(/\s+/, "").downcase).take
    #@@abc = params[:name]
    show_name = params[:name]

    
    unless @@summoner.nil?
            #대학별 db에 뿌려줄 함수 만들기
            def school_name(school2)
                @name = school2.where(:summoner_id => @@summoner.id).take
                @name_all = school2.all.order('total_point DESC') #학교내에서 개인 순위_total point로 정렬
                @name_name = @name_all.index(@name_all.find {|x| x.summoner_id == @name.summoner_id}) #프로필 밑에 본인이 몇위인지 가져오는것 +1 할것!
                @rank_in_major = school2.where(:major => @name.major).order('total_point DESC') #전공별 개인 순위 불러 오기
                @name_name_major = @rank_in_major.index(@rank_in_major.find {|x| x.summoner_id == @name.summoner_id})
                @main_image = @name.champion #프로필 챔피언 이미지 가져오기
                @win_percent = (@name.win.to_f / (@name.win + @name.loose))*100
                @all_count = school2.count #대학교 총 학생 수
                @all_major_count = school2.where(:major => @name.major).count # 전공 총 학생 수
                @percent_univ = ((@name_name + 1)/@all_count.to_f)*100 #학교 상위 몇퍼
                @percent_major = ((@name_name_major + 1)/@all_major_count.to_f)*100 #전공 상위 몇퍼
                
                #전공별 순위 불러 오기
                major_rank_hash = Hash.new 
                major_rank_count = school2.group(:major) #데이터 있는 전공이름 불러오기
                major_rank_count.each do |x|
                    major_rank_count = school2.group(:major).count["#{x.major}"].to_f #전공 해당 데이터 수
                    major_rank = school2.group(:major).sum(:total_point)["#{x.major}"]./major_rank_count # 전공 total_point
                    major_rank_hash["#{x.major}"] = major_rank #해쉬에 담기
                end 
                @major_rank_final = major_rank_hash.sort_by {|k,v| v}.reverse #크기가 큰 순서로 정렬  
                
                
                
                
            end
            
            #챔피언 이미지 뿌려주기
            def champion_uri(image2)
                case image2 #@name.champion
                when "1"
                    @image = "/lol_img/Annie.png" #애니
                when "2"
                    @image = "/lol_img/Olaf.png" #울라프 
                when "3"
                    @image = "/lol_img/Galio.png" #갈리오
                when "4"
                    @image = "/lol_img/TwistedFate.png" #트페
                when "5"
                    @image = "/lol_img/XinZhao.png" #신짜오
                when "6"
                    @image = "/lol_img/Urgot.png" #우르곳
                when "7"
                    @image = "/lol_img/Leblanc.png" #르블랑
                when "8"
                    @image = "/lol_img/Vladimir.png" #블라디
                when "9"
                    @image = "/lol_img/FiddleSticks.png" #피들
                when "10"
                    @image = "/lol_img/Kayle.png" #케일
                when "11"
                    @image = "/lol_img/MasterYi.png" #마이
                when "12"
                    @image = "/lol_img/Alistar.png" #알리스타
                when "13"
                    @image = "/lol_img/Ryze.png" #라이즈
                when "14"
                    @image = "/lol_img/Sion.png" #사이온
                when "15"
                    @image = "/lol_img/Sivir.png" #시비르
                when "16"
                    @image = "/lol_img/Soraka.png" #소라카
                when "17"
                    @image = "/lol_img/Teemo.png" #티모
                when "18"
                    @image = "/lol_img/Tristana.png" #트리스타나
                when "19"
                    @image = "/lol_img/Warwick.png" #워웍
                when "20"
                    @image = "/lol_img/Nunu.png" #누누
                when "21"
                    @image = "/lol_img/MissFortune.png" #미포
                when "22"
                    @image = "/lol_img/Ashe.png" #애쉬
                when "23"
                    @image = "/lol_img/Tryndamere.png" #트린다미어
                when "24"
                    @image = "/lol_img/Jax.png" #잭스
                when "25"
                    @image = "/lol_img/Morgana.png" #모르가나
                when "26"
                    @image = "/lol_img/Zilean.png" #질리언
                when "27"
                    @image = "/lol_img/Singed.png" #신지드
                when "28"
                    @image = "/lol_img/Evelynn.png" #이블린
                when "29"
                    @image = "/lol_img/Twitch.png" #트위치
                when "30"
                    @image = "/lol_img/Karthus.png" #카서스
                when "31"
                    @image = "/lol_img/Chogath.png" #초가스
                when "32"
                    @image = "/lol_img/Amumu.png" #아무무
                when "33"
                    @image = "/lol_img/Rammus.png" #람머스
                when "34"
                    @image = "/lol_img/Anivia.png" #애니비아
                when "35"
                    @image = "/lol_img/Shaco.png" #샤코
                when "36"
                    @image = "/lol_img/DrMundo.png" #문도
                when "37"
                    @image = "/lol_img/Sona.png" #소나
                when "38"
                    @image = "/lol_img/Kassadin.png" #카사딘
                when "39"
                    @image = "/lol_img/Irelia.png" #이렐리아
                when "40"
                    @image = "/lol_img/Janna.png" #잔나
                when "41"
                    @image = "/lol_img/Gangplank.png" #갱플
                when "42"
                    @image = "/lol_img/Corki.png" #코르키
                when "43"
                    @image = "/lol_img/Karma.png" #카르마
                when "44"
                    @image = "/lol_img/Taric.png" #타릭
                when "45"
                    @image = "/lol_img/Veigar.png" #베이가
                when "48"
                    @image = "/lol_img/Trundle.png" #트런들
                when "50"
                    @image = "/lol_img/Swain.png" #스웨인
                when "51"
                    @image = "/lol_img/Caitlyn.png" #케이틀린
                when "53"
                    @image = "/lol_img/Blitzcrank.png" #블츠
                when "54"
                    @image = "/lol_img/Malphite.png" #말파
                when "55"
                    @image = "/lol_img/Katarina.png" #카타
                when "56"
                    @image = "/lol_img/Nocturne.png" #녹턴
                when "57"
                    @image = "/lol_img/Maokai.png" #마오카이
                when "58"
                    @image = "/lol_img/Renekton.png" #레넥톤
                when "59"
                    @image = "/lol_img/JarvanIV.png" #자르반
                when "60"
                    @image = "/lol_img/Elise.png" #엘리스
                when "61"
                    @image = "/lol_img/Orianna.png" #오리아나
                when "62"
                    @image = "/lol_img/MonkeyKing.png" #오공
                when "63"
                    @image = "/lol_img/Brand.png" #브랜드
                when "64"
                    @image = "/lol_img/LeeSin.png" #리신
                when "67"
                    @image = "/lol_img/Vayne.png" #베인
                when "68"
                    @image = "/lol_img/Rumble.png" #럼블
                when "69"
                    @image = "/lol_img/Cassiopeia.png" #카시오페아
                when "72"
                    @image = "/lol_img/Skarner.png" #스카너
                when "74"
                    @image = "/lol_img/Heimerdinger.png" #딩거
                when "75"
                    @image = "/lol_img/Nasus.png" #나서스
                when "76"
                    @image = "/lol_img/Nidalee.png" #니달리
                when "77"
                    @image = "/lol_img/Udyr.png" #우디르
                when "78"
                    @image = "/lol_img/Poppy.png" #뽀삐
                when "79"
                    @image = "/lol_img/Gragas.png" #그라가스
                when "80"
                    @image = "/lol_img/Pantheon.png" #판테온
                when "81"
                    @image = "/lol_img/Ezreal.png" #이즈리얼
                when "82"
                    @image = "/lol_img/Mordekaiser.png" #모데카이저
                when "83"
                    @image = "/lol_img/Yorick.png" #요릭
                when "84"
                    @image = "/lol_img/Akali.png" #아칼리
                when "85"
                    @image = "/lol_img/Kennen.png" #케넨
                when "86"
                    @image = "/lol_img/Garen.png" #가렌
                when "89"
                    @image = "/lol_img/Leona.png" #레오나
                when "90"
                    @image = "/lol_img/Malzahar.png" #말자하
                when "91"
                    @image = "/lol_img/Talon.png" #탈론
                when "92"
                    @image = "/lol_img/Riven.png" #리븐
                when "96"
                    @image = "/lol_img/KogMaw.png" #코그모
                when "98"
                    @image = "/lol_img/Shen.png" #쉔
                when "99"
                     @image = "/lol_img/Lux.png" #럭스
                when "101"
                    @image = "/lol_img/Xerath.png" #제라스
                when "102"
                    @image = "/lol_img/Shyvana.png" #쉬바나
                when "103"
                    @image = "/lol_img/Ahri.png" #아리
                when "104"
                    @image = "/lol_img/Graves.png" #그브
                when "105"
                    @image = "/lol_img/Fizz.png" #피즈
                when "106"
                    @image = "/lol_img/Volibear.png" #볼베
                when "107"
                    @image = "/lol_img/Rengar.png" #렝가
                when "110"
                    @image = "/lol_img/Varus.png" #바루스
                when "111"
                    @image = "/lol_img/Nautilus.png" #노틸러스
                when "112"
                    @image = "/lol_img/Viktor.png" #빅토르
                when "113"
                    @image = "/lol_img/Sejuani.png" #세주아니
                when "114"
                    @image = "/lol_img/Fiora.png" #피오라
                when "115"
                    @image = "/lol_img/Ziggs.png" #직스
                when "117"
                    @image = "/lol_img/Lulu.png" #룰루
                when "119"
                    @image = "/lol_img/Draven.png" #드레이븐
                when "120"
                    @image = "/lol_img/Hecarim.png" #헤카림
                when "121"
                    @image = "/lol_img/Khazix.png" #카직스
                when "122"
                    @image = "/lol_img/Darius.png" #다리
                when "126"
                    @image = "/lol_img/Jayce.png" #제이스
                when "127"
                    @image = "/lol_img/Lissandra.png" #리산드라
                when "131"
                    @image = "/lol_img/Diana.png" #다이애나
                when "133"
                    @image = "/lol_img/Quinn.png" #퀸
                when "134"
                    @image = "/lol_img/Syndra.png" #신드라
                when "136"
                    @image = "/lol_img/AurelionSol.png" #아우렐리온
                when "143"
                    @image = "/lol_img/Zyra.png" #자이라
                when "150"
                    @image = "/lol_img/Gnar.png" #나르
                when "154"
                    @image = "/lol_img/Zac.png" #자크
                when "157"
                    @image = "/lol_img/Yasuo.png" #야스오
                when "161"
                    @image = "/lol_img/Velkoz.png" #벨코즈
                when "201"
                    @image = "/lol_img/Braum.png" #브라움
                when "202"
                    @image = "/lol_img/Jhin.png" #진
                when "203"
                    @image = "/lol_img/Kindred.png" #킨드레드
                when "222"
                    @image = "/lol_img/Jinx.png" #징크스
                when "223"
                    @image = "/lol_img/TahmKench.png" #탐켄치
                when "236"
                    @image = "/lol_img/Lucian.png" #루시안
                when "238"
                    @image = "/lol_img/Zed.png" #제드
                when "245"
                    @image = "/lol_img/Ekko.png" #에코
                when "254"
                    @image = "/lol_img/Vi.png" #바이
                when "266"
                    @image = "/lol_img/Aatrox.png" #아트록스
                when "267"
                    @image = "/lol_img/Nami.png" #나미
                when "268"
                    @image = "/lol_img/Azir.png" #아지르
                when "421"
                    @image = "/lol_img/RekSai.png" #렉사이
                when "432"
                    @image = "/lol_img/Bard.png" #바드
                when "412"
                    @image = "/lol_img/Thresh.png" #쓰레쉬
                when "420"
                    @image = "/lol_img/Illaoi.png" #일라오이
                when "429"
                    @image = "/lol_img/Kalista.png" #칼리스타
                when "163"
                    @image = "/lol_img/Taliyah.png" #탈리야
                else
                    @image = "/lol_img/Illaoi.png" #준비중
                end
            end
            
            case @@summoner.university 
            when "전남대"
                school_name(Jnu)  
            when "인하대"
                school_name(Inha) 
            when "조선대"
                school_name(Chosun) 
            end
            
            #전국 대학별 순위
            university_rank_hash = Hash.new
            university_rank_hash["전남대"] = [Jnu.all.sum(:total_point)/Jnu.all.count, "/univ_img/jnu.png"]
            university_rank_hash["인하대"] = [Inha.all.sum(:total_point)/Inha.all.count, "/univ_img/inha_univ.png"]
            university_rank_hash["조선대"] = [Chosun.all.sum(:total_point)/Chosun.all.count, "/univ_img/chosun.png"]
            @university_rank_final = university_rank_hash.sort_by {|k,v| v[0]}.reverse #크기가 큰 순서로 정렬
    
    else #사이트에 회원이 등록 안되어있으면!
        #redirect_to '/home/not_summoner'
        redirect_to controller: 'home', action: 'not_summoner', name: show_name
    end #사이트에 회원이 등록 안되어있으면 unless문 종료!
    
  end
  
  
  def not_summoner #검색했는데 사이트에 등록이 안되어 있을때
            @ab = params[:name].gsub(/\s+/, "").downcase 
            @ab2 = params[:name] # erb 파일에 소환사 이름 출력
            @univ_list = UnivMajor.all # 대학 리스트 불러오기

            #소환사 고유 id 불러오기
            name = URI.encode(@ab)
            name_uri = "https://kr.api.pvp.net/api/lol/kr/v1.4/summoner/by-name/#{name}?api_key=0827b90b-3e3b-44db-aca4-ac10ebce0f1c"
            source = name_uri
            resp = Net::HTTP.get_response(URI.parse(source))
            data = resp.body
            result = JSON.parse(data)
            unless result["status"].present? #등록이 되어있으면!
            
                    result2 = result[@ab]['id'] #소환사 id
                
                    #소환사 정보 불러오기
                    information_uri = "https://kr.api.pvp.net/api/lol/kr/v2.5/league/by-summoner/#{result2}/entry?api_key=0827b90b-3e3b-44db-aca4-ac10ebce0f1c"
                    source2 = information_uri
                    resp2 = Net::HTTP.get_response(URI.parse(source2))
                    data3 = resp2.body
                    result3 = JSON.parse(data3)
                    
                unless result3["status"].present? #언랭이아니면!
                
                    #숙련된 챔피언 불러오기
                    name_uri = "https://kr.api.pvp.net/championmastery/location/KR/player/#{result2}/champions?api_key=0827b90b-3e3b-44db-aca4-ac10ebce0f1c"
                    source2 = name_uri
                    resp = Net::HTTP.get_response(URI.parse(source2))
                    data2 = resp.body
                    result_champion2 = JSON.parse(data2)
                    @result_champion = result_champion2[0]["championId"] #챔피언 
                    
                    #챔피언 이미지 뿌려주기
           
                case @result_champion #챔피언
                when 1
                    @image = "/lol_img/Annie.png" #애니
                when 2
                    @image = "/lol_img/Olaf.png" #울라프 
                when 3
                    @image = "/lol_img/Galio.png" #갈리오
                when 4
                    @image = "/lol_img/TwistedFate.png" #트페
                when 5
                    @image = "/lol_img/XinZhao.png" #신짜오
                when 6
                    @image = "/lol_img/Urgot.png" #우르곳
                when 7
                    @image = "/lol_img/Leblanc.png" #르블랑
                when 8
                    @image = "/lol_img/Vladimir.png" #블라디
                when 9
                    @image = "/lol_img/FiddleSticks.png" #피들
                when 10
                    @image = "/lol_img/Kayle.png" #케일
                when 11
                    @image = "/lol_img/MasterYi.png" #마이
                when 12
                    @image = "/lol_img/Alistar.png" #알리스타
                when 13
                    @image = "/lol_img/Ryze.png" #라이즈
                when 14
                    @image = "/lol_img/Sion.png" #사이온
                when 15
                    @image = "/lol_img/Sivir.png" #시비르
                when 16
                    @image = "/lol_img/Soraka.png" #소라카
                when 17
                    @image = "/lol_img/Teemo.png" #티모
                when 18
                    @image = "/lol_img/Tristana.png" #트리스타나
                when 19
                    @image = "/lol_img/Warwick.png" #워웍
                when 20
                    @image = "/lol_img/Nunu.png" #누누
                when 21
                    @image = "/lol_img/MissFortune.png" #미포
                when 22
                    @image = "/lol_img/Ashe.png" #애쉬
                when 23
                    @image = "/lol_img/Tryndamere.png" #트린다미어
                when 24
                    @image = "/lol_img/Jax.png" #잭스
                when 25
                    @image = "/lol_img/Morgana.png" #모르가나
                when 26
                    @image = "/lol_img/Zilean.png" #질리언
                when 27
                    @image = "/lol_img/Singed.png" #신지드
                when 28
                    @image = "/lol_img/Evelynn.png" #이블린
                when 29
                    @image = "/lol_img/Twitch.png" #트위치
                when 30
                    @image = "/lol_img/Karthus.png" #카서스
                when 31
                    @image = "/lol_img/Chogath.png" #초가스
                when 32
                    @image = "/lol_img/Amumu.png" #아무무
                when 33
                    @image = "/lol_img/Rammus.png" #람머스
                when 34
                    @image = "/lol_img/Anivia.png" #애니비아
                when 35
                    @image = "/lol_img/Shaco.png" #샤코
                when 36
                    @image = "/lol_img/DrMundo.png" #문도
                when 37
                    @image = "/lol_img/Sona.png" #소나
                when 38
                    @image = "/lol_img/Kassadin.png" #카사딘
                when 39
                    @image = "/lol_img/Irelia.png" #이렐리아
                when 40
                    @image = "/lol_img/Janna.png" #잔나
                when 41
                    @image = "/lol_img/Gangplank.png" #갱플
                when 42
                    @image = "/lol_img/Corki.png" #코르키
                when 43
                    @image = "/lol_img/Karma.png" #카르마
                when 44
                    @image = "/lol_img/Taric.png" #타릭
                when 45
                    @image = "/lol_img/Veigar.png" #베이가
                when 48
                    @image = "/lol_img/Trundle.png" #트런들
                when 50
                    @image = "/lol_img/Swain.png" #스웨인
                when 51
                    @image = "/lol_img/Caitlyn.png" #케이틀린
                when 53
                    @image = "/lol_img/Blitzcrank.png" #블츠
                when 54
                    @image = "/lol_img/Malphite.png" #말파
                when 55
                    @image = "/lol_img/Katarina.png" #카타
                when 56
                    @image = "/lol_img/Nocturne.png" #녹턴
                when 57
                    @image = "/lol_img/Maokai.png" #마오카이
                when 58
                    @image = "/lol_img/Renekton.png" #레넥톤
                when 59
                    @image = "/lol_img/JarvanIV.png" #자르반
                when 60
                    @image = "/lol_img/Elise.png" #엘리스
                when 61
                    @image = "/lol_img/Orianna.png" #오리아나
                when 62
                    @image = "/lol_img/MonkeyKing.png" #오공
                when 63
                    @image = "/lol_img/Brand.png" #브랜드
                when 64
                    @image = "/lol_img/LeeSin.png" #리신
                when 67
                    @image = "/lol_img/Vayne.png" #베인
                when 68
                    @image = "/lol_img/Rumble.png" #럼블
                when 69
                    @image = "/lol_img/Cassiopeia.png" #카시오페아
                when 72
                    @image = "/lol_img/Skarner.png" #스카너
                when 74
                    @image = "/lol_img/Heimerdinger.png" #딩거
                when 75
                    @image = "/lol_img/Nasus.png" #나서스
                when 76
                    @image = "/lol_img/Nidalee.png" #니달리
                when 77
                    @image = "/lol_img/Udyr.png" #우디르
                when 78
                    @image = "/lol_img/Poppy.png" #뽀삐
                when 79
                    @image = "/lol_img/Gragas.png" #그라가스
                when 80
                    @image = "/lol_img/Pantheon.png" #판테온
                when 81
                    @image = "/lol_img/Ezreal.png" #이즈리얼
                when 82
                    @image = "/lol_img/Mordekaiser.png" #모데카이저
                when 83
                    @image = "/lol_img/Yorick.png" #요릭
                when 84
                    @image = "/lol_img/Akali.png" #아칼리
                when 85
                    @image = "/lol_img/Kennen.png" #케넨
                when 86
                    @image = "/lol_img/Garen.png" #가렌
                when 89
                    @image = "/lol_img/Leona.png" #레오나
                when 90
                    @image = "/lol_img/Malzahar.png" #말자하
                when 91
                    @image = "/lol_img/Talon.png" #탈론
                when 92
                    @image = "/lol_img/Riven.png" #리븐
                when 96
                    @image = "/lol_img/KogMaw.png" #코그모
                when 98
                    @image = "/lol_img/Shen.png" #쉔
                when 99
                     @image = "/lol_img/Lux.png" #럭스
                when 101
                    @image = "/lol_img/Xerath.png" #제라스
                when 102
                    @image = "/lol_img/Shyvana.png" #쉬바나
                when 103
                    @image = "/lol_img/Ahri.png" #아리
                when 104
                    @image = "/lol_img/Graves.png" #그브
                when 105
                    @image = "/lol_img/Fizz.png" #피즈
                when 106
                    @image = "/lol_img/Volibear.png" #볼베
                when 107
                    @image = "/lol_img/Rengar.png" #렝가
                when 110
                    @image = "/lol_img/Varus.png" #바루스
                when 111
                    @image = "/lol_img/Nautilus.png" #노틸러스
                when 112
                    @image = "/lol_img/Viktor.png" #빅토르
                when 113
                    @image = "/lol_img/Sejuani.png" #세주아니
                when 114
                    @image = "/lol_img/Fiora.png" #피오라
                when 115
                    @image = "/lol_img/Ziggs.png" #직스
                when 117
                    @image = "/lol_img/Lulu.png" #룰루
                when 119
                    @image = "/lol_img/Draven.png" #드레이븐
                when 120
                    @image = "/lol_img/Hecarim.png" #헤카림
                when 121
                    @image = "/lol_img/Khazix.png" #카직스
                when 122
                    @image = "/lol_img/Darius.png" #다리
                when 126
                    @image = "/lol_img/Jayce.png" #제이스
                when 127
                    @image = "/lol_img/Lissandra.png" #리산드라
                when 131
                    @image = "/lol_img/Diana.png" #다이애나
                when 133
                    @image = "/lol_img/Quinn.png" #퀸
                when 134
                    @image = "/lol_img/Syndra.png" #신드라
                when 136
                    @image = "/lol_img/AurelionSol.png" #아우렐리온
                when 143
                    @image = "/lol_img/Zyra.png" #자이라
                when 150
                    @image = "/lol_img/Gnar.png" #나르
                when 154
                    @image = "/lol_img/Zac.png" #자크
                when 157
                    @image = "/lol_img/Yasuo.png" #야스오
                when 161
                    @image = "/lol_img/Velkoz.png" #벨코즈
                when 201
                    @image = "/lol_img/Braum.png" #브라움
                when 202
                    @image = "/lol_img/Jhin.png" #진
                when 203
                    @image = "/lol_img/Kindred.png" #킨드레드
                when 222
                    @image = "/lol_img/Jinx.png" #징크스
                when 223
                    @image = "/lol_img/TahmKench.png" #탐켄치
                when 236
                    @image = "/lol_img/Lucian.png" #루시안
                when 238
                    @image = "/lol_img/Zed.png" #제드
                when 245
                    @image = "/lol_img/Ekko.png" #에코
                when 254
                    @image = "/lol_img/Vi.png" #바이
                when 266
                    @image = "/lol_img/Aatrox.png" #아트록스
                when 267
                    @image = "/lol_img/Nami.png" #나미
                when 268
                    @image = "/lol_img/Azir.png" #아지르
                when 421
                    @image = "/lol_img/RekSai.png" #렉사이
                when 432
                    @image = "/lol_img/Bard.png" #바드
                when 412
                    @image = "/lol_img/Thresh.png" #쓰레쉬
                when 420
                    @image = "/lol_img/Illaoi.png" #일라오이
                when 429
                    @image = "/lol_img/Kalista.png" #칼리스타
                else
                    @image = "/lol_img/.png" #칼리스타
                end
 
        
                    @tier_info = result3["#{result2}"][0]['tier'] #티어
                    @division_info = result3["#{result2}"][0]['entries'][0]['division'] #티어_단계

                    
                else #소환사가 언랭일때
                    redirect_to '/home/not_show'
                end #소환사가 언랭일때 unless문 종료
            else #소환사 id가 lol에 등록이 안되어있을때!
                redirect_to '/home/not_show'
            end #소환사 id가 lol에 등록이 안되어있을때 unless문 종료

      
  end
  
  
  def sign #회원가입
        sign_name = params[:name]
        sign_name_down = params[:name].gsub(/\s+/, "").downcase
        unless Summoner.where(:summoner => sign_name).present?  
            
            #소환사 고유 id 불러오기
            name = URI.encode(sign_name_down)
            name_uri = "https://kr.api.pvp.net/api/lol/kr/v1.4/summoner/by-name/#{name}?api_key=0827b90b-3e3b-44db-aca4-ac10ebce0f1c"
            source = name_uri
            resp = Net::HTTP.get_response(URI.parse(source))
            data = resp.body
            result = JSON.parse(data)

            
                    result2 = result[sign_name_down]['id'] #소환사 id
                
                    #소환사 정보 불러오기
                    information_uri = "https://kr.api.pvp.net/api/lol/kr/v2.5/league/by-summoner/#{result2}/entry?api_key=0827b90b-3e3b-44db-aca4-ac10ebce0f1c"
                    source2 = information_uri
                    resp2 = Net::HTTP.get_response(URI.parse(source2))
                    data3 = resp2.body
                    result3 = JSON.parse(data3)
                    
            
                
                    #숙련된 챔피언 불러오기
                    name_uri = "https://kr.api.pvp.net/championmastery/location/KR/player/#{result2}/champions?api_key=0827b90b-3e3b-44db-aca4-ac10ebce0f1c"
                    source2 = name_uri
                    resp = Net::HTTP.get_response(URI.parse(source2))
                    data2 = resp.body
                    result_champion2 = JSON.parse(data2)
                    result_champion = result_champion2[0]["championId"]
                    summoner = Summoner.new
                    summoner.summoner = sign_name_down #소환사 이름_in summoner
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
                      jnu.summoner = sign_name
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
                      id2 = Summoner.where(:summoner_number => result2).take
                      jnu = Inha.new
                      jnu.summoner_id = id2.id
                      jnu.summoner = sign_name
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
                    when "조선대"
                      id2 = Summoner.where(:summoner_number => result2).take
                      jnu = Chosun.new
                      jnu.summoner_id = id2.id
                      jnu.summoner = sign_name
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
                      
                    else
                      
                    end
          
                redirect_to controller: 'home', action: 'school', name: sign_name
            else
                redirect_to '/'
            end
    
  end #sign 컨트롤러 끝
  
  
  def update #최신정보 업데이트
    
    @@summoner2 = Summoner.where(:summoner => params[:name].gsub(/\s+/, "").downcase).take
    
    def update_method(university_name)
            #챔피언 정보 가져오기
            information_uri = "https://kr.api.pvp.net/api/lol/kr/v2.5/league/by-summoner/#{@@summoner2.summoner_number}/entry?api_key=0827b90b-3e3b-44db-aca4-ac10ebce0f1c"
            source = information_uri
            resp = Net::HTTP.get_response(URI.parse(source))
            data = resp.body
            result = JSON.parse(data)
            tier_info = result["#{@@summoner2.summoner_number}"][0]['tier'] #티어
            division_info = result["#{@@summoner2.summoner_number}"][0]['entries'][0]['division'] #티어_단계
            point_info = result["#{@@summoner2.summoner_number}"][0]['entries'][0]['leaguePoints'] #포인트
            win_info = result["#{@@summoner2.summoner_number}"][0]['entries'][0]['wins'] #win
            loose_info = result["#{@@summoner2.summoner_number}"][0]['entries'][0]['losses'] #loose
            
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
            
            #숙련된 챔피언 가져오기
            name_uri = "https://kr.api.pvp.net/championmastery/location/KR/player/#{@@summoner2.summoner_number}/champions?api_key=0827b90b-3e3b-44db-aca4-ac10ebce0f1c"
            source2 = name_uri
            resp = Net::HTTP.get_response(URI.parse(source2))
            data2 = resp.body
            result_champion2 = JSON.parse(data2)
            result_champion = result_champion2[0]["championId"]
        
        
          jnu = university_name.where(:summoner_id => @@summoner2.id).take
          jnu.tier = tier_info
          jnu.division = division_info
          jnu.point = point_info
          jnu.win = win_info
          jnu.loose = loose_info
          jnu.total_point = tier_point + division_point + point_info
          jnu.champion = result_champion
          jnu.save
    end
    
    
    case @@summoner2.university 
    when "전남대"  
        update_method(Jnu)
    when "인하대"   
        update_method(Inha)
    when "조선대"   
        update_method(Chosun)
    else
      
    end
    
    redirect_to :back
  end
  
  def not_show # 언랭, 라이엇에 등록 안되어 있을때

  end
  
  def email_send
      flyer = params[:flyer]
      content = params[:content]
      Anycall.welcome_email(flyer, content).deliver_now
      redirect_to :back
  end
  
  
  
  def plus # 대학 추가

  end
  
  def univadd # 대학 저장
    add = UnivMajor.new
    add.univ_name = params[:name]
    add.save
    redirect_to :back
  end
  
  def all_summoner # 등록된 유저 보여주기 & 삭제
    @all_summoner = Summoner.all # 모든 유저 보여주기 => 삭제할때
    
    # 전남대 티어 분류
    @bronze_jnu = Jnu.where(:tier => "BRONZE").count
    @silver_jnu = Jnu.where(:tier => "SILVER").count
    @gold_jnu = Jnu.where(:tier => "GOLD").count
    @platinum_jnu = Jnu.where(:tier => "PLATINUM").count
    @diamond_jnu = Jnu.where(:tier => "DIAMOND").count
    @master_jnu = Jnu.where(:tier => "MASTER").count
    @challenger_jnu = Jnu.where(:tier => "CHALLENGER").count#
    # 전남대 성별 구성도
    @mail_jnu = Jnu.where(:sex => false).count
    @femail_jnu = Jnu.where(:sex => true).count
    
    # 인하대 티어 분류
    @bronze_inha = Inha.where(:tier => "BRONZE").count
    @silver_inha = Inha.where(:tier => "SILVER").count
    @gold_inha = Inha.where(:tier => "GOLD").count
    @platinum_inha = Inha.where(:tier => "PLATINUM").count
    @diamond_inha = Inha.where(:tier => "DIAMOND").count
    @master_inha = Inha.where(:tier => "MASTER").count
    @challenger_inha = Inha.where(:tier => "CHALLENGER").count#
    # 인하대 성별 구성도
    @mail_inha = Inha.where(:sex => false).count
    @femail_inha = Inha.where(:sex => true).count
    
    # 조선대 티어 분류
    @bronze_chosun = Chosun.where(:tier => "BRONZE").count
    @silver_chosun = Chosun.where(:tier => "SILVER").count
    @gold_chosun = Chosun.where(:tier => "GOLD").count
    @platinum_chosun = Chosun.where(:tier => "PLATINUM").count
    @diamond_chosun = Chosun.where(:tier => "DIAMOND").count
    @master_chosun = Chosun.where(:tier => "MASTER").count
    @challenger_chosun = Chosun.where(:tier => "CHALLENGER").count#
    # 조선대 성별 구성도
    @mail_chosun = Chosun.where(:sex => false).count
    @femail_chosun = Chosun.where(:sex => true).count
    
    
    
    
  end
  
  def summoner_delete # 등록된 유저 삭제 파라미터 
      Summoner.find(params[:delete_id].to_i).destroy
      if params[:delete_univ] == "전남대"
          Jnu.where(:summoner_id => params[:delete_id].to_i).take.destroy
      elsif params[:delete_univ] == "인하대"
          Inha.where(:summoner_id => params[:delete_id].to_i).take.destroy  
      elsif params[:delete_univ] == "조선대"
          Chosun.where(:summoner_id => params[:delete_id].to_i).take.destroy
      else
          redirect_to '/'
      end
      
          
      redirect_to :back     
  end
  
  
  
  
end
