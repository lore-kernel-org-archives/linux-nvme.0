From: yuyufen@huawei.com (Yufen Yu)
Date: Wed, 10 Apr 2019 16:00:30 +0800
Subject: [PATCH RFC 1/6] nvme: add new flags NVME_ADMIN_QID for nvme admin
 queue
In-Reply-To: <20190410080035.82529-1-yuyufen@huawei.com>
References: <20190410080035.82529-1-yuyufen@huawei.com>
Message-ID: <20190410080035.82529-2-yuyufen@huawei.com>

Signed-off-by: Yufen Yu <yuyufen at huawei.com>
---
 include/linux/nvme.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index baa49e6a23cc..9f09c0b764ca 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -24,6 +24,9 @@
 
 #define NVME_RDMA_IP_PORT	4420
 
+/* nvme admin queue qid */
+#define NVME_ADMIN_QID 	0
+
 #define NVME_NSID_ALL		0xffffffff
 
 enum nvme_subsys_type {
-- 
2.16.2.dirty
