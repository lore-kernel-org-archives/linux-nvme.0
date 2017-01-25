From: hch@lst.de (Christoph Hellwig)
Date: Wed, 25 Jan 2017 09:14:47 +0100
Subject: [PATCH] nvme/pci: Don't mark IOD as aborted if abort wasn't sent
In-Reply-To: <1485299220-14866-1-git-send-email-keith.busch@intel.com>
References: <1485299220-14866-1-git-send-email-keith.busch@intel.com>
Message-ID: <20170125081447.GA14954@lst.de>

On Tue, Jan 24, 2017@06:07:00PM -0500, Keith Busch wrote:
> This patch sets the aborted flag only if an abort was sent, reducing
> excessive kernel message spamming for completed IO that wasn't actually
> aborted.
> 
> Reported-by: Jens Axboe <axboe at kernel.dk>
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
