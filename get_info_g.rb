# Заходим на страницу http://www.horizont-cinema.ru/
# Получаем названия фильмов и расписания.(время --- цена)
# Сохраняем себе в базу TODO

agent = Mechanize.new
URL = 'http://www.horizont-cinema.ru'

films = agent.get(URL).search(".//div[@class='af_category_item']")

shedule = {}

films.each do |film|
    title = film.search(".//div[@class='event_name']").children.children.children.text
    
    shedule_title = []
    film.search(".//span[@id='msg_rpice']").each do |time|
        shedule_title << "#{time.children[0].text} #{time.children[1].children[2].text}"
    end
    shedule.merge!({title => shedule_title})
end

shedule
