From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Dec 2014 09:46:36 +0100
Subject: [PATCH] misc: Increase available dyanmic minors
In-Reply-To: <1418079710-30968-1-git-send-email-keith.busch@intel.com>
References: <1418079710-30968-1-git-send-email-keith.busch@intel.com>
Message-ID: <3419037.dh84oOupWY@wuerfel>

On Monday 08 December 2014 16:01:50 Keith Busch wrote:
> This increases the number of available miscellaneous character device
> dynamic minors from 63 to the max minor, 1M.
> 
> Dynamic minor previously started at 63 and went down to zero. That's not
> enough in some situations, and also eventually creates a collision with
> 'psaux' misc device. This patch starts minors at the last defined misc
> minor (255) and works up to the max possible.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

I guess this will break support for ancient user space tools, and
possibly also old file systems that do not support more than 8-bit
minor numbers. I would assume that it's ok, but you definitely have
to mention in the changelog that things might break and how you
have concluded that this is safe enough.

If you cannot come up with a good reasoning, it might be better
to combine both and use up the traditional dynamic minor numbers
before using the >255 range.

	Arnd
