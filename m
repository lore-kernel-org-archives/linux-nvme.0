From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 21 Jun 2018 00:10:56 -0700
Subject: [PATCH] nvme: use __GFP_NOWARN for iod allocation
In-Reply-To: <7b6f885f-f605-1bfd-7a7e-2fce8cbde6c2@kernel.dk>
References: <4cb394ca-7032-ea67-5bb1-ef331e42ace2@kernel.dk>
 <b054a000-c7ad-9926-b45f-2771a98b7d23@kernel.dk>
 <b51cce4d-d0c9-fb4e-d5ac-2e48e23e18f7@kernel.dk>
 <20180620204310.GA24840@localhost.localdomain>
 <34e64832-c345-3a70-401f-1915b5bb4af1@kernel.dk>
 <20180620223035.GA25196@localhost.localdomain>
 <7b6f885f-f605-1bfd-7a7e-2fce8cbde6c2@kernel.dk>
Message-ID: <20180621071056.GB21304@infradead.org>

On Wed, Jun 20, 2018@04:30:18PM -0600, Jens Axboe wrote:
> If the fabrics folks have concerns, we could make it dependent on
> it being a pci device. That's the case I care about anyway, and the
> one that's currently breaking for me.

Fabrics uses the SG chain allocator that SCSI also uses, so it
should already be fine, including for larger I/O sizes.
