From: hch@lst.de (Christoph Hellwig)
Date: Mon, 14 Dec 2015 11:18:12 +0100
Subject: [PATCH] nvme: Allow controllers to specify a min queue depth
 for CMB
In-Reply-To: <20151211202546.GA4116@localhost.localdomain>
References: <1449862594-26103-1-git-send-email-jonathan.derrick@intel.com>
 <20151211200653.GA26595@lst.de> <20151211202546.GA4116@localhost.localdomain>
Message-ID: <20151214101812.GA6018@lst.de>

On Fri, Dec 11, 2015@01:25:46PM -0700, Jon Derrick wrote:
> >  - why do we even need to add a quirk?  I quick look at the spec
> >    doesn't seem to require us to align the submission queue size
> >  - this patchs adds a quirk, but no use of it so it's effectively just dead
> >    code
> It is not that apparent. It inherits the restriction on the Create I/O
> Submission Queue command (NVM-Express 1.2a, 5.4, Figure 54).

It only requires the start aligned, not the size.  But yes, that would
force the next one to be unaligned so to be useful we'd need to an unaligned
start as well.
