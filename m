From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 19 Jun 2018 19:21:50 +0300
Subject: [PATCH] nvme: Fix error flow at nvme_rdma_configure_admin_queue()
In-Reply-To: <6e3321f1-373d-4532-4264-ec32e3624497@grimberg.me>
References: <1528979864-3109-1-git-send-email-israelr@mellanox.com>
 <20180615080154.GA19525@lst.de>
 <a760d739-f88b-99bf-27ca-4dee113b5b49@mellanox.com>
 <20180619054157.GC23184@lst.de>
 <b26fe840-8521-82f6-39c4-e5976e37c4a8@grimberg.me>
 <a75ce20c-e217-e2f8-6015-b6e2987499db@mellanox.com>
 <ecedcef1-0025-6848-1276-f143e9707a32@grimberg.me>
 <15c4c281-cea1-1a97-e5dd-41e0ef49fdd9@mellanox.com>
 <6e3321f1-373d-4532-4264-ec32e3624497@grimberg.me>
Message-ID: <fc101045-5b8e-61f2-a56e-7b9bc08e23e2@mellanox.com>



On 6/19/2018 7:12 PM, Sagi Grimberg wrote:
> 
>>>>> I think that the async buffer needs to be allocated right after
>>>>> nvme_alloc_rdma_queue and to be free right before 
>>>>> nvme_rdma_free_queue.
>>>>
>>>> why ? we call nvme_start_ctrl after configuring the admin queue. and 
>>>> we free the async buffer after we drain the QP.
>>>>
>>>> am I missing something ?
>>>
>>> If I'm not mistaken (as the change log wasn't clear enough), the issue
>>> was that in reset we fail to to configure the admin queue? (before async
>>> event buffer was allocated) and then call reconnect_or_remove which will
>>> eventually call nvme_rdma_destroy_admin_queue (freeing the async event
>>> buffer).
>>>
>>
>> No this is no the issue. The issue is that in case of failure during 
>> nvme_rdma_configure_admin_queue we go to error flow that frees the non 
>> allocated buffer. This is happening because the allocation/free are 
>> not symetrical.
>> The patch fixes that.
> 
> But it not addresses the issue where reset_ctrl fails, for that you need
> for the async event buffer to be allocated before the queue is started.

fails where exactly ?
I wasn't talking about it, but I've sent another patch yesterday to fix 
reset error flow (please review):

---
  drivers/nvme/host/rdma.c | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index cef24ad..c193f61 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1781,7 +1781,7 @@ static void nvme_rdma_reset_ctrl_work(struct 
work_struct *work)
  	if (ctrl->ctrl.queue_count > 1) {
  		ret = nvme_rdma_configure_io_queues(ctrl, false);
  		if (ret)
-			goto out_fail;
+			goto destroy_admin;
  	}

  	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
@@ -1795,6 +1795,8 @@ static void nvme_rdma_reset_ctrl_work(struct 
work_struct *work)

  	return;

+destroy_admin:
+	nvme_rdma_destroy_admin_queue(ctrl, false);
  out_fail:
  	++ctrl->ctrl.nr_reconnects;
  	nvme_rdma_reconnect_or_remove(ctrl);
-- 
