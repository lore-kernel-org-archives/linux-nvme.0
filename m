From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Thu, 31 May 2018 09:20:13 -0600
Subject: [PATCH rfc] nvme-pci: make sure to flush sqe writes before db
 record update
In-Reply-To: <92139db3-c1c0-b542-42a9-2383da866254@grimberg.me>
References: <20180307175626.15222-1-sagi@grimberg.me>
 <20180308155147.GD3766@localhost.localdomain>
 <20180308172018.GA6785@ziepe.ca>
 <c6a92092-f1f0-cf3c-3f34-fe5904d9718b@grimberg.me>
 <84ebcf65-d1a2-2ee5-d4d7-b96d61ed3c16@grimberg.me>
 <20180531054739.GA30923@lst.de>
 <92139db3-c1c0-b542-42a9-2383da866254@grimberg.me>
Message-ID: <20180531152013.GA4485@ziepe.ca>

On Thu, May 31, 2018@10:53:22AM +0300, Sagi Grimberg wrote:
> 
> >>resurrecting this one...
> >>
> >>Can anyone say why this is _not_ needed?
> >
> > From Documentation/memory-barriers.txt in linux-next, where this was
> >discussed once more not too log ago:
> >
> >   Note that, when using writel(), a prior wmb() is not needed to guarantee
> >   that the cache coherent memory writes have completed before writing to
> >   the MMIO region.
> 
> Thanks for clarifying, didn't know it was being discussed. I assume a
> bunch of other drivers need to clean it up now...

Yes, that was the conclusion. It is tricky though because the above
statement is maybe only true for un-cached memory.

It is less clear what the semantics are for WC memory...

Jason
