From: mlin@kernel.org (Ming Lin)
Date: Fri, 25 Sep 2015 22:32:36 -0700
Subject: [PATCH] Move nvme driver source into subdirectory and move pci
 specifics from core into separate file
In-Reply-To: <20150925000251.GA25904@infradead.org>
References: <1443130050.6973.125.camel@linux.intel.com>
 <20150925000251.GA25904@infradead.org>
Message-ID: <CAF1ivSYwe41J+kEuna_VYQvHSLanZzx-qqOOQ3X9EzLWYK_bFQ@mail.gmail.com>

On Thu, Sep 24, 2015@5:02 PM, Christoph Hellwig <hch@infradead.org> wrote:
> Hi J,
>
> thanks for starting this important work, but I think we need to do
> this in smaller steps.  This large patch does a few things at the same
> time:
>
>  - move files to a new directory
>  - split data structures
>  - split files
>  - introduces a new internal API
>
> Which need to be split over a few patches.  I'd suggest we start with
> the easiest and most important parts first and then iterate through the
> rest.
>
> My suggestion would be:
>
>  a) move files to a new directory.  My suggestion for that would be
>     driver/nvme/host/ as I have a software NVMe controller
>     implementation under development which I'd like to also add under
>     a different subdirectory of drivers/nvme.

What's the "software NVMe controller"? Is it the initiator for NVMe
over fabrics?

>  b) start splitting struct nvme_dev into a generic struct nvme_ctrl
>     and a PCI-specific nvme_pci_ctrl

Nice. I'll possibly have a virtio-specific nvme_virtio_ctrl.

>
> Based on that we can start thinking about an API and move the PCI code
> to it's own file.  Note that most of your operations should not be
> needed.  With my ongoing work we now have the nvme_submit*cmd* APIs
> that give a nice separatation for anything related to NVMe commans,
> so we'd just need abstractions for the BAR access.
