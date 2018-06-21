From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 21 Jun 2018 08:01:39 -0700
Subject: [PATCH] nvme: use __GFP_NOWARN for iod allocation
In-Reply-To: <dc92becd-403d-9c15-e5bb-5e0c3b5d8a8c@kernel.dk>
References: <4cb394ca-7032-ea67-5bb1-ef331e42ace2@kernel.dk>
 <b054a000-c7ad-9926-b45f-2771a98b7d23@kernel.dk>
 <b51cce4d-d0c9-fb4e-d5ac-2e48e23e18f7@kernel.dk>
 <20180620204310.GA24840@localhost.localdomain>
 <34e64832-c345-3a70-401f-1915b5bb4af1@kernel.dk>
 <20180620223035.GA25196@localhost.localdomain>
 <7b6f885f-f605-1bfd-7a7e-2fce8cbde6c2@kernel.dk>
 <20180621071056.GB21304@infradead.org>
 <dc92becd-403d-9c15-e5bb-5e0c3b5d8a8c@kernel.dk>
Message-ID: <20180621150139.GA22804@infradead.org>

On Thu, Jun 21, 2018@08:47:34AM -0600, Jens Axboe wrote:
> On 6/21/18 1:10 AM, Christoph Hellwig wrote:
> > On Wed, Jun 20, 2018@04:30:18PM -0600, Jens Axboe wrote:
> >> If the fabrics folks have concerns, we could make it dependent on
> >> it being a pci device. That's the case I care about anyway, and the
> >> one that's currently breaking for me.
> > 
> > Fabrics uses the SG chain allocator that SCSI also uses, so it
> > should already be fine, including for larger I/O sizes.
> 
> I'll change it to ignore it for fabrics. What's the best way to
> check? ctrl->sqsize?

ctrl->ops->flags & NVME_F_FABRICS

but in the end we probably want a separate flag, as that is an
implementation detail, and not because these are fabrics drivers.

I'll be spending the rest of the day on phone calls, so it'll take
some time to do more on this than writing some email, but I'll try
to find some time to look into these issues.
