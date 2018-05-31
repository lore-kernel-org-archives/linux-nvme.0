From: weiyongjun1@huawei.com (Wei Yongjun)
Date: Thu, 31 May 2018 01:55:58 +0000
Subject: [PATCH -next] nvmet: fix a typo in nvmet_file_ns_enable()
Message-ID: <1527731758-142629-1-git-send-email-weiyongjun1@huawei.com>

Fix a typo in nvmet_file_ns_enable().

Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
Signed-off-by: Wei Yongjun <weiyongjun1 at huawei.com>
---
 drivers/nvme/target/io-cmd-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index ca1ccf8..9cff553 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -34,7 +34,7 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 			O_RDWR | O_LARGEFILE | O_DIRECT, 0);
 	if (IS_ERR(ns->file)) {
 		pr_err("failed to open file %s: (%ld)\n",
-				ns->device_path, PTR_ERR(ns->bdev));
+				ns->device_path, PTR_ERR(ns->file));
 		return PTR_ERR(ns->file);
 	}
