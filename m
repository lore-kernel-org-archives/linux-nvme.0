From: hch@lst.de (Christoph Hellwig)
Date: Thu,  1 Jun 2017 13:27:27 +0200
Subject: [PATCH 2/4] nvme.h: add dword 12 - 15 fields to struct nvme_features
In-Reply-To: <20170601112729.9726-1-hch@lst.de>
References: <20170601112729.9726-1-hch@lst.de>
Message-ID: <20170601112729.9726-3-hch@lst.de>

From: Arnav Dawn <a.dawn@samsung.com>

Signed-off-by: Arnav Dawn <a.dawn at samsung.com>
[hch: split from a larger patch, new changelog]
Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
---
 include/linux/nvme.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 9fd77fde4ae0..beaefe822104 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -672,7 +672,10 @@ struct nvme_features {
 	union nvme_data_ptr	dptr;
 	__le32			fid;
 	__le32			dword11;
-	__u32			rsvd12[4];
+	__le32                  dword12;
+	__le32                  dword13;
+	__le32                  dword14;
+	__le32                  dword15;
 };
 
 struct nvme_host_mem_buf_desc {
-- 
2.11.0
