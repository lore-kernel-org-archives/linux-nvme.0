From: hare@suse.de (Hannes Reinecke)
Date: Wed, 18 Apr 2018 09:27:23 +0200
Subject: [PATCH] nvme: make NVME_SC_UNWRITTEN_BLOCK a thin-provisioned error
Message-ID: <20180418072723.25874-1-hare@suse.de>

According to the spec NVME_SC_UNWRITTEN_BLOCK signals
'an attempt to read from an LBA range containing a deallocated
or unwritten logical block'.
So this is not so much about the medium being faulty, but
rather should be classified as a thin-provisioning error
and should be mapped onto ENOSPC.

Reported-by: Martin George <martin.george at netapp.com>
Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 197a6ba9700f..0462b7e281f4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -179,6 +179,7 @@ static blk_status_t nvme_error_status(struct request *req)
 	case NVME_SC_SUCCESS:
 		return BLK_STS_OK;
 	case NVME_SC_CAP_EXCEEDED:
+	case NVME_SC_UNWRITTEN_BLOCK:
 		return BLK_STS_NOSPC;
 	case NVME_SC_LBA_RANGE:
 		return BLK_STS_TARGET;
@@ -190,7 +191,6 @@ static blk_status_t nvme_error_status(struct request *req)
 		return BLK_STS_NOTSUPP;
 	case NVME_SC_WRITE_FAULT:
 	case NVME_SC_READ_ERROR:
-	case NVME_SC_UNWRITTEN_BLOCK:
 	case NVME_SC_ACCESS_DENIED:
 	case NVME_SC_READ_ONLY:
 	case NVME_SC_COMPARE_FAILED:
-- 
2.16.2
