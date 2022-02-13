"""

"""
from kivy.metrics import dp
from kivy.properties import ObjectProperty
from kivy.uix.behaviors import ButtonBehavior
from kivy.uix.image import Image
from kivy.uix.scrollview import ScrollView
from kivy.uix.video import Video
from kivy.utils import get_color_from_hex
from kivymd.uix.boxlayout import MDBoxLayout
from kivymd.uix.floatlayout import MDFloatLayout
from kivymd.uix.label import MDIcon, MDLabel
from kivymd.utils.fitimage import FitImage


class VideoCard(MDBoxLayout):
    def __init__(self, data, md_bg_color=[0, 0, 0, 1],
                 size_hint_y=None, video_state='stop', *args, **kwargs):
        super(VideoCard, self).__init__(**kwargs)
        self.data = data
        self.md_bg_color = md_bg_color
        self.size_hint_y = size_hint_y
        self.video_state = video_state
        layout1 = MDFloatLayout()
        layout11 = Video(source=data['source'], state=video_state, pos_hint={'center_x': .5, 'top': 1})

        layout12 = MDBoxLayout(orientation='vertical', pos_hint={'x': 0, 'y': 0}, size_hint_x=None,
                               width=self.width * 0.8, spacing='5dp', padding='5dp')

        layout121 = MDBoxLayout(size_hint_y=None, height=self.minimum_height)
        layout121.add_widget(MDIcon(icon='music-note', size_hint=(None, 1), font_size='14sp',
                                    # size=MDIcon.texture_size,
                                    ))
        layout121.add_widget(MDLabel(text=data['song_name'], font_size='14sp', size_hint_y=None,
                                     # height=MDLabel.texture_size[1],
                                     ))

        layout12.add_widget(MDLabel(text=data['name'], font_size='14sp', size_hint_y=None,
                                    # height=MDLabel.texture_size[1],
                                    ))
        layout12.add_widget(MDLabel(text=data['caption'], font_size='14sp', size_hint_y=None,
                                    # height=MDLabel.texture_size[1]
                                    ))
        layout12.add_widget(layout121)

        layout13 = MDBoxLayout(orientation='vertical', pos_hint={'right': 1, 'y': 0}, size_hint_x=None,
                               width=self.width * 0.2, spacing='20dp', padding='5dp')
        layout13.add_widget(ProfileImg(img=data['profile_pic']))
        layout13.add_widget(NavIcon(icon='\U0000E80A', text=data['likes'], icon_size='40sp'))
        layout13.add_widget(NavIcon(icon='\U0000E808', text=data['comments'], icon_size='40sp'))
        layout13.add_widget(NavIcon(icon='\U0000E80E', text=data['shares'], icon_size='25sp'))
        layout13.add_widget(AlbumImg(img=data['album_pic']))

        layout1.add_widget(layout11)
        layout1.add_widget(layout12)
        layout1.add_widget(layout13)


class ProfileImg(MDFloatLayout):
    def __init__(self, size_hint=(None, None), size=('50dp', '50dp'), radius='25dp', md_bg_color=[1, 1, 1, 1], img='',
                 **kwargs):
        super(ProfileImg, self).__init__(**kwargs)
        self.size_hint = size_hint
        self.size = size
        self.radius = radius
        self.md_bg_color = md_bg_color
        self.img = img
        self.add_widget(FitImage(source=self.img,
                                 radius=self.radius,
                                 size=('45dp', '45dp'),
                                 size_hint=(None, None),
                                 center=self.center))

        self.add_widget(MDLabel(text='+',
                                font_size='15sp',
                                pos_hint={'center_x': .5, 'y': -.15},
                                size=(dp(20), dp(20)),
                                size_hint=(None, None),
                                md_bg_color=get_color_from_hex('#FC2D55'),
                                radius='20dp',
                                halign='center',
                                bold=True))


class AlbumImg(MDFloatLayout):
    def __init__(self, size_hint=(None, None), size=(50, 50), radius=25, md_bg_color=None, img='', **kwargs):
        super(AlbumImg, self).__init__(**kwargs)
        if md_bg_color is None:
            md_bg_color = [0, 0, 0, 1]
        self.size_hint = size_hint
        self.size = size
        self.radius = radius
        self.md_bg_color = md_bg_color
        self.img = img

        self.add_widget(FitImage(source=self.img, radius=self.radius, size=('30dp', '30dp'), size_hint=(None, None),
                                 center=self.center))


