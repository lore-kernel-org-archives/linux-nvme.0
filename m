From: axboe@fb.com (Jens Axboe)
Date: Fri, 30 Nov 2018 15:20:19 +0000
Subject: [PATCH 01/13] block: move queues types to the block layer
In-Reply-To: <20181130080013.GB18936@lst.de>
References: <20181129191310.9795-1-hch@lst.de>
 <20181129191310.9795-2-hch@lst.de>
 <20181129201914.GB9377@localhost.localdomain> <20181130080013.GB18936@lst.de>
Message-ID: <00bcc7f1-9d2b-ceb8-49d6-b3c857fd2df7@fb.com>

On 11/30/18 1:00 AM, Christoph Hellwig wrote:
> On Thu, Nov 29, 2018@01:19:14PM -0700, Keith Busch wrote:
>> On Thu, Nov 29, 2018@08:12:58PM +0100, Christoph Hellwig wrote:
>>> +enum hctx_type {
>>> +	HCTX_TYPE_DEFAULT,	/* all I/O not otherwise accounted for */
>>> +	HCTX_TYPE_READ,		/* just for READ I/O */
>>> +	HCTX_TYPE_POLL,		/* polled I/O of any kind */
>>> +
>>> +	HCTX_MAX_TYPES,
>>>  };
>>
>> Well, there goes my plan to use this with Weighted-Round-Robin NVMe IO
>> queues!
> 
> Wo between what do you even want to round robin?  If it is between
> reads and writes that's easy.  If we want priority reads or writes
> (separate from polling) that's also still fairly easily.
> 
> Btw, one thing I wanted to try once I get hold of the right hardware
> is to mark the poll queues as priority queues and see if that makes
> any differents in poll IOPS/latency.

Probably not a lot, if anything. Only for heavily mixed cases I'd
suspect it to make a difference. I can run some tests with it.

And beware that I've seen weird queue priority issues, ala the one
fixed by:

commit 9abd68ef454c824bfd18629033367b4382b5f390 (tag: for-linus-20180511)
Author: Jens Axboe <axboe at kernel.dk>
Date:   Tue May 8 10:25:15 2018 -0600

    nvme: add quirk to force medium priority for SQ creation

So we need to be careful with enabling priorities, I suspect. Hopefully
that's a standalone case.

-- 
Jens Axboe
