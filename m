From: keith.busch@intel.com (Keith Busch)
Date: Wed, 2 Sep 2015 19:07:59 +0000 (UTC)
Subject: setting nvme irq per cpu affinity in device driver
In-Reply-To: <003c01d0e569$dd9a7b40$98cf71c0$@samsung.com>
References: <003c01d0e569$dd9a7b40$98cf71c0$@samsung.com>
Message-ID: <alpine.LNX.2.00.1509021905520.23840@localhost.lm.intel.com>

On Wed, 2 Sep 2015, ??? wrote:
> Actually, in current status, device driver already tries to set
> affinity_hint for IRQs during Q initialization.
> But in our tests, it does not guarantee the CPU distribution on system-wide
> even with irqbalance daemon working, failing to resolve above issues.

Are you running irqbalance with '--hintpolicy=exact'? It Seems to do
the right thing over here.
