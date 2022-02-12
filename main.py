from kivy.app import App
from kivy.uix.label import Label


class SimpleLabel(Label):
    def __init__(self, *args, **kwgs):
        super(SimpleLabel, self).__init__(**kwgs)
        self.text = 'Hello World'
        try:
            from noteapp.screen import main_screen
            main_screen
        except Exception as e:
            self.text = f"error:{e}"


class SampleApp(App):
    def build(self):
        return SimpleLabel()


SampleApp().run()
