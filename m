From: axboe@fb.com (Jens Axboe)
Date: Wed, 7 Jan 2015 09:34:30 -0700
Subject: [PATCHv2 00/10] Second attempt at blk-mq + nvme hotplug fixes
In-Reply-To: <alpine.LNX.2.00.1501071626500.4026@localhost.lm.intel.com>
References: <1420599484-21582-1-git-send-email-keith.busch@intel.com>
 <54AD5D4E.2080109@fb.com>
 <alpine.LNX.2.00.1501071626500.4026@localhost.lm.intel.com>
Message-ID: <54AD6016.7060306@fb.com>

On 01/07/2015 09:31 AM, Keith Busch wrote:
> On Wed, 7 Jan 2015, Jens Axboe wrote:
>> On 01/06/2015 07:57 PM, Keith Busch wrote:
>>> Second try, this time tested against many more scenarios than before
>>> with error injection and surprise hot-removal and intermittent resets.
>>>
>>> I'm adding a lot of stuff outside the driver, but I didn't find a
>>> cleaner way to a lot of these things. This makes me a little nervous,
>>> so please let me know if anything seems amiss here. I don't think any
>>> of the blk-mq changes could possibly be harmful to anyone else since
>>> nvme is the only driver that uses most of the additions.
>>>
>>> The only issue remaining I found is unfreezing queues might tigger the
>>> percpu_ref_reinit WARN_ON_ONCE when the driver restarts a request_queue
>>> with queued up IO's.
>>>
>>> This is against linux-block/for-next.
>>
>> Series looks sane to me, apart from the timeout change I replied to
>> separately. Could you turn that into a request flag and respin the
>> series on top of that?
>
> Thanks a bunch, I'll respin the series with the no-timeout request flag,
> correct irq spin locking I found in [8/10], and fix attribution in [4/10].

Awesome, thanks Keith! And thanks for taking the time to get this sorted.

-- 
Jens Axboe
