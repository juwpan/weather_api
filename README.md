# Тестовое задание: API для статистики по погоде

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

### Источник данных (https://developer.accuweather.com/apis.)

- API открыт для всех, авторизация не нужна.
- Ожидаемая нагрузка на любой эндпоинт: 5 RPS
- Город любой

# Задание.
### Необходимые эндпоинты:

* /weather/current - Текущая температура
* /weather/historical - Почасовая температура за последние 24 часа
* /weather/historical/max - Максимальная темперетура за 24 часа
* /weather/historical/min - Минимальная темперетура за 24 часа
* /weather/historical/avg - Средняя темперетура за 24 часа
* /weather/by_time - Найти температуру ближайшую к переданному timestamp (например 1621823790 должен отдать температуру за 2021-05-24 08:00. Из имеющихся данных, если такого времени нет вернуть 404)
* /health - Статус бекенда (Можно всегда отвечать OK)


### Важно!
1. Запуск команд производится в консоли вашей опреционой системы.

### Пошаговое руководство запуска приложения.