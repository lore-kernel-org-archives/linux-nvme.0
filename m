From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Tue, 18 Oct 2016 13:11:03 -0700
Subject: [PATCH 4/6] nvme-fabrics: Fix a memory leak in an nvmf_create_ctrl()
 error path
In-Reply-To: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>
References: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>
Message-ID: <2c9d4e7b-1c48-619c-4f48-9c968747663a@sandisk.com>

Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
---
 drivers/nvme/host/fabrics.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 3e37efa..8985de6 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -827,8 +827,7 @@ nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
 out_unlock:
 	mutex_unlock(&nvmf_transports_mutex);
 out_free_opts:
-	nvmf_host_put(opts->host);
-	kfree(opts);
+	nvmf_free_options(opts);
 	return ERR_PTR(ret);
 }
 
-- 
2.10.1
