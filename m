From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 16 Mar 2018 09:26:24 -0700
Subject: [GIT PULL] nvme fix for 4.16-rc6
In-Reply-To: <20180316161655.GA13293@lst.de>
References: <20180316160110.GC720@localhost.localdomain>
 <e58b5357-6885-75dc-c027-9bea3cd6829d@kernel.dk>
 <20180316161655.GA13293@lst.de>
Message-ID: <8734416c-cd14-8bfb-8e2c-6eab84e0ce5d@kernel.dk>

On 3/16/18 9:16 AM, Christoph Hellwig wrote:
> On Fri, Mar 16, 2018@09:14:34AM -0700, Jens Axboe wrote:
>> On 3/16/18 9:01 AM, Keith Busch wrote:
>>> Hi Jens,
>>>
>>> One last fix from Jianchao to address a troubling scenario Ming identified
>>> with offlining CPUs that could leave nvme controllers unusable. We can
>>> not allow that to occur, so we wish to include a new IRQ spread that
>>> prevents that situation.
>>
>> Since this isn't really a regression in this release, how about
>> we push this one to 4.17 instead?
> 
> It is a regression in 4.15.  So I think we should fix this ASAP.

It's not that I dislike the patch (in fact it makes the code
easier to read), but it's pretty late for something that isn't
a regression in this series. I can queue it up for some testing,
but it's then -rc7 time. I guess we can see how it goes and
push the decision until start next week.

-- 
Jens Axboe
