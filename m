From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 11 Jun 2014 13:09:17 -0400
Subject: [PATCH v7] NVMe: conversion to blk-mq
In-Reply-To: <539889DC.7090704@fb.com>
References: <1402392038-5268-2-git-send-email-m@bjorling.me>
 <alpine.LRH.2.03.1406100945250.4699@AMR>
 <A52B97CC-6D77-468B-9A9B-A5888AE63580@fb.com>
 <alpine.LRH.2.03.1406101140490.4699@AMR> <5397636F.9050209@fb.com>
 <alpine.LRH.2.03.1406101458470.4699@AMR> <5397753B.2020009@fb.com>
 <alpine.LRH.2.03.1406101515430.4699@AMR>
 <20140610213333.GA10055@linux.intel.com> <539889DC.7090704@fb.com>
Message-ID: <20140611170917.GA12025@linux.intel.com>

On Wed, Jun 11, 2014@10:54:52AM -0600, Jens Axboe wrote:
> OK, so essentially any single request must be a virtually contig piece
> of memory. Is there any size limitations to how big this contig segment
> can be?

The maximum size of an I/O is 65536 sectors.  So on a 512-byte sector
device, that's 32MB, but on a 4k sector size device, that's 128MB.

> I think this is unique requirement, at least I haven't seen other pieces
> of hardware have it. But it would be pretty trivial to add a setting to
> limit merges based on virtually contig, similarly to what is done for
> number of physical segments.

I think there might be an FCoE device with that requirement too.
