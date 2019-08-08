From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  8 Aug 2019 13:53:25 -0700
Subject: [PATCH v3 7/7] nvme: don't remove namespace if revalidate failed
 because of a transport error
In-Reply-To: <20190808205325.24036-1-sagi@grimberg.me>
References: <20190808205325.24036-1-sagi@grimberg.me>
Message-ID: <20190808205325.24036-8-sagi@grimberg.me>

If a controller reset is racing with a namespace revalidation, the
revalidation (admin) I/O will surely fail, but we should not remove the
namespace as we will execute the I/O when the controller is back up.

Fix this by checking the specific error code that revalidate_disk
returns, and if it is a transport related error, do not remove
the namespace as it will either recover when the controller is
back up and schedule a subsequent scan, or the controller is
going away and the namespaces will be removed anyways.

This fixes a hang namespace scanning racing with a controller reset and
also sporious I/O errors in path failover coditions where the
controller reset is racing with the namespace scan work with multipath
enabled.

Reported-by: Hannes Reinecke  <hare at suse.de>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 49ffccd72091..001bcc8a8d3e 100644
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
@@ -3452,8 +3454,11 @@ static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	ns = nvme_find_get_ns(ctrl, nsid);
 	if (ns) {
-		if (ns->disk && revalidate_disk(ns->disk))
-			nvme_ns_remove(ns);
+		if (ns->disk) {
+			blk_status_t sts = revalidate_disk(ns->disk);
+			if (sts && sts != BLK_STS_TRANSPORT)
+				nvme_ns_remove(ns);
+		}
 		nvme_put_ns(ns);
 	} else
 		nvme_alloc_ns(ctrl, nsid);
-- 
2.17.1
