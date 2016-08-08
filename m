From: hch@lst.de (Christoph Hellwig)
Date: Mon, 8 Aug 2016 09:06:20 +0200
Subject: [PATCH 2/2] nvme-rdma: sqsize/hsqsize/hrqsize is 0-based val
In-Reply-To: <8bca04d5-8793-5bc3-9a18-4a7f66af40cc@grimberg.me>
References: <1470444851-7459-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1470444851-7459-3-git-send-email-james_p_freyensee@linux.intel.com>
 <8bca04d5-8793-5bc3-9a18-4a7f66af40cc@grimberg.me>
Message-ID: <20160808070620.GB12902@lst.de>

On Sun, Aug 07, 2016@10:29:08AM +0300, Sagi Grimberg wrote:
> Did we really decide that? The spec actually explicitly says
> that a 0 sqsize will be failed:
>
> "If the size is 0h or larger than the controller supports, then a
> status value of Connect Invalid Parameters shall be returned."
>
> And then it says: "This is a 0?s based value"
>
> Confusing....

Yeah, I think we'll need an errate in the TWG.  And I think the
current Linux behavior is the sensible one.  Jay, do you want
to drive this in the WG or I should I bring it up?
