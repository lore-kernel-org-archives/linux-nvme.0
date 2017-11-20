From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 19 Nov 2017 23:37:55 -0800
Subject: [PATCH v2 0/3] Fix request completion holes
In-Reply-To: <e89f72c6-12ce-c149-c81e-f3adb43a8e9e@grimberg.me>
References: <20171108100616.26605-1-sagi@grimberg.me>
 <1510611044.3735.49.camel@redhat.com>
 <e89f72c6-12ce-c149-c81e-f3adb43a8e9e@grimberg.me>
Message-ID: <20171120073755.GA2236@infradead.org>

On Thu, Nov 16, 2017@05:39:55PM +0200, Sagi Grimberg wrote:
> 
> > Sagi, are you ready for me to take this series in?  It seemed like there
> > was a question as to whether you might want to try atomics instead of
> > spin locks, or do you want to stick with spinlocks?
> 
> I still need a review for this, and I think we'll get it in through the
> nvme tree (via the block tree). Thanks.

I've  done an initial review pass, but I'd really like to see someone
who has more RDMA experience to take a look as well.
