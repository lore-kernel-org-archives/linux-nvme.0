From: keith.busch@intel.com (Keith Busch)
Date: Tue, 5 Apr 2016 17:54:37 +0000
Subject: [PATCH] NVMe: Re-introduce polling for completions
In-Reply-To: <20160405123523.GA19495@infradead.org>
References: <1459808689-7689-1-git-send-email-keith.busch@intel.com>
 <20160405123523.GA19495@infradead.org>
Message-ID: <20160405175437.GC12625@localhost.localdomain>

On Tue, Apr 05, 2016@05:35:23AM -0700, Christoph Hellwig wrote:
> So how do any other PCIe device work given that almost no driver does
> unconditionaly polling?

I honestly don't have a good answer to that, and I agree with you
that this shouldn't be necessary ... but this is a harmless way to not
frustrate people who purchase these devices.

I suspect other PCI device drivers either at least try to never use the
legacy IRQ, or they've never been tested in platforms that break them.

> > +	spin_lock_irq(&admin_q->q_lock);
> > +	nvme_process_cq(admin_q);
> > +	spin_unlock_irq(&admin_q->q_lock);
> 
> Add a comment on why this is done.  Given that only the admin queue
> is polled it's going to be a really convoluted explanation which should
> be spelled out in detail.

Sounds good.
