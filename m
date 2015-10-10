From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 10 Oct 2015 00:30:44 -0700
Subject: [PATCH] Move nvme driver source into subdirectory and move pci
 specifics from core into separate file
In-Reply-To: <CAF1ivSa4zCLHenbwT3GNk2gkWWPQwM_G5M_FtrEY9rVq8n7iVg@mail.gmail.com>
References: <1443130050.6973.125.camel@linux.intel.com>
 <20150925000251.GA25904@infradead.org>
 <CAF1ivSYwe41J+kEuna_VYQvHSLanZzx-qqOOQ3X9EzLWYK_bFQ@mail.gmail.com>
 <20150926161121.GB30551@infradead.org>
 <CAF1ivSa4zCLHenbwT3GNk2gkWWPQwM_G5M_FtrEY9rVq8n7iVg@mail.gmail.com>
Message-ID: <20151010073044.GA11346@infradead.org>

On Fri, Oct 09, 2015@10:38:40AM -0700, Ming Lin wrote:
> I have been writing vhost-nvme driver for a while.
> http://www.minggr.net/cgit/cgit.cgi/linux/commit/?h=vhost-nvme/v1
> 
> Seems I have to do similar submission/completion queue simulation
> in vhost-nvme as in qemu/nvme.c.
> 
> Will the "software NVMe controller" do these simulation?
> If yes, could you share a draft version then I can try build vhost-nvme
> on top of it?

I'd call it impementation, but not simulation, but otherwise yes.  I'll
talk to the people in charge as I think joining forces would be very
useful.
