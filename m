From: keith.busch@intel.com (Keith Busch)
Date: Wed, 6 Apr 2016 20:50:23 +0000
Subject: [PATCH] Avoid reset work on watchdog timer function during
 error recovery
In-Reply-To: <1459974635-16178-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1459974635-16178-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Message-ID: <20160406205023.GA4140@localhost.localdomain>

On Wed, Apr 06, 2016@05:30:35PM -0300, Guilherme G. Piccoli wrote:
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

Reviewed-by: Keith Busch <keith.busch at intel.com>
