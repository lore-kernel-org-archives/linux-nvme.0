From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 19 Jun 2019 10:36:54 -0700
Subject: [PATCH nvme-cli 06/13] lightnvm: Fix an endianness issue
In-Reply-To: <20190619173701.8263-1-bvanassche@acm.org>
References: <20190619173701.8263-1-bvanassche@acm.org>
Message-ID: <20190619173701.8263-7-bvanassche@acm.org>

This patch avoids that sparse reports the following:

nvme-lightnvm.c:497:35: warning: incorrect type in initializer (different base types)
nvme-lightnvm.c:497:35:    expected unsigned int [usertype] data_len
nvme-lightnvm.c:497:35:    got restricted __le32 [usertype]

Cc: Matias Bjorling <m at bjorling.me>
Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 nvme-lightnvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme-lightnvm.c b/nvme-lightnvm.c
index ee21d6b28e08..0b99786fbab2 100644
--- a/nvme-lightnvm.c
+++ b/nvme-lightnvm.c
@@ -494,7 +494,7 @@ static int __lnvm_do_get_bbtbl(int fd, struct nvme_nvm_id12 *id,
 		.opcode		= nvme_nvm_admin_get_bb_tbl,
 		.nsid		= cpu_to_le32(1),
 		.addr		= (__u64)(uintptr_t)bbtbl,
-		.data_len	= cpu_to_le32(bufsz),
+		.data_len	= bufsz,
 		.ppa		= cpu_to_le64(ppa.ppa),
 	};
 	void *tmp = &cmd;
-- 
2.22.0.rc3
