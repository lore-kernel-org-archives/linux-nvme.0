Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C75C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 06:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3hQNxyY+z4elbyuslI+T7Vx3kWk+2FTo2s8Sppg8zFY=; b=GtFh4MRv5bLYfoeJt8zOBSqfUe
	jKa0rwHV1AcWdgwnxYjajKNOELjBS2ZJKqRYh8vSrAzUpoInHB+T+j9sF/Ng6hYVhV0SyJcJV4Ljo
	4wFfwLEMppjYgLcCT0nxnCUsU8TFCeWgolIgYdoqP8BsfgubM5JKy2ZS4dNdcXgMWK66Hjgb4keKZ
	k+E9vbphQrsQEebUqJXaudToQSLllBDHUzdi3pVY5a6ijA69fbS4yP3d3qjFDPXYpEu0mmHjI4udS
	BGES/NnHet6G85r5N8aM934YHy/CBoIh6pj9e9QsRcywgEO8gDuxLYz98uu+/yXOcgNrXqizQt7sy
	6uTq4rNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDIo1-00Dn70-07;
	Wed, 13 Dec 2023 06:33:17 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDInz-00Dn4H-0K
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 06:33:16 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VyP6OJp_1702449185;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VyP6OJp_1702449185)
          by smtp.aliyun-inc.com;
          Wed, 13 Dec 2023 14:33:10 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 2/5] nvmet: allow identical cntlid_min and cntlid_max settings
Date: Wed, 13 Dec 2023 14:32:49 +0800
Message-Id: <1702449172-8920-3-git-send-email-kanie@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702449172-8920-1-git-send-email-kanie@linux.alibaba.com>
References: <1702449172-8920-1-git-send-email-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_223315_290125_10D83462 
X-CRM114-Status: UNSURE (   9.77  )
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

When the user wants to restrict to only creating one controller,
they can set cntlid_min and cntlid_max to the same value.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/configfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index d937fe0..2482a0d 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1276,7 +1276,7 @@ static ssize_t nvmet_subsys_attr_cntlid_min_store(struct config_item *item,
 		return -EINVAL;
 
 	down_write(&nvmet_config_sem);
-	if (cntlid_min >= to_subsys(item)->cntlid_max)
+	if (cntlid_min > to_subsys(item)->cntlid_max)
 		goto out_unlock;
 	to_subsys(item)->cntlid_min = cntlid_min;
 	up_write(&nvmet_config_sem);
@@ -1306,7 +1306,7 @@ static ssize_t nvmet_subsys_attr_cntlid_max_store(struct config_item *item,
 		return -EINVAL;
 
 	down_write(&nvmet_config_sem);
-	if (cntlid_max <= to_subsys(item)->cntlid_min)
+	if (cntlid_max < to_subsys(item)->cntlid_min)
 		goto out_unlock;
 	to_subsys(item)->cntlid_max = cntlid_max;
 	up_write(&nvmet_config_sem);
-- 
1.8.3.1


