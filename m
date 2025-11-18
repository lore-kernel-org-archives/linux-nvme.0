Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1A0CEBF93
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Nov 2025 07:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NxywsA1nA8TGs2RT9uGSCEgSdjJBrPjC0KiHZ/jaP8E=; b=KMHa7z44hT1glNXsgAX8Vx7Ubz
	VgBg4ar1wO0JJya0RoLcpOz0CPY0NPXuuo3Ik17ADebiVQmZiKq6u1N2fGqlE1wjRTyLwz9MIbqBE
	oVCaTx3BchF86pe088sZPvZFA2j7Lc3Tiz/XKsCzWOjpzLQ0LzAquFLMjsgHLKe+3lWZfmihOp/Ho
	yCwmJUbVmWY70JbFUk0dwL+QQ9+3Mf5IdDglLZ/2fIRQ66t0fNp7C+Pu1pyZClfjiyzksEjNC+NF7
	b4tjO0gOAulwXpbpgsoElBfBCmvmfSx0SV9E9GqBmsfSgepDrlCInM32sMUcoNM3bPEUJpPBoJgce
	x/xEacRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLGMV-0000000Hacw-2VpQ;
	Tue, 18 Nov 2025 07:42:51 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLGMT-0000000Haca-1nB6
	for linux-nvme@lists.infradead.org;
	Tue, 18 Nov 2025 07:42:50 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-7b9387df58cso1360568b3a.3
        for <linux-nvme@lists.infradead.org>; Mon, 17 Nov 2025 23:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763451768; x=1764056568; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NxywsA1nA8TGs2RT9uGSCEgSdjJBrPjC0KiHZ/jaP8E=;
        b=geJplc/jOPLx15W7bLtZziftNMR7vOEFuEW/hca5dHYGeT4fOKBwhzavjBCmy9BeK9
         NcprVsC573bvtLXfmuN+oLW9UjqvtrI8QuM7CVQTR0YKs7OQQCO1Hizxma9g2EHIWZyW
         YTRumJKAooxfkL3W8mJBxwG4g89+xQbFqre16QvQfDq+fE6DXg1j425PePrzVAEJnaSv
         y/4MqhiLXY4SEQD/7HLnsHkytVF0JWnInnpqkqeEiu9eSI5/d08DTFdFOa43bxyMLeo4
         GZcqnl34+1+kU3rJ5XGichJLw5t7aHVvkA62Q1x9OYwuLLmBd6KChBl2ws7zHzGTG520
         W6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763451768; x=1764056568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxywsA1nA8TGs2RT9uGSCEgSdjJBrPjC0KiHZ/jaP8E=;
        b=CJ3qOppRUnsoDeGOkwz9v6t+nehhbrHIQTTglRKdIWbKj1N9UqopjgxpNq/uQj10V4
         2MGBCh7NguAOw6Et0Kf+VVOCJSghlkycRH++9klkDhM24frpRAxR6gRRjoEv5cFLWaMv
         PeiswgdVYaVf4ohTBlO+Aq2a0h8vk/DUsqov2arHTptyvXcQqFvo0idb3kSsll4/WPmz
         YxOfBZ8+zSfPCbOyeosVHj6ePwxnedUEai682Pcp0WWBdmnWgq4KTAgnIkngoo9ML2K7
         CCiCyBr2lXNwlQ17SagB6UleTGe8mVZbsobQ+Lu1kA63oHvDnf2fS/oINzeKVN74BVCG
         /Oew==
X-Forwarded-Encrypted: i=1; AJvYcCW9yVKaFWcDId4xEYsmr6wl2ef/b9645fXn55WFVTGiGa/GlK//6bIDAuAC+B6qehPy80q6SWoROF0A@lists.infradead.org
X-Gm-Message-State: AOJu0Yyp3A/30GF+AdIWkByecgc8/13MvTyrQ1VYB4ScMjnCZvD07lUD
	VW1gGzPhYhqgkyyXypY5ONd5SlHsjgDY0IQr1CQqQhp8Oh5E13dH1xyK
X-Gm-Gg: ASbGncv7LJKpIF+E5Sg/5lSWofwOyaQy3+olJodgJLGIUqlaxfTMxL5vjwSt0a5DMc6
	NVyOfov04BG/cpVC+cmpq6a9rYs7usfppwNgSmy2A4S1dNtLA5H3dQb7tDfpXg4ETvTlPDYjEjU
	GEc6CFmcZhDh0nwurcFEG7Y9Qp7jCDlsNeIfAhTpuPc3iT+JdqlW9rdlEzlo1jtNt+2PzWtFTR6
	Tu3nKZg0mMpN+UCaTbRDhWW5eTxpBHGUVQTjoU77TBLyqFYZryLZmNYXOaztaO2LVnIvO/FEsUD
	m25f8mGZYMEBYz20qMDLrEGPAgHd9YuuNC8LRW/e8dfuC3bGteNxlmSL4DSews1O7KaAZWkpkgy
	sh18+IzMg+nA+3jBGG1ULB8s7k4yVReJMnLp+AhRjhUXkKIHgoQpJ+iYsV4B5dQGQh7efREEGjY
	s0SKPYYNKN8namL0Z3UHA7O/om9cdOFWiApdAaHbl2T41dDpKBkuR91mQ5Xg==
