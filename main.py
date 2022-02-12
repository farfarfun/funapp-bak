from kivy.app import App
from kivy.uix.label import Label


class SampleApp(App):
    def __init__(self, text='Hello World', *args, **kwargs):
        super(SampleApp, self).__init__(**kwargs)
        self.text = text

    def build(self):
        return Label(text=self.text)


def main_app():
    try:
        from noteapp.screen import NoteApp
        return NoteApp()
    except Exception as e:
        text = f"error:{e}"
        return SampleApp(text=text)


main_app().run()
