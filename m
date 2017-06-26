From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 26 Jun 2017 11:15:43 +0200
Subject: DMA_ATTR_WEAK_ORDERING defintion, was Re: [PATCH] nvme: set
 DMA_ATTR_WEAK_ORDERING attribute on dma buffers
In-Reply-To: <20170624073539.GE14580@lst.de>
References: <1497645290-31041-1-git-send-email-alan.adamson@oracle.com>
 <20170617115703.GA13002@lst.de>
 <6a32f30b-433a-9857-164f-1717405a6082@oracle.com>
 <20170624073539.GE14580@lst.de>
Message-ID: <CAK8P3a0itukwNkPk-Yui6juJXt5QiQT6+FYxP12or2wt5jDhLw@mail.gmail.com>

On Sat, Jun 24, 2017@9:35 AM, Christoph Hellwig <hch@lst.de> wrote:
> I always assumed that our streaming mappings are relaxed order for
> TLP anyway.  And at very least Documentation/DMA-attributes.txt seems
> to imply something different:
>
>
>   DMA_ATTR_WEAK_ORDERING
>   ----------------------
>
>   DMA_ATTR_WEAK_ORDERING specifies that reads and writes to the mapping
>   may be weakly ordered, that is that reads and writes may pass each other.
>
> Which to me suggest host reads, which also makes me wonder why these
> would even apply to our streaming mappings.
>
> Adding the powerpc folks that added the DMA_ATTR_WEAK_ORDERING flag
> originally back in 2008, but not actual users as far as I can tell -
> those are all new and from the sparc gang, except for the noveau
> driver, which is a bit older but only uses for dma_alloc_attrs, where
> the original description makes sense to me.

I suspect people have applied the same name for different things over time.

When we added it in 2008, there was one specific use case, improving
throughput on infiniband, iirc using the mthca device driver. In the Cell
IOMMU, this attribute causes concurrent DMA transfers on PCIe
devices to disregard the stricter PCI ordering rules: multiple transfers
could be initiated together and complete in an arbitrary order depending
on e.g. I/O page faults in the IOMMU. Using the dma attributes, this
could be controlled to apply only to certain transfers, so a completion
queue DMA would still be ordered with regard to other transfers, as it would
not come with that attribute.

There are two things that I don't remember unfortunately.

a) why this patch seems to have never made it into the mainline kernel:
http://lists.openfabrics.org/pipermail/general/2008-October/055006.html
We probably had it added to both OFED and the supported distros at
the time (RHEL, Fedora, SLES, all in versions I don't remember any
more)

b) How this relates to the PCIe relaxed ordering flag on DMA transfers.
It's possible that the hardware later learned to correctly set the
flag on the actual transfer to have the same effect, or it's possible
that we had to add the dma_alloc_attr() interface specifically because
the hardware could not do this for some but not other transfers.

      Arnd
