From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 5 Apr 2016 23:56:04 -0700
Subject: [PATCH] NVMe: Re-introduce polling for completions
In-Reply-To: <20160405213904.GD12625@localhost.localdomain>
References: <1459808689-7689-1-git-send-email-keith.busch@intel.com>
 <20160405123523.GA19495@infradead.org>
 <20160405175437.GC12625@localhost.localdomain>
 <20160405213904.GD12625@localhost.localdomain>
Message-ID: <20160406065604.GA9391@infradead.org>

On Tue, Apr 05, 2016@09:39:04PM +0000, Keith Busch wrote:
> Before I resend with the requested code comments, I'd like to hear your
> opinion on an alternate solution (patch below).
> 
> Currently the driver uses legacy IRQ if available only until we know how
> many queues it can create. The legacy IRQ use is tripping up some h/w,
> but I've not heard such issues with MSI/MSI-x.
> 
> Would you prefer going straight to MSI-x? The driver does that when
> there is no INTx, but we wouldn't need to poll from the watchdog timer
> if we make MSI-x the default behavior,

I would much prefer that variant over doing crazy non-standard polling.
