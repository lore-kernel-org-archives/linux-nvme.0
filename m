Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B6CCCF9EE
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 06:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e5fvt+RzaASySb8GgNXuWmgGzmcFQpD2sNGlm+S7rGk=; b=M+RhG+6DETwE7k01efWSagQhkX
	YR0iymr/lUym1nLkt6lUxi9zkqU650hWGt8WHQM6h9VZIbbqLOa3HMxxGsmcktNUwBdl7O7sVqCB8
	EE77zfvngy0z9Pev+hL4B04VF5ZLZ0vY19Ira6TzE/X0/XLLt7nMFmCbC2eyMkAcu6Wr0K8GGuFUh
	4/stqLMzIaD7OVhROppxcYcDr1HJCiEjqGEMUKKbyG0B7k7Apk3Tr0aOZp47cPV0KwBDuEYLJMMpC
	fsnV/7O1IziykpwvlqT13oxAZdjQxbMURpZN9PLeI7AiC0EXdnRf2HuRpGG583droJIPs31Xr7Xpc
	ohUBKieQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEiSH-00000005S6r-09FK;
	Fri, 31 Oct 2025 06:17:45 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEiRl-00000005RlQ-0jfE
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 06:17:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D8A7344C33;
	Fri, 31 Oct 2025 06:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F38C4CEF1;
	Fri, 31 Oct 2025 06:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761891432;
	bh=6ZY0NgFP02+vFWnpcPvHScdxIHEaoDhwgGK8k5yH3n0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BcM90ccjhMOxSsY3pDm6+sydq2PO7b34vdvCtFz4nIHojqi97Irb/5ERU+vHCoT9T
	 NntEHXm4CPMpBsweAtT4RO9gTER1Di4O/y2D2iM/4oiaeXetQh5Ub+Vl7mz1sraL5A
	 BJhejvZcXDFB8ktj+bUZIzh+o9e3ga8+UNK5iFpM8XPBoHzsLfmClQ6+qt8vk45Cyn
	 o5nw6I9SgIfqm1qfR6sRHBix0QMJtOS00sk0v8gyB9/+F18AldVdp7r+ybbhbTXRqo
	 1Y0PESDXnCUZmx6ZNTn+ALTNHoGFXJ87REyIf+hUPOwq638HqogKY6kJSUHzceHuf7
	 whUWVy3Ja/jvw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Keith Busch <keith.busch@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 10/13] block: introduce BLKREPORTZONESV2 ioctl
