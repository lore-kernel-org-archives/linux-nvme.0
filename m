From: snitzer@redhat.com (Mike Snitzer)
Date: Tue, 26 Jan 2016 21:09:32 -0500
Subject: dm-multipath low performance with blk-mq
In-Reply-To: <20160126164437.GB15979@infradead.org>
References: <569E11EA.8000305@dev.mellanox.co.il>
 <20160119224512.GA10515@redhat.com>
 <20160125214016.GA10060@redhat.com>
 <20160126160324.GA24665@redhat.com>
 <20160126164437.GB15979@infradead.org>
Message-ID: <20160127020932.GA26919@redhat.com>

On Tue, Jan 26 2016 at 11:44am -0500,
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Jan 26, 2016@11:03:24AM -0500, Mike Snitzer wrote:
> > Christoph, any chance you could rebase your 'nvme-loop.2' on v4.5-rc1?
> 
> Don't think I have time at the moment, sorry..

No problem, I pulled the latest DM changes ontop of 'nvme-loop.2', see:
http://git.kernel.org/cgit/linux/kernel/git/snitzer/linux.git/log/?h=devel

I was able to use nvme-loop like was documented here:
http://git.infradead.org/users/hch/block.git/commit/47d8d5b1db270463b5bd7b6a68cd89bd8762840d

But I'm not too sure how Sagi used the resulting nvme device with
multipath.. maybe he just manually pushed down a DM multipath table?
And only used the single /dev/nvme0n1 device?  Sagi?
