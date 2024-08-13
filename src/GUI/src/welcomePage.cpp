#include "welcomePage.hpp"
#include "core.hpp"
#include "gtkmm/headerbar.h"
#include "gtkmm/object.h"
#include <iostream>

WelcomePage::WelcomePage() : m_button("Hello World"), m_label("nix window") {
  set_title("Main window");

  auto m_headerBar = Gtk::make_managed<Gtk::HeaderBar>();
  this->set_titlebar(*m_headerBar);

  p_fixed = Gtk::make_managed<Gtk::Fixed>();
  p_fixed->put(m_button, 100, 50);

  m_button.set_margin(10);

  m_button.signal_clicked().connect(
      sigc::mem_fun(*this, &WelcomePage::on_button_clicked));

  this->set_child(*p_fixed);
}

WelcomePage::~WelcomePage() {}

void WelcomePage::on_button_clicked() {
  m_label.set_margin(10);
  this->p_fixed->put(m_label, 250, 55);
  std::cout << core::greet() << std::endl;
}
