From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu,  8 Feb 2018 22:30:25 +0900
Subject: [PATCH] nvme-cli: make it use NVME_IDENTIFY_DATA_SIZE
Message-ID: <1518096625-8560-1-git-send-email-minwoo.im.dev@gmail.com>

Update 0x1000 hard coding magic value to NVME_IDENTIFY_DATA_SIZE which
was added in linux-nvme driver commit 0add5e8e588c.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 nvme-ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index a6e1e01..9261e27 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -342,7 +342,7 @@ int nvme_identify(int fd, __u32 nsid, __u32 cdw10, void *data)
 		.opcode		= nvme_admin_identify,
 		.nsid		= nsid,
 		.addr		= (__u64)(uintptr_t) data,
-		.data_len	= 0x1000,
+		.data_len	= NVME_IDENTIFY_DATA_SIZE,
 		.cdw10		= cdw10,
 	};
 
-- 
2.7.4
