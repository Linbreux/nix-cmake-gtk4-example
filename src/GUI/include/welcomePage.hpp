#ifndef GTKMM_EXAMPLE_HELLOWORLD_H
#define GTKMM_EXAMPLE_HELLOWORLD_H

#include "gtkmm/columnview.h"
#include "gtkmm/fixed.h"
#include "gtkmm/headerbar.h"
#include "gtkmm/label.h"
#include <gtkmm/applicationwindow.h>
#include <gtkmm/button.h>

class WelcomePage : public Gtk::ApplicationWindow {

public:
  WelcomePage();
  ~WelcomePage() override;

protected:
  // Signal handlers:
  void on_button_clicked();

  // Member widgets:
  Gtk::Fixed *p_fixed;
  Gtk::Button m_button;

  Gtk::Label *m_label = nullptr;
};

#endif // GTKMM_EXAMPLE_HELLOWORLD_H
