/// Тип элемента. При формировании эвента, дополняется видом действия.
///
/// Example: button_tap или video_play
///
/// Также популярные примеры в экосистеме МТС:
/// cover, icon, widget, slide,
sealed class Target {
  final String value;
  const Target(this.value);
}

/// Кнопка
class Button extends Target {
  const Button() : super('button');
}

/// Переключатель
class Switcher extends Target {
  const Switcher() : super('switcher');
}

/// Элемент сайта/приложения, отличный от кнопки
class Element extends Target {
  const Element() : super('element');
}

/// Карточка товара/тарифа/услуги
class Card extends Target {
  const Card() : super('card');
}

/// Блок с информацией/кнопками
class Block extends Target {
  const Block() : super('block');
}

/// Форма
class Form extends Target {
  const Form() : super('form');
}

/// Фильтр
class Filter extends Target {
  const Filter() : super('filter');
}

/// Меню сайта
class Menu extends Target {
  const Menu() : super('menu');
}

/// Вкладка
class Tab extends Target {
  const Tab() : super('tab');
}

/// Ссылка, гиперссылка
class Link extends Target {
  const Link() : super('link');
}

/// Баннер
class Banner extends Target {
  const Banner() : super('banner');
}

/// Попап
class Popup extends Target {
  const Popup() : super('popup');
}

/// Иконки мобильных приложений, который переадресуют в PlayMarket/AppStore
class App extends Target {
  const App() : super('app');
}

/// Иконки социальных сетей
class Social extends Target {
  const Social() : super('social');
}

/// Выбор региона
class Region extends Target {
  const Region() : super('region');
}

/// Оффер
class Offer extends Target {
  const Offer() : super('offer');
}

/// Видео
class Video extends Target {
  const Video() : super('video');
}

/// Файл
class Doc extends Target {
  const Doc() : super('doc');
}

/// Ошибка
class Error extends Target {
  const Error() : super('error');
}

/// Используется для формирования эвента без взаимодействия с пользователем
///
/// Example: Подставляется в эвент как: [MtsEvent.eventAction] = [EAction.empty]
class Empty extends Target {
  const Empty() : super('');
}

class Custom extends Target {
  const Custom(super.value);
}
