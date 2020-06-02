Return-Path: <SRS0=vW9m=7P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2457DC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2020 02:41:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED26D2068D
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2020 02:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sHTccaNI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hUDRkSkR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED26D2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rXSX6IkXykBWMaA3j1B0leay3/1ORY3DUAT/9SFska8=; b=sHTccaNIV7ZnD3
	LQ4mu3ImuTNqKIVmh4dd6M8Y+LGIhnroi+b3QAJJQfpBiZD5T0cJB00MmKzRwORlws+CabcXzEWCg
	q2/obgbwCyduMVCwKcyAGlaFmsUgvjPj+24P6xvN5nA0EposWX73jIzeVR6z2LgeLCAR7xup0hm4C
	GWFlB0iFxNPf7Dd2Q6Q+37Jn0v2YktyAJ9jewq55ClUqV4PD5WLVolcmqNbQINsTw6vnrWxkZoSIK
	PXPP9iccHA/8xzRZQsLfVh0GPWPHk4ra/8i62wyKdVxkO4Gz40ZynETmALSWoEgRmZeAH4QIIEZWR
	3gzbkNbDb2X3np7VcZGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jfwrz-0004j7-BX; Tue, 02 Jun 2020 02:41:39 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jfwrs-0004c9-DV
 for linux-nvme@lists.infradead.org; Tue, 02 Jun 2020 02:41:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591065692; x=1622601692;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KFUQMfddMDnWSoNM9D/rcjg31ED870dQvT/0AOs2Kbk=;
 b=hUDRkSkRU1hC1rJaw14TcP0EbcSiPUzo1MXIzLsoIdJcYw1QSE+smMI2
 OmmzhjNSm+bNlhqCd+72GGLzFSTzU5/DpidQHF+Pppnr23/+9qYpbAiLa
 tVa6f/JAI6GasFJy5DXuBYdZoAunNAznf3hdAOBhs6Sm8zXEiwBdWEKx6
 F9FmM55tn2wo6Y7dfbDtZjvF4t6i8vMzhpz9W/4vz8qbnOmRTWMRJ3dPG
 spuz0jVWxpmiM9OOFIO76w7hLIP4s+tON7nC2fSdouWsSzATx7q7MQp4M
 2WYLbYWgt7Z+0w0crDddUCdYkSvFpeQawgorPSKq8q8C6ryq2coMN7Qf6 g==;
IronPort-SDR: JwpIx2TsScgnS0y/vxjxFTCA3CGlYJybEhdU8G6UoQZHwVNnmqnIyqZlJzCQU4Q6WSl/HqAvOo
 IqZo0v6MmYiyRSJlIuii4pktE+y0V08M1JAddTzIaEBig2ZJ5sUlx4BbKDQGQf3h/2LD6KJ2ZB
 QqchMgdi94JBG4fUb16S5obdqdwPfZOwlqNqJjNuz9W5hTDQlPSGUxg62bZ2qTAVt3b563uwyy
 /A6z34AAGq1D3u8uYHG0MF/B+FGMELSyIwH73Hdnb20bsukx3Dou7eOFrKCgSkWit5XsyC9jhF
 8a0=
X-IronPort-AV: E=Sophos;i="5.73,462,1583164800"; d="scan'208";a="138988918"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2020 10:41:30 +0800
IronPort-SDR: 7zk9Us+Nn/ygUp4n1/N8e3iyRzUPdHMU4lRBpTuf7MSgVeN4yaV7PN245YVB2pWCCkYqq9F++i
 UrVeefYKzwTN7jJQVedC//Lbs14J4ycHo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2020 19:30:38 -0700
IronPort-SDR: 8M+R6zGpWT8KoG1ofUteKqzEDI53ESCYVgEkqiD4U/2r/i3AkTRiQKCgfvpn57PKsAZWWNXncz
 tqn/za69P4QA==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 01 Jun 2020 19:41:29 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/4] nvme-core: use u16 type for ctrl->sqsize
Date: Mon,  1 Jun 2020 19:41:12 -0700
Message-Id: <20200602024114.5153-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200602024114.5153-1-chaitanya.kulkarni@wdc.com>
References: <20200602024114.5153-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200601_194132_519199_E53F44F1 
X-CRM114-Status: GOOD (  10.55  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In nvme_init_identify() when calculating submission queue size use u16
instead of int type in the min_t() since target variable ctrl->sqsize is
of type u16.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8d05dbf29d76..d463b3060543 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2866,7 +2866,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		return ret;
 	}
 	page_shift = NVME_CAP_MPSMIN(ctrl->cap) + 12;
-	ctrl->sqsize = min_t(int, NVME_CAP_MQES(ctrl->cap), ctrl->sqsize);
+	ctrl->sqsize = min_t(u16, NVME_CAP_MQES(ctrl->cap), ctrl->sqsize);
 
 	if (ctrl->vs >= NVME_VS(1, 1, 0))
 		ctrl->subsystem = NVME_CAP_NSSRC(ctrl->cap);
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
