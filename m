From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 24 Apr 2019 11:53:19 -0700
Subject: [PATCH 4/4] nvme-tcp: rename function to have nvme_tcp prefix
In-Reply-To: <20190424185319.18942-1-sagi@grimberg.me>
References: <20190424185319.18942-1-sagi@grimberg.me>
Message-ID: <20190424185319.18942-5-sagi@grimberg.me>

usually nvme_ prefix is for core functions.
While we're cleaning up, remove redundant empty lines

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/tcp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7201fbeb4a8f..1a5217c85158 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -476,7 +476,6 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
 	}
 
 	return 0;
-
 }
 
 static int nvme_tcp_handle_comp(struct nvme_tcp_queue *queue,
@@ -637,7 +636,6 @@ static inline void nvme_tcp_end_request(struct request *rq, u16 status)
 	nvme_end_request(rq, cpu_to_le16(status << 1), res);
 }
 
-
 static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 			      unsigned int *offset, size_t *len)
 {
@@ -1543,7 +1541,7 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 	return ret;
 }
 
-static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
+static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 {
 	int i, ret;
 
@@ -1574,7 +1572,7 @@ static unsigned int nvme_tcp_nr_io_queues(struct nvme_ctrl *ctrl)
 	return nr_io_queues;
 }
 
-static int nvme_alloc_io_queues(struct nvme_ctrl *ctrl)
+static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 {
 	unsigned int nr_io_queues;
 	int ret;
@@ -1591,7 +1589,7 @@ static int nvme_alloc_io_queues(struct nvme_ctrl *ctrl)
 	dev_info(ctrl->device,
 		"creating %d I/O queues.\n", nr_io_queues);
 
-	return nvme_tcp_alloc_io_queues(ctrl);
+	return __nvme_tcp_alloc_io_queues(ctrl);
 }
 
 static void nvme_tcp_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
@@ -1608,7 +1606,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 {
 	int ret;
 
-	ret = nvme_alloc_io_queues(ctrl);
+	ret = nvme_tcp_alloc_io_queues(ctrl);
 	if (ret)
 		return ret;
 
-- 
2.17.1
