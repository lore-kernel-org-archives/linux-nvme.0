Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7891C369B2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 13:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tYsmlOT5GxYgSLJwU+21J22ia9V2iVsXN94QgOs+tk4=; b=VWlu7fZ4dF5WhAbHziju4ptm7+
	UhQdKdr00B6kby0AS8EXFOqlPz6sJ86w95wcRizyZAmrYXl6Wl1Hv2DEVsoLEWQc2evwtucUF2x6o
	h60phRJuh/LH4tpPNdHcyUCckR56ctf0jquEoh/1/okyC8Ji2wN4uuK7/LqDQxv6R+MWJGBpg7MrJ
	7RLh/7cFFUfHADz3jXDzfvSyWgzGIzI7xdlYtUxceEGjBV7bYoJyHfN1vSryyWs2e6VX38NKKd9fA
	I28YwyEcGTAJWtVEErxlcaclL8VDp+hvks1+d+FcfV/1+znbJy8f9Ae/RhvY79ospJCeFjq/P/Fpn
	SD/OIP1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JtD-000000028iy-1kKG;
	Mon, 14 Apr 2025 13:30:19 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JrV-000000028Fq-1sYO
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:28:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E3D335C5580;
	Mon, 14 Apr 2025 13:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59594C4CEE2;
	Mon, 14 Apr 2025 13:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637312;
	bh=gmCfe1COb9qkb2Vi9dOY8JKW+Czq0eYOsx8yhYbnm9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OrPY+ZhEW3+DOvf6b+ZXBq2xujvtr9QOi/DMVIw5HBIwks8O/GOTQwuDKhkfjqLkR
	 bIBXr6kgaw66fsgpWnCWNWzj6LFjK3lPWMmV3qqAvGzcf2Pgs3w87OhLue2XR1+TT2
	 xBUID10piJdhzeMr0l2f4uCibxGmYOeapH0pI9W41Xrpk9ZxL2fOFwufbXAPhVew7E
	 HKoZncVuhLoDtFCTLL6nW4KKkcNAp33V1TrcthpbI9G1vDZP4QeOMX5lyODTL1eOZ2
	 suRTDPhsiLBnwu292PbOvLM9qw2eTcO9GclnRoIXJmQ/Tpyd+VgivbrS8LFh4NK9sg
	 ksg5dOO3zNn1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 27/34] nvmet-fc: put ref when assoc->del_work is already scheduled
Date: Mon, 14 Apr 2025 09:27:21 -0400
Message-Id: <20250414132729.679254-27-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132729.679254-1-sashal@kernel.org>
References: <20250414132729.679254-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.11
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_062833_521085_63CA7043 
X-CRM114-Status: GOOD (  10.36  )
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

From: Daniel Wagner <wagi@kernel.org>

[ Upstream commit 70289ae5cac4d3a39575405aaf63330486cea030 ]

Do not leak the tgtport reference when the work is already scheduled.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index a3a6dfe98d6fc..0dfffb3f39b06 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1103,7 +1103,8 @@ static void
 nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
 {
 	nvmet_fc_tgtport_get(assoc->tgtport);
-	queue_work(nvmet_wq, &assoc->del_work);
+	if (!queue_work(nvmet_wq, &assoc->del_work))
+		nvmet_fc_tgtport_put(assoc->tgtport);
 }
 
 static bool
-- 
2.39.5


