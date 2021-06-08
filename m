Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E800AC47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 03:46:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA36F60C41
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 03:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA36F60C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=oUi2OP4ghY7ZbMxrwIGLn1mhx4xUMZT4l+e5qBfEdNM=; b=4qDiZRp89fioCV
	p48mh8YaImmi0xaMpMrnWun+gwB0/g0J89JGBoDVG+GwSI1J1JfHdhUpllcaP1hcNk/ueQCT1OQXc
	L446UCzUE3V1+1t4c8lINU+R8dhKwFk5D4gHJWwOhXWLSy3AhUjf02fAjKBZvYoM0WRFqRI8S6cJe
	b5knuVcDQ0r4pk2eGA9sjTPdXgU9NbjspwrGZReXpIbPIhCCsQPs9uYHdFZk8ksfXrFz1VXJX0e7+
	wNBn54rdPrhfxB7iRhn2XIX7OVYrFErlVsbocwsjWA04fW5Be5d6Fz44/kkItBbDmiT249qz0es8z
	idqACdkAx7qjf5NYQyKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqSh6-006LaY-W2; Tue, 08 Jun 2021 03:46:25 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqSgs-006LZ7-CX
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 03:46:12 +0000
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Fzbdr4sCPz6vFb;
 Tue,  8 Jun 2021 11:42:08 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 11:45:59 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 8 Jun 2021
 11:45:58 +0800
From: Wu Bo <wubo40@huawei.com>
To: <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
 <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <linfeilong@huawei.com>, <wubo40@huawei.com>
Subject: [PATCH] nvme-multipath: combine grpid and ANA state checks in
 nvme_parse_ana_log()
Date: Tue, 8 Jun 2021 12:13:36 +0800
Message-ID: <1623125616-629270-1-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_204610_621432_DDDFB29C 
X-CRM114-Status: UNSURE (   8.72  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

Combine grpid and ANA state checks in nvme_parse_ana_log() to
reduce repetitive code and more intuitive meaning.

Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 drivers/nvme/host/multipath.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f81871c..19fe16d 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -522,13 +522,11 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
 		nr_nsids = le32_to_cpu(desc->nnsids);
 		nsid_buf_size = nr_nsids * sizeof(__le32);
 
-		if (WARN_ON_ONCE(desc->grpid == 0))
+		if (WARN_ON_ONCE(desc->grpid == 0 ||
+			le32_to_cpu(desc->grpid) > ctrl->anagrpmax))
 			return -EINVAL;
-		if (WARN_ON_ONCE(le32_to_cpu(desc->grpid) > ctrl->anagrpmax))
-			return -EINVAL;
-		if (WARN_ON_ONCE(desc->state == 0))
-			return -EINVAL;
-		if (WARN_ON_ONCE(desc->state > NVME_ANA_CHANGE))
+		if (WARN_ON_ONCE(desc->state == 0 ||
+			desc->state > NVME_ANA_CHANGE))
 			return -EINVAL;
 
 		offset += sizeof(*desc);
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
