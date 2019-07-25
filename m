From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 25 Jul 2019 11:23:26 -0600
Subject: [PATCH v6 07/16] nvmet: make nvmet_copy_ns_identifier() non-static
In-Reply-To: <20190725172335.6825-1-logang@deltatee.com>
References: <20190725172335.6825-1-logang@deltatee.com>
Message-ID: <20190725172335.6825-8-logang@deltatee.com>

This function will be needed by the upcoming passthru code.

[chaitanya.kulkarni at wdc.com: this was factored out of a patch
 originally authored by Chaitanya]
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 drivers/nvme/target/admin-cmd.c | 4 ++--
 drivers/nvme/target/nvmet.h     | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 4dc12ea52f23..eeb24f606d00 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -506,8 +506,8 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
-static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
-				    void *id, off_t *off)
+u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
+			     void *id, off_t *off)
 {
 	struct nvme_ns_id_desc desc = {
 		.nidt = type,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 217a787952e8..d1a0a3190a24 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -489,6 +489,8 @@ u16 nvmet_bdev_flush(struct nvmet_req *req);
 u16 nvmet_file_flush(struct nvmet_req *req);
 void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
 
+u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
+			     void *id, off_t *off);
 static inline u32 nvmet_rw_len(struct nvmet_req *req)
 {
 	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) <<
-- 
2.20.1
