Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46760C54E41
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Feb 2024 03:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lYYGnac+yr2aKcoqmhHqm4eS279syDZjIVgESYM1q48=; b=po23QuC90bdWIbJb4IUSxfqa2N
	kHmoA3WZ1kPFOBhvR2d1Lfrk8hgbeEfNkKJHZML2BRmvWO8l4LsJ8xGSZLCcW5m2wTP5/9mXVwr2Z
	b0z7gMuESYa0VNCXCH18cXS/2+XAox7rkdWP7bKydn2Tg1uXTIk+YDIYWFMXs5+sVdmNmRTtSagz7
	QNTL/zkj+UxvOqziD0XjioI+NY3RBOWD/l9fcwjUR94WSMOHSP/XoknyiNZkCwszSlq2QgA8NeRf5
	BCRV1/f4LR+fEbsbSI0xdj2SZq0movh0/LvrQvF77FkFh5Mh5hITepQhezcaI4VeD1YeilzjClmVW
	OsAX5x2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdMGg-00000007gwc-3fj8;
	Fri, 23 Feb 2024 03:30:39 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdMGO-00000007gi1-1V91
	for linux-nvme@lists.infradead.org;
	Fri, 23 Feb 2024 03:30:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708659013; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lYYGnac+yr2aKcoqmhHqm4eS279syDZjIVgESYM1q48=;
	b=adDX2Y/YqvkdjO0ZpkuN3UNU9XENjQH2ra2yJIZRjeLKcOjNtV8J8fCjyrhKSvrRzFsgwkS7rl459HvTEQwW9U2FOcPthT6aswtu086uklzNXl/cCdDOirM6+dgfcxzyH7EWiVH4/gcsVvRht8vUf1vrw2Ea+wjZ9uyeYax83XU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W12gwfW_1708659004;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W12gwfW_1708659004)
          by smtp.aliyun-inc.com;
          Fri, 23 Feb 2024 11:30:09 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-fabrics: check max outstanding commands
Date: Fri, 23 Feb 2024 11:30:04 +0800
Message-ID: <20240223033004.55756-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_193021_782782_5CBD54A9 
X-CRM114-Status: UNSURE (   9.94  )
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

Maxcmd is mandatory for fabrics, check it early to identify the root
cause instead of waiting for it to propagate to "sqsize" and "allocing
queue".

By the way, change nvme_check_ctrl_fabric_info() to
nvmf_validate_identify_ctrl().

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0a96362912ce..5cdd22f591f9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3084,7 +3084,8 @@ static int nvme_init_effects(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	return 0;
 }
 
-static int nvme_check_ctrl_fabric_info(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
+static int nvmf_validate_identify_ctrl(struct nvme_ctrl *ctrl,
+				       struct nvme_id_ctrl *id)
 {
 	/*
 	 * In fabrics we need to verify the cntlid matches the
@@ -3117,6 +3118,11 @@ static int nvme_check_ctrl_fabric_info(struct nvme_ctrl *ctrl, struct nvme_id_ct
 		return -EINVAL;
 	}
 
+	if (!ctrl->maxcmd) {
+		dev_err(ctrl->device, "Maximum outstanding commands is 0\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -3232,7 +3238,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 		ctrl->iorcsz = le32_to_cpu(id->iorcsz);
 		ctrl->maxcmd = le16_to_cpu(id->maxcmd);
 
-		ret = nvme_check_ctrl_fabric_info(ctrl, id);
+		ret = nvmf_validate_identify_ctrl(ctrl, id);
 		if (ret)
 			goto out_free;
 	} else {
-- 
2.43.0


