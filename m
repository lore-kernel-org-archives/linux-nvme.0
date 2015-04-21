From: matthew.r.wilcox@intel.com (Wilcox, Matthew R)
Date: Tue, 21 Apr 2015 13:21:58 +0000
Subject: [PATCH 2/2] added two nvme commands for open/close streams and
 garbage collection
In-Reply-To: <1429580863-3451-3-git-send-email-kwan.huen@samsung.com>
References: <1429580863-3451-1-git-send-email-kwan.huen@samsung.com>
 <1429580863-3451-3-git-send-email-kwan.huen@samsung.com>
Message-ID: <100D68C7BA14664A8938383216E40DE040897FBB@FMSMSX114.amr.corp.intel.com>

Woah, woah, woah!  Those command IDs have *NOT* been assigned by the NVMe working group!  NACK this patch!

-----Original Message-----
From: kwan.huen [mailto:kwan.huen@samsung.com] 
Sent: Monday, April 20, 2015 6:48 PM
To: Wilcox, Matthew R; Busch, Keith; Jens Axboe; kwan.huen at samsung.com; Dimitri John Ledkov
Cc: linux-nvme at lists.infradead.org; linux-kernel at vger.kernel.org; linux-api at vger.kernel.org
Subject: [PATCH 2/2] added two nvme commands for open/close streams and garbage collection

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
