From: axboe@fb.com (Jens Axboe)
Date: Tue, 10 Jun 2014 13:58:39 -0600
Subject: [PATCH v7] NVMe: conversion to blk-mq
In-Reply-To: <alpine.LRH.2.03.1406101140490.4699@AMR>
References: <1402392038-5268-1-git-send-email-m@bjorling.me>
 <1402392038-5268-2-git-send-email-m@bjorling.me>,
 <alpine.LRH.2.03.1406100945250.4699@AMR>
 <A52B97CC-6D77-468B-9A9B-A5888AE63580@fb.com>
 <alpine.LRH.2.03.1406101140490.4699@AMR>
Message-ID: <5397636F.9050209@fb.com>

On 06/10/2014 01:29 PM, Keith Busch wrote:
> On Tue, 10 Jun 2014, Jens Axboe wrote:
>>> On Jun 10, 2014,@9:52 AM, Keith Busch <keith.busch@intel.com> wrote:
>>>
>>>> On Tue, 10 Jun 2014, Matias Bj?rling wrote:
>>>> This converts the current NVMe driver to utilize the blk-mq layer.
>>>
>>> I'd like to run xfstests on this, but it is failing mkfs.xfs. I honestly
>>> don't know much about this area, but I think this may be from the recent
>>> chunk sectors patch causing a __bio_add_page to reject adding a new
>>> page.
>>
>> Gah, yes that's a bug in the chunk patch. It must always allow a
>> single page
>> at any offset. I'll test and send out a fix.
> 
> I have two devices, one formatted 4k, the other 512. The 4k is used as
> the TEST_DEV and 512 is used as SCRATCH_DEV. I'm always hitting a BUG when
> unmounting the scratch dev in xfstests generic/068. The bug looks like
> nvme was trying to use an SGL that doesn't map correctly to a PRP.

I'm guessing it's some of the coalescing settings, since the driver is
now using the generic block rq mapping.

> Also, it doesn't look like this driver can recover from an unresponsive
> device, leaving tasks in uniterruptible sleep state forever. Still looking
> into that one though; as far as I can tell the device is perfectly fine,
> but lots of "Cancelling I/O"  messages are getting logged.

If the task is still stuck, some of the IOs must not be getting cancelled.
