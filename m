From: keith.busch@intel.com (Keith Busch)
Date: Tue, 10 Jun 2014 15:10:16 -0600 (MDT)
Subject: [PATCH v7] NVMe: conversion to blk-mq
In-Reply-To: <5397636F.9050209@fb.com>
References: <1402392038-5268-1-git-send-email-m@bjorling.me>
 <1402392038-5268-2-git-send-email-m@bjorling.me>,
 <alpine.LRH.2.03.1406100945250.4699@AMR>
 <A52B97CC-6D77-468B-9A9B-A5888AE63580@fb.com>
 <alpine.LRH.2.03.1406101140490.4699@AMR> <5397636F.9050209@fb.com>
Message-ID: <alpine.LRH.2.03.1406101458470.4699@AMR>

On Tue, 10 Jun 2014, Jens Axboe wrote:
> On 06/10/2014 01:29 PM, Keith Busch wrote:
>> I have two devices, one formatted 4k, the other 512. The 4k is used as
>> the TEST_DEV and 512 is used as SCRATCH_DEV. I'm always hitting a BUG when
>> unmounting the scratch dev in xfstests generic/068. The bug looks like
>> nvme was trying to use an SGL that doesn't map correctly to a PRP.
>
> I'm guessing it's some of the coalescing settings, since the driver is
> now using the generic block rq mapping.

Ok, sounds right. I mentioned in a way earlier review it doesn't look
like a request that doesn't conform to a PRP list would get split anymore,
and this test seems to confirm that.

Can we create something that will allow a driver to add DMA constraints to
a request queue with the rules of a PRP list?
