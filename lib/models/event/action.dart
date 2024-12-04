/// Вид действия. При формировании эвента, дополняется типом элемента.
///
/// Example: button_tap или video_play
///
/// Также популярные примеры в экосистеме МТС:
/// retry,
sealed class Action {
  final String value;
  const Action(this.value);
}

/// действие, клик пользователем на элемент, кнопку, иконку
class Click extends Action {
  const Click() : super('click');
}

/// тап пользователем на элемент, кнопку, иконку
class Tap extends Action {
  const Tap() : super('tap');
}

/// действие, открытие pop-up, переход в карточку товара/услуги/тарифа
class Open extends Action {
  const Open() : super('open');
}

/// переключение переключателя
class Switch extends Action {
  const Switch() : super('switch');
}

/// добавление товара/тарифа/услуги в корзину, прикрепление файлов/фото/документов
class Add extends Action {
  const Add() : super('add');
}

/// удаление товара/тарифа/услуги в корзину
class Remove extends Action {
  const Remove() : super('remove');
}

/// состояние переключателя
class Status extends Action {
  const Status() : super('status');
}

/// клик по лайку товара/тарифа/услуги
class Like extends Action {
  const Like() : super('like');
}

/// отправка формы
class Send extends Action {
  const Send() : super('send');
}

/// прилистывание сайта (скроллинг)
class Scroll extends Action {
  const Scroll() : super('scroll');
}

/// показ баннеров, элементов
class Show extends Action {
  const Show() : super('show');
}

/// скрытие баннеров, элементов
class Hide extends Action {
  const Hide() : super('hide');
}

/// создание
class Create extends Action {
  const Create() : super('create');
}

/// применить настройки, условия фильтра
class Apply extends Action {
  const Apply() : super('apply');
}

/// изменить
class Change extends Action {
  const Change() : super('change');
}

/// поделиться информацией  (например:в социальных сетях)
class Share extends Action {
  const Share() : super('share');
}

/// подтверждение в подключении
class Confirmed extends Action {
  const Confirmed() : super('confirmed');
}

/// отказ в подключении
class Rejected extends Action {
  const Rejected() : super('rejected');
}

/// закрыть
class Close extends Action {
  const Close() : super('close');
}

/// свайп влево/вправо/вверх/вниз
class Swipe extends Action {
  const Swipe() : super('swipe');
}

/// запуск видео
class Play extends Action {
  const Play() : super('play');
}

/// постановка видео на паузу
class Pause extends Action {
  const Pause() : super('pause');
}

/// Используется для формирования эвента без взаимодействия с пользователем
///
/// Example: Подставляется в эвент как: [MtsEvent.eventAction] = [EAction.empty]
class Empty extends Action {
  const Empty() : super('');
}

class Custom extends Action {
  const Custom(super.value);
}
