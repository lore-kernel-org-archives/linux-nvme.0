From: sbates@raithlin.com (Stephen Bates)
Date: Mon, 17 Oct 2016 17:24:19 -0600
Subject: [TRIVIAL PATCH] nvme : trivial whitespace fix in pci.c
Message-ID: <1476746659-24663-1-git-send-email-sbates@raithlin.com>

Remove annoying white space damage in pci.c.

Signed-off-by: Stephen Bates <sbates at raithlin.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a7c6e9d..e2b3243 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -50,7 +50,7 @@
 #define NVME_AQ_DEPTH		256
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
-
+
 /*
  * We handle AEN commands ourselves and don't even let the
  * block layer know about them.
--
2.1.4
