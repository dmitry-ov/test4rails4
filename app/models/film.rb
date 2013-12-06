class Film < ActiveRecord::Base
    has_many :seances, dependent: :destroy

    def self.tabletime_update
        Film.all.each {|e| e.delete}
        get_from_gorizont
        get_from_kado
    end


    def self.push_to_base shedule
        shedule.each_key do |key|
            film = Film.new(title: key)
            film.save
            
            seances = shedule[key]
            seances.each  do |s|
                seance = Seance.new(begin_at: s) 
                seance.film = film
                seance.save
            end
        end
    end


    def self.get_from_kado
        agent = Mechanize.new
        url = "http://www.gold-cinema.ru/index.php?option=com_content&view=article&id=75&Itemid=80"

        films = agent.get(url).search(".//table[@width='600']").search(".//td[@valign='top']")

        shedule = {}
        films.each do |film|
            title = film.search(".//td[@width='300']").search(".//a").text

            shedules = []
            film.search(".//td[@style='font-size: 14pt;']").search(".//font").each do |shedule_item|
                line = shedule_item.text.strip
                shedules << line if (line.length > 0) 
            end
            shedule.merge!({title => shedules})
        end
        shedule.merge!({ :cinema => :kado}) # допишем имя кинотеатра 

        self.push_to_base(shedule)
    end


    def self.get_from_gorizont
        agent = Mechanize.new
        url = 'http://www.horizont-cinema.ru'
        
        films = agent.get(url).search(".//div[@class='af_category_item']")
        
        shedule = {}
        films.each do |film|
            title = film.search(".//div[@class='event_name']").children.children.children.text

            shedule_title = []
            film.search(".//span[@id='msg_rpice']").each do |time|
                #shedule_title << "#{time.children[0].text} #{time.children[1].children[2].text}"
                shedule_title << "#{time.children[0].text}"
            end
            title[0,2] = '' # удаляем из названия нумерацию и 1 точку  
            shedule.merge!({title => shedule_title})
        end
        shedule.merge!({ :cinema => :gorizont}) # допишем имя кинотеатра 
        
        self.push_to_base(shedule)
    end


end
