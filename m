From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Tue, 2 Feb 2016 14:41:37 +0200
Subject: [PATCH] NVMe: do not touch sq door bell if nvmeq has been
 suspended
In-Reply-To: <BJXPR01MB19940BA759DBBADC6BF6BD2E0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
References: <1454341324-21273-1-git-send-email-mail_weber_wang@163.com>
 <56AF8DB5.70206@fb.com>
 <BJXPR01MB19940BA759DBBADC6BF6BD2E0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
Message-ID: <56B0A401.30306@dev.mellanox.co.il>


> Jens,
>
> I did the following test to validate the issue.
>
> 1. Modify code as below to increase the chance of races.
> 	Add 10s delay after nvme_dev_unmap() in nvme_dev_disable()
> 	Add 10s delay before __nvme_submit_cmd()
> 2. Run dd and at the same time, echo 1 to reset_controller to trigger device reset. Finally kernel crashes due to accessing unmapped door bell register.
>
> Following is the execution order of the two code paths:
> __blk_mq_run_hw_queue
>    Test BLK_MQ_S_STOPPED
> 					nvme_dev_disable()
> 					     nvme_stop_queues()  <-- set BLK_MQ_S_STOPPED
> 					     nvme_dev_unmap(dev)  <-- unmap door bell
>    nvme_queue_rq()
>        Touch door bell	<-- panic here

First of all, I think we need to cancel all
inflight requests before nvme_dev_unmap.

With my patches that move I/O termination to the
nvme core ([PATCH v1 0/3] Move active IO termination to the core)
the change needed is:
--
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e921165..2288bdb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1890,10 +1890,11 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
                 nvme_shutdown_ctrl(&dev->ctrl);
                 nvme_disable_queue(dev, 0);
         }
-       nvme_dev_unmap(dev);

         blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_io, dev);
         blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_io, dev);
+
+       nvme_dev_unmap(dev);
  }

  static int nvme_setup_prp_pools(struct nvme_dev *dev)
--

But still we need a way to wait out for all active
queue_rq to end. It seems like we need to maintain
the request_fn_active for blk-mq and provide an
API (blk_mq_wait_for_active_requests ?) that waits for
it to drop to zero.

Thoughts?
