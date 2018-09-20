From: hch@lst.de (Christoph Hellwig)
Date: Thu, 20 Sep 2018 08:30:47 +0200
Subject: [PATCH] nvme/pci: Fix hot removal during error handling
In-Reply-To: <20180919154852.28187-1-keith.busch@intel.com>
References: <20180919154852.28187-1-keith.busch@intel.com>
Message-ID: <20180920063047.GA12913@lst.de>

On Wed, Sep 19, 2018@09:48:52AM -0600, Keith Busch wrote:
> A removal waits for the reset_work to complete. If a surprise removal
> occurs around the same time as an error triggered controller reset,
> and reset work happened to dispatch a command to the removed controller,
> the command won't be recovered since the timeout work doesn't do
> anything during error recovery.
> 
> This patch fixes this by killing admin queues prior to syncing reset.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Looks sensible to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>
