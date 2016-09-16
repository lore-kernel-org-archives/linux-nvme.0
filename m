From: axboe@fb.com (Jens Axboe)
Date: Fri, 16 Sep 2016 09:34:12 -0600
Subject: [PATCH v3 2/3] nvme: Pass pointers, not dma addresses, to
 nvme_get/set_features()
In-Reply-To: <CALCETrVr2hTd=-gX8oVSL_AR3WX1rpp9B+9EXswE7c1J6rF8FA@mail.gmail.com>
References: <cover.1474002926.git.luto@kernel.org>
 <accff9a7a1b04cdb8fc364851f20b93e3de0d7f0.1474002926.git.luto@kernel.org>
 <20160916084121.GC2415@lst.de>
 <CALCETrVr2hTd=-gX8oVSL_AR3WX1rpp9B+9EXswE7c1J6rF8FA@mail.gmail.com>
Message-ID: <f454464c-3afb-f151-69c2-1634f0b28545@fb.com>

On 09/16/2016 09:13 AM, Andy Lutomirski wrote:
> On Sep 16, 2016 1:41 AM, "Christoph Hellwig" <hch@lst.de> wrote:
>>
>> On Thu, Sep 15, 2016@10:24:20PM -0700, Andy Lutomirski wrote:
>>> Any user I can imagine that needs a buffer at all will want to pass
>>> a pointer directly.  There are no currently callers that use
>>> buffers, so this change is painless, and it will make it much easier
>>> to start using features that use buffers (e.g. APST).
>>>
>>> Signed-off-by: Andy Lutomirski <luto at kernel.org>
>>> ---
>>
>> Looks good mostly good, but a nitpick below:
>>
>>> +     /*
>>> +      * Casting buffer to void* is safe here: __nvme_submit_sync_cmd knows
>>> +      * that we're writing because it decodes the opcode.
>>> +      */
>>> +     ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &cqe,
>>> +                     (void *)buffer, buflen, 0, NVME_QID_ANY, 0, 0);
>>
>> Cant we just drop the const annotation to avoid these casts?
>>
>
> Then we'd have nvme_set_feature() taking a non-const pointer, which
> would seem a little bit silly to me and might require the same cast
> somewhere else down the road.

That'd still be a lot cleaner than the cast, which needs a comment to
explain why it's supposedly safe. Just drop the const, imho.

-- 
Jens Axboe
