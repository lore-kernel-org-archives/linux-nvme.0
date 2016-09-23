From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 23 Sep 2016 08:58:10 -0500
Subject: crash when connecting to targets using nr_io_queues < num cpus
In-Reply-To: <20160923033157.GA12637@infradead.org>
References: <e31f7c2f-7b15-95f9-f882-4406c94eaedc@grimberg.me>
 <018701d20dca$22a02080$67e06180$@opengridcomputing.com>
 <20160913175223.GB13741@localhost.localdomain>
 <005101d21024$1f8913f0$5e9b3bd0$@opengridcomputing.com>
 <20160916142649.GA18798@infradead.org> <20160922210255.GA11015@infradead.org>
 <023c01d21519$b3cda450$1b68ecf0$@opengridcomputing.com>
 <20160922214800.GA16008@infradead.org>
 <024201d2151d$28013b90$7803b2b0$@opengridcomputing.com>
 <022301d2152d$94c202e0$be4608a0$@opengridcomputing.com>
 <20160923033157.GA12637@infradead.org>
Message-ID: <003f01d215a2$84d78dd0$8e86a970$@opengridcomputing.com>


> 
> On Thu, Sep 22, 2016@07:01:05PM -0500, Steve Wise wrote:
> > The fabrics module displays these errors.  But the 28 rdma connections still
> > get setup.  I'm not sure this is what we want, but it does avoid failing the
> > connect altogether...
> 
> Bo, it's not really what we want.  I think we simply need to move
> forward with the queue state machine, and use that to check if we have
> a blk-mq queue allocated for the queue.  If not we can simply skip it
> later on.
> 
> So I'd say I'll send the crash fix in blk-mq to Jens ASAP, and you'll
> look into the queue state machine for 4.9?

Sure.
