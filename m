From: hch@lst.de (Christoph Hellwig)
Date: Fri, 11 May 2018 08:38:24 +0200
Subject: [PATCH] nvme/pci: Sync controller reset for AER slot_reset
In-Reply-To: <20180510160113.4432-1-keith.busch@intel.com>
References: <20180510160113.4432-1-keith.busch@intel.com>
Message-ID: <20180511063824.GB8368@lst.de>

On Thu, May 10, 2018@10:01:13AM -0600, Keith Busch wrote:
> AER handling expects a successful return from slot_reset means the
> driver made the device functional again. The nvme driver had been using
> an asynchronous reset to recover the device, so the device
> may still be initializing after control is returned to the
> AER handler. This creates problems for subsequent event handling,
> causing the initializion to fail.
> 
> This patch fixes that by syncing the controller reset before returning
> to the AER driver, and reporting the true state of the reset.

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
