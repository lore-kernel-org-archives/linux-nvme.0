From: hare@suse.de (Hannes Reinecke)
Date: Mon, 14 May 2018 14:23:12 +0200
Subject: [PATCH] nvme: fix KASAN warning when parsing host nqn
Message-ID: <20180514122312.62068-1-hare@suse.de>

The host nqn is actually smaller than the space reserved for it,
so we should only copy the allocated data to keep KASAN happy.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/fabrics.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 124c458806df..dec7d4629f38 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -52,12 +52,12 @@ static struct nvmf_host *nvmf_host_add(const char *hostnqn)
 		goto out_unlock;
 	}
 
-	host = kmalloc(sizeof(*host), GFP_KERNEL);
+	host = kzalloc(sizeof(*host), GFP_KERNEL);
 	if (!host)
 		goto out_unlock;
 
 	kref_init(&host->ref);
-	memcpy(host->nqn, hostnqn, NVMF_NQN_SIZE);
+	memcpy(host->nqn, hostnqn, strlen(hostnqn));
 
 	list_add_tail(&host->list, &nvmf_hosts);
 out_unlock:
-- 
2.12.3
