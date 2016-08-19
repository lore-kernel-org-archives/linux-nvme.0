From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 19 Aug 2016 09:24:31 -0500
Subject: nvme/rdma initiator stuck on reboot
In-Reply-To: <008001d1fa25$0c960fb0$25c22f10$@opengridcomputing.com>
References: <043901d1f7f5$fb5f73c0$f21e5b40$@opengridcomputing.com>
 <2202d08c-2b4c-3bd9-6340-d630b8e2f8b5@grimberg.me>
 <073301d1f894$5ddb81d0$19928570$@opengridcomputing.com>
 <7c4827ff-21c9-21e9-5577-1bd374305a0b@grimberg.me>
 <075901d1f899$e5cc6f00$b1654d00$@opengridcomputing.com>
 <e2e04664-c374-3745-ecf3-f49ca7a3addf@grimberg.me>
 <012701d1f958$b4953290$1dbf97b0$@opengridcomputing.com>
 <20160818152107.GA17807@infradead.org>
 <f06590ad-e408-e234-2ec4-7f28978411b7@grimberg.me>
 <008001d1fa25$0c960fb0$25c22f10$@opengridcomputing.com>
Message-ID: <008101d1fa25$66c62290$345267b0$@opengridcomputing.com>

> One other thing:  in both nvme_rdma_device_unplug() and
> nvme_rdma_del_ctrl(), the code kicks the delete_work thread to delete the
> controller and then calls flush_work().  This is a possible
> touch-after-free, no?  The proper way, I think, should be to take a ref on
> ctrl, kick the delete_work thread, call flush_work(), and then
> nvme_put_ctrl(ctrl).  Do you agree? 

IE: do we need this:

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9c69393..6198eaa 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1341,9 +1341,15 @@ static int nvme_rdma_device_unplug(struct nvme_rdma_queue
*queue)
                ret = 1;
        }

-       /* Queue controller deletion */
+       /*
+        * Queue controller deletion. Keep a reference until all
+        * work is flushed since delete_work will free the ctrl mem
+        */
+       kref_get(&ctrl->ctrl.kref);
        queue_work(nvme_rdma_wq, &ctrl->delete_work);
        flush_work(&ctrl->delete_work);
+       nvme_put_ctrl(&ctrl->ctrl);
+
        return ret;
 }

@@ -1690,15 +1696,22 @@ static int __nvme_rdma_del_ctrl(struct nvme_rdma_ctrl
*ctrl)
 static int nvme_rdma_del_ctrl(struct nvme_ctrl *nctrl)
 {
        struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
-       int ret;
+       int ret = 0;
+
+       /*
+        * Keep a reference until all work is flushed since
+        * __nvme_rdma_del_ctrl can free the ctrl mem
+        */
+       kref_get(&ctrl->ctrl.kref);

        ret = __nvme_rdma_del_ctrl(ctrl);
        if (ret)
-               return ret;
+               goto out;

        flush_work(&ctrl->delete_work);
-
-       return 0;
+out:
+       nvme_put_ctrl(&ctrl->ctrl);
+       return ret;
 }

 static void nvme_rdma_remove_ctrl_work(struct work_struct *work)
