From: hch@lst.de (Christoph Hellwig)
Date: Fri, 10 Mar 2017 15:24:24 +0100
Subject: [PATCH 25/47] nvme: don't take the I/O queue q_lock in
 nvme_timeout
In-Reply-To: <1489150271.26967.6.camel@infradead.org>
References: <1448037342-18384-26-git-send-email-hch@lst.de>
 <1489150271.26967.6.camel@infradead.org>
Message-ID: <20170310142424.GB18987@lst.de>

On Fri, Mar 10, 2017@01:51:11PM +0100, David Woodhouse wrote:
> > There is nothing it protects, but it makes lockdep unhappy in many different
> > ways.
> >
> > Signed-off-by: Christoph Hellwig <hch at lst.de>
> > Signed-off-by: Keith Busch <keith.busch at intel.com>
> 
> This is commit 4c9f748f0ee88447b28546991f60f43a7319aafd in 4.5.
> 
> Doesn't it want to be applied to 4.4 stable too?

No idea.  For what someone would have to look a 4.4 stable, check if
it makes sense and hopefully do some NVMe regression testing including
testing timeouts.
