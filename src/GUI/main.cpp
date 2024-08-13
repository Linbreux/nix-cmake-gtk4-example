#include <gtkmm.h>

#include "welcomePage.hpp"

int main(int argc, char *argv[]) {
  auto app = Gtk::Application::create("org.gtkmm.examples.base");

  return app->make_window_and_run<WelcomePage>(argc, argv);
}
