From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Tue, 07 Apr 2015 21:15:12 -0400
Subject: [RESEND PATCH] NVMe: Add translation for block limits
In-Reply-To: <1428442458-3219-1-git-send-email-keith.busch@intel.com> (Keith
 Busch's message of "Tue, 7 Apr 2015 15:34:18 -0600")
References: <1428442458-3219-1-git-send-email-keith.busch@intel.com>
Message-ID: <yq1y4m3fmjj.fsf@sermon.lab.mkp.net>


Keith,

+static int nvme_trans_bdev_limits_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
+					u8 *inq_response, int alloc_len)
+{
+	__be32 max_sectors = cpu_to_be32(queue_max_hw_sectors(ns->queue));

max_hw_sectors is in 512-byte units, the VPD page in logical blocks.

+	__be32 max_discard = cpu_to_be32(ns->queue->limits.max_discard_sectors);

Same.

+	__be32 discard_desc_count = cpu_to_be32(0x100);

max_discard_sectors is the maximum number of 512-byte contiguous blocks
that can be discarded in a single command using however many range
descriptors will fit in the command's payload.

So max_discard_sectors for an NVMe device would technically be:

   256 * 0xffffffff << (ilog2(ns block size) - 9)

You only report 0xffffffff going the other way so it is not a big
deal. Just wanted to make it clear since you're converting a value from
Linux' block limit to NVMe/SCSI.

-- 
Martin K. Petersen	Oracle Linux Engineering
