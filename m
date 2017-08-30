From: daniel.verkamp@intel.com (Daniel Verkamp)
Date: Wed, 30 Aug 2017 15:18:19 -0700
Subject: [PATCH] nvme/host: generate spec-compliant UUID NQNs
Message-ID: <20170830221819.43340-1-daniel.verkamp@intel.com>

The default host NQN, which is generated based on the host's UUID,
does not follow the UUID-based NQN format laid out in the NVMe 1.3
specification.  Remove the "NVMf:" portion of the NQN to match the spec.

Signed-off-by: Daniel Verkamp <daniel.verkamp at intel.com>
---
 drivers/nvme/host/fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 5f5cd306f76d..ffa7191ddfa5 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -75,7 +75,7 @@ static struct nvmf_host *nvmf_host_default(void)
 
 	kref_init(&host->ref);
 	snprintf(host->nqn, NVMF_NQN_SIZE,
-		"nqn.2014-08.org.nvmexpress:NVMf:uuid:%pUb", &host->id);
+		"nqn.2014-08.org.nvmexpress:uuid:%pUb", &host->id);
 
 	mutex_lock(&nvmf_hosts_mutex);
 	list_add_tail(&host->list, &nvmf_hosts);
-- 
2.13.5
