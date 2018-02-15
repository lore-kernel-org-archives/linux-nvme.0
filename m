From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 15 Feb 2018 20:09:29 +0200
Subject: [PATCH 1/3] nvme: rename NVME_CTRL_RECONNECTING state to
 NVME_CTRL_CONNECTING
In-Reply-To: <86130f62-dc14-e0d1-8e67-8918e4fcf59c@mellanox.com>
References: <1517416286-31109-1-git-send-email-maxg@mellanox.com>
 <1517416286-31109-2-git-send-email-maxg@mellanox.com>
 <d8241724-ef3a-4946-4629-3598413ca836@grimberg.me>
 <c896305c-90d0-e4aa-d861-ea9ad0076161@grimberg.me>
 <7a611bf2-8a70-1b11-0616-f79531a2cc3d@mellanox.com>
 <d6e78772-5345-3a03-b376-5656bfebe606@grimberg.me>
 <HE1PR0501MB1979A7C5B848771064C30C57B6F60@HE1PR0501MB1979.eurprd05.prod.outlook.com>
 <44b5f866-3b98-ba25-ff8a-3c0ce9f03c8b@grimberg.me>
 <86130f62-dc14-e0d1-8e67-8918e4fcf59c@mellanox.com>
Message-ID: <eee14d43-d5cb-6903-ad4d-a0ef5be62991@mellanox.com>



On 2/14/2018 4:20 PM, Max Gurtovoy wrote:
> 
> 
> On 2/14/2018 3:40 PM, Sagi Grimberg wrote:
>>
>>> During port toggle with traffic (using dm-multipath) I see some
>>> warnings during ib_destroy_qp that say there are still mrs_used.
>>> and therefore also in ib_dealloc_pd that says refcount on pd is not 0.
>>>
>>> I'll debug it tomorrow hopefully and update.
>>
>> Is this a regression that happened due to your patch set?
> 
> I don't think so. Without my patches we crash.
> I see that we have a timeout on admin_q, and then I/O error:
> 
> 
> [Wed Feb 14 14:10:59 2018] nvme nvme0: I/O 0 QID 0 timeout, reset 
> controller
> [Wed Feb 14 14:10:59 2018] nvme nvme0: failed nvme_keep_alive_end_io 
> error=10
> [Wed Feb 14 14:10:59 2018] print_req_error: I/O error, dev nvme0n1, 
> sector 704258460
> [Wed Feb 14 14:10:59 2018] print_req_error: I/O error, dev nvme0n1, 
> sector 388820158
> [Wed Feb 14 14:10:59 2018] ib_mr_pool_destroy: destroyed 121 mrs, 
> mrs_used 6 for qp 000000008182fc6f
> [Wed Feb 14 14:10:59 2018] print_req_error: I/O error, dev nvme0n1, 
> sector 489120554
> [Wed Feb 14 14:10:59 2018] print_req_error: I/O error, dev nvme0n1, 
> sector 399385206
> [Wed Feb 14 14:10:59 2018] device-mapper: multipath: Failing path 259:0.
> [Wed Feb 14 14:10:59 2018] WARNING: CPU: 9 PID: 12333 at 
> drivers/infiniband/core//verbs.c:1524 ib_destroy_qp+0x159/0x170 [ib_core]
> [Wed Feb 14 14:10:59 2018] print_req_error: I/O error, dev nvme0n1, 
> sector 269330912
> [Wed Feb 14 14:10:59 2018] Modules linked in:
> [Wed Feb 14 14:10:59 2018] print_req_error: I/O error, dev nvme0n1, 
> sector 211936734
> [Wed Feb 14 14:10:59 2018]? nvme_rdma(OE)
> [Wed Feb 14 14:10:59 2018] print_req_error: I/O error, dev nvme0n1, 
> sector 383446442
> [Wed Feb 14 14:10:59 2018]? nvme_fabrics(OE) nvme_core(OE)
> [Wed Feb 14 14:10:59 2018] print_req_error: I/O error, dev nvme0n1, 
> sector 160594228
> 
> 
> for some reason not all commands complete before we destroy the QP (we 
> use dm-multipath here).

What I did is freezing the queue and it seems to help. But now the 
failover takes ~cmd_timeout secs:


@@ -931,6 +938,8 @@ static void nvme_rdma_error_recovery_work(struct 
work_struct *work)
         nvme_stop_keep_alive(&ctrl->ctrl);

         if (ctrl->ctrl.queue_count > 1) {
+               nvme_start_freeze(&ctrl->ctrl);
+               nvme_wait_freeze(&ctrl->ctrl);
                 nvme_stop_queues(&ctrl->ctrl);
                 blk_mq_tagset_busy_iter(&ctrl->tag_set,
                                         nvme_cancel_request, &ctrl->ctrl);
@@ -948,6 +957,7 @@ static void nvme_rdma_error_recovery_work(struct 
work_struct *work)
          */
         blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
         nvme_start_queues(&ctrl->ctrl);
+       nvme_unfreeze(&ctrl->ctrl);

         if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
                 /* state change failure should never happen */


I borrowed it from the nvme pci driver to make sure we won't receive any 
new requests (even timed out requests).
Maybe Keith can look on that ?

I don't think the above is the right solution but we must to make sure 
we don't get any request during reconnection or after freeing the QP.
We might end up with free/alloc the tagset on each reconnection or at 
least use blk_mq_queue_reinit.

I'll try it too.


> 
> In iser (we also saw that the pool has registered regions) we created 
> all_list and we free the MRs from there...
> 
> 
> -Max.
