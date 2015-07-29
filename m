From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 29 Jul 2015 00:55:57 -0700
Subject: SGL support of driver
In-Reply-To: <20150728143500.GX13681@linux.intel.com>
References: <CAB7xdimg82dhfMY5mVAfZZ5=Ub-Dz5N+x1gQ5QWg7qPwb5fsXA@mail.gmail.com>
 <20150727163123.GA5034@infradead.org>
 <alpine.LNX.2.00.1507271636430.15930@localhost.lm.intel.com>
 <20150727165756.GA8847@infradead.org>
 <20150728143500.GX13681@linux.intel.com>
Message-ID: <20150729075557.GA11755@infradead.org>

On Tue, Jul 28, 2015@10:35:00AM -0400, Matthew Wilcox wrote:
> On Mon, Jul 27, 2015@09:57:56AM -0700, Christoph Hellwig wrote:
> > It also requires pagecache I/O to be split into multiple commands
> > where other block devices can handle it a lot more efficiently.
> 
> Wait, what?  pagecache I/O is page aligned and page sized.  That can
> always be represented by a PRP list.

Pagecache I/O is not nessecarily page aligned.

Think of this case thay I remember clearly because it exposed a bug
a few years ago:

64k page size, 4k file system block size, raid 0 with a stripe size of
8k and two legs.

The typical SGL feds to the hardware driver for streaming I/O will be:

page A, offset 0, len 8k
page A, offset 16k, len 8k
page A, offset 32k, len 8k
page A, offset 48k, len 8k
page B, offset 0, len 8k

This is clearly something PRP list will not handle well.  Note that I'm
not nessecarily saying this is soemthing to optimize for, the more
interesting case for NVMe really is the vectored direct I/O case.
