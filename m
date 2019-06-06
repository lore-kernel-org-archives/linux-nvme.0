From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu,  6 Jun 2019 15:32:27 +0900
Subject: [RFC PATCH V6 1/3] nvmet: introduce nvmet_req_to_ctrl to get ctrl
 instance
In-Reply-To: <20190606063229.17258-1-minwoo.im.dev@gmail.com>
References: <20190606063229.17258-1-minwoo.im.dev@gmail.com>
Message-ID: <20190606063229.17258-2-minwoo.im.dev@gmail.com>

nvme host driver can get the controller instance from
nvme_req(req)->ctrl.  In case of target driver, it needs to get
controller instance from the struct nvmet_req with sq where the request
has been submitted.

Cc: Keith Busch <kbusch at kernel.org>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/target/nvmet.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index c25d88fc9dec..2d569a1dc3f4 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -318,6 +318,15 @@ struct nvmet_req {
 	u64			error_slba;
 };
 
+static inline struct nvmet_ctrl *nvmet_req_to_ctrl(struct nvmet_req *req)
+{
+	struct nvmet_sq *sq = req->sq;
+
+	if (sq)
+		return sq->ctrl;
+	return NULL;
+}
+
 extern struct workqueue_struct *buffered_io_wq;
 
 static inline void nvmet_set_result(struct nvmet_req *req, u32 result)
-- 
2.21.0
