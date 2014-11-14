From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 14 Nov 2014 09:32:11 -0700
Subject: [PATCH] NVMe: Add rw_page support
In-Reply-To: <20141114155223.GG11522@wil.cx>
References: <1415923538-18760-1-git-send-email-keith.busch@intel.com>
 <54655B01.9090206@kernel.dk> <20141114145858.GF11522@wil.cx>
 <54661AC5.7000605@kernel.dk> <20141114155223.GG11522@wil.cx>
Message-ID: <54662E8B.9070409@kernel.dk>

On 11/14/2014 08:52 AM, Matthew Wilcox wrote:
> On Fri, Nov 14, 2014@08:07:49AM -0700, Jens Axboe wrote:
>> On 11/14/2014 07:58 AM, Matthew Wilcox wrote:
>>> On Thu, Nov 13, 2014@06:29:37PM -0700, Jens Axboe wrote:
>>>> The downside I see is that this is an OOB IO path. Once we start adding IO
>>>> scheduling for those that need that, then this will completely bypass that.
>>>
>>> The idea is that you would only enable it for devices that are based on
>>> NVM that is of "near-DRAM" speeds, and can complete small I/Os as fast
>>> as they are issued.  For those kinds of devices, there is absolutely no
>>> value to any kind of IO scheduling.
>>
>> I agree, that's not the kind of device that people would generally do
>> scheduling on, and we can't at those rates. But if that's the case, why
>> isn't this a sync interface? "Near DRAM speeds" and interrupt driven
>> seems like a poor choice.
> 
> It could be done as a sync interface; zram and brd do implement it
> synchronously.  But if you look at the callers, mostly they try to send
> several pages before waiting on each of them to complete, and so we can
> overlap the work of sending each page with the drive handling the I/O
> of the previous page.  You'll notice that we check the completion queue
> before returning from nvme_rw_page(), so not waiting for an interrupt
> to fire for anything that already completed.

For the cases where you do indeed end up submitting multiple, it's even
more of a shame to bypass the normal IO path. There are various tricks
we can do in there to speed things up, like batched doorbell rings. And
if we kill that last alloc/free per IO, then I'd really be curious to
know why rw_page is faster. Seems it should be possible to fix that up
instead.

> The missing piece that I think we need is something like the
> patch I sent last year to spin instead of sleeping in io_schedule()
> (https://lwn.net/Articles/555886/).  That will ensure that we pick up
> the last I/O or two without waiting for an interrupt.

Yes, we need to look more into that at some point. If we can eliminate a
sleep/wakeup cycle, we're way ahead in the game.


-- 
Jens Axboe
