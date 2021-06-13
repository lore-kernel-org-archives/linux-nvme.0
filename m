Return-Path: <SRS0=vQ/w=LH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB69BC48BDF
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Jun 2021 20:03:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF6561245
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Jun 2021 20:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF6561245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wg/bzDRwIbJabMZrGVLqZuzzTRx/ztK2NVpTmL11cys=; b=PsKbMllV9hK962
	VTEPjf35Oy3ndG+p3e2fETztct6bTZ2axOjNc0b83RqrbRnBZW4Zc0FFv0585dmybhPeyAsCls+Jb
	hM5siEUn6tYUhexIL1LcTWPVnsXI/lGKP5LOKRuGKAM7Ya8s/McUQJN/zwGXroXDVO7VEwhqjsErZ
	f4nk0CmG2Wj8jnuz6t0kOWovwxeN5bcnoHgMiOPsVYSS/FmKwjqopk/4aOIcrpp4TU5WnmnAisHca
	62daGEwQTQYESWXURosJ77k4eCWKb+s7YrxQIVX68g70/11dQRIEqMdyetqF5YdEgn/wACD4REj1Q
	1jlW5BURu+FZY+bnc6lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lsWKV-00B6lZ-AI; Sun, 13 Jun 2021 20:03:35 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsWJy-00B6hW-87
 for linux-nvme@lists.infradead.org; Sun, 13 Jun 2021 20:03:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623614584; x=1655150584;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PUeLtYqjhIUlshhTLbQrBVrtTSPP7LmAaPpv7C+9lY0=;
 b=kk9KLrhNUegF/7KMeDNr7kxqP11DqX6SU0es1flOiST4iPKwqSkUShJF
 sdslSnCEFcxhIDFr39ZM7SPl5UrQBhae3PchINLcgKcKmEwETPPk1/y7a
 XcAouKlIzaOPHHljUWnYvZrtmrT5UtVfQ7GvQtKaCV3z4dRImLf3RBev9
 7OWWfGdMY1k+dCGJglbP0zAIP7jjJYDxlVhBdwlUpUfqJuOvbH2ewl9sU
 Y/Cif0O36ArcFGAMyuuZrObl1ySkCV3Pm+EJa+TdSzsDsFB3qYpYKn6um
 I3Wtsalb2DcCRmr+ldVi0GAtRaIQkzjNUyuYaE+sTZTbWxpobiu/jRw71 g==;
IronPort-SDR: bXeRyOeDul1dV0MVkoUyIk8FVMy1HvPuddAyPq7Pk8tke9yfrAh8IM4nDu/zThJdcJ3L8DXE0D
 Ms4reDHUwTGvVIQWyUUFBvHT04pbePMVMWRW9Brp9WfB9OFpsNcU09yg//4Us63FgQ6XOMCBP5
 9NMRJT5VYYIeLmlaSBC4e5BXeY2cAPu3kwub1U4aYdEexg/XMfQzK3wjHqLuqbCUUNs5nQ56hz
 laiAEbPkZSFbqXf1v+nmFt0nJnAg4MaF8bLe2J0iobBvCVWjhDR5yrYIwwYWF7HbCcU3HnzDVM
 KPU=
X-IronPort-AV: E=Sophos;i="5.83,271,1616428800"; 
 d="scan'208,223";a="275545732"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2021 04:03:02 +0800
IronPort-SDR: 4SA1iNlTDxjHsT/EWM1tUb828lwKb+kgultXmGHYM7eyFbVS5xNLTFAmcEycz84I990naUUVD3
 8bQ8vetIhoBhqRtMwaXMTzSpsDDw0qSXrLQPcWu9VckEqiT54c8WceVNDGIm8/TtlzyCZbImbN
 Z/2YJ+fc5g2DUSjXT69Fm93Fp6UXJ9yNd9ZO1r/Ws0Mv94nCZoMYXLBoTu+jc0YTlhkD86T5el
 b2vOeDlM/4hIvXEhL9UybM25jc6meUxo+IP7hYozCyXPGyb5MNIB6D5IHHS4U3piX6VxO/4TSd
 NelQm1aEKyrCS1O10/csnxqX
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2021 12:41:59 -0700
IronPort-SDR: zY9Vzf5Y6GvuJoY1cip8zZrVvaR+I3fsMK2WX6Ij5Ti4lHa9CjhPndZr3KXQdWpmMuXdoVaW+Z
 +Y3jobDCe4zxteyw4MTsuIUFpUrnjfGzktJrBT4Uh0ddChutjiQbDVUuFAeeNVbnVu+pA+vxQ/
 JAuHlRc4KMhCkDMH6o4EfP2kCGionlcu14xBlHWGkZthpvJvbmA8xCTmogD5JZ+XX7qpJDkhD9
 q33RewgwwZVChkQkXQT0OkfxviDReS2UHd8lgncn1m6FAN1ZUZlbPRTUu2x8X448sjJ/uCcWE2
 kak=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 13 Jun 2021 13:03:01 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, dwagner@suse.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/3] nvmet: prevent creating ctrl with no namespace
Date: Sun, 13 Jun 2021 13:02:51 -0700
Message-Id: <20210613200252.9167-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210613200252.9167-1-chaitanya.kulkarni@wdc.com>
References: <20210613200252.9167-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210613_130302_432922_B2EDE564 
X-CRM114-Status: GOOD (  11.63  )
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

From Spec :-

If the controller supports Asymmetric Namespace Access Reporting, then
MNAN shall be set to a non-zero value that is less than or equal
to the NN value.

In current implementation if subsys has 0 namespaces then we report
wrong MNAN value for the controller if we allow controller creation.

Prevent new controller creation if the subsys associated with the new
controller has no namespaces.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 146909486b8f..26d93ac9bd2e 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1325,6 +1325,15 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		goto out;
 	}
 
+	mutex_lock(&subsys->lock);
+	if (!subsys->max_nsid) {
+		mutex_unlock(&subsys->lock);
+		pr_err("invalid mnan value for the ana enabled controller\n");
+		status = NVME_SC_INTERNAL;
+		goto out_put_subsystem;
+	}
+	mutex_unlock(&subsys->lock);
+
 	down_read(&nvmet_config_sem);
 	if (!nvmet_host_allowed(subsys, hostnqn)) {
 		pr_info("connect by host %s for subsystem %s not allowed\n",
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
