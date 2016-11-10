From: keith.busch@intel.com (Keith Busch)
Date: Thu, 10 Nov 2016 18:23:12 -0500
Subject: [RFC PATCH 5/6] nvme: Add unlock_from_suspend
In-Reply-To: <20161110230130.GA1923@sbauer-Z170X-UD5>
References: <1477951099-3127-1-git-send-email-scott.bauer@intel.com>
 <1477951099-3127-6-git-send-email-scott.bauer@intel.com>
 <6a6a131a-09fe-4c7c-85a7-01149555e427@grimberg.me>
 <20161101135705.GA32697@infradead.org>
 <20161110230130.GA1923@sbauer-Z170X-UD5>
Message-ID: <20161110232312.GG4929@localhost.localdomain>

On Thu, Nov 10, 2016@04:01:31PM -0700, Scott Bauer wrote:
> On Tue, Nov 01, 2016@06:57:05AM -0700, Christoph Hellwig wrote:
> > blk_execute_rq_nowait is the API to use - blk_mq_insert_request isn't
> > even exported.
> 
> I remember now, after I changed it to use rq_nowait, why we added this wrapper
> function and used blk_mq_insert_request.
> 
> When we dispatch opal commands down to the controller we're doing so in an IRQ,
> so if we use rq_nowait, we lockup.

In this case can we push the submission off to a work queue and use
blk_mq_insert_rq_nowait?
