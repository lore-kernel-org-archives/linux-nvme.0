From: keith.busch@intel.com (Keith Busch)
Date: Thu, 29 Jan 2015 15:44:41 +0000 (UTC)
Subject: [PATCH] NVMe: Skip namespaces with interleaved meta-data
In-Reply-To: <yq1a912iet4.fsf@sermon.lab.mkp.net>
References: <1422382021-15350-1-git-send-email-keith.busch@intel.com>
 <1422395867952.40819@hgst.com>
 <alpine.LNX.2.00.1501272203000.15481@localhost.lm.intel.com>
 <alpine.LNX.2.00.1501280111410.15481@localhost.lm.intel.com>
 <yq1zj93iszd.fsf@sermon.lab.mkp.net>
 <alpine.LNX.2.00.1501281456010.15481@localhost.lm.intel.com>
 <54C94B90.20805@ranbarg.com>
 <alpine.LNX.2.00.1501282102210.15481@localhost.lm.intel.com>
 <54C958D1.3010209@ranbarg.com> <yq1iofqimmu.fsf@sermon.lab.mkp.net>
 <alpine.LNX.2.00.1501282210070.15481@localhost.lm.intel.com>
 <yq1egqeilpi.fsf@sermon.lab.mkp.net>
 <alpine.LNX.2.00.1501282232380.15481@localhost.lm.intel.com>
 <yq1a912iet4.fsf@sermon.lab.mkp.net>
Message-ID: <alpine.LNX.2.00.1501291542270.15481@localhost.lm.intel.com>

On Wed, 28 Jan 2015, Martin K. Petersen wrote:
>>>>>> "Keith" == Keith Busch <keith.busch at intel.com> writes:
>
> Keith> Integrity verify is broken in here. blk_mq_end_request() calls
> Keith> blk_update_request(), which moves the bio iterator to the end.
> Keith> When we get to bio_integrity_process(), there's nothing for it to
> Keith> do, so verification is skipped.
>
> Looks like 594416a72032 inadvertently broke this.

Good call, reverting that at least addresses my problem.

> Does using __bio_for_each_segment() help?

Sorry, I don't follow. That still takes an iterator, but the bio's is
advanced to the end, and I don't see how to get it to the original start.
