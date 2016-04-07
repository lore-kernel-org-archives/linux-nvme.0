From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 07 Apr 2016 10:05:41 +0200
Subject: [PATCH] Avoid reset work on watchdog timer function during error
 recovery
In-Reply-To: <1459974635-16178-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1459974635-16178-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Message-ID: <1802104.y6NSSh3rgK@c203>

On Mittwoch, 6. April 2016 17:30:35 CEST Guilherme G. Piccoli wrote:
> This patch adds a check on nvme_watchdog_timer() function to avoid the
> call to reset_work() when an error recovery process is ongoing on
> controller. The check is made by looking at pci_channel_offline()
> result.
> 
> If we don't check for this on nvme_watchdog_timer(), error recovery
> mechanism can't recover well, because reset_work() won't be able to
> do its job (since we're in the middle of an error) and so the
> controller is removed from the system before error recovery mechanism
> can perform slot reset (which would allow the adapter to recover).
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli at linux.vnet.ibm.com>

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
