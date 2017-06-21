From: alan.adamson@oracle.com (Alan Adamson)
Date: Wed, 21 Jun 2017 13:30:40 -0700
Subject: [PATCH] nvme: set DMA_ATTR_WEAK_ORDERING attribute on dma buffers
In-Reply-To: <20170617115703.GA13002@lst.de>
References: <1497645290-31041-1-git-send-email-alan.adamson@oracle.com>
 <20170617115703.GA13002@lst.de>
Message-ID: <6a32f30b-433a-9857-164f-1717405a6082@oracle.com>

Christoph,


Hopefully, this answers your questions.

The SPARC platforms are designed in accordance with PCIe specification 
and expects the the device driver to set DMA_ATTR_WEAK_ORDERING to avoid 
restrict ordering rules enforced by PCIe root-complex and ultimately 
experience higher latency for DMA Writes.

The Root Complex needs to break PCIe Memory Write request into one or 
more cacheline size requests to host memory. If RO is not set, those 
cacheline requests are serialized and the next/subsequent write cannot 
issue until the coherency acknowledgment for the first/earlier write is 
received. This serialization of write transactions can significantly 
impact sustained DMA write performance for the given device.

Relaxed ordering should be used as much as possible to avoid the 
serialization penalty described above. The risk of using weak ordering 
indiscriminately on all writes, however, is that certain devices and 
drivers may rely on strong ordering for certain writes. For example, a 
device may use a specific location in host memory to serve as a "done" 
flag. The device writes data to a buffer, and those writes can be 
relaxed because the order in which the data bytes enter the buffer is 
not visible to software. The device then writes to the "done" flag 
location, to indicate to the consumer that it has completed the buffer 
write. The write to "done" cannot pass the prior writes to the data 
buffer; otherwise software polling on the "done" location could 
potentially read stale data from the data buffer. Device driver 
developers need to understand the hardware behavior and only set the 
DMA_ATTR_WEAK_ORDERING attribute when safe.

Alan Adamson

On 06/17/2017 04:57 AM, Christoph Hellwig wrote:
> On Fri, Jun 16, 2017@01:34:50PM -0700, Alan Adamson wrote:
>> SPARC based platforms suffer significant read performance penalties for
>> nvme reads when Relaxed Ordering is not enabled. This change sets the
>> DMA_ATTR_WEAK_ORDERING (Relaxed Ordering) attribute for nvme block dma
>> buffers.
> Please explain what it does exactly, and why you think it's safe for NVMe,
> as that belongs into the changelog.
>
> Bonus points for explaining why DMA_ATTR_WEAK_ORDERING shouldn't
> be the default behavior for the dma_map_ routines instead of sprinkling
> it over just about every driver..
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
