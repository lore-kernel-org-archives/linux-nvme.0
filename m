From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 26 Oct 2016 20:05:14 -0700
Subject: [PATCH 05/12] blk-mq: Introduce blk_mq_quiesce_queue()
In-Reply-To: <CACVXFVNyRnJFnsSO9TNksE5GNy7TJKL=iZnqrv38=u0XCrW7jA@mail.gmail.com>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
 <5143c240-39af-9fe2-d3e6-ed69f9c20531@sandisk.com>
 <CACVXFVPWL=izFmUPtpi-+RLrhNX0LFfw2m6eurgMC5GvfDWsxQ@mail.gmail.com>
 <7690b469-f5b7-ab04-4b6f-fa0d679e0f18@acm.org>
 <CACVXFVNvdNXm4JXsXo2p1_pZLqDpCos0MTTR+svR98p_vw5PCA@mail.gmail.com>
 <16074653-5e31-27b0-90db-33d36a9df0bc@acm.org>
 <CACVXFVNyRnJFnsSO9TNksE5GNy7TJKL=iZnqrv38=u0XCrW7jA@mail.gmail.com>
Message-ID: <8404f2d1-5bc3-6c84-7ca0-24e7672ff67d@acm.org>

On 10/26/16 19:48, Ming Lei wrote:
> On Thu, Oct 27, 2016@10:40 AM, Bart Van Assche <bvanassche@acm.org> wrote:
>> If you have a look at the later patches in this series then you will see
>> that the dm core and the NVMe driver have been modified such that
>> blk_mq_stop_hw_queues(q) is called immediately before
>> blk_mq_quiesce_queue(q) is called.
>
> Cause any current and future users of blk_mq_quiesce_queue(q)
> have to set the flag via blk_mq_stop_hw_queues(q), why not set
> the flag explicitly in blk_mq_quiesce_queue(q)?

Hello Ming,

I'll leave it to Jens to decide whether I should repost the patch series 
with this change integrated or whether to realize this change with a 
follow-up patch.

Bart.
