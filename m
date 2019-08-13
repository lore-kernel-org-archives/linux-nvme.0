From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 13 Aug 2019 12:12:08 +0200
Subject: [PATCH v3 2/6] scsi: mvsas: rename LED_* enums to SGPIO_LED_*
In-Reply-To: <1565459703-30513-3-git-send-email-akinobu.mita@gmail.com>
References: <1565459703-30513-1-git-send-email-akinobu.mita@gmail.com>
 <1565459703-30513-3-git-send-email-akinobu.mita@gmail.com>
Message-ID: <20190813101208.GB26337@amd>

On Sun 2019-08-11 02:54:59, Akinobu Mita wrote:
> The mvsas driver declares LED_* enums for enum sgpio_led_status. The
> LED_OFF and LED_ON enums cause redeclaration of enumerator with the
> LED subsystem's LED_OFF and LED_ON enums.
> 
> This adds 'SGPIO_' prefix to these enums in mvsas driver.
> 
> Cc: Frank Steiner <fsteiner-mail1 at bio.ifi.lmu.de>
> Cc: Jacek Anaszewski <jacek.anaszewski at gmail.com>

Acked-by: Pavel Machek <pavel at ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190813/bcaeee53/attachment.sig>
