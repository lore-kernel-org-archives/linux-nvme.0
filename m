From: keith.busch@intel.com (Keith Busch)
Date: Mon, 4 Jan 2016 15:54:32 +0000
Subject: [PATCHv2 5/5] NVMe: Shutdown controller only for power-off
In-Reply-To: <568951C7.5010504@dev.mellanox.co.il>
References: <1451580116-12252-1-git-send-email-keith.busch@intel.com>
 <1451580116-12252-6-git-send-email-keith.busch@intel.com>
 <568951C7.5010504@dev.mellanox.co.il>
Message-ID: <20160104155431.GH31375@localhost.localdomain>

On Sun, Jan 03, 2016@06:52:23PM +0200, Sagi Grimberg wrote:
> 
> >We don't need to shutdown a controller for a reset. A controller in a
> >shutdown state may take longer to become ready than one that was simply
> >disabled.
> 
> Just out of curiosity, what's "longer"? how much does this patch save us?

It depends on the device's capacity in my experience. Testing on a 2TB
P3700, a complete reset takes about 8 seconds when using controller
shutdown, and ~3 seconds without it.
