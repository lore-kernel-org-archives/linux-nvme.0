From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  8 Aug 2019 16:25:36 -0700
Subject: [PATCH v4 7/7] nvme: fix ns removal hang when failing to revalidate
 due to a transient error
In-Reply-To: <20190808232536.4258-1-sagi@grimberg.me>
References: <20190808232536.4258-1-sagi@grimberg.me>
Message-ID: <20190808232536.4258-8-sagi@grimberg.me>

If a controller reset is racing with a namespace revalidation, the
revalidation (admin) I/O will surely fail, but we should not remove the
namespace as we will execute the I/O when the controller is back up.
Same for spurious allocation errors (return -ENOMEM).

Fix this by checking the specific error code that revalidate_disk
returns, and if it is a transient error (for example ENOLINK correlates
to BLK_STS_TRANSPORT or ENOMEM correlates to BLK_STS_RESOURCE or an
allocation failure), do not remove the namespace as it will either
recover when the controller is back up and schedule a subsequent scan,
or the controller is going away and the namespaces will be removed anyways.

This fixes a hang namespace scanning racing with a controller reset and
also sporious I/O errors in path failover coditions where the
controller reset is racing with the namespace scan work with multipath
enabled.

Reported-by: Hannes Reinecke  <hare at suse.de>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

2

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fcac41a76f0c..ae30ed75dad9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -228,6 +228,8 @@ static blk_status_t nvme_error_status(struct request *req)
 		return BLK_STS_PROTECTION;
 	case NVME_SC_RESERVATION_CONFLICT:
 		return BLK_STS_NEXUS;
+	case NVME_SC_HOST_PATH_ERROR:
+		return BLK_STS_TRANSPORT;
 	default:
 		return BLK_STS_IOERR;
 	}
@@ -3452,8 +3454,17 @@ static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	ns = nvme_find_get_ns(ctrl, nsid);
 	if (ns) {
-		if (ns->disk && revalidate_disk(ns->disk))
-			nvme_ns_remove(ns);
+		if (ns->disk) {
+			int ret = revalidate_disk(ns->disk);
+
+			/*
+			 * remove the ns only if the return status is
+			 * not a temporal execution error.
+			 */
+			if (ret && ret != -ENOLINK && ret != -ENOMEM &&
+			    ret != -EAGAIN && ret != -EBUSY)
+				nvme_ns_remove(ns);
+		}
 		nvme_put_ns(ns);
 	} else
 		nvme_alloc_ns(ctrl, nsid);
-- 
2.17.1
