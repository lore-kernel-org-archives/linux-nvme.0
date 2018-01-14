From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 14 Jan 2018 11:56:49 +0200
Subject: [PATCH] nvme: Add weighted-round-robin arbitration support
In-Reply-To: <1515078129-4041-1-git-send-email-joshi.k@samsung.com>
References: <CGME20180104150334epcas1p14579a6ab7bcf1b6ce326d0bce89c91e1@epcas1p1.samsung.com>
 <1515078129-4041-1-git-send-email-joshi.k@samsung.com>
Message-ID: <e9a8ceea-0568-b712-326f-adff2f07121a@grimberg.me>

Hi Joshi,

> This patch enables support for Weighted-Round-Robin (WRR) arbitration, so
> that applications can make use of the prioritization capabilities natively
> present in NVMe controller.
> 
> - It links existing io-nice classes (real-time, best-effort, none, low)
> to NVMe priorities (urgent, high, medium, low).  This is done through
> 'request->ioprio' field inside 'queue_rq' function.
> 
> - Current driver has 1:1 mapping (1 SQ, 1 CQ) per cpu, encapsulated in
> 'nvmeq' structure.  This patch refactors the code so that N:1 mapping per
> cpu can be created; 'nvmeq' has been changed to contain variable number of SQ
> related fields.  For WRR, 4 submission-queues (corresponding to each queue
> priorites) need to be created on each cpu.
> 
> - When 'enable_wrr' module param is passed, it creates 4:1 mapping and enables
> controller in WRR mode.  Otherwise, it cotinues to retain 1:1 mapping and
> controller remains in RR mode.
> 
> - NVMe device may have less number of queues than required for 4:1 mapping
> per cpu.  For example, when num_possible_cpus is 64, 256 submission-queues are
> required for 4:1 mapping while device may support, say, 128.
> This case is handled by creating 32 queue-pairs which are shared among 64 cpus.
> Another way to handle this could have been reducing to 3:1 or 2:1 mapping
> (and remapping 4 ionice classes as well).
> 
> -Admin queue, contains 1:1 mapping irrespective of the mode (RR or WRR) used.

Regardless the dicussion with Keihth, this patch should be divided into
three or four preparatory patches and the wrr patch.

1. keeping nvmeq->cq_db
2. changing nvme_enable_ctrl not to set ctrl_config (needs to verify
    doesn't break anything)
3. keeping multiple sqs per nvmeq and plumbing the sq_index
4. wire up wrr

This is true also if this is moving to blk-mq
