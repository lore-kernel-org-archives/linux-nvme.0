From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 2 Sep 2015 12:03:30 -0600
Subject: [PATCH 3/3] block: Refuse adding appending a gapped integrity
 page to a bio
In-Reply-To: <55E7324B.3060601@dev.mellanox.co.il>
References: <1436966356-8979-1-git-send-email-sagig@mellanox.com>
 <1436966356-8979-4-git-send-email-sagig@mellanox.com>
 <55A67C17.4080706@kernel.dk> <20150716092646.GA17712@infradead.org>
 <55A7D4B6.9020101@kernel.dk> <55ABBFB1.7070201@dev.mellanox.co.il>
 <20150819094003.GB14734@infradead.org> <55D45AE0.50805@dev.mellanox.co.il>
 <20150819104246.GA4956@infradead.org> <55E6ADA4.5040905@dev.mellanox.co.il>
 <20150902143756.GA11062@kernel.dk> <55E7324B.3060601@dev.mellanox.co.il>
Message-ID: <55E739F2.2050006@kernel.dk>

On 09/02/2015 11:30 AM, Sagi Grimberg wrote:
> On 9/2/2015 5:37 PM, Jens Axboe wrote:
>> On 09/02/2015 02:04 AM, Sagi Grimberg wrote:
>>> On 8/19/2015 1:42 PM, Christoph Hellwig wrote:
>>>> On Wed, Aug 19, 2015@01:30:56PM +0300, Sagi Grimberg wrote:
>>>>> Actually I didn't. I started to, but then I noticed that
>>>>> I was still seeing gaps when using cfq (e.g. non-mq code
>>>>> path), I assume that this was never tested?
>>>>
>>>> It probably wasn't.  The only user so far is the NVMe driver which
>>>> is blk-mq only.
>>>
>>> So I got back to have a look on this. I originally thought that
>>> this issue was specific to io schedulers, but I don't think it is
>>> anymore, its just easier to trigger with io schedulers.
>>>
>>> It seems we are only protecting against gapped back merges (i.e.
>>> appending a gapped bio to a request biotail) but we are not protecting
>>> against front merges (i.e. adding a gapped bio to request as the bio
>>> head).
>>>
>>> Imagine we have two bio_vec elements and the queue boundary is 0xfff:
>>> req_bvec: offset=0xe00 length=0x200
>>> bio_bvec: offset=0x0 length=0x200
>>>
>>> bvec_gap_to_prev() will allow back merging {req_bvec, bio_bvec} as
>>> bio_vec->offset=0x0 and req_bvec->offset + req_bvec->length is aligned
>>> to the queue boundary, but the problem is we might do a front merge
>>> {bio_bvec, req_bvec} which gives us a gap.
>>>
>>> I'm able to reproduce this with iser with 512B sequential reads
>>> (encourage gapped merges) but I wonder how this issue was missed in
>>> nvme (the code seem to allow front merges)?
>>>
>>> Anyway, the patch below seems to solved the issue for me:
>>>
>>> Comments?
>>
>> Weird, I guess front merging was overlooked when the initial patch was
>> added. Looks correct to me, and as far as I can see, we have now got all
>> bases covered.
>>
>> But there's room for some cleanup now, where we check is a bit of a
>> mess. If we kill the check in blk_rq_merge_ok() and only do them in the
>> front/back merge points (and the req-to-req case), then I think that
>> would be an improvement.
>
>
> Yea, we do get to checking back merges even for front merges in this
> point...

Yup

>> Does the below work for you?
>
> It's not on top of Keith virt_boundary patch right?
> First glance looks ok though.

Looks like I was on the wrong branch, master. Let me update it for post 
that patch.

-- 
Jens Axboe
