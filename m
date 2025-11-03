Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0076FCCF9FE
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 13:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+2/zBgevySVaWIE/HSYr6GJXHoWvxNraPm+0dEs5LYY=; b=cWsj/laWQy9VsfC/Oqpdy+k0vA
	SvDdS2J7dU6yKrCCwhIoqHHUBBz0NIgqQ2aM1wk0R3gDYtjWVwBIiw3v5R2mGsxQZBl6Ek3mkvDVW
	gmgh5Ime3czQNpD/A8qVex0EBvtm8fiEskbkpdIP52GynUPyltlQW3LmWN8JvmsNB37OqUi8WX+iJ
	SfX+gD+Oepy0L7w0ljYEaKUBxhd3xDyis8azJixyuZ0wMVGlL50iYlQldzoix+cLITHfdc4AAXKVH
	+smWfW2C0RVVLdiGKKeb3TmgQMMTIYeuqxxExrXeO/v3ujyiVHzqiUatvi9HFnbIhsLstBitvmWGR
	v1hov+JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFuit-00000009uh6-3dG2;
	Mon, 03 Nov 2025 13:35:51 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFuin-00000009uX0-0F32
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 13:35:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B044E438B1;
	Mon,  3 Nov 2025 13:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1DDC4CEE7;
	Mon,  3 Nov 2025 13:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762176944;
	bh=71ngn76yrYFjaxkK05PGAxZ9HfO52W4Ba3k1t35Su6U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OWF43w5ThLkGT6v8kuvqbmh2kuLm4dhel6BuA2De50zPhfxBt3b40WdtyeO2YuLMY
	 qfKSeQUvMgCQS+3ovwrocalAvstvwjsBe+5Bn5gd7Cct5u5RHVVjvIaynHq8t7/DyU
	 sqjOVE0/LZ9N9f6c1FrLMbMIZ3+b/Bo/ow5rOuNuc5Klmnukp+HZFLfEolCbR4mTjO
	 3tpKfeHk0Ue348ibeIeiP8iCbFrl6F6mur5+lHjXdIsSPpLYcjf0WPzv5l5LjRMhzc
	 VTUGODYLFdR++42ScmSIx8g+qb4Ty0s40utpMJg5Wx8Yc0Od5k5915BNDrs/TBcg5S
	 oEqHL3bOcNXRg==
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
Subject: [PATCH v2 15/15] xfs: use blkdev_report_zones_cached()
Date: Mon,  3 Nov 2025 22:31:23 +0900
Message-ID: <20251103133123.645038-16-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103133123.645038-1-dlemoal@kernel.org>
References: <20251103133123.645038-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_053545_155304_20310327 
X-CRM114-Status: GOOD (  11.11  )
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