X-Google-Smtp-Source: AGHT+IEP4Fiq1WYi0fQwUxT7w8CcXRrYGmKQQRpSmtx18AEGOxK4QGIRV7JKkjFv4nGOrRKeWjhvWA==
X-Received: by 2002:a05:7022:69aa:b0:11b:3742:1257 with SMTP id a92af1059eb24-11b4120ca2amr9929883c88.34.1763451767829;
        Mon, 17 Nov 2025 23:42:47 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b06088625sm58814092c88.8.2025.11.17.23.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 23:42:47 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-xfs@vger.kernel.org
Cc: axboe@kernel.dk,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	song@kernel.org,
	yukuai3@huawei.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	jaegeuk@kernel.org,
	chao@kernel.org,
	cem@kernel.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [RFC PATCH] block: change __blkdev_issue_discard() return type to void
Date: Mon, 17 Nov 2025 23:42:43 -0800
Message-Id: <20251118074243.636812-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_234249_473586_CBACE41B 
X-CRM114-Status: GOOD (  18.23  )
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

__blkdev_issue_discard() always returns 0, making all error checking
at call sites dead code. The function simply stops allocating bios 
and returns 0.

Discard operations are advisory/optimization, not critical. Some callers
have dead error checking code expecting wrong return codes such as
-ENOTSUPP when 0 is only returned. 

This patch changes __blkdev_issue_discard() return type to void and
removes dead error checking code from all call sites:

* Block layer:
  blk-lib.c: Remove return value, update blkdev_issue_discard() caller

* Device mapper:
  dm-thin.c: Change issue_discard() to void, update both callers
  md.c: Simplify conditional to just check for NULL bio

* NVMe target:
  io-cmd-bdev.c: Remove dead error handling and error_slba assignment

* Filesystems:
  f2fs/segment.c: Preserve fault injection
  xfs/xfs_discard.c: Update both xfs_discard_extents() and
  xfs_discard_rtdev_extents() to remove dead error checks

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
Hi,

Due to involvement of all the subsystem making it as an RFC, ideally
it shuoldn't be an RFC.

-ck
---
 block/blk-lib.c                   |  7 +++----
 drivers/md/dm-thin.c              | 12 +++++-------
 drivers/md/md.c                   |  4 ++--
 drivers/nvme/target/io-cmd-bdev.c |  7 +------
 fs/f2fs/segment.c                 |  2 +-
 fs/xfs/xfs_discard.c              | 17 +++--------------
 include/linux/blkdev.h            |  2 +-
 7 files changed, 16 insertions(+), 35 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 3030a772d3aa..ca78ec6b5326 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -60,7 +60,7 @@ struct bio *blk_alloc_discard_bio(struct block_device *bdev,
 	return bio;
 }
 
-int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
+void __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
 {
 	struct bio *bio;
@@ -68,7 +68,6 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	while ((bio = blk_alloc_discard_bio(bdev, &sector, &nr_sects,
 			gfp_mask)))
 		*biop = bio_chain_and_submit(*biop, bio);
-	return 0;
 }
 EXPORT_SYMBOL(__blkdev_issue_discard);
 
@@ -90,8 +89,8 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	int ret;
 
 	blk_start_plug(&plug);
-	ret = __blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, &bio);
-	if (!ret && bio) {
+	__blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, &bio);
+	if (bio) {
 		ret = submit_bio_wait(bio);
 		if (ret == -EOPNOTSUPP)
 			ret = 0;
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index c84149ba4e38..77c76f75c85f 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -395,13 +395,13 @@ static void begin_discard(struct discard_op *op, struct thin_c *tc, struct bio *
 	op->bio = NULL;
 }
 
-static int issue_discard(struct discard_op *op, dm_block_t data_b, dm_block_t data_e)
+static void issue_discard(struct discard_op *op, dm_block_t data_b, dm_block_t data_e)
 {
 	struct thin_c *tc = op->tc;
 	sector_t s = block_to_sectors(tc->pool, data_b);
 	sector_t len = block_to_sectors(tc->pool, data_e - data_b);
 
-	return __blkdev_issue_discard(tc->pool_dev->bdev, s, len, GFP_NOIO, &op->bio);
+	__blkdev_issue_discard(tc->pool_dev->bdev, s, len, GFP_NOIO, &op->bio);
 }
 
 static void end_discard(struct discard_op *op, int r)
@@ -1113,9 +1113,7 @@ static void passdown_double_checking_shared_status(struct dm_thin_new_mapping *m
 				break;
 		}
 
-		r = issue_discard(&op, b, e);
-		if (r)
-			goto out;
+		issue_discard(&op, b, e);
 
 		b = e;
 	}
