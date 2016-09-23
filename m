From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Sep 2016 20:23:02 -0700
Subject: [PATCH 11/18] fix num_ctrls endianess in nvme_ns_attachment
In-Reply-To: <1474600989-16657-1-git-send-email-hch@lst.de>
References: <1474600989-16657-1-git-send-email-hch@lst.de>
Message-ID: <1474600989-16657-12-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 nvme-ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index db9c332..9df04ae 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -502,8 +502,8 @@ int nvme_ns_attachment(int fd, __u32 nsid, __u16 num_ctrls, __u16 *ctrlist,
 	};
 
 	memset(buf, 0, sizeof(buf));
-	cntlist->num = num_ctrls;
-	for (i = 0; i < cntlist->num; i++)
+	cntlist->num = cpu_to_le16(num_ctrls);
+	for (i = 0; i < num_ctrls; i++)
 		cntlist->identifier[i] = cpu_to_le16(ctrlist[i]);
 
 	return nvme_submit_admin_passthru(fd, &cmd);
-- 
2.1.4
