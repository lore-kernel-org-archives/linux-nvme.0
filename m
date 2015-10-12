From: keith.busch@intel.com (Keith Busch)
Date: Mon, 12 Oct 2015 17:31:54 +0000 (UTC)
Subject: nvme driver split, the easy part
In-Reply-To: <20151012172430.GA29517@lst.de>
References: <1444633456-27698-1-git-send-email-hch@lst.de>
 <alpine.LNX.2.00.1510121505490.27742@localhost.lm.intel.com>
 <20151012172430.GA29517@lst.de>
Message-ID: <alpine.LNX.2.00.1510121729431.27742@localhost.lm.intel.com>

On Mon, 12 Oct 2015, Christoph Hellwig wrote:
> On Mon, Oct 12, 2015@05:20:25PM +0000, Keith Busch wrote:
>> Your second series will take a few days to process, but I can already
>> tell the meta-data patch [2/8] is incomplete. At the least, we need to
>> set cmnd.rw.meta in nvme_submit_priv(), but I'll give a more thorough
>> review later this week.
>
> That's handled by "nvme: refactor nvme_queue_rq" which now uses
> a common helper to map data and metadata shared by the read/write
> and passthrough path.

Aha, so it is. Very cool, I'm still getting used to the recent changes. :)

> Thanks for the offer for testing!

No problem!
