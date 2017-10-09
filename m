From: keith.busch@intel.com (Keith Busch)
Date: Mon, 9 Oct 2017 09:12:11 -0600
Subject: [PATCH] nvme: simplify compat_ioctl handling
In-Reply-To: <20171005164646.17473-1-hch@lst.de>
References: <20171005164646.17473-1-hch@lst.de>
Message-ID: <20171009151210.GC19329@localhost.localdomain>

On Thu, Oct 05, 2017@06:46:46PM +0200, Christoph Hellwig wrote:
> We can just use our normal ioctl handler for the compat case and remove
> the boilerplate code for it.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good. The compact ioctl was left-over from SG_IO handling.

Reviewed-by: Keith Busch <keith.busch at intel.com>
