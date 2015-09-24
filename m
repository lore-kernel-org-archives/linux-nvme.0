From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 24 Sep 2015 16:00:27 +0200
Subject: [PATCH 19/19] block: nvme-scsi: make nvme_trans_get_blk_desc_len
 return unsigned
In-Reply-To: <1443103227-25612-1-git-send-email-a.hajda@samsung.com>
References: <1443103227-25612-1-git-send-email-a.hajda@samsung.com>
Message-ID: <1443103227-25612-20-git-send-email-a.hajda@samsung.com>

The function returns always non-negative values.

The problem has been detected using proposed semantic patch
scripts/coccinelle/tests/assign_signed_to_unsigned.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2046107

Signed-off-by: Andrzej Hajda <a.hajda at samsung.com>
---
Hi,

To avoid problems with too many mail recipients I have sent whole
patchset only to LKML. Anyway patches have no dependencies.

Regards
Andrzej
---
 drivers/block/nvme-scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index e5a63f0..2d65e20 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -1091,7 +1091,7 @@ static int nvme_trans_fill_all_pages(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 					MODE_PAGE_INF_EXC_LEN);
 }
 
-static inline int nvme_trans_get_blk_desc_len(u8 dbd, u8 llbaa)
+static inline unsigned int nvme_trans_get_blk_desc_len(u8 dbd, u8 llbaa)
 {
 	if (dbd == MODE_SENSE_BLK_DESC_ENABLED) {
 		/* SPC-4: len = 8 x Num_of_descriptors if llbaa = 0, 16x if 1 */
-- 
1.9.1
