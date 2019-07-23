From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 24 Jul 2019 03:35:58 +0900
Subject: [PATCH 2/5] lnvm: export lnvm_get_identity
In-Reply-To: <20190723183601.29370-1-minwoo.im.dev@gmail.com>
References: <20190723183601.29370-1-minwoo.im.dev@gmail.com>
Message-ID: <20190723183601.29370-3-minwoo.im.dev@gmail.com>

When a subcommand wants to fetch Geometry, this function would be the
one to be taken.

Cc: Keith Busch <kbusch at kernel.org>
Cc: Matias Bjorling <mb at lightnvm.io>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 nvme-lightnvm.c | 2 +-
 nvme-lightnvm.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/nvme-lightnvm.c b/nvme-lightnvm.c
index e8cdccd..2e665bf 100644
--- a/nvme-lightnvm.c
+++ b/nvme-lightnvm.c
@@ -436,7 +436,7 @@ static void show_lnvm_id_ns(struct nvme_nvm_id *id, unsigned int flags)
 	}
 }
 
-static int lnvm_get_identity(int fd, int nsid, struct nvme_nvm_id *nvm_id)
+int lnvm_get_identity(int fd, int nsid, struct nvme_nvm_id *nvm_id)
 {
 	struct nvme_admin_cmd cmd = {
 		.opcode		= nvme_nvm_admin_identity,
diff --git a/nvme-lightnvm.h b/nvme-lightnvm.h
index 9dea912..9dc1868 100644
--- a/nvme-lightnvm.h
+++ b/nvme-lightnvm.h
@@ -299,6 +299,8 @@ static inline struct ppa_addr generic_to_dev_addr(
 	return l;
 }
 
+int lnvm_get_identity(int fd, int nsid, struct nvme_nvm_id *nvm_id);
+
 int lnvm_do_init(char *, char *);
 int lnvm_do_list_devices(void);
 int lnvm_do_info(void);
-- 
2.17.1
