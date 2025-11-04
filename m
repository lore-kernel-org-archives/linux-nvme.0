Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384D1CCFA05
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 21:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mww4gDmcKx9I0BN6qtGZSVoNcZHHjvoTAI/CE+YdHu0=; b=16RKP15/2fkvKS7AQtST5FOAS/
	Yq2AIJaqMVHoGa/ziEbJ5NrKM5EUb7MvTP4r9N2J1XZ0scEjF2uyJM6xkYXgw2qM9mHy4vg6Ckoli
	if8Pbmp/XPsUayoJ2lIWCmxQtxS2SWOGVE6l+HALBMgoFYqWllgJ5QLg3xWfm+MLoYKbgDwsjHs5x
	n9IZpj2WveHq3b5iMOn9mzrr0sUH0cXLDkkd4QT3XMN40kzhSs7E66xd8ZKROXR0j4gs2qpDr8Fa9
	KQynS3vXwUtq6yPdqpJdjUt/Af+zZZsSI+261Pvhz3NVUA090udHD+u3/EHQLvur5Vwef5e2Eoo0k
	8gr9rGWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGOYD-0000000CbHF-2XwW;
	Tue, 04 Nov 2025 21:26:49 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGOYC-0000000CbFt-1OD1
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 21:26:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BCD87601FE;
	Tue,  4 Nov 2025 21:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED6FC116D0;
	Tue,  4 Nov 2025 21:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762291607;
	bh=2EfCk3eYpYsd2FRAsj4V2+AIABRSzPxnsTzWZwJoh/A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OYpGvEnI7hpjwpl9tKrVQ3TIVkgWggDHeZdrkuOYCTRznpYBESn0NLGhwlN8LCQGP
	 YjulCmiRj5lRiNqCN15nnSqDvPDcr1nV1MxhDXpuGHa8apgh6Cd8Uiyzpw+gL3vPce
	 s/yAY+7wLZoKyPaRnCt0yl/lNrtkJF7tFklvTqpyoGMuNWVzggK2EYpo3skJsVgx78
	 y9B6I57Kd7AI2zvegFixbH+Bj3rsvvVnckEDhBYY0ULkcSg9+4F3o7jKZx4Wply0xH
	 DmNl+J0hS91SrcYCfI6AaTBUWCZWfaq9JeOfJk+z588+IVp4I58QTLibmr0ro+c2/y
	 IDflLpAfVNo0A==
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
Subject: [PATCH v4 05/15] block: reorganize struct blk_zone_wplug
Date: Wed,  5 Nov 2025 06:22:39 +0900
Message-ID: <20251104212249.1075412-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104212249.1075412-1-dlemoal@kernel.org>
References: <20251104212249.1075412-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-zoned.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index de3524c17f67..d4fc87b0be6b 100644
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


