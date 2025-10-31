Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F59CCF9EE
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 06:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L0feInR/0mTvgZNDm/YO9r3a9t4x7kOUokP19TJ4dZc=; b=wahWpJuuHRaKXRvm7R3YkDfoR8
	N6s4VJISZKHv2x2ujxthMnS+R/rF9u8lPev/xJTUbmbFDRbICV6YpnqYLb0gvsCU1NSRpj2i5KaKs
	MqFMQDzZ8gOfzEXA5SHYXdeyG/TVmqtd7egMRYw3e2rtLR4oqE0PyvEEeRSRsUCSVgaTnSYFaJEl8
	tVbsW+3ALcYZK1J+fSFngzQrEa8E7fPKnvSy/l73EENnbNWWxiR5zDCkv8gfyxyzELDTSot5jdrSD
	+e+gG33CBQlsMnyZMRwgrdzAWGRLFBBWtYPpZqNF2BprEpsukf4wFcQDT5eYMASTqZYIZuoDU9MSm
	d8fwdqNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEiRx-00000005Rvl-0srj;
	Fri, 31 Oct 2025 06:17:25 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEiRq-00000005RmW-1YyV
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 06:17:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1AA6344B5B;
	Fri, 31 Oct 2025 06:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8739EC4CEF1;
	Fri, 31 Oct 2025 06:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761891438;
	bh=FbZy3KaSfTVCZMhW0kFyGoAA/ywDZmHfYKpfi/XoXsQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HUBaBZX7tYnu6KkCB5R0b9DlxmnO/MoztbBUmGNjqSjyKLPt+vAClDxB8WNMNEFvE
	 /B1vkhN6grqHOrduFlQ1e+Yj0QEmGheSLwGzHhcvd3EP3jhnE2w5I6DoZFcWHsz+CH
	 6fMrVL2vN1DOCPi1+0Sd0aYu3NN0poaEPObu7L7R8hdpgld5WpqSrvX7UI7rqZ148y
	 LTA0G0ar77yPWwLfrenRx92uPJa6tbaU7Hl2hhxz8nceW13hlce2YAnV0i4Laxygk1
	 6SSJP9QijYQE07qCN/RHAPreEV7IaaGWmenJMpxzwkjr924OXKoasEvHuLI4cnyFUA
	 Fn6G0BGaTsztQ==
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
Subject: [PATCH 13/13] xfs: use blkdev_report_zones_cached()
Date: Fri, 31 Oct 2025 15:13:07 +0900
Message-ID: <20251031061307.185513-14-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031061307.185513-1-dlemoal@kernel.org>
References: <20251031061307.185513-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251030_231719_316503_4AC9A88A 
X-CRM114-Status: GOOD (  10.49  )
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

With this change, mounting a freshly formatted large capacity (30 TB)
SMR HDD completes under 2s compared to over 4.7s before.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 fs/xfs/xfs_zone_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_zone_alloc.c b/fs/xfs/xfs_zone_alloc.c
index 23cdab4515bb..8d819bc134cd 100644
--- a/fs/xfs/xfs_zone_alloc.c
+++ b/fs/xfs/xfs_zone_alloc.c
@@ -1231,7 +1231,7 @@ xfs_mount_zones(
 	trace_xfs_zones_mount(mp);
 
 	if (bdev_is_zoned(bt->bt_bdev)) {
-		error = blkdev_report_zones(bt->bt_bdev,
+		error = blkdev_report_zones_cached(bt->bt_bdev,
 				XFS_FSB_TO_BB(mp, mp->m_sb.sb_rtstart),
 				mp->m_sb.sb_rgcount, xfs_get_zone_info_cb, &iz);
 		if (error < 0)
-- 
2.51.0


