Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3B8E77198
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 16:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=u3buKDNJr5X6KF22K4Hp8EFIxV8s+Qa976u4D9fN56w=; b=s+qfOeE1uCYy1zLI47XjaKCx1G
	ClWEKt+Msw7x83u64T5VIXiAEkDVQ08re1/RGPhRwfNI5Gw23BNiQQrq2vQspqINFPZ01LakKnKxw
	LYoCAf7eOCpjmSACLDjCM113Rttqh7wWFasEYP+t0Z96OBHmCUhBPWZBCSYAXDriDKujYxPvlc6Ty
	h2QzOwWe4BDONDyVX1VlWIjSt9gP0Tnn9I/5UQBHUOoVyil83NYqCcSZ8x2Y254xLbakvbAdp8mt3
	PdTF1NN3hVHYb2i1e2maJkHdC5BI/zJdWtSd2f15zOZ368+/LbpwHpiEqsZIQqihEq9eFAM/c6xXw
	4OPtnDUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUqCo-00000001zVB-40ek;
	Mon, 06 Jan 2025 16:43:54 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUqBB-00000001z0L-3vIW
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 16:42:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5C604A419FE;
	Mon,  6 Jan 2025 16:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E649DC4CED2;
	Mon,  6 Jan 2025 16:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736181732;
	bh=MMqHdZJR+afNkPyiAkcoQt7WMqJ2INQ4U0BUyM+ywFs=;
	h=From:To:Cc:Subject:Date:From;
	b=fDZ9x7yL9Y1NFpt8fyBgZldCELCzLb/tgh1pDV3R8U5n2Jku+ncTnsEymSZOqAe+k
	 YgZAxirY9KOPDqmkIGFruHycZaENoexE6sUdgnHrWr3dX9LRMI2zdFepnOa5YRBe82
	 +l/Zm9cOhIPPYz2zOCDJSxi8siiNx565VgD0bpeIfvWAYlZMggOvGuCXHbTe0WhijT
	 Hn+omk+cjYxjCa52K/mJXBDETNtXeQCDpQ2sKr6cw6+DLzNoA8fzJ/Hvz5oWx/qwDb
	 M+XnFWfFPksYjoP6sxkAjKRVrWwR9xYdlpeR6uxnWyX4xFM+jKMV3POQiKohfApoEO
	 6ZL/p0cx4l30A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1] nvmet: propagate npwg topology
Date: Mon,  6 Jan 2025 11:42:10 -0500
Message-Id: <20250106164210.1122348-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.123
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_084214_026466_C7591E47 
X-CRM114-Status: GOOD (  10.44  )
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

From: Luis Chamberlain <mcgrof@kernel.org>

[ Upstream commit b579d6fdc3a9149bb4d2b3133cc0767130ed13e6 ]

Ensure we propagate npwg to the target as well instead
of assuming its the same logical blocks per physical block.

This ensures devices with large IUs information properly
propagated on the target.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/io-cmd-bdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index c2d6cea0236b..ada58a4d0d0c 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -36,7 +36,7 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	 */
 	id->nsfeat |= 1 << 4;
 	/* NPWG = Namespace Preferred Write Granularity. 0's based */
-	id->npwg = lpp0b;
+	id->npwg = to0based(bdev_io_min(bdev) / bdev_logical_block_size(bdev));
 	/* NPWA = Namespace Preferred Write Alignment. 0's based */
 	id->npwa = id->npwg;
 	/* NPDG = Namespace Preferred Deallocate Granularity. 0's based */
-- 
2.39.5


