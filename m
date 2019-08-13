From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 13 Aug 2019 12:33:13 +0200
Subject: [PATCH v3 4/6] block: introduce LED block device activity trigger
In-Reply-To: <1565459703-30513-5-git-send-email-akinobu.mita@gmail.com>
References: <1565459703-30513-1-git-send-email-akinobu.mita@gmail.com>
 <1565459703-30513-5-git-send-email-akinobu.mita@gmail.com>
Message-ID: <20190813103313.GC26337@amd>

On Sun 2019-08-11 02:55:01, Akinobu Mita wrote:
> This allows LEDs to be controlled by block device activity.
> 
> We already have ledtrig-disk (LED disk activity trigger), but the lower
> level disk drivers need to utilize ledtrig_disk_activity() to make the
> LED blink.
> 
> The LED block device trigger doesn't require the lower level drivers to
> have any instrumentation. The activity is collected by polling the disk
> stats.
> 
> Example:
> 
> echo block-nvme0n1 > /sys/class/leds/diy/trigger

Some machines have lots of block devices... Should we perhaps have
"echo block > trigger; echo nvme0n1 > device"?

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190813/a5a8ffbc/attachment.sig>
