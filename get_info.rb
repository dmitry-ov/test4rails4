# //*[@id="rt-mainbody"]/div/div[7]
# //*[@id="rt-mainbody"]/div/div[8]
#af_category_item

#  Заходим на страницу http://www.horizont-cinema.ru/
# Получаем названия фильмов и расписания.
# Сохраняем себе в базу
#
#

agent = Mechanize.new

# находим элементы расписания
items = agent.get('http://www.horizont-cinema.ru').search(".//div[@class='af_category_item']")

# в каждом элементе находим название фильма
title = []
items.each do |item|
	title << item.search(".//div[@class='event_name']").children.children.children.text
end
title



item = items[0]

	
timetable = item.search(".//span[@class='inpast']").text


