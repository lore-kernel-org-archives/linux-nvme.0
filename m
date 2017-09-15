From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Fri, 15 Sep 2017 17:57:31 +0000
Subject: [PATCH 1/5] block: don't call blk_mq_delay_run_hw_queue() in case
 of BLK_STS_RESOURCE
In-Reply-To: <20170915164456.9803-2-ming.lei@redhat.com>
References: <20170915164456.9803-1-ming.lei@redhat.com>
 <20170915164456.9803-2-ming.lei@redhat.com>
Message-ID: <1505498249.3420.15.camel@wdc.com>

On Sat, 2017-09-16@00:44 +0800, Ming Lei wrote:
> If .queue_rq() returns BLK_STS_RESOURCE, blk-mq will rerun
> the queue in the three situations:
> 
> 1) if BLK_MQ_S_SCHED_RESTART is set
> - queue is rerun after one rq is completed, see blk_mq_sched_restart()
> which is run from blk_mq_free_request()
> 
> 2) BLK_MQ_S_TAG_WAITING is set
> - queue is rerun after one tag is freed
> 
> 3) otherwise
> - queue is run immediately in blk_mq_dispatch_rq_list()
> 
> So calling blk_mq_delay_run_hw_queue() inside .queue_rq() doesn't make
> sense because no matter it is called or not, the queue still will be
> rerun soon in above three situations, and the busy req can be dispatched
> again.

NAK

Block drivers call blk_mq_delay_run_hw_queue() if it is known that the queue
has to be rerun later even if no request has completed before the delay has
expired. This patch breaks at least the SCSI core and the dm-mpath drivers.

Bart.
