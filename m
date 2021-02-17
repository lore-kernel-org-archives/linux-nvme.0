Return-Path: <SRS0=TApw=HT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199FCC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:10:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0BEF64DFF
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0BEF64DFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IBcTI/Lh/QCn5zawjH6aVGL64xncgyHFekwAPL6NcW4=; b=qmIMCPWjlObFCDJQvbpJWHN6A
	FpKgjnim2BDlSOoJzMAC3ErLDKO3OkK5qr2MJ81p9vtwmH1VwJtAvNxDh7KKEE7K4ND7jpCV18s/T
	1ckob/ocdGG01GAkO9LCpdZ+Y74vq5LcPMrgioQtXcMl3thZ/COJxFxIKiQCNieiKF2nXZEx9TUn8
	9yQtAzrUAX8wyLKg/K57vtDa30hjCMjACE/abMxx8U7yOe1QJjc/tZmy0+nT5ILqAED/epeeFRoLk
	tv0wok/Hh7WwFlNo5P8FGvmK+a0X3jFzlPDeTmVqGdKls+Nvf8xDvqNaLTtcYDHiEXrwFm0ZbMjH5
	bOezPFZdA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCAQe-0007WS-FL; Wed, 17 Feb 2021 00:10:52 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCAQc-0007Vj-Cb
 for linux-nvme@lists.infradead.org; Wed, 17 Feb 2021 00:10:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613520650; x=1645056650;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e1TzgnHu9v+z5yqxv+kHmsmei7vZc8/y4cShVkrdeH4=;
 b=E75+E2PoWJvbhoPIBPSVcq2qUPjV3tlNHIUMFMLLBX7hETJ46L770N22
 NkuhvCQXG+UUfTGs3OboEICtIEEtj2s5MAMDsDaEiXUsyfipdxFXhzitA
 hmk3YC2zE4pkobc2rux2sBUPj+7iuLMYTzyilc/2+bhj7GDu069pCATzZ
 RqWzRxmSCiSBHftjqUpwoyaC6s0wPxisdoliKWatK+/H0fO3hjruYvZuJ
 c8CThKcp1SqyAe6q/j0cc7LC+qcSVfV+lB8tBC1ExqIvmHxa6WzBQ238Q
 aLJRzFx6A5FMkmIj2sVxoZn9AYdJQhEwwB0TRn/sUO6+i5AakSTvV/KsB A==;
IronPort-SDR: +NFDyNyw9sFnrItWnp/aHy76txDtAe9ED3v4iv/LjyuEExXS6qMYCGc4Jir6XQtOAMzZOfKa7Q
 1rbWMC+BJf2l7SQa0XKf4tza1XZic4KKNG7/uHBAqHhNBScrqRBz0RQx1x+V3AYHw3/mhwL4Kl
 xAH4HJy6Mtz8iaRABIXDXZYT4XYcCEky3JiXHRKrUymolcDmiQCcjv3AtsxsACYOTgOKUDcwaF
 y8wcJS6PBnbamjYj4mPUaDxXq0BWeaS63uLeYhvwzNfrynixk/sSJAuQVLUMfasiOsgBogSJtP
 Dls=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; d="scan'208";a="270629550"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 08:10:49 +0800
IronPort-SDR: d8v443D/bXWpPeQLBsuNAo+p5Aov/ZUhz1Yh/zaBxtT3IZNSSCB7PVwUcCPB0IJFl1sxwVnXEj
 /uBzmJVn38uUlxBPLCe/FWL+X+ccPAB2W2TLh+3CEOH6oj3+y6tnCPP80jk0sUUGPVMRrG3rlp
 orqhSudgcrXlPO9+1rlSBa9RytS3P279VV7wbfj7asmmdjLFadNcroHgULjv+tXkDmUEj5x1nF
 NTwJ0JXL9VfPUa6X2J9E6+CTQREs0xbVlCcSVxMzv1awFL3vD8jttw3zMlzwtY/LJuBGvyyXqn
 U7t4rbL5Wyam/ReJ1W9/3n0b
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 15:54:21 -0800
IronPort-SDR: DHGf2BkhK0quHV3gg5JsNyzM3Q5+IDN2V0aBnAw+AA5Cfcpc7k38GEWT9k1oUa16yLQ6HHELIs
 pYApqQRzZHsrwKDZN1RQN3U0cvZzO4KTK+61mZnPcc4dBfq/gKPLOyJ+kxraCS2aBENA/D3YBS
 ukxXdnUCMMHHqp1W4LLg+n5JlVEV6fGiYxE8IV6kSZ9N0YjA9zHT5q/RQ7t3WwTLi2+OSwH9R/
 toBao7BHYUEliLdQsolwyDuis2/oFO76niqstfwPIeDD71PSgTRBtf93nEASo9Z+0KgLrsHBxd
 Kcc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2021 16:10:50 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 02/14] nvme-core: don't use switch for only one case use
Date: Tue, 16 Feb 2021 16:10:20 -0800
Message-Id: <20210217001032.25741-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
References: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_191050_601814_D6412E76 
X-CRM114-Status: GOOD (  12.08  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

There is no point in using switch case statement for only one case that
takes about 5 lines.

Remove switch case which only checks for the NVME_CTRL_LIVE state and
use simple if statement that only takes one line.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 70042e111efe..2f6b89f6309d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3254,12 +3254,8 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
 	struct nvme_ctrl *ctrl =
 		container_of(inode->i_cdev, struct nvme_ctrl, cdev);
 
-	switch (ctrl->state) {
-	case NVME_CTRL_LIVE:
-		break;
-	default:
+	if (ctrl->state != NVME_CTRL_LIVE)
 		return -EWOULDBLOCK;
-	}
 
 	nvme_get_ctrl(ctrl);
 	if (!try_module_get(ctrl->ops->module)) {
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
