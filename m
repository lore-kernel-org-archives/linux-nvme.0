From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 8 May 2018 22:12:17 -0700
Subject: [PATCH nvme-4.18] nvme/pci: Hold controller reference during
 async probe
In-Reply-To: <20180507164322.28571-1-keith.busch@intel.com>
References: <20180507164322.28571-1-keith.busch@intel.com>
Message-ID: <20180509051217.GC28673@infradead.org>

On Mon, May 07, 2018@10:43:22AM -0600, Keith Busch wrote:
> It is possible the driver's remove may have freed the controller if
> the remove callback is invoked prior to the async_schedule starting
> the reset_work. This patch fixes that by holding a reference on the
> controller.
> 
> Reported-by: Mikulas Patocka <mpatocka at redhat.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