@@ -1188,8 +1186,8 @@ static void process_prepared_discard_passdown_pt1(struct dm_thin_new_mapping *m)
 		struct discard_op op;
 
 		begin_discard(&op, tc, discard_parent);
-		r = issue_discard(&op, m->data_block, data_end);
-		end_discard(&op, r);
+		issue_discard(&op, m->data_block, data_end);
+		end_discard(&op, 0);
 	}
 }
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 41c476b40c7a..7fc0bb7a3814 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9041,8 +9041,8 @@ void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
 {
 	struct bio *discard_bio = NULL;
 
-	if (__blkdev_issue_discard(rdev->bdev, start, size, GFP_NOIO,
-			&discard_bio) || !discard_bio)
+	__blkdev_issue_discard(rdev->bdev, start, size, GFP_NOIO, &discard_bio);
+	if (!discard_bio)
 		return;
 
 	bio_chain(discard_bio, bio);
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 8d246b8ca604..f26010c46c33 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -366,16 +366,11 @@ static u16 nvmet_bdev_discard_range(struct nvmet_req *req,
 		struct nvme_dsm_range *range, struct bio **bio)
 {
 	struct nvmet_ns *ns = req->ns;
-	int ret;
 
-	ret = __blkdev_issue_discard(ns->bdev,
+	__blkdev_issue_discard(ns->bdev,
 			nvmet_lba_to_sect(ns, range->slba),
 			le32_to_cpu(range->nlb) << (ns->blksize_shift - 9),
 			GFP_KERNEL, bio);
-	if (ret && ret != -EOPNOTSUPP) {
-		req->error_slba = le64_to_cpu(range->slba);
-		return errno_to_nvme_status(req, ret);
-	}
 	return NVME_SC_SUCCESS;
 }
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b45eace879d7..e6078176f733 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1346,7 +1346,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 		if (time_to_inject(sbi, FAULT_DISCARD)) {
 			err = -EIO;
 		} else {
-			err = __blkdev_issue_discard(bdev,
+			__blkdev_issue_discard(bdev,
 					SECTOR_FROM_BLOCK(start),
 					SECTOR_FROM_BLOCK(len),
 					GFP_NOFS, &bio);
diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
index ee49f20875af..f82cc07806df 100644
--- a/fs/xfs/xfs_discard.c
+++ b/fs/xfs/xfs_discard.c
@@ -116,7 +116,6 @@ xfs_discard_extents(
 	struct xfs_extent_busy	*busyp;
 	struct bio		*bio = NULL;
 	struct blk_plug		plug;
-	int			error = 0;
 
 	blk_start_plug(&plug);
 	list_for_each_entry(busyp, &extents->extent_list, list) {
@@ -126,18 +125,10 @@ xfs_discard_extents(
 
 		trace_xfs_discard_extent(xg, busyp->bno, busyp->length);
 
-		error = __blkdev_issue_discard(btp->bt_bdev,
+		__blkdev_issue_discard(btp->bt_bdev,
 				xfs_gbno_to_daddr(xg, busyp->bno),
 				XFS_FSB_TO_BB(mp, busyp->length),
 				GFP_KERNEL, &bio);
-		if (error && error != -EOPNOTSUPP) {
-			xfs_info(mp,
-	 "discard failed for extent [0x%llx,%u], error %d",
-				 (unsigned long long)busyp->bno,
-				 busyp->length,
-				 error);
-			break;
-		}
 	}
 
 	if (bio) {
@@ -149,7 +140,7 @@ xfs_discard_extents(
 	}
 	blk_finish_plug(&plug);
 
-	return error;
+	return 0;
 }
 
 /*
@@ -496,12 +487,10 @@ xfs_discard_rtdev_extents(
 
 		trace_xfs_discard_rtextent(mp, busyp->bno, busyp->length);
 
-		error = __blkdev_issue_discard(bdev,
+		__blkdev_issue_discard(bdev,
 				xfs_rtb_to_daddr(mp, busyp->bno),
 				XFS_FSB_TO_BB(mp, busyp->length),
 				GFP_NOFS, &bio);
-		if (error)
-			break;
 	}
 	xfs_discard_free_rtdev_extents(tr);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f0ab02e0a673..b05c37d20b09 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1258,7 +1258,7 @@ extern void blk_io_schedule(void);
 
 int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask);
-int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
+void __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop);
 int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp);
-- 
2.40.0


