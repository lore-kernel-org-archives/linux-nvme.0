From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 1 Nov 2016 06:57:05 -0700
Subject: [RFC PATCH 5/6] nvme: Add unlock_from_suspend
In-Reply-To: <6a6a131a-09fe-4c7c-85a7-01149555e427@grimberg.me>
References: <1477951099-3127-1-git-send-email-scott.bauer@intel.com>
 <1477951099-3127-6-git-send-email-scott.bauer@intel.com>
 <6a6a131a-09fe-4c7c-85a7-01149555e427@grimberg.me>
Message-ID: <20161101135705.GA32697@infradead.org>

On Tue, Nov 01, 2016@10:18:13AM +0200, Sagi Grimberg wrote:
> > +
> > +	return nvme_insert_rq(q, req, 1, sec_submit_endio);
> 
> No need to introduce nvme_insert_rq at all, just call
> blk_mq_insert_request (other examples call blk_execute_rq_nowait
> but its pretty much the same...)

blk_execute_rq_nowait is the API to use - blk_mq_insert_request isn't
even exported.
