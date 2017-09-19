From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Tue, 19 Sep 2017 23:25:47 +0000
Subject: [PATCH 1/5] block: don't call blk_mq_delay_run_hw_queue() in case
 of BLK_STS_RESOURCE
In-Reply-To: <20170919224410.GA21829@ming.t460p>
References: <1505498249.3420.15.camel@wdc.com>
 <20170917124000.GB6289@ming.t460p> <1505747894.2685.6.camel@wdc.com>
 <20170919054308.GA2517@ming.t460p> <1505835394.2671.18.camel@wdc.com>
 <20170919155603.GB22809@redhat.com> <20170919160401.GC19830@ming.t460p>
 <1505839754.2671.42.camel@wdc.com>
 <CACVXFVNvGna59hYG+gF7O41tKNURdbb+gm0sW-FGemnJi0RrRg@mail.gmail.com>
 <1505846549.2671.52.camel@wdc.com> <20170919224410.GA21829@ming.t460p>
Message-ID: <1505863546.2671.55.camel@wdc.com>

On Wed, 2017-09-20@06:44 +0800, Ming Lei wrote:
> For this issue, it isn't same between SCSI and dm-rq.
> 
> We don't need to run queue in .end_io of dm, and the theory is
> simple, otherwise it isn't performance issue, and should be I/O hang.
> 
> 1) every dm-rq's request is 1:1 mapped to SCSI's request
> 
> 2) if there is any mapped SCSI request not finished, either
> in-flight or in requeue list or whatever, there will be one
> corresponding dm-rq's request in-flight
> 
> 3) once the mapped SCSI request is completed, dm-rq's completion
> path will be triggered and dm-rq's queue will be rerun because of
> SCHED_RESTART in dm-rq
> 
> So the hw queue of dm-rq has been run in dm-rq's completion path
> already, right? Why do we need to do it again in the hot path?

The measurement data in the description of patch 5/5 shows a significant
performance regression for an important workload, namely random I/O.
Additionally, the performance improvement for sequential I/O was achieved
for an unrealistically low queue depth. Sorry but given these measurement
results I don't see why I should spend more time on this patch series.

Bart.
