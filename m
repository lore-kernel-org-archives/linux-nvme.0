From: emilne@redhat.com (Ewan D. Milne)
Date: Fri,  5 Jan 2018 12:44:06 -0500
Subject: [PATCH] nvme-fabrics: initialize default host->id in
 nvmf_host_default()
Message-ID: <1515174246-5836-1-git-send-email-emilne@redhat.com>

From: "Ewan D. Milne" <emilne@redhat.com>

The field was uninitialized before use.

Signed-off-by: Ewan D. Milne <emilne at redhat.com>
---
 drivers/nvme/host/fabrics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 76b4fe6..894c2cc 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -74,6 +74,7 @@ static struct nvmf_host *nvmf_host_default(void)
 		return NULL;
 
 	kref_init(&host->ref);
+	uuid_gen(&host->id);
 	snprintf(host->nqn, NVMF_NQN_SIZE,
 		"nqn.2014-08.org.nvmexpress:uuid:%pUb", &host->id);
 
-- 
1.8.3.1
