From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu,  1 Aug 2019 17:45:08 -0600
Subject: [PATCH v7 09/14] nvmet-core: don't check the data len for pt-ctrl
In-Reply-To: <20190801234514.7941-1-logang@deltatee.com>
References: <20190801234514.7941-1-logang@deltatee.com>
Message-ID: <20190801234514.7941-10-logang@deltatee.com>

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Right now, data_len is calculated before the transfer len after we
parse the command, With passthru interface we allow VUCs (Vendor-Unique
Commands). In order to make the code simple and compact, instead of
assigning the data len or each VUC in the command parse function
just use the transfer len as it is. This may result in error if expected
data_len != transfer_len.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
[logang at deltatee.com:
   * added definition of VUC to the commit message and comment
   * use nvmet_req_passthru_ctrl() helper seeing we can't dereference
     subsys->passthru_ctrl if CONFIG_NVME_TARGET_PASSTHRU is not set]
Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 drivers/nvme/target/core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index c655f26db3da..1cda94437fbf 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -941,7 +941,16 @@ EXPORT_SYMBOL_GPL(nvmet_req_uninit);
 
 void nvmet_req_execute(struct nvmet_req *req)
 {
-	if (unlikely(req->data_len != req->transfer_len)) {
+	/*
+	 * data_len is calculated before the transfer len after we parse
+	 * the command, With passthru interface we allow VUC (Vendor-Unique
+	 * Commands)'s. In order to make the code simple and compact,
+	 * instead of assinging the dala len for each VUC in the command
+	 * parse function just use the transfer len as it is. This may
+	 * result in error if expected data_len != transfer_len.
+	 */
+	if (!(req->sq->ctrl && nvmet_req_passthru_ctrl(req)) &&
+	    unlikely(req->data_len != req->transfer_len)) {
 		req->error_loc = offsetof(struct nvme_common_command, dptr);
 		nvmet_req_complete(req, NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR);
 	} else
-- 
2.20.1
