From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 28 Jul 2019 15:35:14 +0900
Subject: [PATCH V3 1/3] lnvm: make data_len to sizeof() instead of magic number
In-Reply-To: <20190728063516.17732-1-minwoo.im.dev@gmail.com>
References: <20190728063516.17732-1-minwoo.im.dev@gmail.com>
Message-ID: <20190728063516.17732-2-minwoo.im.dev@gmail.com>

We can have it as a sizeof() instead of the hard-coded value for the
data structure.

Cc: Keith Busch <kbusch at kernel.org>
Cc: Matias Bjorling <mb at lightnvm.io>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
Signed-off-by: Matias Bj?rling <matias.bjorling at wdc.com>
Reviewed-by: Javier Gonz?lez <javier at javigon.com>
---
 nvme-lightnvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme-lightnvm.c b/nvme-lightnvm.c
index 0b99786..e8cdccd 100644
--- a/nvme-lightnvm.c
+++ b/nvme-lightnvm.c
@@ -442,7 +442,7 @@ static int lnvm_get_identity(int fd, int nsid, struct nvme_nvm_id *nvm_id)
 		.opcode		= nvme_nvm_admin_identity,
 		.nsid		= nsid,
 		.addr		= (__u64)(uintptr_t)nvm_id,
-		.data_len	= 0x1000,
+		.data_len	= sizeof(struct nvme_nvm_id),
 	};
 
 	return nvme_submit_passthru(fd, NVME_IOCTL_ADMIN_CMD, &cmd);
-- 
2.17.1
