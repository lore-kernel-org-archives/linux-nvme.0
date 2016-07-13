From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 13 Jul 2016 09:41:25 -0700
Subject: [PATCHv3 for-4.7] nvme: Remove RCU namespace protection
In-Reply-To: <20160713164858.GA20963@localhost.localdomain>
References: <1467825770-27355-1-git-send-email-keith.busch@intel.com>
 <20160709010754.GA28997@localhost.localdomain> <57857A01.1080004@kernel.dk>
 <20160713022206.GA17034@infradead.org> <57866B41.1050307@fb.com>
 <20160713164858.GA20963@localhost.localdomain>
Message-ID: <57866F35.9090709@kernel.dk>

On 07/13/2016 09:48 AM, Keith Busch wrote:
> On Wed, Jul 13, 2016@09:24:33AM -0700, Jens Axboe wrote:
>> On 07/12/2016 07:22 PM, Christoph Hellwig wrote:
>>> On Tue, Jul 12, 2016@04:15:13PM -0700, Jens Axboe wrote:
>>>> I'm going back and forth on this... This isn't a regression for 4.7, is it?
>>>> If so, I'd be a lot more comfortable queuing this up for 4.8 (marked stable)
>>>> instead. It'll be another late addition, causing issues when it comes time
>>>> to merge for-4.8/drivers in the next merge window.
>>>
>>> It's a 4.7 regression.
>>
>> Two questions, then:
>>
>> 1) Why isn't it marked as such? Should have a Fixes tag.
>
> Sorry, my fault. I missed appending the "fixes" in later revisions as
> this evovled. Should have:
>
>    Reported-by: Ming Lin <mlin at kernel.org>
>    [fixes 0bf77e9 nvme: switch to RCU freeing the namespace]
>
>> 2) It's so large... Not really a question, other than, how can we make it
>> smaller/more contained?
>
> Fair enough. Part of the changes are not absolutely necessary (the
> ordered insertion, for example). I'll resend a smaller patch with
> the appropriate tags.

Thanks, please do. The smaller, the better...

-- 
Jens Axboe
