From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 6 Nov 2016 10:51:01 +0200
Subject: nvmet_rdma crash - DISCONNECT event with NULL queue
In-Reply-To: <01d601d2353d$e3d10810$ab731830$@opengridcomputing.com>
References: <01b401d23458$af277210$0d765630$@opengridcomputing.com>
 <6f42d056-284d-00fc-2b98-189f54957980@grimberg.me>
 <01cc01d2345b$d445acd0$7cd10670$@opengridcomputing.com>
 <4cc25277-429a-4ab9-470c-b3af1428ce93@grimberg.me>
 <01d101d2345e$2f054390$8d0fcab0$@opengridcomputing.com>
 <dbe5f18d-7928-f065-920f-753b30fb99a2@grimberg.me>
 <01d901d2345f$da0d2e00$8e278a00$@opengridcomputing.com>
 <1d09c064-1cbe-7e6e-43d2-cfa6cf0c19ea@grimberg.me>
 <024e01d23476$6668b890$333a29b0$@opengridcomputing.com>
 <3512b8bb-4d29-b90a-49e1-ebf1085c47d7@grimberg.me>
 <004701d2351a$d9e4ad70$8dae0850$@opengridcomputing.com>
 <01d601d2353d$e3d10810$ab731830$@opengridcomputing.com>
Message-ID: <b499abb0-afc9-2985-c4c4-3ceba4ca6f33@grimberg.me>

>> I'll also try and reproduce this on mlx4 to rule out
>> iwarp and cxgb4 anomolies.
>
> Running the same test over mlx4/roce, I hit a warning in list_debug, and then a
> stuck CPU...

Steve,

Does this patch help?
--
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index bafd9898b5f6..5946dac9564f 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -951,6 +951,7 @@ static int nvmet_rdma_create_queue_ib(struct 
nvmet_rdma_queue *queue)

  static void nvmet_rdma_destroy_queue_ib(struct nvmet_rdma_queue *queue)
  {
+       ib_drain_qp(queue->cm_id->qp);
         rdma_destroy_qp(queue->cm_id);
         ib_free_cq(queue->cq);
  }
@@ -1247,7 +1248,6 @@ static void __nvmet_rdma_queue_disconnect(struct 
nvmet_rdma_queue *queue)

         if (disconnect) {
                 rdma_disconnect(queue->cm_id);
-               ib_drain_qp(queue->cm_id->qp);
                 schedule_work(&queue->release_work);
         }
  }
--
