Return-Path: <SRS0=Gozd=AY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EFBC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2020 06:26:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D885C20674
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2020 06:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T3cXA/t5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D885C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=O12eykdYnn9L0COvnpGNdrxC2yjABH+Pm05KARFLvSE=; b=T3cXA/t5GgKX2lf6q6E/J64tG7
	OIwHGKCSToaPX4Y1FjHMj9jJ3n1kg+ryw74IC56E/aH02XWjh71ekaUpGmmF3rUVz0kjngZZuP1en
	nSZ0NV6L0btCRNgso+RR1dL2CgrVX+Z2b1RZ8Tu6aqgP6lBUC0Y8ISuRvRdUTlQ1/mWaL/vPG4HPQ
	BysKqh9vWkMs1i6q0lNysxpKkpulb5KXCB1rImzwr9yUuWlDkwgFW2uHcj1H5pWAq9qWr2LRh7RDX
	INuwvj87BPG2B4W/85BW7lmMFoBT2PCXe5JbtIMSA6TugWQfQXiXddz9jvaOBA+8Musc0eIw4TA4G
	CI2EH4fA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jurun-0003bb-Bn; Mon, 13 Jul 2020 06:26:13 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jurud-0003X6-7h
 for linux-nvme@lists.infradead.org; Mon, 13 Jul 2020 06:26:06 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01f04427;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0U2X9-sE_1594621552; 
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0U2X9-sE_1594621552) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 13 Jul 2020 14:25:52 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH] nvme: Remove redundant validation in nvme_start_ctrl()
Date: Mon, 13 Jul 2020 14:25:21 +0800
Message-Id: <710eb90d9c1c125bdb37aae31ddc41a0f9782fa6.1594621435.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200713_022603_529384_5B2A948F 
X-CRM114-Status: UNSURE (   8.45  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
 baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We've already validated the 'kato' in nvme_start_keep_alive(), thus no
need to validate it again in nvme_start_ctrl(). Remove it.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/nvme/host/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3d00ea4..a95e26e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4313,8 +4313,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 
 void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 {
-	if (ctrl->kato)
-		nvme_start_keep_alive(ctrl);
+	nvme_start_keep_alive(ctrl);
 
 	nvme_enable_aen(ctrl);
 
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
