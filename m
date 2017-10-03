From: ckulkarnilinux@gmail.com (Chaitanya Kulkarni)
Date: Tue,  3 Oct 2017 12:24:25 -0700
Subject: [PATCH V4 1/2] nvme: add SGL controller capability constant
In-Reply-To: <1507058666-15298-1-git-send-email-ckulkarnilinux@gmail.com>
References: <1507058666-15298-1-git-send-email-ckulkarnilinux@gmail.com>
Message-ID: <1507058666-15298-2-git-send-email-ckulkarnilinux@gmail.com>

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This adds a constant definition which can be used to determine whether
NVMe Controller supports SGL mode for IOs.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 include/linux/nvme.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 9310ce77..22bbcfb 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -466,6 +466,8 @@ enum nvme_opcode {
 	nvme_cmd_resv_release	= 0x15,
 };
 
+#define NVME_CTRL_SUPP_SGL     0x1
+
 /*
  * Descriptor subtype - lower 4 bits of nvme_(keyed_)sgl_desc identifier
  *
-- 
1.8.3.1
