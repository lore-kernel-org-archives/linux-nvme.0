Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11150C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Oct 2022 00:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ANct6a9K15Q1KpV8swFzxyQnkMtO7Yx23Ui5NPwxQWs=; b=BeG3FguGulo112a+0fRs4k2bG+
	oZ/6SQjMCQdQbGKk7cXb+Y9zb4ORMhdHitmFk73biglvs4TcCF/NF5oMrp7PPWy7VvdX951W260aZ
	PdIWfBzl/LwH5K2PzyjqE0TQJuETspuPI+Qwt1DiLresh49j3b0uCpY5TYEJ+T3F9LgjDSYRWqDDe
	XbdQwXQFdQx2F2SXydnBAwJKhhZWQ0HDGz+7tt6D/G9nLgTYVzALfhGpuP5DGWnjIMyBLRBkRC58V
	LUn8vSdt6+bpqWZ15Oe046hU6SZLzaBHGo+FbtpyD3jteTZv0/tIHTbtKGCkW1P5NcgsudLA/woGb
	AaT4YZ9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oimBZ-009uwb-RD; Thu, 13 Oct 2022 00:34:53 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oim0K-009pXX-Lz
	for linux-nvme@lists.infradead.org; Thu, 13 Oct 2022 00:23:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2D580616E4;
	Thu, 13 Oct 2022 00:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BA4C433B5;
	Thu, 13 Oct 2022 00:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665620596;
	bh=wrATyctV2ohV737W7q/40WRodm8LvGQCPuOWW++0vFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XxXF7tK8dzgPfW2k5xFYJ4rxjzyWqUrUn4+A3wwF64aNWC3gVI0jnXdHpIwwUwpWJ
	 +qxUH1gjR6P/6U0a7njpVWiJENnhsEsQUa++l0KAmhSbpuuSNTSfBsVKBEl1e/R5gz
	 BLgebmIJyFa7knIQvtzBnl2Vs1ct/RBLdAlJGo0CW2Q68i/O4kV3lVQYHVV8RnEpaC
	 fUIgKVZu6jlucVSyxD/Mc0JXfT5cCjSEUQ51Wx7H33im/V9dKmPMmneAlzNq+tl1kM
	 ujj7kR9q8zp3ggqui8LFhgx1Ruzg2eo2xj8Fbr7SezLJrIh3u7pm318KN1dCLSI6F5
	 lJXqiEDQWV+DA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jeff Lien <jeff.lien@wdc.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Chao Leng <lengchao@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	axboe@fb.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 41/47] nvme: copy firmware_rev on each init
Date: Wed, 12 Oct 2022 20:21:16 -0400
Message-Id: <20221013002124.1894077-41-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221013002124.1894077-1-sashal@kernel.org>
References: <20221013002124.1894077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_172316_805952_4F7C16F1 
X-CRM114-Status: GOOD (  12.49  )
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

[ Upstream commit a8eb6c1ba48bddea82e8d74cbe6e119f006be97d ]

The firmware revision can change on after a reset so copy the most
recent info each time instead of just the first time, otherwise the
sysfs firmware_rev entry may contain stale data.

Reported-by: Jeff Lien <jeff.lien@wdc.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Chao Leng <lengchao@huawei.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 76d8a72f52e2..3527a0667568 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2732,7 +2732,6 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	nvme_init_subnqn(subsys, ctrl, id);
 	memcpy(subsys->serial, id->sn, sizeof(subsys->serial));
 	memcpy(subsys->model, id->mn, sizeof(subsys->model));
-	memcpy(subsys->firmware_rev, id->fr, sizeof(subsys->firmware_rev));
 	subsys->vendor_id = le16_to_cpu(id->vid);
 	subsys->cmic = id->cmic;
 	subsys->awupf = le16_to_cpu(id->awupf);
@@ -2939,6 +2938,8 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 				ctrl->quirks |= core_quirks[i].quirks;
 		}
 	}
+	memcpy(ctrl->subsys->firmware_rev, id->fr,
+	       sizeof(ctrl->subsys->firmware_rev));
 
 	if (force_apst && (ctrl->quirks & NVME_QUIRK_NO_DEEPEST_PS)) {
 		dev_warn(ctrl->device, "forcibly allowing all power states due to nvme_core.force_apst -- use at your own risk\n");
-- 
2.35.1


