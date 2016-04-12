From: axboe@fb.com (Jens Axboe)
Date: Tue, 12 Apr 2016 13:13:01 -0600
Subject: [PATCH v2] nvme: add missing lock nesting notation
In-Reply-To: <20160412190826.GA20168@infradead.org>
References: <1459877524-15471-1-git-send-email-mlin@kernel.org>
 <20160412190121.GC32482@infradead.org> <570D46A3.1040304@fb.com>
 <20160412190826.GA20168@infradead.org>
Message-ID: <570D48BD.2080700@fb.com>

On 04/12/2016 01:08 PM, Christoph Hellwig wrote:
> On Tue, Apr 12, 2016@01:04:03PM -0600, Jens Axboe wrote:
>> On 04/12/2016 01:01 PM, Christoph Hellwig wrote:
>>> Jens, is this something we could still add to 4.6 to kill this annoying
>>> warning?
>>
>> Can't it wait until 4.7? It's not a regression in this merge window, looks
>> like it happened for 4.5.
>
> True.  On the other hand lockdep annotations are totally harmless..

Not disagreeing with that, just trying to keep it extra clean this 
round... So if it's not introduced in this cycle, let's defer it for the 
next.

-- 
Jens Axboe
