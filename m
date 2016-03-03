From: hch@lst.de (Christoph Hellwig)
Date: Thu, 3 Mar 2016 12:59:53 +0100
Subject: blk-mq merge flags
In-Reply-To: <CACVXFVPVBZkfyvvh1xTZiHbBeZGYepYuEpXhfZZ9+_k61==KzQ@mail.gmail.com>
References: <1456938434-20387-1-git-send-email-hch@lst.de>
 <1456938434-20387-2-git-send-email-hch@lst.de>
 <56D7247C.4000208@dev.mellanox.co.il> <20160302211729.GA3803@lst.de>
 <CACVXFVM=-BSTGbrO1MqciCs4zPAt1Lfk1=9DZr+NNur-R96j_g@mail.gmail.com>
 <20160303084609.GA14051@lst.de>
 <CACVXFVPVBZkfyvvh1xTZiHbBeZGYepYuEpXhfZZ9+_k61==KzQ@mail.gmail.com>
Message-ID: <20160303115953.GB20543@lst.de>

On Thu, Mar 03, 2016@07:24:10PM +0800, Ming Lei wrote:
> After bio splitting is introduced, SG merging becomes much cheaper, and
> I can't see the difference between SG_MERGE and NO_SG_MERGE when
> doing test over null_blk.

Ok.

> Once multipage bvecs is supported, SG merging should be always because
> the bvec stored in bio->bi_io_vec can be thought as sort of segment.
> 
> Also from hardware view, it is often more efficient to handle less segments.
> Last time Keith mentioned the point too about NVMe.
> 
> That is why I think we might consider to remove the flag.

I hate these sorts of flags, but we have to weight this against the
reason they were introduced.  I think the rational was for workloads
that do small (4k or less) I/Os and really care about latency.

But I'd be much happier if we'd only allow this to be turned off at
runtime through sysfs, and not requiring the drivers to opt for
sane behavior at compile time.

I also agree about the multipage biovecs - if we build large iovecs
directly in bio_add_page we get S/G merging for a two comparisms and
a branch, so it'll be essentially for free.  But for that we need
multipage biovecs first.
