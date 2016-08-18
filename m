From: hch@lst.de (Christoph Hellwig)
Date: Thu, 18 Aug 2016 11:16:35 -0700
Subject: [PATCH 1/2] nvme-fabrics: get a reference when reusing a nvme_host
 structure
In-Reply-To: <1471544196-30525-1-git-send-email-hch@lst.de>
References: <1471544196-30525-1-git-send-email-hch@lst.de>
Message-ID: <1471544196-30525-2-git-send-email-hch@lst.de>

Without this we'll get a use after free after connecting two controller
using the same hostnqn and then disconnecting one of them.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/fabrics.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 020302c..df7b84b 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -47,8 +47,10 @@ static struct nvmf_host *nvmf_host_add(const char *hostnqn)
 
 	mutex_lock(&nvmf_hosts_mutex);
 	host = __nvmf_host_find(hostnqn);
-	if (host)
+	if (host) {
+		kref_get(&host->ref);
 		goto out_unlock;
+	}
 
 	host = kmalloc(sizeof(*host), GFP_KERNEL);
 	if (!host)
-- 
2.1.4
