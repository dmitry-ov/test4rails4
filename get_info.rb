# Заходим на страницу http://www.horizont-cinema.ru/
# Получаем названия фильмов и расписания.(время --- цена)
# Сохраняем себе в базу
#
#


agent = Mechanize.new

items = agent.get('http://www.horizont-cinema.ru').search(".//div[@class='af_category_item']")

shedule = {}

items.each do |item|
    title = item.search(".//div[@class='event_name']").children.children.children.text
    
    timetable = item.search(".//span[@id='msg_rpice']")

    shedule_title = [] 
    timetable.each do |row|
        time = row.children[0].text
        price = row.children[1].children[2].text
        shedule_title << "#{time} #{price}"
    end
    shedule.merge!({title => shedule_title})
end

shedule
    