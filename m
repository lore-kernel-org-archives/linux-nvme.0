From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 18 Apr 2018 14:59:57 -0400
Subject: [PATCH 06/20] nvmet: add new members for sync file I/O
In-Reply-To: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180418190011.3973-7-chaitanya.kulkarni@wdc.com>

This patch adds new structure members to implement O_SYNC
IO mode for file-backed ns. The user can optionally choose
to switch between O_SYNC and O_DIRECT with the configfs parameter
which we add in the next patch.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/nvmet.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 21825b4a222a..96aa5fc72467 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -53,9 +53,11 @@ struct nvmet_ns {
 	uuid_t			uuid;
 
 	bool			enabled;
+	bool			sync;
 	struct nvmet_subsys	*subsys;
 	const char		*device_path;
 
+	struct workqueue_struct *file_wq;
 	struct config_group	device_group;
 	struct config_group	group;
 
@@ -233,6 +235,7 @@ struct nvmet_req {
 	/* data length as parsed from the SGL descriptor: */
 	size_t			transfer_len;
 
+	struct work_struct	sync_work; /* file backed ns */
 	struct nvmet_port	*port;
 
 	void (*execute)(struct nvmet_req *req);
-- 
2.14.1
