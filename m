From: hch@lst.de (Christoph Hellwig)
Date: Mon, 12 Oct 2015 19:44:02 +0200
Subject: nvme driver split, the easy part
In-Reply-To: <alpine.LNX.2.00.1510121729431.27742@localhost.lm.intel.com>
References: <1444633456-27698-1-git-send-email-hch@lst.de>
 <alpine.LNX.2.00.1510121505490.27742@localhost.lm.intel.com>
 <20151012172430.GA29517@lst.de>
 <alpine.LNX.2.00.1510121729431.27742@localhost.lm.intel.com>
Message-ID: <20151012174402.GA30245@lst.de>

On Mon, Oct 12, 2015@05:31:54PM +0000, Keith Busch wrote:
>> That's handled by "nvme: refactor nvme_queue_rq" which now uses
>> a common helper to map data and metadata shared by the read/write
>> and passthrough path.
>
> Aha, so it is. Very cool, I'm still getting used to the recent changes. :)

I only sent that out late last week, and it still needs a throughout
review from you.

Note that only this second series depends on that series, the first
one only touches unrelated code.
