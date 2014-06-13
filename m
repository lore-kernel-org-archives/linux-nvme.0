From: keith.busch@intel.com (Keith Busch)
Date: Fri, 13 Jun 2014 09:16:41 -0600 (MDT)
Subject: [PATCH v7] NVMe: conversion to blk-mq
In-Reply-To: <539B14A9.8010204@fb.com>
References: <1402392038-5268-2-git-send-email-m@bjorling.me>
 <alpine.LRH.2.03.1406100945250.4699@AMR>
 <A52B97CC-6D77-468B-9A9B-A5888AE63580@fb.com>
 <alpine.LRH.2.03.1406101140490.4699@AMR> <5397636F.9050209@fb.com>
 <alpine.LRH.2.03.1406101458470.4699@AMR>
 <5397753B.2020009@fb.com> <alpine.LRH.2.03.1406101515430.4699@AMR>
 <20140610213333.GA10055@linux.intel.com> <539889DC.7090704@fb.com>
 <20140611170917.GA12025@linux.intel.com>
 <CAOu_J6kocZZ1mRQeSidyqJ_Ew0F_POS30v2kgUZX2wDOOnuExg@mail.gmail.com>
 <alpine.LRH.2.03.1406111641180.4699@AMR> <5399BA00.7000705@bjorling.me>
 <alpine.LRH.2.03.1406121015130.4699@AMR>
 <alpine.LRH.2.03.1406121757130.4699@AMR> <539B05A1.7080700@fb.com>
 <alpine.LRH.2.03.1406130838210.4699@AMR> <539B14A9.8010204@fb.com>
Message-ID: <alpine.LRH.2.03.1406130914110.4699@AMR>

On Fri, 13 Jun 2014, Jens Axboe wrote:
> On 06/13/2014 09:05 AM, Keith Busch wrote:
>> Here are the performance drops observed with blk-mq with the existing
>> driver as baseline:
>>
>>  CPU : Drop
>>  ....:.....
>>    0 : -6%
>>    8 : -36%
>>   16 : -12%
>
> We need the hints back for sure, I'll run some of the same tests and
> verify to be sure. Out of curiousity, what is the topology like on your
> box? Are 0/1 siblings, and 0..7 one node?

0-7 are different cores on node 0, with 16-23 being their thread
siblings. Similiar setup with 8-15 and 24-32 on node 1.
