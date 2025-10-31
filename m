Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22319CCFA00
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 06:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7ab7RC0o/IadUFK65jGPR3CoEs5LpSrh+rGYkfznOMQ=; b=SeQQAQFXdd5NQphQLyV7vD2X0J
	RlNQl7s2Y43DcwXp7j9RtBdRuCBC9jNDj48hILLgS14HLWg/zYMXWhU43juat4uzLRhsWXYoRT1v+
	fKb/Dh2wy5BdTKTL4lZHr4zoeL8Kuk+d1MWog5TbIL2boB5CpMTZjQsDAYJKKsq3lV7WlheSWBKxp
	TxuszM7cGg7StbnR7SkgSgZYtLuqlG1tlgF50lplfa2q3r8QI2HDjdDj4wMU1JYwtOq+LLG5OPtuL
	t4wuHqtUP1twId3bYpTo6MDKfif0rTyJEqGc+aVouEHTNZEKGYXX+KYX0biZMx7nNoPFEO2aWi4X9
	7rwOCbSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEiRg-00000005Rhi-0eOn;
	Fri, 31 Oct 2025 06:17:08 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEiRc-00000005ReW-1TFx
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 06:17:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 14BDC43444;
	Fri, 31 Oct 2025 06:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DA6C4CEE7;
	Fri, 31 Oct 2025 06:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761891424;
	bh=jAeMnW5IAIhrVXXBBq3h2j8UAN/r4N1L4IH+uugW13E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gcaZ3PnVYv9Qq4D6p+2NtpRx0NyB2RLfe6yf/s2qdOcZIRCJPcqZ97s8kODXpHinW
	 k+Ay4G/E6RkM9iRPqgJMUZcD2AC/GHhBLNc7W0o0WaDKqRUDAzarkVOH8pDXOMps4U
	 sB6tl7VIyIVo5ZO4AdQiey9+JiuAf9eLcxf7Pna9I96Oou+HThVAp7VXm1SYThACTM
	 9wgMJpj2e6BmYahF0l2Et1/f8xQC8YiaiCXsNnYPw+iPhCIBTbhb903jz38XgbBLlA
	 mgopxynXMZ6enhlCugmD5wOs5Q3dRCw0ZeNfTdbsv3SKOdwnrd4y6x87UqkzUa6StL
	 NLEw6PTuFNXxQ==
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
Subject: [PATCH 05/13] block: reorganize struct blk_zone_wplug
Date: Fri, 31 Oct 2025 15:12:59 +0900
Message-ID: <20251031061307.185513-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031061307.185513-1-dlemoal@kernel.org>
References: <20251031061307.185513-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251030_231704_454110_E07F0A3C 
X-CRM114-Status: GOOD (  14.53  )
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

Reorganize the fields of struct blk_zone_wplug to remove a hole after
the wp_offset field and avoid having the bio_work structure split
between 2 cache lines.

No functional changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 603ed8dc472c..29891253a920 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -39,6 +39,11 @@ static const char *const zone_cond_name[] = {
 /*
  * Per-zone write plug.
  * @node: hlist_node structure for managing the plug using a hash table.
+ * @bio_list: The list of BIOs that are currently plugged.
+ * @bio_work: Work struct to handle issuing of plugged BIOs
+ * @rcu_head: RCU head to free zone write plugs with an RCU grace period.
+ * @disk: The gendisk the plug belongs to.
+ * @lock: Spinlock to atomically manipulate the plug.
  * @ref: Zone write plug reference counter. A zone write plug reference is
  *       always at least 1 when the plug is hashed in the disk plug hash table.
  *       The reference is incremented whenever a new BIO needing plugging is
@@ -48,27 +53,22 @@ static const char *const zone_cond_name[] = {
  *       reference is dropped whenever the zone of the zone write plug is reset,
  *       finished and when the zone becomes full (last write BIO to the zone
  *       completes).
- * @lock: Spinlock to atomically manipulate the plug.
  * @flags: Flags indicating the plug state.
  * @zone_no: The number of the zone the plug is managing.
  * @wp_offset: The zone write pointer location relative to the start of the zone
  *             as a number of 512B sectors.
- * @bio_list: The list of BIOs that are currently plugged.
- * @bio_work: Work struct to handle issuing of plugged BIOs
- * @rcu_head: RCU head to free zone write plugs with an RCU grace period.
- * @disk: The gendisk the plug belongs to.
  */
 struct blk_zone_wplug {
 	struct hlist_node	node;
-	refcount_t		ref;
-	spinlock_t		lock;
-	unsigned int		flags;
-	unsigned int		zone_no;
-	unsigned int		wp_offset;
 	struct bio_list		bio_list;
 	struct work_struct	bio_work;
 	struct rcu_head		rcu_head;
 	struct gendisk		*disk;
+	spinlock_t		lock;
+	refcount_t		ref;
+	unsigned int		flags;
+	unsigned int		zone_no;
+	unsigned int		wp_offset;
 };
 
 static inline unsigned int disk_zone_wplugs_hash_size(struct gendisk *disk)
-- 
2.51.0


