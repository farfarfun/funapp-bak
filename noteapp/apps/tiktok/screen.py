from kivy.core.window import Window
from kivy.metrics import dp
from kivy.uix.screenmanager import FadeTransition, Screen, ScreenManager
from kivymd.uix.boxlayout import MDBoxLayout
from kivymd.uix.button import MDTextButton
from kivymd.uix.card import MDSeparator
from kivymd.uix.label import MDLabel
from noteapp.apps.tiktok.layout import NavBar, SnapScroll, VideoCard
from noteapp.utils.widget import widget_wrap

from .data import data as users


class Home(Screen):
    data = []

    def __init__(self, **kwargs):
        for profile in users:
            _data = {
                'name': profile['name'],
                'source': profile['video'],
                'caption': profile['caption'],
                'song_name': profile['song_name'],
                'profile_pic': profile['profile_pic'],
                'likes': profile['likes'],
                'comments': profile['comments'],
                'shares': profile['shares'],
                'album_pic': profile['album_pic'],
            }
            self.data.append(_data)
        super(Home, self).__init__(**kwargs)
        self.layout = MDBoxLayout(orientation='vertical', adaptive_height=True)

        layout1 = widget_wrap(
            MDBoxLayout(orientation='vertical'))
        layout11 = widget_wrap(
            ScreenManager(transition=FadeTransition()),
            widget_wrap(
                Screen(name="feed"),
                widget_wrap(
                    MDBoxLayout(md_bg_color=[0, 0, 0, 1], size_hint_y=None, height=self.height - dp(50)),
                    widget_wrap(SnapScroll(layout=self.layout), self.layout))),
            widget_wrap(Screen(name='discover'), MDLabel(text='Discover', halign='center')),
            widget_wrap(Screen(name='upload'), MDLabel(text='Upload')),
            widget_wrap(Screen(name='inbox'), MDLabel(text='Inbox', halign='center')),
            widget_wrap(Screen(name='profile'), MDLabel(text='Profile', halign='center')))

        layout12 = widget_wrap(MDBoxLayout(size_hint_y=None, height='50dp'), NavBar(screen_manager=layout11))

        layout1.add_widget(layout11)
        layout1.add_widget(layout12)

        layout2 = widget_wrap(
            MDBoxLayout(height=dp(20), size_hint_y=None, pos_hint={'top': .95, 'center_x': .5}, adaptive_width=True,
                        spacing='5dp'),
            MDTextButton(text='Following', font_size='16sp', theme_text_color='Custom', text_color=[1, 1, 1, .5]),
            MDSeparator(orientation='vertical', width='2dp', md_bg_color=[1, 1, 1, .5]),
            MDTextButton(text='Following', font_size='16sp', theme_text_color='Custom', text_color=[1, 1, 1, 1],
                         bold=True)
        )
        self.add_widget(layout1)
        self.add_widget(layout2)

    def on_enter(self, *args):
        for data in self.data:
            video_card = VideoCard()
            video_card.data = data
            video_card.height = Window.size[1] - dp(50)
            if self.data.index(data) == 0:
                video_card.video_state = 'play'

            self.layout.add_widget(video_card)
        return super(Home, self).on_enter(*args)
