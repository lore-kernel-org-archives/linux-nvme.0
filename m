From: hch@lst.de (Christoph Hellwig)
Date: Fri, 25 May 2018 14:35:49 +0200
Subject: [PATCHv3 8/9] nvme-pci: Queue creation error handling
In-Reply-To: <20180524203500.14081-9-keith.busch@intel.com>
References: <20180524203500.14081-1-keith.busch@intel.com>
 <20180524203500.14081-9-keith.busch@intel.com>
Message-ID: <20180525123549.GB23463@lst.de>

On Thu, May 24, 2018@02:34:59PM -0600, Keith Busch wrote:
> This patch sets the nvmeq's cq_vector only after the cq was successfully
> created. This way a device reset doesn't mistakenly believe that the
> vector is allocated. In case a reset does occur during queue creation,
> this patch will return status immediately instead of trying to unwind
> the created queues since the device won't be able to delete queues anyway.
> 
> This patch will also handle device reported failures correctly. These
> errors are reported as positive nvme status codes, which were previously
> not handled at all.

I applied the original patch this morning with some minor fixup.  Can
you send a relative patch to the nvme-4.18-2 tree?
