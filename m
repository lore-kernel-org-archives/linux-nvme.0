From: axboe@fb.com (Jens Axboe)
Date: Tue, 10 Jun 2014 16:19:18 +0000
Subject: [PATCH v7] NVMe: conversion to blk-mq
In-Reply-To: <alpine.LRH.2.03.1406100945250.4699@AMR>
References: <1402392038-5268-1-git-send-email-m@bjorling.me>
 <1402392038-5268-2-git-send-email-m@bjorling.me>,
 <alpine.LRH.2.03.1406100945250.4699@AMR>
Message-ID: <A52B97CC-6D77-468B-9A9B-A5888AE63580@fb.com>


> On Jun 10, 2014,@9:52 AM, Keith Busch <keith.busch@intel.com> wrote:
> 
>> On Tue, 10 Jun 2014, Matias Bj?rling wrote:
>> This converts the current NVMe driver to utilize the blk-mq layer.
> 
> I'd like to run xfstests on this, but it is failing mkfs.xfs. I honestly
> don't know much about this area, but I think this may be from the recent
> chunk sectors patch causing a __bio_add_page to reject adding a new page.

Gah, yes that's a bug in the chunk patch. It must always allow a single page at any offset. I'll test and send out a fix. 
