Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A0FC48BC4
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Feb 2024 03:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tGM5KLLESS/1WL4YuYWItTqaiJx273aXFAvZosbzi4w=; b=HzGoP69c5x7ieWm5Po/TKyPour
	7j4bztEMsG+D39V2V7hOlruDipH1lfR4q9ts9Vt8welrCuH8wyrLhd0hk4zZsgOtf6EEgJgsTKPhs
	gmAO5d2jP+p0YXgV5fxrPCjGczDdgkM2T8zsCnT+a5FsGb7GDWWJmqk/enu2pfDxewZEEDI7RiC0a
	xk3QzkIW/8avg5V8PcyZagxf+CYOUFZKCmAf7ruOXz7wF/V7qHk4dkOTUgEApYNCBMdJm0QS+TUhi
	mTVkBPeFtb2BfJab7FUeu8aAxazkrzcmAh7VZn7v52Vf9Za6RAjItXD+KJOjPruNh/IZpqbTYWKs0
	V3WcifyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdMGa-00000007gnN-1zHj;
	Fri, 23 Feb 2024 03:30:31 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdMGJ-00000007ga6-1vrv
	for linux-nvme@lists.infradead.org;
	Fri, 23 Feb 2024 03:30:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708658996; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=tGM5KLLESS/1WL4YuYWItTqaiJx273aXFAvZosbzi4w=;
	b=ii1bzjhtQX2JiRVw8O1Qk/LoSAQ/kBtIIJjLkkpJ0O67xsJlKQF9qyvh7p7x/g5mQ7b80Jk7PXIM+Htt+agVmMVCWtOjMTecdvePMxaogUINhS9ApYoSsLyK1rWNuI4nIeW5XWXBAf4XPU+ZmqsNmTKtzXNrskqLPYUrrjDyEzQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W12kC4T_1708658987;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W12kC4T_1708658987)
          by smtp.aliyun-inc.com;
          Fri, 23 Feb 2024 11:29:53 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: move nvme_dsm_range size check to _nvme_check_size()
Date: Fri, 23 Feb 2024 11:29:47 +0800
Message-ID: <20240223032947.55086-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_193012_729751_AA5990F3 
X-CRM114-Status: UNSURE (   7.60  )
X-CRM114-Notice: Please train this message.
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

Move nvme_dsm_range size check to _nvme_check_size(), and remove
redundant same check.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5cdd22f591f9..848d4b896fec 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1800,9 +1800,6 @@ static void nvme_config_discard(struct nvme_ctrl *ctrl, struct gendisk *disk,
 		return;
 	}
 
-	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
-			NVME_DSM_MAX_RANGES);
-
 	/*
 	 * If discard is already enabled, don't reset queue limits.
 	 *
@@ -4602,8 +4599,6 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
 	ctrl->ka_last_check_time = jiffies;
 
-	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
-			PAGE_SIZE);
 	ctrl->discard_page = alloc_page(GFP_KERNEL);
 	if (!ctrl->discard_page) {
 		ret = -ENOMEM;
@@ -4823,6 +4818,8 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_directive_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_feat_host_behavior) != 512);
+	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
+			PAGE_SIZE);
 }
 
 
-- 
2.43.0


