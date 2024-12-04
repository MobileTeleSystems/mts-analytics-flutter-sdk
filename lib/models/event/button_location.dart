/// Место расположения элемента
///
/// Примеры своих имён,
/// которые можно отправить через вариант Custom [ButtonLocation.Custom('drawer_menu')]:
/// top_nav_menu, bottom_nav_menu, tab_menu, drawer_menu, main_menu, context_menu,
/// card, toast, snackbar, bottom_sheet_dialog, modal_dialog, fullscreen_dialog
library;

sealed class ButtonLocation {
  final String? value;
  const ButtonLocation(this.value);
}

class Nullable extends ButtonLocation {
  const Nullable() : super(null);
}

class Up extends ButtonLocation {
  const Up() : super('up');
}

class Mid extends ButtonLocation {
  const Mid() : super('mid');
}

class Down extends ButtonLocation {
  const Down() : super('down');
}

class Header extends ButtonLocation {
  const Header() : super('header');
}

class Footer extends ButtonLocation {
  const Footer() : super('footer');
}

class Popup extends ButtonLocation {
  const Popup() : super('popup');
}

class Screen extends ButtonLocation {
  const Screen() : super('screen');
}

class Sidebar extends ButtonLocation {
  const Sidebar() : super('sidebar');
}

class Curtain extends ButtonLocation {
  const Curtain() : super('curtain');
}

class Left extends ButtonLocation {
  const Left() : super('left');
}

class Right extends ButtonLocation {
  const Right() : super('right');
}

class TabBar extends ButtonLocation {
  const TabBar() : super('tab_bar');
}

class PlusMenu extends ButtonLocation {
  const PlusMenu() : super('plus_menu');
}

class TopBar extends ButtonLocation {
  const TopBar() : super('top_bar');
}

class Custom extends ButtonLocation {
  const Custom(String super.customName);
}
