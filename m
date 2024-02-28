Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE13C47DD9
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 18:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=alKHL8CM8KKSBdPN6Bu4nIeV2UKJk208uMbG0wiOBj8=; b=LX3WuSQpJ1AEwcbMDH2hd/8IoZ
	izpE7tm/GzemMNG6QVnfSksQgAltMCtMSl0YfiAHSSxNuGXvRuqbbbQrae28vNwQvlOZm3ywGDN9N
	uKWGmJMcnwsNYRhTsgcBmhDmd1N2u9lqt5QF1piQfitlb22FZCz15NB4HbaF3NDlmtk1zJrDpj7BJ
	TgTTZPD07LWFb5JZzfxqP+6b1jliwcDrHX+MRpAVpceDBAvb/LGT562HLPPuyBjepplB2qy1UUIwj
	CfYyBmdV+3RHIxlSXgPus7lOVdmFqBrXGRk+wDLmQQfs7uEghBW80a6272DL101wyVr8YN1pIHWf/
	F11P5rng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOQY-0000000ARrf-2OJn;
	Wed, 28 Feb 2024 18:13:10 +0000
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOPp-0000000ARIM-3BS6;
	Wed, 28 Feb 2024 18:12:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: [PATCH 18/21] nvme-fc: initialize max_hw_sectors earlier
Date: Wed, 28 Feb 2024 10:12:12 -0800
Message-Id: <20240228181215.873854-19-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228181215.873854-1-hch@lst.de>
References: <20240228181215.873854-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Initialize max_hw_sectors and max_sectors a little earlier so that
nvme_alloc_admin_tag_set can rely on it to set the initial queue limits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/fc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 68a5d971657bb5..537008dd2c616c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3113,10 +3113,6 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	if (ret)
 		goto out_disconnect_admin_queue;
 
-	ctrl->ctrl.max_segments = ctrl->lport->ops->max_sgl_segments;
-	ctrl->ctrl.max_hw_sectors = ctrl->ctrl.max_segments <<
-						(ilog2(SZ_4K) - 9);
-
 	nvme_unquiesce_admin_queue(&ctrl->ctrl);
 
 	ret = nvme_init_ctrl_finish(&ctrl->ctrl, false);
@@ -3542,6 +3538,10 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	/* at this point, teardown path changes to ref counting on nvme ctrl */
 
+	ctrl->ctrl.max_segments = ctrl->lport->ops->max_sgl_segments;
+	ctrl->ctrl.max_hw_sectors =
+		ctrl->ctrl.max_segments << (ilog2(SZ_4K) - 9);
+
 	ret = nvme_alloc_admin_tag_set(&ctrl->ctrl, &ctrl->admin_tag_set,
 			&nvme_fc_admin_mq_ops,
 			struct_size_t(struct nvme_fcp_op_w_sgl, priv,
-- 
2.39.2


