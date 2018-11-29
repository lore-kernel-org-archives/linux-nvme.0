From: axboe@fb.com (Jens Axboe)
Date: Thu, 29 Nov 2018 20:25:10 +0000
Subject: [PATCH 01/13] block: move queues types to the block layer
In-Reply-To: <20181129201914.GB9377@localhost.localdomain>
References: <20181129191310.9795-1-hch@lst.de>
 <20181129191310.9795-2-hch@lst.de>
 <20181129201914.GB9377@localhost.localdomain>
Message-ID: <74fb1df7-f1c4-93e9-0340-4c11e5147a9d@fb.com>

On 11/29/18 1:19 PM, Keith Busch wrote:
> On Thu, Nov 29, 2018@08:12:58PM +0100, Christoph Hellwig wrote:
>> +enum hctx_type {
>> +	HCTX_TYPE_DEFAULT,	/* all I/O not otherwise accounted for */
>> +	HCTX_TYPE_READ,		/* just for READ I/O */
>> +	HCTX_TYPE_POLL,		/* polled I/O of any kind */
>> +
>> +	HCTX_MAX_TYPES,
>>  };
> 
> Well, there goes my plan to use this with Weighted-Round-Robin NVMe IO
> queues!
> 
> I'm not that sad about it, though.

That's why I wanted these to be driver private, so you could just expand
at will. But it's not like we can't do that now, we'll just add some
extra types in here. The downside is that if we have a bunch of drivers
having dis-separate queues, then we end up with a bigger MAX number than
we would have with driver private queues.

IOW, I don't think this is ruining anything for you.

-- 
Jens Axboe
