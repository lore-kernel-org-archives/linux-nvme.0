From: kbusch@kernel.org (Keith Busch)
Date: Fri, 15 Mar 2019 10:47:08 -0600
Subject: [PATCH v4 1/3] nvme: set 0 capacity if namespace block size
 exceeds PAGE_SIZE
In-Reply-To: <20190315164057.GA28739@lst.de>
References: <20190311220227.23656-1-sagi@grimberg.me>
 <20190311220227.23656-2-sagi@grimberg.me>
 <20190312143231.GA1149@lst.de>
 <8a80ce70-0b98-6c82-a47c-f312a41d2d2a@grimberg.me>
 <20190315162837.GA27308@lst.de>
 <20190315163843.GA18289@localhost.localdomain>
 <20190315164057.GA28739@lst.de>
Message-ID: <20190315164708.GA18306@localhost.localdomain>

On Fri, Mar 15, 2019@05:40:57PM +0100, Christoph Hellwig wrote:
> On Fri, Mar 15, 2019@10:38:43AM -0600, Keith Busch wrote:
> > I'm not sure abuot a divide-by-zero, but I just hacked up qemu to report
> > an 8k block size and get this on boot. Happens because alloc_page_buffers
> > won't allocate a buffer_head when block size is greater than a page size:
> 
> But that is without either the patch from Sagi or the one from me,
> right?

Sorry, I misunderstood to think you were saying only that Sagi's patch
wasn't necessary. Yes, either patch works.
