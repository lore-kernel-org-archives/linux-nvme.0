Return-Path: <SRS0=TApw=HT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591E0C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:11:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210AB64DDA
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210AB64DDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4DKTxhO9Gp4wttP50mpsf+UHd1hsGkSDvvJMTiWPGqA=; b=w5BnaiG8HA2GARgok+cx645jb
	lkkoPHxq7naTDqL4puK59IJW4dBsic9j5GIhwHI3c6BMGqohfTfsITbxl6X2n41GR/Y4OTajXlwkY
	QeH2kVGvjpNOnh245HE6jDaWEAwnTh02ycLktjx2537/KXSAevMCFKezGd70VfCdn7VtNdZGh6H/w
	MTuFn+prbj1wylywnikq4ds4lgMNbjnxULG/RtNE7Vi56NtdS8Ig06KhZaUP7Pd+Y7tE8hvEjb1nY
	zkACFCc037VDz9V5Ss9OOIFoRmtVTq57wgPZdSAA21Ij3lPuVjcgxr5Tdsj4rP8tL2iaLUbrqCxkI
	x4JLlY38Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCAQu-0007aq-Ti; Wed, 17 Feb 2021 00:11:08 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCAQs-0007ZS-Kk
 for linux-nvme@lists.infradead.org; Wed, 17 Feb 2021 00:11:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613520666; x=1645056666;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hirTfHPdIfT83yQBwJs0Tmpud5YKSBXqHqKDMMNCw98=;
 b=gcm9Jww187/5CtBn0EMze4maVc9fShIa55cINYEetxDR6zx4bGavk0wt
 +zY2Wx3c9ujVgr/K18KBxaA7Hknyz0b4WZVLVBV59Dr8U3AgB74WJjJGz
 8oBrJAS1qdIrimkylBcjkFfLj17DMWxHpexEUoUjupqfLUOyziDzf2S8W
 V9gqrZPiYXpnxEqb48lmgHqITHyOtoElgXyF2XVuOGlE0k5Pte2X5908r
 ubeC0TGJfIcSWiar/YOffB7d7xUzQAAtYmnXU+o+Lg+zIOKsmA/D3Mb9O
 APNzSW1z9F/QLcv3CN1ITdQ5LevscyAbXNYAVFkPBpSOZ3R7S4lXXMmsq g==;
IronPort-SDR: 48APHxhDEWA/idhKjmzUrOkYjEX19cpW+FVy3K+gQ01ST2ycv/5uwUMMo1ZyiEWWnV+Qbhuu1P
 uS0TiFt+w1P8Vpuv7ehlCP9nU/FG03JIq02GfrXwxSz6OSiM1xc9L3LZcP1eSP1PJNSZ598Gw3
 E/ckrIawwWrWDh0ZdEQI3Unof3OUsh+Nt5DtfjoFpp929rd/youfac6GTETaCEaZLUyZozameE
 4mdSxBJ+GnL0LmlEODZLb6oO1TbDUq/AYR62ZPlaBDvtFRVmJ6eVGRZXsskZmOlFQVwhjM6M2V
 2hA=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; d="scan'208";a="160098686"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 08:11:04 +0800
IronPort-SDR: VY2Ppz9S45NLLXIJ5BZqp4BIlXFN033Q6lPSJ52fubqouSUfok6nDIEf4bRaBQLQSFkDcXWyUO
 W+HvZe3NLbPTD4ZCCr5DdBpPDYOMg88RKb4ZtWWneMuklTJVsaAnxPg3Qz1TXgUSGz/o7sFja2
 J/0+Vg6/8ZeMbVjZms2ilgD7GWwAPhQisDzC6Wc+MkB5Z5mgaaiq+LgtS3rqt74jY01gZrfTVY
 DTGCqxVyPvHP6gVG3CJE38QpjjOz/OJiCQZ/fO+juUhuJcHLu7RY/JbtcP07MqtYqzEIKQ2WFS
 8BbdnS0hlndzLenHdvaAe7F3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 15:54:36 -0800
IronPort-SDR: 3WvkzhreQ4435V+Idn1qKwLDnT2clp3nW2EPmFw0DUyLgALtrMg88W2mOvSib4vPCtlGG45Lpy
 ayJj8u3RTrd440oRKifZQ658d7Prlo/UDGCiYs3acsUKctp9ZXwDkoIGdbd0W1C/ukWBcUdSrL
 fPX1QSbbBRSIpIPHRzVG5RTiNSWkCl7uR4HaMhW+Xe0huC2yfhmz4Is6AFoe6x5xFL9d3D4siv
 JcGLnDnqx68rp95mdX4qChXzD64MTwUwcbKCEYUkR9RZoaWGHbdKp20Yk5fi7sPaWLcjN3G6sx
 rtI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2021 16:11:05 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 04/14] nvme-core: fix the type for shutdown_timeout
Date: Tue, 16 Feb 2021 16:10:22 -0800
Message-Id: <20210217001032.25741-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
References: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_191106_876520_F4754423 
X-CRM114-Status: GOOD (  12.09  )
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

In the function nvme_init_identify() we calculate the
ctrl->shutdown_timeout value with module parameter shutdown_timeout
and transition_timeout with clamp_t().

The variable ctrl->shutdown_timeout and transition_timeout is of type
unsigned int.

Change the module parameter shutdown_timeout from unsigned char to
unsigned int so it stays consistent with the type of local variable
transition_timeout, ctrl->shutdown_timeout & clamp_t unsigned int type.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cae526757e03..840c32c755b2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -40,8 +40,8 @@ module_param_named(io_timeout, nvme_io_timeout, uint, 0644);
 MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
 EXPORT_SYMBOL_GPL(nvme_io_timeout);
 
-static unsigned char shutdown_timeout = 5;
-module_param(shutdown_timeout, byte, 0644);
+static unsigned int shutdown_timeout = 5;
+module_param(shutdown_timeout, uint, 0644);
 MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
 
 static u8 nvme_max_retries = 5;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
