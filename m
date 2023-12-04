Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAAC6C10DC3
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 20:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9z5jCdx+T26EZ6+OvAfcMwIiIuYVlZE6gfVJ36qpWH4=; b=tXmrU+IaddMaXwkS9D26/lni9x
	vrBntZ5ELqOEVHrIvEKOLoqoHBsiQzFTqsKCDuKDRahTK9t6rGcYA/WLJ4b1TekiMRLJ50z5u6qb6
	/kTinq+FxrdIS9piIfxLwC/TmGykoL4g2/1XbbzEi7g+AfmhlMSOUViTqHfCIa8v3dGDMSufOXNT2
	k57UFr8pPbLC/gXW2tqPvmVAEngLPhtGrvT5c2fA0heIa0WnB3QabibFaVrWfKPyymkF8fgmSGllD
	dT/14Glaan1iNb0EBB0vPB5Yqp5Kxb3H64Ry5sVmiRdHV2Ks9W8LyvJIfRmh3ZT0A92mHLibr2FSz
	VTMY1aDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAFfn-005Zed-0e;
	Mon, 04 Dec 2023 20:36:11 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAFfj-005Zbe-2W
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 20:36:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 7922EB81213;
	Mon,  4 Dec 2023 20:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B45C43397;
	Mon,  4 Dec 2023 20:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722166;
	bh=xT+cBc7QfYA6bGC+1nskdoROx+HjWk63kF5Ysn7A7/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fTt8GQw56nN4TvKyOvKh9/T0S78ZZW5j8kcUS8UpESkSmmGUzxXR0ir1NG1uwTWjV
	 oFcqUJUnBNwbwrSYSKD8o4SBwYUowz2jMh+wWRGkdQA7ibdcSmTVnmAH1UP3Gw7Lod
	 Q0vXhFYBwvzk170REKK4/+/KKCUPTTMUI6ziWX4C6xjFp8S1yRLrjUdYCOWsI2S9o/
	 66zPlUOU6fo8Y4BWJFeRNOP1ryHCeTGU+NiyjXOiiwqUTkVLaypZrwSu1Q7KIgquG/
	 IQebcGONIkRiH+MJFEj3FLmhR50ClZ/xyJlVNN0zietzCAiG3NDBvRwVNMV7Gp9yCT
	 HnnhZCtbLT2Zg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 17/17] nvme-core: check for too small lba shift
Date: Mon,  4 Dec 2023 15:35:02 -0500
Message-ID: <20231204203514.2093855-17-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203514.2093855-1-sashal@kernel.org>
References: <20231204203514.2093855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.65
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_123607_977310_F63818DF 
X-CRM114-Status: GOOD (  13.60  )
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 74fbc88e161424b3b96a22b23a8e3e1edab9d05c ]

The block layer doesn't support logical block sizes smaller than 512
bytes. The nvme spec doesn't support that small either, but the driver
isn't checking to make sure the device responded with usable data.
Failing to catch this will result in a kernel bug, either from a
division by zero when stacking, or a zero length bio.

Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0590c0b81fca9..b0db3b54d69a3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1922,9 +1922,10 @@ static void nvme_update_disk_info(struct gendisk *disk,
 
 	/*
 	 * The block layer can't support LBA sizes larger than the page size
-	 * yet, so catch this early and don't allow block I/O.
+	 * or smaller than a sector size yet, so catch this early and don't
+	 * allow block I/O.
 	 */
-	if (ns->lba_shift > PAGE_SHIFT) {
+	if (ns->lba_shift > PAGE_SHIFT || ns->lba_shift < SECTOR_SHIFT) {
 		capacity = 0;
 		bs = (1 << 9);
 	}
-- 
2.42.0


