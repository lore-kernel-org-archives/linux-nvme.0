From: keith.busch@intel.com (Keith Busch)
Date: Wed, 3 Feb 2016 14:41:24 +0000
Subject: [PATCH] NVMe: do not touch sq door bell if nvmeq has been
 suspended
In-Reply-To: <BJXPR01MB19940BA759DBBADC6BF6BD2E0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
References: <1454341324-21273-1-git-send-email-mail_weber_wang@163.com>
 <56AF8DB5.70206@fb.com>
 <BJXPR01MB19940BA759DBBADC6BF6BD2E0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
Message-ID: <20160203144123.GB23910@localhost.localdomain>

On Tue, Feb 02, 2016@07:15:57AM +0000, Wenbo Wang wrote:
> I did the following test to validate the issue.
> 
> 1. Modify code as below to increase the chance of races.
> 	Add 10s delay after nvme_dev_unmap() in nvme_dev_disable()
> 	Add 10s delay before __nvme_submit_cmd()
> 2. Run dd and at the same time, echo 1 to reset_controller to trigger device reset. Finally kernel crashes due to accessing unmapped door bell register.
> 
> Following is the execution order of the two code paths:
> __blk_mq_run_hw_queue
>   Test BLK_MQ_S_STOPPED
> 					nvme_dev_disable()
> 					     nvme_stop_queues()  <-- set BLK_MQ_S_STOPPED
> 					     nvme_dev_unmap(dev)  <-- unmap door bell
>   nvme_queue_rq()
>       Touch door bell	<-- panic here

Does the following force the first to complete before the unmap?

---
@@ -1415,10 +1421,21 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 
 		blk_mq_cancel_requeue_work(ns->queue);
 		blk_mq_stop_hw_queues(ns->queue);
+		blk_sync_queue(ns->queue);
 	}
 	mutex_unlock(&ctrl->namespaces_mutex);
 }
--
