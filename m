From: hch@lst.de (Christoph Hellwig)
Date: Fri, 15 Mar 2019 17:40:57 +0100
Subject: [PATCH v4 1/3] nvme: set 0 capacity if namespace block size
 exceeds PAGE_SIZE
In-Reply-To: <20190315163843.GA18289@localhost.localdomain>
References: <20190311220227.23656-1-sagi@grimberg.me>
 <20190311220227.23656-2-sagi@grimberg.me> <20190312143231.GA1149@lst.de>
 <8a80ce70-0b98-6c82-a47c-f312a41d2d2a@grimberg.me>
 <20190315162837.GA27308@lst.de>
 <20190315163843.GA18289@localhost.localdomain>
Message-ID: <20190315164057.GA28739@lst.de>

On Fri, Mar 15, 2019@10:38:43AM -0600, Keith Busch wrote:
> On Fri, Mar 15, 2019@05:28:37PM +0100, Christoph Hellwig wrote:
> > On Tue, Mar 12, 2019@02:15:26PM -0700, Sagi Grimberg wrote:
> > >
> > >> I like the idea behind this, but it looks rather convoluted.  I think
> > >> for the unusable namespace case we should warn and have a common label
> > >> that just sets the capacity, not touching anything else.
> > >>
> > >> Does something like this work for you?
> > >
> > > No, this is what I had done originally, but we need to always have the
> > > queue set to a decent block size, otherwise blk_queue_stack_limits()
> > > panics on div by 0..
> > 
> > I actually tested it by manually hacking a 8k block size into nvmet
> > and and it works just fine for me.  Where do you see a division by
> > zero with this patch exactly?
> 
> I'm not sure abuot a divide-by-zero, but I just hacked up qemu to report
> an 8k block size and get this on boot. Happens because alloc_page_buffers
> won't allocate a buffer_head when block size is greater than a page size:

But that is without either the patch from Sagi or the one from me,
right?
