# Заходим на страницу http://www.horizont-cinema.ru/
# Получаем названия фильмов и расписания.(время --- цена)
# Сохраняем себе в базу
#
#


agent = Mechanize.new

films = agent.get('http://www.horizont-cinema.ru').search(".//div[@class='af_category_item']")

shedule = {}

films.each do |film|
    title = film.search(".//div[@class='event_name']").children.children.children.text
    
    shedule_title = []
    film.search(".//span[@id='msg_rpice']").each do |timetable_item|
        shedule_title << "#{timetable_item.children[0].text} #{timetable_item.children[1].children[2].text}"
    end
    shedule.merge!({title => shedule_title})
end

shedule