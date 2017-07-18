From: keith.busch@intel.com (Keith Busch)
Date: Tue, 18 Jul 2017 14:04:32 -0400
Subject: [PATCH] nvme/pci: Fix HMB size calculation
In-Reply-To: <20170718173954.GA7511@lst.de>
References: <1500335139-6338-1-git-send-email-keith.busch@intel.com>
 <20170718173954.GA7511@lst.de>
Message-ID: <20170718180431.GB7613@localhost.localdomain>

On Tue, Jul 18, 2017@07:39:54PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 17, 2017@07:45:39PM -0400, Keith Busch wrote:
> > It's possible the preferred HMB size may not be a multiple of the
> > chunk_size. This patch will set the chunk_size to the descriptor's actual
> > length so the last iteration doesn't cause the total size to exceed the
> > allocated HMB size.
> 
> This looks a little weird, and might do the wrong thing
> if we hit the retry loop after reducing chunk_size.

It may look weird when you consider the retry, but I'm pretty sure it
isn't wrong. The only way you can get to the retry is if the for-loop
breaks before the last interation, which means chunk_size will be
unchanged. That's not immediately obvious, though, so maybe this
implementation was trying to be too clever.
 
> I suspect we just need to change to
> 
> 	for (size = 0; size < preferred; size += len) {
> 
> and move len to function scope.

That's fine too.
