from libqtile import widget
from libqtile import qtile


class Volumex(widget.PulseVolume):
    def _update_drawer(self):
        if self.theme_path:
            self.drawer.clear(self.background or self.bar.background)
            if self.volume <= 0:
                img_name = "audio-volume-muted"
            elif self.volume <= 30:
                img_name = "audio-volume-low"
            elif self.volume < 80:
                img_name = "audio-volume-medium"
            else:  # self.volume >= 80:
                img_name = "audio-volume-high"

            self.drawer.ctx.set_source(self.surfaces[img_name])
            self.drawer.ctx.paint()
        elif self.emoji:
            if self.volume <= 0:
                self.text = "󰸈 "
            elif self.volume <= 30:
                self.text = "\uf027 "
            elif self.volume < 80:
                self.text = "\udb81\udd7e "
            elif self.volume >= 80:
                self.text = "\uf028 "
        else:
            if self.volume == -1:
                self.text = "\udb81\udf5f"
            else:
                self.text = "{}%".format(self.volume)
