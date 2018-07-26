From: hch@lst.de (Christoph Hellwig)
Date: Thu, 26 Jul 2018 17:34:57 +0200
Subject: [PATCH 1/9] nvme.h: add support for the log specific field
In-Reply-To: <20180726153505.4153-1-hch@lst.de>
References: <20180726153505.4153-1-hch@lst.de>
Message-ID: <20180726153505.4153-2-hch@lst.de>

NVMe 1.3 added a new log specific field to the get log page CQ
defintion, add it to our get_log_page SQ structure.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Hannes Reinecke <hare at suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 include/linux/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 80dfedcf0bf7..39f05b0b8c7f 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -885,7 +885,7 @@ struct nvme_get_log_page_command {
 	__u64			rsvd2[2];
 	union nvme_data_ptr	dptr;
 	__u8			lid;
-	__u8			rsvd10;
+	__u8			lsp; /* upper 4 bits reserved */
 	__le16			numdl;
 	__le16			numdu;
 	__u16			rsvd11;
-- 
2.18.0
