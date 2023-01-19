# Тестовое задание: API для статистики по погоде

### Источник данных (https://developer.accuweather.com/apis.)

<div>
  <a href="https://rubyonrails.org">
    <img src="https://img.shields.io/badge/Rails-7.0.4-ff0000?logo=RubyonRails&logoColor=white&?style=for-the-badge"
    alt="Rails badge" />
  </a>
  <a href="https://rubyonrails.org">
    <img src="https://img.shields.io/badge/Ruby-3.1.2-ff0000?logo=Ruby&logoColor=white&?style=for-the-badge"
    alt="Rails badge" />
  </a>
</div>

# Задание
### Необходимые эндпоинты:

* /weather/current - Текущая температура
* /weather/historical - Почасовая температура за последние 24 часа
* /weather/historical/max - Максимальная темперетура за 24 часа
* /weather/historical/min - Минимальная темперетура за 24 часа
* /weather/historical/avg - Средняя темперетура за 24 часа
* /weather/by_time - Найти температуру ближайшую к переданному timestamp (например 1621823790 должен отдать температуру за 2021-05-24 08:00. Из имеющихся данных, если такого времени нет вернуть 404)
* /health - Статус бекенда (Можно всегда отвечать OK)

### Дополнение к заданию:

* Ожидаемая нагрузка на любой эндпоинт: 5 RPS

### Важно!
Запуск команд производится в консоли вашей опреционой системы.

### Пошаговое руководство запуска приложения.

Перейдите в папку, в которую вы хотите скачать исходный код Ruby on Rails, и запустите:

```
$ git clone https://github.com/juwpan/weather_api.git
```
```
$ cd weather_api
```

### Установка зависимостей
```
bundle install
```
### Запуск миграции

```
bundle exec rails db:create
```
```
bundle exec rails db:migrate
```
### Создание ключей

В корне папки появится файл
```
.env
```
Запишите туда свой API соданный на сайте  (https://developer.accuweather.com/apis.)

Вид:
```
API_KEY_ACCUWEATHER="your_key"
```
### Запуск приложения

```
rails s
```

### Запуск тестов

```
bundle exec rspec
```

### Для смены локации поменяйте значение CITY_LOCAL  на ваше, в файле

```
/app/services/forecast_service.rb
```

### Использованные дополнительные библиотеки(gem)

* sidekiq и sidekiq-cron
* factory_bot_rails, rspec, vcr, webmock
* rack-throttle