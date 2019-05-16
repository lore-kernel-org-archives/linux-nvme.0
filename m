From: kbusch@kernel.org (Keith Busch)
Date: Thu, 16 May 2019 13:01:22 -0600
Subject: [PATCH 1/4] nvme: fix srcu locking on error return in
 nvme_get_ns_from_disk
In-Reply-To: <20190516185036.17394-1-hch@lst.de>
References: <20190516185036.17394-1-hch@lst.de>
Message-ID: <20190516190122.GA23669@localhost.localdomain>

On Thu, May 16, 2019@08:50:33PM +0200, Christoph Hellwig wrote:
> If we can't get a namespace don't leak the SRCU lock.  nvme_ioctl was
> working around this, but nvme_pr_command wasn't handling this properly.
> Just do what callers would usually expect.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
