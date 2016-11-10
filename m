From: scott.bauer@intel.com (Scott Bauer)
Date: Thu, 10 Nov 2016 16:01:31 -0700
Subject: [RFC PATCH 5/6] nvme: Add unlock_from_suspend
In-Reply-To: <20161101135705.GA32697@infradead.org>
References: <1477951099-3127-1-git-send-email-scott.bauer@intel.com>
 <1477951099-3127-6-git-send-email-scott.bauer@intel.com>
 <6a6a131a-09fe-4c7c-85a7-01149555e427@grimberg.me>
 <20161101135705.GA32697@infradead.org>
Message-ID: <20161110230130.GA1923@sbauer-Z170X-UD5>

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

I remember now, after I changed it to use rq_nowait, why we added this wrapper
function and used blk_mq_insert_request.

When we dispatch opal commands down to the controller we're doing so in an IRQ,
so if we use rq_nowait, we lockup.

Will there be pushback if we continue with the original patch idea, where we 
export blk_mq_insert_request (forgot to send that) and use it? I looked through
the block API and I didn't see a execute_rq that was irq safe.

Any suggestions?
