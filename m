From: hare@suse.de (Hannes Reinecke)
Date: Fri, 25 May 2018 11:04:03 +0200
Subject: [PATCH] nvme: fix KASAN warning when parsing host nqn
Message-ID: <20180525090403.58723-1-hare@suse.de>

The host nqn actually is smaller than the space reserved for it,
so we should be using strlcpy to keep KASAN happy.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index a5c8ebf24eaa..9961eabb0321 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -57,7 +57,7 @@ static struct nvmf_host *nvmf_host_add(const char *hostnqn)
 		goto out_unlock;
 
 	kref_init(&host->ref);
-	memcpy(host->nqn, hostnqn, NVMF_NQN_SIZE);
+	strlcpy(host->nqn, hostnqn, NVMF_NQN_SIZE);
 
 	list_add_tail(&host->list, &nvmf_hosts);
 out_unlock:
-- 
2.12.3
