From: axboe@fb.com (Jens Axboe)
Date: Mon, 22 Dec 2014 11:19:21 -0700
Subject: [PATCH 0/4] nvme-blkmq fixes
In-Reply-To: <alpine.LNX.2.00.1412221807560.4026@localhost.lm.intel.com>
References: <1419036856-16275-1-git-send-email-keith.busch@intel.com>
 <5495B2BF.8070602@fb.com> <5495CDFE.3060404@fb.com>
 <alpine.LNX.2.00.1412221543240.4026@localhost.lm.intel.com>
 <54984B10.6060907@fb.com>
 <alpine.LNX.2.00.1412221807560.4026@localhost.lm.intel.com>
Message-ID: <549860A9.7060106@fb.com>

On 12/22/2014 11:17 AM, Keith Busch wrote:
> On Mon, 22 Dec 2014, Jens Axboe wrote:
>> On 12/22/2014 09:38 AM, Keith Busch wrote:
>>> Call Trace:
>>>   [<ffffffff810e75ae>] ? pcpu_free_area+0x79/0xf8
>>>   [<ffffffff8106579f>] ? __wake_up+0x35/0x46
>>>   [<ffffffff811bb67d>] ? blk_set_queue_dying+0x33/0x69
>>>   [<ffffffff811bce39>] ? blk_cleanup_queue+0x25/0xfd
>>>   [<ffffffff812b2ca5>] ? __dm_destroy+0x22c/0x254
>>
>> I wonder if it cleaned up the requests lists upfront, otherwise I
>> don't see where that would crash. I'll look into that. This particular
>> patch isn't pushed out yet.
>
> The above failure happens because dm called blk_alloc_queue(), but
> never made it far enough to call blk_init_allocated_queue(). One way
> to fix is call blk_init_rl() from blk_alloc_queue_node() instead of
> blk_init_allocated_queue(). I'm not sure if that's the right way to fix
> it or if blk_cleanup_queue() should somehow be aware if the request_list
> was initialized in the first place.

OK, I'll take care of this one.

> Also I found out I set nvmeq->cq_vector in the wrong place, messing up
> h/w completion queue interrupt setup (I was wondering why things got so
> slow!), so I'll fix that along with the struct alignment.

Oops... I'll just fold the patches, these are queued up for this round, 
so not a stable development base anyawy.

-- 
Jens Axboe
