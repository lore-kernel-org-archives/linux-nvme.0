From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 14 Jul 2015 11:06:34 -0700
Subject: Partitions and end-to-end protection
In-Reply-To: <alpine.LNX.2.00.1507131909210.15930@localhost.lm.intel.com>
References: <55A40881.5000108@ranbarg.com>
 <alpine.LNX.2.00.1507131909210.15930@localhost.lm.intel.com>
Message-ID: <20150714180634.GB10203@infradead.org>

On Mon, Jul 13, 2015@07:16:25PM +0000, Keith Busch wrote:
> On Mon, 13 Jul 2015, Paul Grabinar wrote:
> >What seems to be happening is that the driver starts off by setting the
> >capacity to zero whilst it validates the meta-data configuration and
> >then sets the real size after this validation. However, setting the
> >capacity does not seem to be enough to tell the kernel to re-read the
> >partition table.
> 
> The driver did it this way because we need a disk allocated before we can
> subscribe to block integrity extensions. I think we can fix the partition
> issue by making a call to blkdev_reread_part() right after the second
> revalidate_disk if the namespace is a meta-data formatted. I'll test it
> out and post a patch if it works out.

I dont think requiring this crazy scheme is something that should spread
in drivers.  I'd suggest you work with Martin (on Cc) so that we can
set up the integrity profile at the right time.
