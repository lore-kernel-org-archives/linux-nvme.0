Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B11FC369BB
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 13:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tYsmlOT5GxYgSLJwU+21J22ia9V2iVsXN94QgOs+tk4=; b=yk7JbrSjiR5Lx/i54w+HguAzJZ
	nPA8mDBxADM+DzPoAMlPwm3JrhoELAvmXOCJV+ZiJ7SCdLKor1w8g2VaFPVySuT4QIQ7oiqptmox4
	j+Bv2Mf/axzLCbhMpNm20DCO7YTA7LhaxBxAW/7SBauhRRvtuqPX7kh30jkHTH3r+ed95LkM+TEKh
	ZpJNXXOHjghUhrGwwNj+rYBdmycvYUPRZsVgdp6BJgZcAdsFizWK4QNMoz7lxIRy9aXAjmcZBt1wP
	cubK/B/AwKs8lK57WCac9Ui0jlBPivEHQjT/cVMZqmAEjxd2De8bzeZy+3hQ7dqu1boOIi5EJQqom
	ptaR958A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JtH-000000028o4-2t77;
	Mon, 14 Apr 2025 13:30:23 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Jsd-000000028aK-0Tw4
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:29:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D2A8D4A540;
	Mon, 14 Apr 2025 13:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E59C4CEE2;
	Mon, 14 Apr 2025 13:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637382;
	bh=gmCfe1COb9qkb2Vi9dOY8JKW+Czq0eYOsx8yhYbnm9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QnygZ4pIZkHFPFWqhN/JudlBqw61+/KO0WgbT8ZC11VB2qVXOqSCE/nFqT+0Hz0tf
	 F2d2bu7tl0RqiJzU6GsR6C4uxBIdqXZB7xqCOZC3htK3WQ0v58kcIVb9Kj9t7bArQd
	 bwt/LBIqI4+xDd8CcjexBiMeo7Pz8Pe+fDqycLPd3xmBZ9+FfntjoqlLZfq2PNzdh7
	 pOzQEM1YiQzDp+4euUR487xr1iSr9ZaDB47oGz80vdBq0C+fFRgqCvoStW59ZhSsQL
	 IEJbIs51wtvmrZiL5rJxnX3Gh7D2vGhFv5ayQS/ejIpaG/4yInXlt9O3YOdETV8DBa
	 u93Lb7UCQeP5A==
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
Subject: [PATCH AUTOSEL 6.12 23/30] nvmet-fc: put ref when assoc->del_work is already scheduled
Date: Mon, 14 Apr 2025 09:28:40 -0400
Message-Id: <20250414132848.679855-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132848.679855-1-sashal@kernel.org>
References: <20250414132848.679855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.23
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_062943_164893_31D6B029 
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