Date: Fri, 31 Oct 2025 15:13:04 +0900
Message-ID: <20251031061307.185513-11-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031061307.185513-1-dlemoal@kernel.org>
References: <20251031061307.185513-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251030_231719_378179_F36AE9F7 
X-CRM114-Status: GOOD (  20.56  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Introduce the new BLKREPORTZONESV2 ioctl command to allow user
applications access to the fast zone report implemented by
blkdev_report_zones_cached(). This new ioctl is defined as number 142
and is documented in include/uapi/linux/fs.h.

Unlike the existing BLKREPORTZONES ioctl, this new ioctl uses the flags
field of struct blk_zone_report also as an inpiut. If as an input, the
user sets the flag BLK_ZONE_REP_CACHED, then
blkdev_report_zones_cached() is used to generate the zone report using
cached zone information. If this flag is not set, then BLKREPORTZONESV2
behaves in the same manner as BLKREPORTZONES and the zone report is
generated by accessing the zoned device.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c             | 25 ++++++++++++++++++++++---
 block/ioctl.c                 |  1 +
 include/uapi/linux/blkzoned.h | 30 ++++++++++++++++++++++++++----
 include/uapi/linux/fs.h       |  2 +-
 4 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 0234bb7f41b3..c8335654b1cd 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -356,7 +356,12 @@ static int blkdev_copy_zone_to_user(struct blk_zone *zone, unsigned int idx,
 }
 
 /*
- * BLKREPORTZONE ioctl processing.
+ * Mask of valid input flags for BLKREPORTZONEV2 ioctl.
+ */
+#define BLK_ZONE_REPV2_INPUT_FLAGS	(BLK_ZONE_REP_CACHED)
+
+/*
+ * BLKREPORTZONE and BLKREPORTZONEV2 ioctl processing.
  * Called from blkdev_ioctl.
  */
 int blkdev_report_zones_ioctl(struct block_device *bdev, unsigned int cmd,
@@ -380,8 +385,22 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, unsigned int cmd,
 		return -EINVAL;
 
 	args.zones = argp + sizeof(struct blk_zone_report);
-	ret = blkdev_report_zones(bdev, rep.sector, rep.nr_zones,
-				  blkdev_copy_zone_to_user, &args);
+
+	switch (cmd) {
+	case BLKREPORTZONE:
+		ret = blkdev_report_zones(bdev, rep.sector, rep.nr_zones,
+					  blkdev_copy_zone_to_user, &args);
+		break;
+	case BLKREPORTZONEV2:
+		if (rep.flags & ~BLK_ZONE_REPV2_INPUT_FLAGS)
+			return -EINVAL;
+		ret = blkdev_report_zones_cached(bdev, rep.sector, rep.nr_zones,
+					 blkdev_copy_zone_to_user, &args);
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	if (ret < 0)
 		return ret;
 
diff --git a/block/ioctl.c b/block/ioctl.c
index 3927ca4707d0..698629e4c619 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -581,6 +581,7 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
 	case BLKGETDISKSEQ:
 		return put_u64(argp, bdev->bd_disk->diskseq);
 	case BLKREPORTZONE:
+	case BLKREPORTZONEV2:
 		return blkdev_report_zones_ioctl(bdev, cmd, arg);
 	case BLKRESETZONE:
 	case BLKOPENZONE:
diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
index dab5d9700898..1441d79a6173 100644
--- a/include/uapi/linux/blkzoned.h
+++ b/include/uapi/linux/blkzoned.h
@@ -82,10 +82,20 @@ enum blk_zone_cond {
 /**
  * enum blk_zone_report_flags - Feature flags of reported zone descriptors.
  *
- * @BLK_ZONE_REP_CAPACITY: Zone descriptor has capacity field.
+ * @BLK_ZONE_REP_CAPACITY: Output only. Indicates that zone descriptors in a
+ *			   zone report have a valid capacity field.
+ * @BLK_ZONE_REP_CACHED: Input only. Indicates that the zone report should be
+ *			 generated using cached zone information. In this case,
+ *			 the implicit open, explicit open and closed zone
+ *			 conditions are all reported with the
+ *			 BLK_ZONE_COND_ACTIVE condition.
  */
 enum blk_zone_report_flags {
+	/* Output flags */
 	BLK_ZONE_REP_CAPACITY	= (1 << 0),
+
+	/* Input flags */
+	BLK_ZONE_REP_CACHED	= (1 << 31),
 };
 
 /**
@@ -128,6 +138,10 @@ struct blk_zone {
  * @sector: starting sector of report
  * @nr_zones: IN maximum / OUT actual
  * @flags: one or more flags as defined by enum blk_zone_report_flags.
+ * @flags: one or more flags as defined by enum blk_zone_report_flags.
+ *	   With BLKREPORTZONE, this field is ignored as an input and is valid
+ *	   only as an output. Using BLKREPORTZONEV2, this field is used as both
+ *	   input and output.
  * @zones: Space to hold @nr_zones @zones entries on reply.
  *
  * The array of at most @nr_zones must follow this structure in memory.
@@ -154,9 +168,16 @@ struct blk_zone_range {
 /**
  * Zoned block device ioctl's:
  *
- * @BLKREPORTZONE: Get zone information. Takes a zone report as argument.
- *                 The zone report will start from the zone containing the
- *                 sector specified in the report request structure.
+ * @BLKREPORTZONE: Get zone information from a zoned device. Takes a zone report
+ *		   as argument. The zone report will start from the zone
+ *		   containing the sector specified in struct blk_zone_report.
+ *		   The flags field of struct blk_zone_report is used as an
+ *		   output only and ignored as an input.
+ *		   DEPRECATED, use BLKREPORTZONEV2 instead.
+ * @BLKREPORTZONEV2: Same as @BLKREPORTZONE but uses the flags field of
+ *		     struct blk_zone_report as an input, allowing to get a zone
+ *		     report using cached zone information if BLK_ZONE_REP_CACHED
+ *		     is set.
  * @BLKRESETZONE: Reset the write pointer of the zones in the specified
  *                sector range. The sector range must be zone aligned.
  * @BLKGETZONESZ: Get the device zone size in number of 512 B sectors.
@@ -175,5 +196,6 @@ struct blk_zone_range {
 #define BLKOPENZONE	_IOW(0x12, 134, struct blk_zone_range)
 #define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)
 #define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)
+#define BLKREPORTZONEV2	_IOWR(0x12, 142, struct blk_zone_report)
 
 #endif /* _UAPI_BLKZONED_H */
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 957ce3343a4f..66ca526cf786 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -298,7 +298,7 @@ struct file_attr {
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
 #define BLKGETDISKSEQ _IOR(0x12,128,__u64)
-/* 130-136 are used by zoned block device ioctls (uapi/linux/blkzoned.h) */
+/* 130-136 and 142 are used by zoned block device ioctls (uapi/linux/blkzoned.h) */
 /* 137-141 are used by blk-crypto ioctls (uapi/linux/blk-crypto.h) */
 #define BLKTRACESETUP2 _IOWR(0x12, 142, struct blk_user_trace_setup2)
 
-- 
2.51.0


