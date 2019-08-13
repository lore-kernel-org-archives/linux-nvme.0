From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 13 Aug 2019 12:11:50 +0200
Subject: [PATCH v3 1/6] block: umem: rename LED_* macros to MEMCTRL_LED_*
In-Reply-To: <1565459703-30513-2-git-send-email-akinobu.mita@gmail.com>
References: <1565459703-30513-1-git-send-email-akinobu.mita@gmail.com>
 <1565459703-30513-2-git-send-email-akinobu.mita@gmail.com>
Message-ID: <20190813101150.GA26337@amd>

On Sun 2019-08-11 02:54:58, Akinobu Mita wrote:
> The umem driver defines LED_* macros for MEMCTRLCMD_LEDCTRL register
> values.  The LED_OFF and LED_ON macros conflict with the LED subsystem's
> LED_OFF and LED_ON enums.
> 
> This renames these LED_* macros to MEMCTRL_LED_* in umem driver.
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
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190813/9f14a906/attachment.sig>
