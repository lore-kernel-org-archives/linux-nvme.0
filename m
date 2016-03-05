From: willy@linux.intel.com (Matthew Wilcox)
Date: Sat, 5 Mar 2016 17:39:49 -0500
Subject: [PATCH] NVMe: Create discard zero quirk white list
In-Reply-To: <20160304180443.GA3972@infradead.org>
References: <1457113522-14099-1-git-send-email-keith.busch@intel.com>
 <20160304180443.GA3972@infradead.org>
Message-ID: <20160305223949.GD5530@linux.intel.com>

On Fri, Mar 04, 2016@10:04:43AM -0800, Christoph Hellwig wrote:
> On Fri, Mar 04, 2016@10:45:22AM -0700, Keith Busch wrote:
> > The NVMe specification does not require discarded blocks return zeroes on
> > read, but provides that behavior as a possibility. Some applications more
> > efficiently use an SSD if reads on discarded blocks were deterministically
> > zero, based on the "discard_zeroes_data" queue attribute.
> 
> Meh, indeed:
> 
> "If a read occurs to a deallocated range, the controller shall return
> all zeros, all ones, or the last data written to the associated LBA."
> 
> time to write a TP for a bit on the identify page..

Since we have a WRITE ZEROES command, do we need this?

> > There is no specification defined way to determine device behavior on
> > discarded blocks, so the driver always left the queue setting disabled. We
> > can only know behavior based on individual device models, so this patch
> > adds a flag to the NVMe "quirk" list that vendors may set if they know
> > their controller works that way. The patch also sets the new flag for one
> > such known device.
> > 
> > Suggested-by: Artur Paszkiewicz <artur.paszkiewicz at intel.com>
> > Signed-off-by: Keith Busch <keith.busch at intel.com>
> 
> Not happy about this, but I guess we'll need something like this in the
> long run..
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
