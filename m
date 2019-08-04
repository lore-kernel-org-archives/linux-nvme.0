From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun,  4 Aug 2019 16:50:47 +0900
Subject: [PATCH 1/4] nvme: add Get LBA Status command opcode
In-Reply-To: <20190804075050.14642-1-minwoo.im.dev@gmail.com>
References: <20190804075050.14642-1-minwoo.im.dev@gmail.com>
Message-ID: <20190804075050.14642-2-minwoo.im.dev@gmail.com>

NVMe 1.4 added Get LBA Status command with opcode 0x86.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 include/linux/nvme.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 01aa6a6c241d..a01277501eae 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -814,6 +814,7 @@ enum nvme_admin_opcode {
 	nvme_admin_security_send	= 0x81,
 	nvme_admin_security_recv	= 0x82,
 	nvme_admin_sanitize_nvm		= 0x84,
+	nvme_admin_get_lba_status	= 0x86,
 };
 
 #define nvme_admin_opcode_name(opcode)	{ opcode, #opcode }
-- 
2.17.1
