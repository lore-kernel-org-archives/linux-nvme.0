From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 26 Feb 2018 11:48:21 +0200
Subject: v4.16-rc2 nvme_rdma ib_destroy_qp() warns about MRs
In-Reply-To: <ca148f27-1b59-02a2-fc76-ee3e9a7edeb3@grimberg.me>
References: <1519431811.2904.52.camel@wdc.com>
 <7b1527ec-8c2f-6bc6-37f8-56053882b328@grimberg.me>
 <ca148f27-1b59-02a2-fc76-ee3e9a7edeb3@grimberg.me>
Message-ID: <d3e62a90-4a0b-fee0-7c78-5bd6e4dbab52@mellanox.com>

hi Sagi,

I tried this patch but it still doesn't fix the issue.
this is the same issue I reported and discussed with Ming:
https://www.mail-archive.com/linux-block at vger.kernel.org/msg18559.html

we must somehow drain the commands that were pushed between 
blk_mq_quiesce_queue to blk_mq_unquiesce_queue. The timeout expires 
after we destroy the QP and there are MR missing in the pool.

I'll get back to this after SDC EMEA :)

-Max.

On 2/25/2018 8:06 PM, Sagi Grimberg wrote:
> 
> 
> On 02/25/2018 08:02 PM, Sagi Grimberg wrote:
>>
>>> Hello,
>>
>> Hi Bart,
>>
>>> With the v4.16-rc2 nvme_rdma driver on top of the rdma_rxe driver the
>>> following kernel warning appeared in the kernel log:
>>>
>>> CPU: 3 PID: 152 Comm: kworker/u8:3 Not tainted 4.16.0-rc2-dbg+ #3
>>> Workqueue: nvme-wq nvme_rdma_error_recovery_work [nvme_rdma]
>>> RIP: 0010:ib_destroy_qp+0x177/0x1a0 [ib_core]
>>> Call Trace:
>>> ? nvme_rdma_destroy_queue_ib+0x32/0x70 [nvme_rdma]
>>> ? nvme_rdma_free_queue+0x2e/0x90 [nvme_rdma]
>>> ? nvme_rdma_destroy_io_queues+0x5d/0xb0 [nvme_rdma]
>>> ? nvme_rdma_error_recovery_work+0x4c/0xb0 [nvme_rdma]
>>> ? process_one_work+0x20b/0x6a0
>>> ? worker_thread+0x35/0x380
>>> ? kthread+0x117/0x130
>>> ? ret_from_fork+0x24/0x30
>>
>> Thanks for reporting.
>>
>>> Does this mean that the nvme_rdma driver calls ib_destroy_qp() before 
>>> all MRs
>>> associated with the QP have been destroyed?
>>
>> That's the warning... But I'm having troubles understanding how can this
>> be a nvme-rdma issue. We only allocate in .queue_rq if we passed which
>> means that the queue has READY on, and before we destroy the qp only
>> after we:
>> 1. quiesced all the request queues
>> 2. cancel all started requests (which trigger nvme_rdma_complete_request
>> that returns the mr to the pool)
>>
>> So the only way I see that we can get here, is if
>> blk_mq_complete_request does not call __blk_mq_complete_request.
>>
>> This can happen when:
>> -- 
>> ???????? /*
>> ????????? * If @rq->aborted_gstate equals the current instance, 
>> timeout is
>> ????????? * claiming @rq and we lost.? This is synchronized through
>> ????????? * hctx_lock().? See blk_mq_timeout_work() for details.
>> ????????? *
>> ????????? * Completion path never blocks and we can directly use RCU here
>> ????????? * instead of hctx_lock() which can be either RCU or SRCU.
>> ????????? * However, that would complicate paths which want to 
>> synchronize
>> ????????? * against us.? Let stay in sync with the issue path so that
>> ????????? * hctx_lock() covers both issue and completion paths.
>> ????????? */
>> ???????? hctx_lock(hctx, &srcu_idx);
>> ???????? if (blk_mq_rq_aborted_gstate(rq) != rq->gstate)
>> ???????????????? __blk_mq_complete_request(rq);
>> ???????? hctx_unlock(hctx, srcu_idx);
>> -- 
>>
>> Does this mean that the block driver must not assume that .complete will
>> be called on a timed out request for sure?
>>
>> Is this easy to reproduce Bart? Does this patch help?
>> -- 
>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>> index 2ef761b5a26e..ffc9362a3a82 100644
>> --- a/drivers/nvme/host/rdma.c
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -1585,6 +1585,11 @@ nvme_rdma_timeout(struct request *rq, bool 
>> reserved)
>> ????????????????? "I/O %d QID %d timeout, reset controller\n",
>> ????????????????? rq->tag, nvme_rdma_queue_idx(req->queue));
>>
>> +?????? if (req->mr) {
>> +?????????????? ib_mr_pool_put(queue->qp, &queue->qp->rdma_mrs, req->mr);
>> +?????????????? req->mr = NULL;
>> +?????? }
>> +
>> ???????? /* queue error recovery */
>> ???????? nvme_rdma_error_recovery(req->queue->ctrl);
>> -- 
> 
> Now with a patch that actually compiles :)
> -- 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 2ef761b5a26e..4c32518a6c81 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1585,6 +1585,11 @@ nvme_rdma_timeout(struct request *rq, bool reserved)
>  ???????????????? "I/O %d QID %d timeout, reset controller\n",
>  ???????????????? rq->tag, nvme_rdma_queue_idx(req->queue));
> 
> +?????? if (req->mr) {
> +?????????????? ib_mr_pool_put(req->queue->qp, 
> &req->queue->qp->rdma_mrs, req->mr);
> +?????????????? req->mr = NULL;
> +?????? }
> +
>  ??????? /* queue error recovery */
>  ??????? nvme_rdma_error_recovery(req->queue->ctrl);
> -- 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&data=02%7C01%7Cmaxg%40mellanox.com%7Cf5862c14e9174ef33a8c08d57c7a8817%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636551788090800209&sdata=QTzZ4zaOYXajnh1HVIaIYhnjOE3t3TUr9hGSU2xW%2FPI%3D&reserved=0 
> 
