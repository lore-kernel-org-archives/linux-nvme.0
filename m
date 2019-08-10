From: fsteiner-mail1@bio.ifi.lmu.de (Frank Steiner)
Date: Sat, 10 Aug 2019 17:41:39 +0200
Subject: [PATCH v2 0/3] introduce LED block device activity trigger
In-Reply-To: <1563807552-23498-1-git-send-email-akinobu.mita@gmail.com>
References: <1563807552-23498-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <0c3fa931-bdcd-5e7c-3d2a-16c8d6a95d28@bio.ifi.lmu.de>

Akinobu Mita wrote:

> This work is inspired by the report on linux-nvme mailing list.
> 
> disk-activity trigger not working for nvme disk:
> http://lists.infradead.org/pipermail/linux-nvme/2019-July/025253.html
> 
> This LED block device activity trigger works with any block devices.

I've backported/hacked this (together with the "rename LED_OFF and LED_ON"
and some additional patches) to the current SLES 15 kernel (4.12.14)
and can confirm that it works great for my Thinkpad T580 with e.g. the
FnLock LED, as well as for all our office desktops, using block-nvme0n1
as trigger.

cu,
Frank


-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
