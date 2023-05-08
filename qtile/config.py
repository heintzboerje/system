# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, hook, extension
from libqtile.config import Click, Drag, Group, ScratchPad, DropDown, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from qtile_extras import widget
from qtile_extras.widget.decorations import BorderDecoration

# from qtile_extras.resources import wallpapers
from volumex import Volumex
import os
import subprocess

mod = "mod4"
terminal = guess_terminal()

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "up", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"],
        "left",
        lazy.layout.shuffle_left(),
        desc="Move window to the left",
    ),
    Key(
        [mod, "shift"],
        "right",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "up", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key(
        [mod, "control"],
        "left",
        lazy.layout.grow_left(),
        desc="Grow window to the left",
    ),
    Key(
        [mod, "control"],
        "right",
        lazy.layout.grow_right(),
        desc="Grow window to the right",
    ),
    Key([mod, "control"], "down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "up", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn("brightnessctl -n -e set 5%-"),
        desc="Raise brightness",
    ),
    Key(
        [],
        "XF86MonBrightnessUp",
        lazy.spawn("brightnessctl -e set +5%"),
        desc="Augment brightness",
    ),
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("pamixer -i 5 --allow-boost --set-limit 150"),
        desc="Raise volume",
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("pamixer -d 5 --allow-boost --set-limit 150"),
        desc="Lower volume",
    ),
    Key([], "XF86AudioMute", lazy.spawn("pamixer -t"), desc="Mute audio"),
    Key(
        [],
        "Print",
        lazy.spawn("/home/42ne/.local/bin/screenshot"),
        desc="Take screenshot",
    ),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key(
        [mod],
        "r",
        lazy.run_extension(
            extension.J4DmenuDesktop(
                j4dmenu_generic=False,
                # dmenu_height=18,
                dmenu_ignorecase=True,
                dmenu_lines=4,
            )
        ),
        desc="Spawn a command using a prompt widget",
    ),
    # Key([mod], "v", lazy.widget["visualiser"].start(), desc="Toggle visualiser"),
]

groups = [
    Group("1"),
    Group("2"),
    Group("3"),
    Group("4"),
    Group("4"),
    Group("5"),
    Group("6"),
    Group("7"),
    Group("8"),
    Group("9"),
    # ),
]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    # layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    layout.MonadThreeCol(
        margin=2,
        border_width=1,
        # border_focus="#ede346",
        border_focus="#66cccc",
    ),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    layout.Zoomy(),
]

widget_defaults = dict(
    font="Mononoki Nerd Font",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

decor = {
    "decorations": [
        BorderDecoration(border_width=[0, 0, 1, 0], colour="#c94824", padding=2)
    ],
}

screens = [
    Screen(
        top=bar.Bar(
            [
                # widget.TextBox(
                # "\uf325 ",
                # name="logo",
                # foreground="#efdc0b",
                # **decor,
                # ),
                widget.Image(filename="~/.config/qtile/guix.svg", margin=1),
                widget.AGroupBox(borderwidth=0),
                widget.GlobalMenu(),
                widget.Notify(),
                widget.Spacer(),
                # widget.Visualizer(
                # autostart=True,
                # cava_path="/home/42ne/.guix-profile/bin/cava",
                # hide=False,
                # background="#BC83E37F",
                # bar_color="#ffffff",
                # bars=5,
                # height=16,
                # width=100,
                # ),
                widget.WidgetBox(
                    text_closed="󱕏 ",
                    text_open="󰧛 ",
                    close_button_location="right",
                    widgets=[
                        widget.CPUGraph(
                            line_width=1,
                            graph_color="ff3399",
                            # fill_color="663399",
                            border_width=1,
                            border_color="9c99c9",
                            type="line",
                        ),
                        widget.NetGraph(
                            line_width=1,
                            graph_color="33f3f9",
                            fill_color="33f3f9",
                            border_width=1,
                            border_color="9c99c9",
                        ),
                        widget.MemoryGraph(
                            line_width=1,
                            graph_color="f6f329",
                            fill_color="f6f329",
                            border_width=1,
                            border_color="9c99c9",
                        ),
                    ],
                ),
                widget.Backlight(
                    backlight_name="intel_backlight",
                    update_interval=0.01,
                    format="{percent:2.0%} ",
                ),
                widget.UPowerWidget(
                    battery_height=9,
                    fill_charge="00f900",
                    fill_normal="cccccc",
                    border_colour="ffffff",
                    border_charge_colour="ffffff",
                    border_critical_colour="ffffff",
                ),
                Volumex(
                    # theme_path="/home/42ne/.local/share/icons/Deepin2022",
                    emoji=True,
                    volume_app="pamixer",
                    check_mute_command=["pamixer", "--get-mute"],
                    get_volume_command="--get-volume-human",
                    mute_command="--toggle-mute",
                    volume_down_command="--decrease 5",
                    volume_up_command="--increase 5 --allow-boost --set-limit 150",
                    update_interval=0.001,
                ),
                # widget.Bluetooth(),
                widget.WiFiIcon(interface="wlp0s20f3"),
                widget.AnalogueClock(face_shape="circle", hour_size=1, minute_size=1),
            ],
            17,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
            background="#00000000",
            # opacity=0,
        ),
        bottom=bar.Bar(
            [
                widget.Wttr(
                    location={"Les_Cayes": "Home"},
                    units="M",
                    update_interval=30,
                    format="%c %t %m",
                ),
                widget.Spacer(),
                # widget.GroupBox(
                # **decor,
                # highlight_method="block",
                # block_color="342453",
                # disable_drag=True,
                # hide_unused=True,
                # ),
                widget.Moc(),
                # widget.TaskList(
                # theme_mode="preferred",
                # theme_path="/home/42ne/.local/share/icons/Deepin2022",
                # ),
                widget.Spacer(),
                widget.Pomodoro(
                    prefix_inactive="\ue001 ",
                    prefix_active="\ue003 ",
                    prefix_break="\ue005 ",
                    prefix_long_break="\ue006 ",
                    prefix_paused="\ue004 ",
                    update_interval=None,
                ),
            ],
            24,
            background="#ffffff00",
            # opacity=0,
        ),
        wallpaper="~/.config/qtile/wallpapers/starry-night/tree.jpg",
        wallpaper_mode="fill",
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.Popen([home])
