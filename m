Return-Path: <SRS0=dBpD=HS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF38C433E6
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Feb 2021 21:31:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B52DC64D99
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Feb 2021 21:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52DC64D99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dRIz04g5S9tcT29itLh5aEqKMztH+10WZgJhG3qAExE=; b=deOdTcE7LQMWk6RxqqNAZoMWr
	kL2PFeHqKZX9DDEO5IlVDRzj5GcQlLLT1wSm1RtjoWLTIox9af7pAiRNAT+4xgW16zEv2KRNnb9nf
	aFUSajEDfPLVQo/ie1S/d5bqnDf6LQ45PdOWZlhPP8t7AZyq3XB2nrQupPCqV0+SF/qJTRIsq/6sx
	J+WtqLJXHgZkoHLJY7eQBQGOkYc3ypIimUrqlIQ8UZNI9FoGzovDpT91ZOhUSuxvymY2tDPFSF/df
	3W9Geh9/xpskBn78/SjpBpWTcUap8xiqBXEuvEc6OpVK0j815KUMWPjNXWNfnb0CdpJTXZxRE2uRl
	TWT6yiJfQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lC7wP-0005SM-Gn; Tue, 16 Feb 2021 21:31:29 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lC7wM-0005Mr-Ry
 for linux-nvme@lists.infradead.org; Tue, 16 Feb 2021 21:31:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613511086; x=1645047086;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jSNIpHYC77Mz1eR89Sg/FjLbsHPqgbf3+qpH29cC3OQ=;
 b=N1DJWHrmBY/sRmlYyY5rv9VRZB5X0i6fjyFlGzsk5/Yjznj3N39q+7t9
 Ss14VwGP7WkcqmGrQ8gBewHEYPXjNWBEJVMC0j6hmnE0J0HNf7iEKCrkS
 KtbyDRwwOaynY5PkkBK+f/i275C/9iFPPw1m3p/XdCQ2QbH+iO9E7UyqU
 ge9kXex/ihCmQtPav2Wzhg6r0FwEjaWK32xugA44oH89CuZSYrUhmNBLM
 eZN5omtbdsXYYSwqDw31F3Z/42nvDGjAWVc3dT+jaotGyc46U0Sfgz65k
 MiYnjUYr1nWTwU8EOzJKJPYX4ccqsgJpyXF3hoedJfXgdrHkTgI3qQXWQ A==;
IronPort-SDR: WwI+yFqsEL2cLruExOJdlj0pHC/vgI7INdYJhPyXi5BgA1URWkbqTnePLSvP0JmvJqUuI3+yV1
 4y5SrBA7JvMOlhXBQimitANVbQykzzDov3VZRpSr6/FDta7BzUg0vHF4CmEdD2P+lwbZeoKZsY
 +LPL9t0+CXB3WqKTSV1jXTaaqqHKwpEu4A2j+u3yGTtva+lOa0HnSwdfSsUwAjEMBWI1BNyUoN
 E0zoWkXPBQxhzTnXg6sFYKk5ndlABlZ1b7sWGr52X53nVh6ZLy09fDxPIwJFUu4pKcCUTAamnV
 Qxw=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; d="scan'208";a="164580897"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 05:31:24 +0800
IronPort-SDR: Dg+1nvSZM16TLbTCaZXXP+0rRnALZRx7KlajCAYjh4CcqtOuo23Yn66k2wHnGbblZcZKE40dsn
 hji67VsTIU0fGKQbk0DLuWi/GtRCi5Z714Ma/S6v+bfJSFOWRT+7Lqk+mV/CF2aOh1ADHOdRa3
 LuBFOJC23TiM2jvF36hyZdCBDdCyKbCJblCeAmdVStVVTbMnf4EdvR9xMtYUjPJIgDISAwIbsD
 ogf+mnuOnDVsM4AAhGC7TPhRPJvnd4tPnlGi2G0uYkpAiBGOuts8AfnpnBo6rsZ+LjYZYRUfYV
 yclw7kowYUyVF2098AxEKvO6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 13:13:09 -0800
IronPort-SDR: 3hb3JMAld87IyzMD87utdwgGD+c+NiDSjV1PDXfomP/Idt/fGeZJ2r3oCCABk2thl2VGz08dor
 6LYuEQcJ3kcDti+9222UdJQfnt9tASBjNEH0TpRdRajcgVVHSiWWUKhua9mvAo3RFvYOgEXen7
 6USusc7WM67DvKZ+iXKZYR/n9oumGYD52Ob1oZMC4VDk3ge+I6+sC5t1m6xWcMaLPYQJ+SZgZ7
 B7CZPhtXtGgXdU1Lqr/0B9Md2KSkBZ9XdH4IEozZZQXAk7+IKGC85HjNYMzonXWhWtvdAv3EdY
 Qt0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2021 13:31:24 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/6] nvmet: remove duplicate status assignment
Date: Tue, 16 Feb 2021 13:31:07 -0800
Message-Id: <20210216213112.20078-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210216213112.20078-1-chaitanya.kulkarni@wdc.com>
References: <20210216213112.20078-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_163127_066743_279C3307 
X-CRM114-Status: GOOD (  10.05  )
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

In the function nvmet_alloc_ctrl() we assign status value before we
call nvmet_fine_get_subsys() to :-
status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;

After we successfully find the subsystem we again set the status value
to :-
status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;

Remove the duplicate status assignment value.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 67bbf0e3b507..64c08b71be2c 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1314,7 +1314,6 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		goto out;
 	}
 
-	status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 	down_read(&nvmet_config_sem);
 	if (!nvmet_host_allowed(subsys, hostnqn)) {
 		pr_info("connect by host %s for subsystem %s not allowed\n",
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
