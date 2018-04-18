From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 18 Apr 2018 15:00:02 -0400
Subject: [PATCH 11/20] nvmet: introduce new members for ns-mgmt
In-Reply-To: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180418190011.3973-12-chaitanya.kulkarni@wdc.com>

We update the target data structures to support ns-mgmt
commands. The new members for nvmet_ns are used to in the
create-ns command implementation. We use mount_path
of the nvmet_subsys to allow the user to initialize the
directory under which all the files for the respective
namespace(s) are created.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/nvmet.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 96aa5fc72467..b185a2add99b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -57,6 +57,10 @@ struct nvmet_ns {
 	struct nvmet_subsys	*subsys;
 	const char		*device_path;
 
+	u64			nsze;
+	u64			ncap;
+	u64			nuse;
+	u8			flbas;
 	struct workqueue_struct *file_wq;
 	struct config_group	device_group;
 	struct config_group	group;
@@ -165,6 +169,8 @@ struct nvmet_subsys {
 
 	struct config_group	namespaces_group;
 	struct config_group	allowed_hosts_group;
+	char			*mount_path;
+	unsigned long		nsid_map[1024]; /* MAX LIMIT ? */
 };
 
 static inline struct nvmet_subsys *to_subsys(struct config_item *item)
-- 
2.14.1
