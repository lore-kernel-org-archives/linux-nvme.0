From: scott.bauer@intel.com (Scott Bauer)
Date: Tue, 1 Nov 2016 08:40:45 -0600
Subject: [RFC PATCH 5/6] nvme: Add unlock_from_suspend
In-Reply-To: <20161101135705.GA32697@infradead.org>
References: <1477951099-3127-1-git-send-email-scott.bauer@intel.com>
 <1477951099-3127-6-git-send-email-scott.bauer@intel.com>
 <6a6a131a-09fe-4c7c-85a7-01149555e427@grimberg.me>
 <20161101135705.GA32697@infradead.org>
Message-ID: <20161101144044.GA7911@sbauer-Z170X-UD5>

On Tue, Nov 01, 2016@06:57:05AM -0700, Christoph Hellwig wrote:
> On Tue, Nov 01, 2016@10:18:13AM +0200, Sagi Grimberg wrote:
> > > +
> > > +	return nvme_insert_rq(q, req, 1, sec_submit_endio);
> > 
> > No need to introduce nvme_insert_rq at all, just call
> > blk_mq_insert_request (other examples call blk_execute_rq_nowait
> > but its pretty much the same...)
> 
> blk_execute_rq_nowait is the API to use - blk_mq_insert_request isn't
> even exported.

Thanks for the reviews. This patch needs to be separated into two 
patches. There is the addition of the nvme-suspend stuff and the
addition of sec_ops. Most of the clutter and weird stuff is coming
from the latter. I'll separate the patches, use the correct api and 
clean the clutter.

Thanks
