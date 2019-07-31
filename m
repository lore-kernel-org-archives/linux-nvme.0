From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed, 31 Jul 2019 17:35:33 -0600
Subject: [PATCH v3 3/4] nvmet-file: fix nvmet_file_flush() always returning an
 error
In-Reply-To: <20190731233534.4841-1-logang@deltatee.com>
References: <20190731233534.4841-1-logang@deltatee.com>
Message-ID: <20190731233534.4841-4-logang@deltatee.com>

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
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b86a23aa9020..3a67e244e568 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -46,6 +46,9 @@ inline u16 errno_to_nvme_status(struct nvmet_req *req, int errno)
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
