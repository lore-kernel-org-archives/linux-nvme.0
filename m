From: kbusch@kernel.org (Keith Busch)
Date: Thu, 16 May 2019 13:01:38 -0600
Subject: [PATCH 2/4] nvme: remove the ifdef around nvme_nvm_ioctl
In-Reply-To: <20190516185036.17394-2-hch@lst.de>
References: <20190516185036.17394-1-hch@lst.de>
 <20190516185036.17394-2-hch@lst.de>
Message-ID: <20190516190137.GB23669@localhost.localdomain>

On Thu, May 16, 2019@08:50:34PM +0200, Christoph Hellwig wrote:
> We already have a proper stub if lightnvm is not enabled, so don't bother
> with the ifdef.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
