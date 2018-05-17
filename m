From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 17 May 2018 11:08:11 -0600
Subject: RFC: handle completions outside the queue lock and split the
 queue lock
In-Reply-To: <20180517170544.GF23555@localhost.localdomain>
References: <20180517163152.23155-1-hch@lst.de>
 <20180517165546.GE23555@localhost.localdomain> <20180517170045.GA4945@lst.de>
 <20180517170544.GF23555@localhost.localdomain>
Message-ID: <a8e14f05-f757-a1d8-f83b-826a49a46171@kernel.dk>

On 5/17/18 11:05 AM, Keith Busch wrote:
> On Thu, May 17, 2018@07:00:45PM +0200, Christoph Hellwig wrote:
>> On Thu, May 17, 2018@10:55:46AM -0600, Keith Busch wrote:
>>> On Thu, May 17, 2018@06:31:45PM +0200, Christoph Hellwig wrote:
>>>> Mostly the previous work from Jens, just with random cleanups from me
>>>> thrown in.  Based on nvme/nvme-4.18 minus the two top-most commits,
>>>> very lightly tested.
>>>
>>> Looking good. I can force push a rebase removing the current top-two
>>> commits. Sound okay?
>>
>> Yes, let's do that for now, and let pending series settle for another
>> day or two.
> 
> Done. That's enough excitement for one day. :)

Bah, where's your sense of adventure!

FWIW, I'm testing this series, committed here:

http://git.kernel.dk/cgit/linux-block/log/?h=nvme-4.18

I'll report back end-of-day when the full cycle is done.

-- 
Jens Axboe
