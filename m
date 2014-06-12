From: keith.busch@intel.com (Keith Busch)
Date: Thu, 12 Jun 2014 10:24:31 -0600 (MDT)
Subject: [PATCH v7] NVMe: conversion to blk-mq
In-Reply-To: <5399BA00.7000705@bjorling.me>
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
Message-ID: <alpine.LRH.2.03.1406121015130.4699@AMR>

On Thu, 12 Jun 2014, Matias Bj?rling wrote:
> On 06/12/2014 12:51 AM, Keith Busch wrote:
>> So far so good: it passed the test that was previously failing. I'll
>> let the remaining xfstests run and see what happens.
>
> Great.
>
> The flushes was a fluke. I haven't been able to reproduce.

Cool, most of the tests are passing, except there is some really weird
stuff with the timeout handling. You've got two different places with the
same two prints, so I was a little confused where they were coming from.

I've got some more things to try to debug this, but this is thwat I have
so far:

It looks like the abort_complete callback is broken. First, the dev_warn
there makes no sense because you're pointing to the admin queue's abort
request, not the IO queue's request you're aborting. Then you call
cancel_cmd_info on the same command you're completing but it looks like
you're expecting to be doing this on the IO request you meant to abort,
but that could cause double completions.
