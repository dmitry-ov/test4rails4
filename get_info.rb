# //*[@id="rt-mainbody"]/div/div[7]
# //*[@id="rt-mainbody"]/div/div[8]
#af_category_item

#  Заходим на страницу http://www.horizont-cinema.ru/
# Получаем названия фильмов и расписания.(время --- цена)
# Сохраняем себе в базу
#
#

agent = Mechanize.new

# находим элементы расписания
items = agent.get('http://www.horizont-cinema.ru').search(".//div[@class='af_category_item']")

# в каждом элементе находим название фильма
title = []
shedule = []

items.each do |item|
	title << item.search(".//div[@class='event_name']").children.children.children.text
	timetable = item.search(".//span[@class='inpast']")
   
    timetable.each do |row|
		# время начала сеанса
		time = row.children[0].text
		# цена билета
		price = row.children[1].children[2]
		shedule << "#{time} #{price}"  
    end
end
title
shedule


