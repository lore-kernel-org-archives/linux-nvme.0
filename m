From: m@bjorling.me (=?UTF-8?B?TWF0aWFzIEJqw7hybGluZw==?=)
Date: Thu, 12 Jun 2014 16:32:32 +0200
Subject: [PATCH v7] NVMe: conversion to blk-mq
In-Reply-To: <alpine.LRH.2.03.1406111641180.4699@AMR>
References: <1402392038-5268-2-git-send-email-m@bjorling.me>
 <alpine.LRH.2.03.1406100945250.4699@AMR>
 <A52B97CC-6D77-468B-9A9B-A5888AE63580@fb.com>
 <alpine.LRH.2.03.1406101140490.4699@AMR> <5397636F.9050209@fb.com>
 <alpine.LRH.2.03.1406101458470.4699@AMR> <5397753B.2020009@fb.com>
 <alpine.LRH.2.03.1406101515430.4699@AMR>
 <20140610213333.GA10055@linux.intel.com> <539889DC.7090704@fb.com>
 <20140611170917.GA12025@linux.intel.com>
 <CAOu_J6kocZZ1mRQeSidyqJ_Ew0F_POS30v2kgUZX2wDOOnuExg@mail.gmail.com>
 <alpine.LRH.2.03.1406111641180.4699@AMR>
Message-ID: <5399BA00.7000705@bjorling.me>

On 06/12/2014 12:51 AM, Keith Busch wrote:
> On Wed, 11 Jun 2014, Matias Bj?rling wrote:
>> I've rebased nvmemq_review and added two patches from Jens that add
>> support for requests with single range virtual addresses.
>>
>> Keith, will you take it for a spin and see if it fixes 068 for you?
>>
>> There might still be a problem with some flushes, I'm looking into this.
>
> So far so good: it passed the test that was previously failing. I'll
> let the remaining xfstests run and see what happens.

Great.

The flushes was a fluke. I haven't been able to reproduce.
