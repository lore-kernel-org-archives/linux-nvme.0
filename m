From: tom.leiming@gmail.com (Ming Lei)
Date: Wed, 20 Sep 2017 00:55:37 +0800
Subject: [PATCH 1/5] block: don't call blk_mq_delay_run_hw_queue() in case
 of BLK_STS_RESOURCE
In-Reply-To: <1505839754.2671.42.camel@wdc.com>
References: <20170915164456.9803-1-ming.lei@redhat.com>
 <20170915164456.9803-2-ming.lei@redhat.com>
 <1505498249.3420.15.camel@wdc.com> <20170917124000.GB6289@ming.t460p>
 <1505747894.2685.6.camel@wdc.com> <20170919054308.GA2517@ming.t460p>
 <1505835394.2671.18.camel@wdc.com> <20170919155603.GB22809@redhat.com>
 <20170919160401.GC19830@ming.t460p> <1505839754.2671.42.camel@wdc.com>
Message-ID: <CACVXFVNvGna59hYG+gF7O41tKNURdbb+gm0sW-FGemnJi0RrRg@mail.gmail.com>

On Wed, Sep 20, 2017 at 12:49 AM, Bart Van Assche
<Bart.VanAssche@wdc.com> wrote:
> On Wed, 2017-09-20@00:04 +0800, Ming Lei wrote:
>> Run queue at end_io is definitely wrong, because blk-mq has SCHED_RESTART
>> to do that already.
>
> Sorry but I disagree. If SCHED_RESTART is set that causes the blk-mq core to
> reexamine the software queues and the hctx dispatch list but not the requeue
> list. If a block driver returns BLK_STS_RESOURCE then requests end up on the
> requeue list. Hence the following code in scsi_end_request():

That doesn't need SCHED_RESTART, because it is requeue's
responsibility to do that,
see blk_mq_requeue_work(), which will run hw queue at the end of this func.


-- 
Ming Lei
