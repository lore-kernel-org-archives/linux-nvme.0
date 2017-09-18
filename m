From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Mon, 18 Sep 2017 15:18:16 +0000
Subject: [PATCH 1/5] block: don't call blk_mq_delay_run_hw_queue() in case
 of BLK_STS_RESOURCE
In-Reply-To: <20170917124000.GB6289@ming.t460p>
References: <20170915164456.9803-1-ming.lei@redhat.com>
 <20170915164456.9803-2-ming.lei@redhat.com>
 <1505498249.3420.15.camel@wdc.com> <20170917124000.GB6289@ming.t460p>
Message-ID: <1505747894.2685.6.camel@wdc.com>

On Sun, 2017-09-17@20:40 +0800, Ming Lei wrote:
> "if no request has completed before the delay has expired" can't be a
> reason to rerun the queue, because the queue can still be busy.

That statement of you shows that there are important aspects of the SCSI
core and dm-mpath driver that you don't understand.

> I suggest to understand the root cause, instead of keeping this
> ugly random delay because run hw queue after 100ms may be useless
> in 99.99% times.

If you are still looking at removing the blk_mq_delay_run_hw_queue() calls
then I think you are looking in the wrong direction. What kind of problem
are you trying to solve? Is it perhaps that there can be a delay between
dm-mpath request completion and the queueing of a new request? If so,
adding a queue run call into the dm-mpath end_io callback is probably
sufficient and probably can replace this entire patch series.

Bart.
