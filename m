Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACEBCCFA04
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 21:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l072zxpGhRb3+CXrY0IPUy/q7DCe6IXrfzRfkKiWwKQ=; b=VFaSEmskUfrTNddv0fpGlsoI73
	y7SUxpRavlKExsjbJU6rFoOln7BJbbV/EjpTLBj3cr2lKyut72YVWi2dMPqLdzTzhQcbaCtq7Y3A7
	0OP3cOm874mazREYeOnMapvJIAy46heC6RLXDifWTROPBmpDxqw+97PbO+zpNLbwhVUjPLrTSKhGU
	HIqBAD2b9Ki1ZI/asZSQ4hd6m+6sYPwSJVSQ+u3+vU1yzpdYi5PG1TYouJxj6DyYlNqY3s3eLMDTT
	CmhR3k1qvD+NYIqXd9tdQpqTJyVLXi0Ga90ifo1B3kjrSL28Fd1ud8hVWD4MROY9nvnopvfL2hWz0
	OdBlMiug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGOYa-0000000CboW-3s5Q;
	Tue, 04 Nov 2025 21:27:12 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGOYW-0000000Cbhe-2Y71
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 21:27:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3BB684075D;
	Tue,  4 Nov 2025 21:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEE0C16AAE;
	Tue,  4 Nov 2025 21:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762291628;
	bh=ZQitxpNbla8eatdIt11qa+C2wAmNOTfTTPJx07AuheM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=sMXjp4sPvYyhvfNDO+HaY+mz76FAj1m1xRua75qET13g6hbvwAUMi1sTxX6/xJ1Py
	 2Xmc6XOrcPWCN7M/UQPpE3+nWvYzXhTVyZojCFhLRczFrRy12Pp8oWmxiB7Yu/kR3b
	 xPcJzh1q2XwtJACOz0UmJq0HOezj6SW7KDA4DtfL8uIw9OL2YRFXBx860Se79uZZtS
	 zqAIwtyfuC4vDKyv6DMg+1gutR68lcqCHLTvcyAyy1kGyGUnQQ9Zz/DCFQZ8F8ISvC
	 dGt7p6TpMRnXI1YY+6RkeZM3ZONSrpzk8IvSD5yJXrwF3A+HfGWkM46G74s9GuEz2r
	 H1OjBBMrQ4cGw==
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
Subject: [PATCH v4 15/15] xfs: use blkdev_report_zones_cached()
Date: Wed,  5 Nov 2025 06:22:49 +0900
Message-ID: <20251104212249.1075412-16-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104212249.1075412-1-dlemoal@kernel.org>
References: <20251104212249.1075412-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_132708_741289_E36D5035 
X-CRM114-Status: GOOD (  12.21  )
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

Modify xfs_mount_zones() to replace the call to blkdev_report_zones()
with blkdev_report_zones_cached() to speed-up mount operations.
Since this causes xfs_zone_validate_seq() to see zones with the
BLK_ZONE_COND_ACTIVE condition, this function is also modified to acept
this condition as valid.

With this change, mounting a freshly formatted large capacity (30 TB)
SMR HDD completes under 2s compared to over 4.7s before.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 fs/xfs/libxfs/xfs_zones.c | 1 +
 fs/xfs/xfs_zone_alloc.c   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_zones.c b/fs/xfs/libxfs/xfs_zones.c
index b0791a71931c..b40f71f878b5 100644
--- a/fs/xfs/libxfs/xfs_zones.c
+++ b/fs/xfs/libxfs/xfs_zones.c
@@ -95,6 +95,7 @@ xfs_zone_validate_seq(
 	case BLK_ZONE_COND_IMP_OPEN:
 	case BLK_ZONE_COND_EXP_OPEN:
 	case BLK_ZONE_COND_CLOSED:
+	case BLK_ZONE_COND_ACTIVE:
 		return xfs_zone_validate_wp(zone, rtg, write_pointer);
 	case BLK_ZONE_COND_FULL:
 		return xfs_zone_validate_full(zone, rtg, write_pointer);
diff --git a/fs/xfs/xfs_zone_alloc.c b/fs/xfs/xfs_zone_alloc.c
index 040402240807..9c8587622692 100644
--- a/fs/xfs/xfs_zone_alloc.c
+++ b/fs/xfs/xfs_zone_alloc.c
@@ -1239,7 +1239,7 @@ xfs_mount_zones(
 	trace_xfs_zones_mount(mp);
 
 	if (bdev_is_zoned(bt->bt_bdev)) {
-		error = blkdev_report_zones(bt->bt_bdev,
+		error = blkdev_report_zones_cached(bt->bt_bdev,
 				XFS_FSB_TO_BB(mp, mp->m_sb.sb_rtstart),
 				mp->m_sb.sb_rgcount, xfs_get_zone_info_cb, &iz);
 		if (error < 0)
-- 
2.51.0