class NavBar(MDBoxLayout):
    def __init__(self, md_bg_color=[0, 0, 0, 1], orientation='vertical', height=dp(50), size_hint_y=None,
                 screen_manager=None, **kwargs):
        self.md_bg_color = md_bg_color
        self.orientation = orientation
        self.height = height
        self.size_hint_y = size_hint_y
        self.screen_manager = screen_manager
        super(NavBar, self).__init__(**kwargs)

        layout = MDBoxLayout(padding=('10dp', '5dp'), spacing='5dp')
        layout.add_widget(NavIcon(icon='\U0000E80B', text='Home', icon_size='18sp', text_size='10sp', screen='feed'))
        layout.add_widget(NavIcon(icon='\U0000E80F', text='Discover', icon_size='18sp', text_size='10sp',
                                  screen='discover'))
        layout.add_widget(
            Image(source='/Users/bingtao/workspace/MyDiary/src/games/notetiktok/tiktok/assets/img/plus.png',
                  size_hint_x=None, width='35dp'))
        layout.add_widget(NavIcon(icon='\U0000E80C', text='Inbox', icon_size='18sp', text_size='10sp', screen='inbox'))
        layout.add_widget(NavIcon(icon='\U0000E80D', text='Me', icon_size='18sp', text_size='10sp', screen='profile'))
        self.add_widget(layout)
        self.add_widget(MDBoxLayout(size_hint_y=None, height='5dp'))


class NavIcon(ButtonBehavior, MDBoxLayout):
    def __init__(self, icon='', text='', orientation='vertical', text_size='14sp', icon_size='35sp', screen='',
                 **kwargs):
        super(NavIcon, self).__init__(**kwargs)
        self.adaptive_height = True
        self.icon = icon
        self.text = text
        self.orientation = orientation
        self.text_size = text_size
        self.icon_size = icon_size
        self.screen = screen

        self.add_widget(MDIcon(text=self.icon,
                               font_size=self.icon_size,
                               font_style='TikTokIcons',
                               # height=self.texture_size[1],
                               halign='center',
                               size_hint_y=None
                               ))
        self.add_widget(MDLabel(text=self.text,
                                # height=self.texture_size[1],
                                font_size=self.text_size,
                                bold=True,
                                size_hint_y=None,
                                halign='center',
                                ))

    def on_press(self):
        self.parent.parent.screen_manager.current = self.screen


class SnapScroll(ScrollView):
    layout = ObjectProperty()  # The adaptive layout inside the scrollview; where widgets are added to

    def __init__(self, scroll_distance=500, bar_width=0, scroll_wheel_distance=0, **kwargs):
        self.scroll_distance = scroll_distance  # helps prevent kivy detecting multiple scroll in one drag.
        self.bar_width = bar_width
        self.scroll_wheel_distance = scroll_wheel_distance  # disable mouse scrolling
        super(SnapScroll, self).__init__(**kwargs)

    def on_scroll_start(self, touch, check_children=True):
        touch.ud['pos'] = self.to_local(*touch.pos)  # saving the touch pos clicked by the user.
        for widget in self.layout.children:  # Looping through all widget to get the clicked widget
            if widget != self:
                if widget.collide_point(*touch.ud['pos']):
                    touch.ud['widget'] = widget  # saving the widget that recieved the touch
                    touch.ud['index'] = self.layout.children.index(widget)  # and its index

        return super().on_scroll_start(touch, check_children=check_children)  # Make sure you return this

    def on_scroll_stop(self, touch, check_children=True):
        self._touch = None  # cancel touch
        local_touch = self.to_local(*touch.pos)

        if local_touch[1] > touch.ud['pos'][1]:  # Comparing current touch pos with the one we saved.
            # to know the direction the user is scrolling.
            if touch.ud['index'] != 0:  # If widget is not the first, scroll up
                self.scroll_to(self.layout.children[touch.ud['index'] - 1], padding=0)
                self.layout.children[touch.ud['index'] - 1].video_state = 'play'  # play next video
                self.layout.children[touch.ud['index']].video_state = 'pause'  # pause current video

        elif local_touch[1] < touch.ud['pos'][1]:
            if touch.ud['index'] < len(self.layout.children) - 1:  # If widget is not the last, scroll down
                self.scroll_to(self.layout.children[touch.ud['index'] + 1], padding=0)

                self.layout.children[touch.ud['index'] + 1].video_state = 'play'  # play prev video
                self.layout.children[touch.ud['index']].video_state = 'pause'  # pause current video

        touch.ud.pop('pos')  # we are done with the pos we save so we clear it
        return True  # ...........
