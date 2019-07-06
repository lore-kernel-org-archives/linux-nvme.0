From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Sun,  7 Jul 2019 02:58:58 +0900
Subject: [PATCH 1/2] leds: move declaration of led_stop_software_blink() to
 linux/leds.h
In-Reply-To: <1562435939-15466-1-git-send-email-akinobu.mita@gmail.com>
References: <1562435939-15466-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <1562435939-15466-2-git-send-email-akinobu.mita@gmail.com>

In preparation for adding LED block device activity trigger, expose
led_stop_software_blink() to outside the leds subsystem.

Cc: Frank Steiner <fsteiner-mail1 at bio.ifi.lmu.de>
Cc: Jacek Anaszewski <jacek.anaszewski at gmail.com>
Cc: Pavel Machek <pavel at ucw.cz>
Cc: Dan Murphy <dmurphy at ti.com>
Cc: Jens Axboe <axboe at kernel.dk>
Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
---
 drivers/leds/leds.h  | 1 -
 include/linux/leds.h | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds.h b/drivers/leds/leds.h
index 47b2294..64fe774 100644
--- a/drivers/leds/leds.h
+++ b/drivers/leds/leds.h
@@ -18,7 +18,6 @@ static inline int led_get_brightness(struct led_classdev *led_cdev)
 }
 
 void led_init_core(struct led_classdev *led_cdev);
-void led_stop_software_blink(struct led_classdev *led_cdev);
 void led_set_brightness_nopm(struct led_classdev *led_cdev,
 				enum led_brightness value);
 void led_set_brightness_nosleep(struct led_classdev *led_cdev,
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 9b2bf57..6aeda4f 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -189,6 +189,8 @@ extern void led_blink_set_oneshot(struct led_classdev *led_cdev,
 extern void led_set_brightness(struct led_classdev *led_cdev,
 			       enum led_brightness brightness);
 
+extern void led_stop_software_blink(struct led_classdev *led_cdev);
+
 /**
  * led_set_brightness_sync - set LED brightness synchronously
  * @led_cdev: the LED to set
-- 
2.7.4
