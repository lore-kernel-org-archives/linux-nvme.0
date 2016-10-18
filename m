From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Tue, 18 Oct 2016 15:02:03 -0700
Subject: Disconnecting nvmet-rdma
Message-ID: <26c343fe-23a8-e482-0b28-0b4a8c2ac70e@sandisk.com>

Hello Christoph,

Without the patch below I can easily trigger a NULL pointer dereference in
nvmet_rdma_queue_disconnect(). However, I don't think that that patch is
correct. Can you have a look at this?

Thanks,

Bart.


BUG: unable to handle kernel NULL pointer dereference at 0000000000000200
IP: [<ffffffffa0621488>] nvmet_rdma_queue_disconnect+0x18/0x70 [nvmet_rdma]
Workqueue: ib_cm cm_work_handler [ib_cm]
Call Trace:
 [<ffffffffa0623219>] nvmet_rdma_cm_handler+0x309/0x592 [nvmet_rdma]
 [<ffffffffa0275461>] cma_ib_handler+0xa1/0x1f0 [rdma_cm]
 [<ffffffffa025daa0>] cm_process_work+0x20/0x100 [ib_cm]
 [<ffffffffa025e223>] cm_work_handler+0x6a3/0x1f68 [ib_cm]
 [<ffffffff81081485>] process_one_work+0x1f5/0x690
 [<ffffffff81081969>] worker_thread+0x49/0x490
 [<ffffffff8108817a>] kthread+0xea/0x100
 [<ffffffff8162cd7f>] ret_from_fork+0x1f/0x40


---
 drivers/nvme/target/rdma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index d1aea17..a61e47f 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1354,9 +1354,12 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		break;
 	case RDMA_CM_EVENT_ADDR_CHANGE:
 	case RDMA_CM_EVENT_DISCONNECTED:
-	case RDMA_CM_EVENT_TIMEWAIT_EXIT:
 		nvmet_rdma_queue_disconnect(queue);
 		break;
+	case RDMA_CM_EVENT_TIMEWAIT_EXIT:
+		if (queue)
+			nvmet_rdma_queue_disconnect(queue);
+		break;
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 		ret = nvmet_rdma_device_removal(cm_id, queue);
 		break;
