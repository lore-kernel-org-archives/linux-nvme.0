From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 15 Jul 2019 16:17:07 -0600
Subject: [PATCH v2] nvmet-file: fix nvmet_file_flush() always returning an
 error
Message-ID: <20190715221707.3265-1-logang@deltatee.com>

Presently, nvmet_file_flush() always returns a call to
errno_to_nvme_status() but that helper doesn't take into account the
case when errno=0. So nvmet_file_flush() always returns an error code.

All other callers of errno_to_nvme_status() check for success before
calling it.

To fix this, ensure errno_to_nvme_status() returns success if the
errno is zero. This should prevent future mistakes like this from
happening.

Fixes: c6aa3542e010 ("nvmet: add error log support for file backend")
Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 7734a6acff85..e1f03cfc6675 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -43,6 +43,9 @@ inline u16 errno_to_nvme_status(struct nvmet_req *req, int errno)
 	u16 status;
 
 	switch (errno) {
+	case 0:
+		status = NVME_SC_SUCCESS;
+		break;
 	case -ENOSPC:
 		req->error_loc = offsetof(struct nvme_rw_command, length);
 		status = NVME_SC_CAP_EXCEEDED | NVME_SC_DNR;
-- 
2.20.1
