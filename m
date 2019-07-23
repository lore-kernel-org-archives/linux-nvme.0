From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 24 Jul 2019 03:35:59 +0900
Subject: [PATCH 3/5] lnvm: add chunk_info log page structure
In-Reply-To: <20190723183601.29370-1-minwoo.im.dev@gmail.com>
References: <20190723183601.29370-1-minwoo.im.dev@gmail.com>
Message-ID: <20190723183601.29370-4-minwoo.im.dev@gmail.com>

The log ID is 0xCA which is defined in OCSSD 2.0 spec.  Also it has
32bytes sized structure for each entries.

Cc: Keith Busch <kbusch at kernel.org>
Cc: Matias Bjorling <mb at lightnvm.io>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 nvme-lightnvm.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/nvme-lightnvm.h b/nvme-lightnvm.h
index 9dc1868..7a8ef7d 100644
--- a/nvme-lightnvm.h
+++ b/nvme-lightnvm.h
@@ -246,6 +246,20 @@ struct nvme_nvm_id {
 	__u8			resv[4095];
 } __attribute__((packed));
 
+enum {
+	NVM_LID_CHUNK_INFO = 0xCA,
+};
+
+struct nvme_nvm_chunk_desc {
+	__u8	cs;
+	__u8	ct;
+	__u8	wli;
+	__u8	rsvd_7_3[5];
+	__u64	slba;
+	__u64	cnlb;
+	__u64	wp;
+};
+
 struct nvme_nvm_bb_tbl {
 	__u8	tblid[4];
 	__le16	verid;
-- 
2.17.1
