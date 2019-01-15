From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 16 Jan 2019 06:46:32 +0800
Subject: [PATCH] PCI/MSI: preference to returning -ENOSPC from
 pci_alloc_irq_vectors_affinity
In-Reply-To: <20190115193135.GH33971@google.com>
References: <20190103013106.26452-1-ming.lei@redhat.com>
 <20190114232338.GE33971@google.com> <20190115131140.GB28672@lst.de>
 <05cb9e71-e455-a717-c64c-b5242ec38bad@kernel.dk>
 <20190115193135.GH33971@google.com>
Message-ID: <20190115224631.GA22558@ming.t460p>

Hi Bjorn,

I think Christoph and Jens are correct, we should make this patch into
5.0 because the issue is triggered since 3b6592f70ad7b4c2 ("nvme: utilize
two queue maps, one for reads and one for writes"), which is merged to
5.0-rc.

For example, before 3b6592f70ad7b4c2, one nvme controller may be
allocated 64 irq vectors; but after that commit, only 1 irq vector
is assigned to this controller.

On Tue, Jan 15, 2019@01:31:35PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 15, 2019@09:22:45AM -0700, Jens Axboe wrote:
> > On 1/15/19 6:11 AM, Christoph Hellwig wrote:
> > > On Mon, Jan 14, 2019@05:23:39PM -0600, Bjorn Helgaas wrote:
> > >> Applied to pci/msi for v5.1, thanks!
> > >>
> > >> If this is something that should be in v5.0, let me know and include the
> > >> justification, e.g., something we already merged for v5.0 or regression
> > >> info, etc, and a Fixes: line, and I'll move it to for-linus.
> > > 
> > > I'd be tempted to queues this up for 5.0.  Ming, what is your position?
> > 
> > I think we should - the API was introduced in this series, I think there's
> > little (to no) reason NOT to fix it for 5.0.
> 
> I'm guessing the justification goes something like this (I haven't
> done all the research, so I'll leave it to Ming to fill in the details):
> 
>   pci_alloc_irq_vectors_affinity() was added in v4.x by XXXX ("...").

dca51e7892fa3b ("nvme: switch to use pci_alloc_irq_vectors")

>   It had this return value defect then, but its min_vecs/max_vecs
>   parameters removed the need for callers to interatively reduce the
>   number of IRQs requested and retry the allocation, so they didn't
>   need to distinguish -ENOSPC from -EINVAL.
> 
>   In v5.0, XXX ("...") added IRQ sets to the interface, which

3b6592f70ad7b4c2 ("nvme: utilize two queue maps, one for reads and one for writes")

>   reintroduced the need to check for -ENOSPC and possibly reduce the
>   number of IRQs requested and retry the allocation.

Thanks,
Ming
