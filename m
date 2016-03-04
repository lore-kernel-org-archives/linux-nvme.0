From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 4 Mar 2016 10:04:43 -0800
Subject: [PATCH] NVMe: Create discard zero quirk white list
In-Reply-To: <1457113522-14099-1-git-send-email-keith.busch@intel.com>
References: <1457113522-14099-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160304180443.GA3972@infradead.org>

On Fri, Mar 04, 2016@10:45:22AM -0700, Keith Busch wrote:
> The NVMe specification does not require discarded blocks return zeroes on
> read, but provides that behavior as a possibility. Some applications more
> efficiently use an SSD if reads on discarded blocks were deterministically
> zero, based on the "discard_zeroes_data" queue attribute.

Meh, indeed:

"If a read occurs to a deallocated range, the controller shall return
all zeros, all ones, or the last data written to the associated LBA."

time to write a TP for a bit on the identify page..

> There is no specification defined way to determine device behavior on
> discarded blocks, so the driver always left the queue setting disabled. We
> can only know behavior based on individual device models, so this patch
> adds a flag to the NVMe "quirk" list that vendors may set if they know
> their controller works that way. The patch also sets the new flag for one
> such known device.
> 
> Suggested-by: Artur Paszkiewicz <artur.paszkiewicz at intel.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Not happy about this, but I guess we'll need something like this in the
long run..

Reviewed-by: Christoph Hellwig <hch at lst.de>
