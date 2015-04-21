From: kwan.huen@samsung.com (kwan.huen)
Date: Mon, 20 Apr 2015 18:47:43 -0700
Subject: [PATCH 2/2] added two nvme commands for open/close streams and garbage
 collection
In-Reply-To: <1429580863-3451-1-git-send-email-kwan.huen@samsung.com>
References: <1429580863-3451-1-git-send-email-kwan.huen@samsung.com>
Message-ID: <1429580863-3451-3-git-send-email-kwan.huen@samsung.com>

---
 include/uapi/linux/nvme.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index aef9a81..5025610 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -229,6 +229,8 @@ enum nvme_opcode {
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
 	nvme_cmd_resv_release	= 0x15,
+	nvme_cmd_stream_ctrl	= 0x18,
+	nvme_cmd_gc_ctrl	= 0x1c,
 };
 
 struct nvme_common_command {
-- 
1.9.1
