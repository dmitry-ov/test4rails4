
# Заходим на страницу http://www.gold-cinema.ru/index.php?option=com_content&view=article&id=75&Itemid=80
# Получаем названия фильмов и расписания.(только время, цена на сайте не публикуется)
# Сохраняем себе в базу TODO


agent = Mechanize.new
URL = "http://www.gold-cinema.ru/index.php?option=com_content&view=article&id=75&Itemid=80"

films = agent.get(URL).search(".//table[@width='600']").search(".//td[@valign='top']")

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

shedule