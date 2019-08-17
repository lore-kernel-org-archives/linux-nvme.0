From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 17 Aug 2019 16:55:09 +0200
Subject: [PATCH v4 4/5] block: introduce LED block device activity trigger
In-Reply-To: <1565888399-21550-5-git-send-email-akinobu.mita@gmail.com>
References: <1565888399-21550-1-git-send-email-akinobu.mita@gmail.com>
 <1565888399-21550-5-git-send-email-akinobu.mita@gmail.com>
Message-ID: <20190817145509.GA18381@amd>

On Fri 2019-08-16 01:59:58, Akinobu Mita wrote:
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

Lets use one trigger "block" and have the device as a parameter,
please.

We already have 1000 cpu triggers on 1000 cpu machines, and yes, its a
disaster we'll need to fix. Lets not repeat the same mistake here.

I guess it may be slightly more work. Sorry about that.

								Pavel

> +++ b/include/linux/leds.h
> +#else
> +
> +struct ledtrig_blk {
> +};
> +

Is the empty struct neccessary?

> +static inline void ledtrig_blk_enable(struct gendisk *disk)
> +{
> +}
> +
> +static inline void ledtrig_blk_disable(struct gendisk *disk)
> +{
> +}
> +
> +static inline int ledtrig_blk_register(struct gendisk *disk)
> +{
> +	return 0;
> +}
> +
> +static inline void ledtrig_blk_unregister(struct gendisk *disk)
> +{
> +}

Normally we put such empty functions on single lines...

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
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190817/55367839/attachment.sig>
