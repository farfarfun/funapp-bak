import os

from kivy.app import App
from kivy.uix.label import Label


class SampleApp(App):
    def build(self):
        text = 'Hello World'
        try:
            from noteapp.screen import main_screen
            main_screen()
        except Exception as e:
            text = f"error:{e}"
        text += f"\n{os.listdir()}"
        return Label(text=text)


SampleApp().run()
