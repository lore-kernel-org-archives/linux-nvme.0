From: keith.busch@intel.com (Keith Busch)
Date: Tue, 29 Aug 2017 18:00:12 -0400
Subject: [PATCH for-4.13] nvme-pci: use dma memory for the host memory
 buffer descriptors
In-Reply-To: <20170828084718.29007-1-hch@lst.de>
References: <20170828084718.29007-1-hch@lst.de>
Message-ID: <20170829220012.GE4428@localhost.localdomain>

On Mon, Aug 28, 2017@10:47:18AM +0200, Christoph Hellwig wrote:
> The NVMe 1.3 specification says in section 5.21.1.13:
> 
> "After a successful completion of a Set Features enabling the host memory
>  buffer, the host shall not write to the associated host memory region,
>  buffer size, or descriptor list until the host memory buffer has been
>  disabled."
> 
> While this doesn't state that the descriptor list must remain accessible
> to the device it certainly implies it must remaing readable by the device.
> 
> So switch to a dma coherent allocation for the descriptor list just to be
> safe - it's not like the cost for it matters compared to the actual
> memory buffers.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good to me.

Reviewed-by: Keith Busch <keith.busch at intel.com>
