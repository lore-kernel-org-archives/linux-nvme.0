From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 25 Sep 2018 22:38:22 -0700
Subject: nvmet: Kernel v4.19-rc4 circular locking complaint
In-Reply-To: <1537465780.224533.19.camel@acm.org>
References: <1537465780.224533.19.camel@acm.org>
Message-ID: <1b13d375-3ab4-4e95-ea3b-662ddba8bdf9@grimberg.me>

> Hello,

Thanks for reporting Bart!

> Here is another complaint that appeared while running the nvmeof-mp tests.
> Sagi, I have Cc-ed you because I think that this complaint may be related
> to the flush_scheduled_work() call that was inserted in
> nvmet_rdma_queue_connect() by commit 777dc82395de ("nvmet-rdma: occasionally
> flush ongoing controller teardown"). It seems weird to me that work is
> flushed from the context of an RDMA/CM handler, which is running in the
> context of a work item itself.

Your right, the point was to make sure we free resources (async) in
rapid connect/disconnect scenarios.

I think that moving release work to a private wq should help, does it
make this complaint go away?
--
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index bfc4da660bb4..5becca88ccbe 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -122,6 +122,7 @@ struct nvmet_rdma_device {
         int                     inline_page_count;
  };

+struct workqueue_struct *nvmet_rdma_delete_wq;
  static bool nvmet_rdma_use_srq;
  module_param_named(use_srq, nvmet_rdma_use_srq, bool, 0444);
  MODULE_PARM_DESC(use_srq, "Use shared receive queue.");
@@ -1267,12 +1268,12 @@ static int nvmet_rdma_queue_connect(struct 
rdma_cm_id *cm_id,

         if (queue->host_qid == 0) {
                 /* Let inflight controller teardown complete */
-               flush_scheduled_work();
+               flush_workqueue(nvmet_rdma_delete_wq);
         }

         ret = nvmet_rdma_cm_accept(cm_id, queue, &event->param.conn);
         if (ret) {
-               schedule_work(&queue->release_work);
+               queue_work(nvmet_rdma_delete_wq, &queue->release_work);
                 /* Destroying rdma_cm id is not needed here */
                 return 0;
         }
@@ -1337,7 +1338,7 @@ static void __nvmet_rdma_queue_disconnect(struct 
nvmet_rdma_queue *queue)

         if (disconnect) {
                 rdma_disconnect(queue->cm_id);
-               schedule_work(&queue->release_work);
+               queue_work(nvmet_rdma_delete_wq, &queue->release_work);
         }
  }
@@ -1367,7 +1368,7 @@ static void nvmet_rdma_queue_connect_fail(struct 
rdma_cm_id *cm_id,
         mutex_unlock(&nvmet_rdma_queue_mutex);

         pr_err("failed to connect queue %d\n", queue->idx);
-       schedule_work(&queue->release_work);
+       queue_work(nvmet_rdma_delete_wq, &queue->release_work);
  }

  /**
@@ -1649,8 +1650,17 @@ static int __init nvmet_rdma_init(void)
         if (ret)
                 goto err_ib_client;

+       nvmet_rdma_delete_wq = alloc_workqueue("nvmet-rdma-delete-wq",
+                       WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
+       if (!nvmet_rdma_delete_wq) {
+               ret = -ENOMEM;
+               goto err_unreg_transport;
+       }
+
         return 0;

+err_unreg_transport:
+       nvmet_unregister_transport(&nvmet_rdma_ops);
  err_ib_client:
         ib_unregister_client(&nvmet_rdma_ib_client);
         return ret;
@@ -1658,6 +1668,7 @@ static int __init nvmet_rdma_init(void)

  static void __exit nvmet_rdma_exit(void)
  {
+       destroy_workqueue(nvmet_rdma_delete_wq);
         nvmet_unregister_transport(&nvmet_rdma_ops);
         ib_unregister_client(&nvmet_rdma_ib_client);
         WARN_ON_ONCE(!list_empty(&nvmet_rdma_queue_list));
--
