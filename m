From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Sep 2016 20:23:07 -0700
Subject: [PATCH 16/18] add missing endianess conversions in __lnvm_do_get_bbtbl
In-Reply-To: <1474600989-16657-1-git-send-email-hch@lst.de>
References: <1474600989-16657-1-git-send-email-hch@lst.de>
Message-ID: <1474600989-16657-17-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 nvme-lightnvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/nvme-lightnvm.c b/nvme-lightnvm.c
index ddb8a3e..2454e01 100644
--- a/nvme-lightnvm.c
+++ b/nvme-lightnvm.c
@@ -338,9 +338,9 @@ static int __lnvm_do_get_bbtbl(int fd, struct nvme_nvm_id *id,
 
 	struct nvme_nvm_getbbtbl cmd = {
 		.opcode		= nvme_nvm_admin_get_bb_tbl,
-		.nsid		= 1,
+		.nsid		= cpu_to_le32(1),
 		.addr		= (__u64)(uintptr_t)bbtbl,
-		.data_len	= bufsz,
+		.data_len	= cpu_to_le32(bufsz),
 		.ppa		= cpu_to_le64(ppa.ppa),
 	};
 
-- 
2.1.4
