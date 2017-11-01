From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 1 Nov 2017 09:21:40 -0700
Subject: [PATCH] nvme: freeze IO accesses around format
In-Reply-To: <20171101162147.GA26245@localhost.localdomain>
References: <6951d74c-e765-1b5d-6e39-d88d261bf9b9@kernel.dk>
 <20171027230756.GA17245@localhost.localdomain>
 <20171101155603.GC25317@infradead.org>
 <20171101162147.GA26245@localhost.localdomain>
Message-ID: <20171101162140.GA29779@infradead.org>

On Wed, Nov 01, 2017@10:21:47AM -0600, Keith Busch wrote:
> 
> Okay, we can freeze single nvme namespace's request queues if desired.
> It's only a little more code to do that.

Not sure we need to bother doing it now, but a comment that we are
lazy might be useful.

> > Also don't we need to also handle this for I/O commands?  While
> > non of the currently defined I/O commands would need anything, the
> > spec defines the mechanism? and it might be useful for vendor
> > specific commands
> 
> That gets tricky. What if the IO command effects says it needs to run
> exclusively? We don't have a way to quiesce IO queues and then issue our
> exclusive IO through the frozen queue. We'd deadlock trying to allocate
> a request from it.
> 
> If it's okay, I'd like to handle the IO command effects separately for
> future work.

True.  Maybe we should warn if we have any bit set for I/O commands?
