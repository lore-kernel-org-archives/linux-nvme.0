Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C890E7719C
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 16:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FddIcM+naUF99hiKqT1hA5CIRuyQbXJQlZrBWnl0wqw=; b=Kw58BVEENfWbn34Z0ehPGO2iSj
	hpOrwEPrKth2FDE6BT9Aw1pb4wsoGYgsK7C1ClKr6A5PuARd4tGkkn2DYgxpb6Keg2WHimbBS9goo
	BmyXOFs6RgjCFdXqqJYFXC5eDQDAIKMCFyCTlM7KgNihiCu3bwRvW2PnH1BMjMa/jzUbJWUarwG5j
	GWdGgTY7NFJ/hzpSv1Rlj6k8rMZM1JbkdjTezmn4nYVPN/f8yE3wD7e79/zMPlbszO/rDGCikXZoh
	7tff/RiMjIU7c1D2gjjuO1y/m3THAskuVdpUm74pkvsb/IBS6uLS3iLE/pbkvIKKMD1B6yweS1k+w
	Q+6vJZ1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUqCq-00000001zWZ-1y89;
	Mon, 06 Jan 2025 16:43:56 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUqBH-00000001z2N-1HpI
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 16:42:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A9B6E5C47D6;
	Mon,  6 Jan 2025 16:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9245EC4CED2;
	Mon,  6 Jan 2025 16:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736181738;
	bh=NZjaipx7SOL5Wkr2z0JjaWDaYrgGFoWE9FvBd4OLYBs=;
	h=From:To:Cc:Subject:Date:From;
	b=ItO3rogYaVrwBDxuvqD1Lpxm6bv2X9Mbb18jHSH77WRlLNcwCFlmazF296kIlVnBE
	 MD3T58x1aj5evbVGXl0TB9cUiE2+zv+kyIkWJAMNf3kIFpIAZI8GrevCQPV1wBZGbZ
	 lmFxaiwhjgVCIb9yUmceFZ6w3jYSyX1QL6RMfrPZabI6ZQH+GC0Y71hHMZ9+o/LkQU
	 fWk5j3ojU+r1ulG3VXL2+R4IqcNi+V3BYTxQeMhEoqMs6dQlHfeLRDu09MZjFuGK1U
	 xHuHi5mn0nO/abqkwKNU7TH41fdsAok4tvXlwOyGMDPbrV2NZLYkp/IqGsTvm/zYCB
	 OLteGizzCI26Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10] nvmet: propagate npwg topology
Date: Mon,  6 Jan 2025 11:42:16 -0500
Message-Id: <20250106164216.1122400-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.232
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_084219_386272_84130559 
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
index 6a9626ff0713..58dd91d2d71c 100644
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


