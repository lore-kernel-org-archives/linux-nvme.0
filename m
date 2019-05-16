From: kbusch@kernel.org (Keith Busch)
Date: Thu, 16 May 2019 08:08:59 -0600
Subject: [PATCH 4/6] nvme-pci: Sync queues on reset
In-Reply-To: <20190516062959.GF29930@lst.de>
References: <20190515163625.21776-1-keith.busch@intel.com>
 <20190515163625.21776-4-keith.busch@intel.com>
 <20190516062959.GF29930@lst.de>
Message-ID: <20190516140859.GA23333@localhost.localdomain>

On Wed, May 15, 2019@11:29:59PM -0700, Christoph Hellwig wrote:
> On Wed, May 15, 2019@10:36:23AM -0600, Keith Busch wrote:
> > A controller with multiple namespaces may have multiple request_queues
> > with their own timeout work. If a live controller fails with IO
> > outstanding to diffent namespaces, each request queue may attempt to
> > disable and reset the controller in different threads. Synchronize each
> > queue prior to starting the controller to ensure there no previously
> > scheduled timeout work is running.
> > 
> > Signed-off-by: Keith Busch <keith.busch at intel.com>
> 
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> 
> I wonder if we should move the timeouts to a per-tagset single threaded
> workqueue in the block layer, so that we don't process them in parallel?

I thought that made sense too, and tried that last year:

  https://patchwork.kernel.org/patch/10532983/

There was something wrong with detecting idle queues, but taking a
second look now, I think that's fixable.

But this is a good patch too.
