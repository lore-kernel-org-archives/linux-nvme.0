From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Sep 2016 20:23:08 -0700
Subject: [PATCH 17/18] add missing endianess conversions in __lnvm_do_set_bbtbl
In-Reply-To: <1474600989-16657-1-git-send-email-hch@lst.de>
References: <1474600989-16657-1-git-send-email-hch@lst.de>
Message-ID: <1474600989-16657-18-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 nvme-lightnvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme-lightnvm.c b/nvme-lightnvm.c
index 2454e01..1575366 100644
--- a/nvme-lightnvm.c
+++ b/nvme-lightnvm.c
@@ -398,7 +398,7 @@ static int __lnvm_do_set_bbtbl(int fd, struct ppa_addr ppa, __u8 value)
 
 	struct nvme_nvm_setbbtbl cmd = {
 		.opcode		= nvme_nvm_admin_set_bb_tbl,
-		.nsid		= 1,
+		.nsid		= cpu_to_le32(1),
 		.ppa		= cpu_to_le64(ppa.ppa),
 		.nlb		= cpu_to_le16(0),
 		.value		= value,
-- 
2.1.4
