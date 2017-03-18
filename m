From: sagi@grimberg.me (Sagi Grimberg)
Date: Sat, 18 Mar 2017 19:50:59 +0200
Subject: mlx4_core 0000:07:00.0: swiotlb buffer is full and OOM observed
 during stress test on reset_controller
In-Reply-To: <1768681609.3995777.1489837916289.JavaMail.zimbra@redhat.com>
References: <2013049462.31187009.1488542111040.JavaMail.zimbra@redhat.com>
 <d21c5571-78fd-7882-b4cc-c24f76f6ff47@redhat.com>
 <20170310165214.GC14379@mtr-leonro.local>
 <56e8ccd3-8116-89a1-2f65-eb61a91c5f84@mellanox.com>
 <860db62d-ae93-d94c-e5fb-88e7b643f737@redhat.com>
 <0a825b18-df06-9a6d-38c9-402f4ee121f7@mellanox.com>
 <7496c68a-15f3-d8cb-b17f-20f5a59a24d2@redhat.com>
 <31678a43-f76c-a921-e40c-470b0de1a86c@grimberg.me>
 <1768681609.3995777.1489837916289.JavaMail.zimbra@redhat.com>
Message-ID: <059299cc-7f45-e8eb-f1b1-7da2cf49cf5a@grimberg.me>


> Hi Sagi
> With this path, the OOM cannot be reproduced now.
>
> But there is another problem, the reset operation[1] failed at iteration 1007.
> [1]
> echo 1 >/sys/block/nvme0n1/device/reset_controller

We can relax this a bit by only flushing for admin queue accepts, and
also let the host accept longer time for establishing a connection.

Does this help?
--
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 47a479f26e5d..e1db1736823f 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -34,7 +34,7 @@
  #include "fabrics.h"


-#define NVME_RDMA_CONNECT_TIMEOUT_MS   1000            /* 1 second */
+#define NVME_RDMA_CONNECT_TIMEOUT_MS   5000            /* 5 seconds */

  #define NVME_RDMA_MAX_SEGMENT_SIZE     0xffffff        /* 24-bit SGL 
field */

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index ecc4fe862561..88bb5814c264 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1199,6 +1199,11 @@ static int nvmet_rdma_queue_connect(struct 
rdma_cm_id *cm_id,
         }
         queue->port = cm_id->context;

+       if (queue->host_qid == 0) {
+               /* Let inflight controller teardown complete */
+               flush_scheduled_work();
+       }
+
         ret = nvmet_rdma_cm_accept(cm_id, queue, &event->param.conn);
         if (ret)
                 goto release_queue;
--
