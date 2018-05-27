From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 27 May 2018 18:50:14 +0300
Subject: [PATCH 09/17] nvme: reduce the metadata size in case the ctrl doesn't
 support it
In-Reply-To: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
Message-ID: <1527436222-15494-10-git-send-email-maxg@mellanox.com>

There is no reason for setting metadata size while the controller is
not capable to perform command with metadata.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e81e898..1830978 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1461,6 +1461,10 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 		}
 	}
 
+	/* Reduce the metadata size in case the ctrl doesn't support it */
+	if (!ns->ctrl->max_integrity_segments)
+		ns->ms = 0;
+
 	/* the PI implementation requires metadata equal t10 pi tuple size */
 	if (ns->ms == sizeof(struct t10_pi_tuple))
 		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
-- 
1.8.3.1
