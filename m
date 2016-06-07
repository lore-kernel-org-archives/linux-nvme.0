From: hch@lst.de (Christoph Hellwig)
Date: Tue,  7 Jun 2016 17:19:18 +0200
Subject: [PATCH 02/11] Support Get Log Page extended Number of Dwords
In-Reply-To: <1465312767-10070-1-git-send-email-hch@lst.de>
References: <1465312767-10070-1-git-send-email-hch@lst.de>
Message-ID: <1465312767-10070-3-git-send-email-hch@lst.de>

From: Ming Lin <ming.l@ssi.samsung.com>

This supports 32 bits(rather than 12 bits) extended Number of Dwords
in nvme_get_log().

Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Reviewed-and-tested-by: Sagi Grimberg <sagi at grimberg.me>
Tested-by: Armen Baloyan <armenx.baloyan at intel.com>
---
 nvme-ioctl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index 849d3b6..0510837 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -362,8 +362,13 @@ int nvme_get_log(int fd, __u32 nsid, __u8 log_id, __u32 data_len, void *data)
 		.addr		= (__u64)(uintptr_t) data,
 		.data_len	= data_len,
 	};
+	__u32 numd = (data_len >> 2) - 1;
+	__le16 numdu, numdl;
 
-	cmd.cdw10 = log_id | ((data_len >> 2) - 1) << 16;
+	numdu = htole16((numd & 0xFFFF0000) >> 16);
+	numdl = htole16(numd & 0x0000FFFF);
+	cmd.cdw10 = log_id | (numdl << 16);
+	cmd.cdw11 = numdu;
 
 	return nvme_submit_admin_passthru(fd, &cmd);
 }
-- 
2.1.4
