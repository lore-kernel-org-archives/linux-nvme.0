From: daniel.verkamp@intel.com (Verkamp, Daniel)
Date: Mon, 8 Aug 2016 16:30:00 +0000
Subject: [PATCH 2/2] nvme-rdma: sqsize/hsqsize/hrqsize is 0-based val
In-Reply-To: <20160808070620.GB12902@lst.de>
References: <1470444851-7459-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1470444851-7459-3-git-send-email-james_p_freyensee@linux.intel.com>
 <8bca04d5-8793-5bc3-9a18-4a7f66af40cc@grimberg.me>
 <20160808070620.GB12902@lst.de>
Message-ID: <1470673797.40000.27.camel@intel.com>

On Mon, 2016-08-08@09:06 +0200, Christoph Hellwig wrote:
> On Sun, Aug 07, 2016@10:29:08AM +0300, Sagi Grimberg wrote:
> > 
> > Did we really decide that? The spec actually explicitly says
> > that a 0 sqsize will be failed:
> > 
> > "If the size is 0h or larger than the controller supports, then a
> > status value of Connect Invalid Parameters shall be returned."
> > 
> > And then it says: "This is a 0?s based value"
> > 
> > Confusing....
> 
> Yeah, I think we'll need an errate in the TWG.??And I think the
> current Linux behavior is the sensible one.??Jay, do you want
> to drive this in the WG or I should I bring it up?

I would be happy if all of the 0's based values in the spec were
removed, but I think it's a little too late for that...

In this particular case, I'm pretty sure this is not a mistake; the
relevant text is copied directly from the NVMe base spec Create I/O
Submission Queue command's QSIZE parameter.

What does need to be clarified is the RDMA transport definition. ?The
Connect private data contains two queue size-related fields:

- HSQSIZE, which is supposed to be the RDMA QP send depth, but also says
"shall be set to the Submission Queue Size (SQSIZE)", while not saying
whether it is 0's based.
- HRQSIZE, which is the QP receive depth, which has no equivalent like
SQSIZE in the Connect command, and also does not mention being 0's
based.

These should hopefully both be 0's based or both not 0's based, but
right now, I have no idea what the intent of the spec is.

Thanks,
-- Daniel
