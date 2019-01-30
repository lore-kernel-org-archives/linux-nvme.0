From: hch@lst.de (Christoph Hellwig)
Date: Wed, 30 Jan 2019 18:44:37 +0100
Subject: [PATCH-for-5.1] nvme: Use discard for quirked write zeroes devices
In-Reply-To: <20190130173822.19457-1-keith.busch@intel.com>
References: <20190130173822.19457-1-keith.busch@intel.com>
Message-ID: <20190130174436.GA7069@lst.de>

On Wed, Jan 30, 2019@10:38:22AM -0700, Keith Busch wrote:
> The current devices that set NVME_QUIRK_DEALLOCATE_ZEROES don't support
> the Write Zeroes NVMe command, but the driver still sets the queue limit
> that enables REQ_OP_WRITE_ZEROES. Continue using Data Set Management for
> such quirked controllers instead of the preferred Write Zeroes command.
> 
> Cc: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>

This looks sensible to me.  We should probably fold this into
the original patch to avoid bisection issues.
