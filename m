Return-Path: <SRS0=TApw=HT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267B4C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:10:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C494264DFF
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C494264DFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kChOqfNi8t/CedU8Gkf64GQyJ40TC/kMuvH4s2LOMb4=; b=QfpRj/fZ3G9lKUxeYT0e9F/sC
	PPBM3zIv/Ged2aQVXINR3oocFgfefZVMDgYWHzdPb4p98Hkx6G8tlm7DJXQ90U2m522UcurqPZu9q
	qzCOHLqII0xfo9AYhUZRiQrh83oYscM+VxHdv8KVt1RHdxKqj8F4mxdQ5/OwTHTf+WNaqyUfHbyw4
	s+tQAbf2GIjVXVj6PN5KYq1dhDLjRnXM3JHc52pXRSzxxz5PmQFY3qu6Z1JUBU5e82J9+gGG+R3Px
	PlUajy8pdzMUOmN/5UhvTaHAN11w5RL316WwgSzYqys/YYFQQZKjO+6WGziWFF4cC5Mb4S3BewpI6
	bN0KXelkw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCAQY-0007VH-Sg; Wed, 17 Feb 2021 00:10:46 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCAQX-0007Ug-Cq
 for linux-nvme@lists.infradead.org; Wed, 17 Feb 2021 00:10:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613520645; x=1645056645;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3qFtBnl0WxOvvaJKkyLToRznleKs2lSQLyqli8Cl9GU=;
 b=aHb+EwdYi3rVh+ArSlg/oSuS+j1RoA7hPVgyy6y9Zn6+odlDrleb1eBF
 LTy+7tSPlcdCjHIooj1k933ikPEsnnxfImZxwKRXYWWqYopSBRy2eayKL
 oV07shZPRopE95Qeb+1P/DCuz6bZToXotlvl7sJFGIHurep3sa4zg8fFM
 4wU3gKPkZfQqjSU1I93LCRrJN4lZXDTHADJuduvwo99/4E5QmiLKww0n0
 jFn2zyaLgYfN+pVgttjo3b0IgURE726tRG/iuHXbCZ6c4GqU9+Yqgnwgj
 /5CE1BxKXRZURkBU2mR6u9/kU6vbgRNGiYF0JieDcBjsddgDRlJQsGyF3 w==;
IronPort-SDR: 8t69/pS1wL6pqfA9CdZ6aMIVSwQESa1MLo6GL6vGbCuRYWdFzn5Q+NmHlu5embZjok8r5KVjao
 I1tWWLOZBybLhO1rXkhgTV5VC8hEGiqRVGaqi/ypkila2JGc/v1vEvJ84b7a2P4DojWBdyNamC
 /mMqHmqaw8Q+EgsE1vDttkxQ8xBlkm2CVmAIvZTR1mMi/qkZ1cVZg+xduq3bpLQit3k9Zhfhze
 kt0nVi8ZVbwSPGMAGwOf/g5cm7X46xlheZiVmbeXCGEo3aDYQoqMXJKetRp+g4rHFhBNyg1ahU
 HFU=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; d="scan'208";a="160123448"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 08:10:43 +0800
IronPort-SDR: Ng6HhQ/BFzzzMes8trIe3bkttTKe2kmGuh+OrBWgU5DZz5YosaUbax/vMrRQnD46woO6ZiQhHz
 JUtoPrfCCv8RBeQU6KZrlZjpnBz0aUW0N5TYkT9+HNfhMA18yxOjt2LT35h+w+sRkOo4RvSCVT
 poTOnGE46SeRF9wzUV4wMDjLCfcTzG2u2mqIUWPCc9yfVx/FG+scR5C9xPOvLlpiS4hrEZ3EXX
 z5hH7BobD8xdF6SXlGdoRQzsjq/8WlP4SJLbk8liib4wARomzBJ5X1YnYUAWgRWhky5dg5xCXF
 8lWNQmrvfZId+OCB+a7lmE/4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 15:54:15 -0800
IronPort-SDR: d8cpluBKvrQmW6rDJL42sz1XD6FmyvWAIE6nMISiKSyAMPrbFaMkxpzkxcUL+cvd8OFAsJ8++r
 EbCKmh3asWBgnCsW1mHXEe/I5cf/OsB0w8SEg6iX/L7S/eaWnnCuyqQjsvNi6VpHL31B4xIf19
 WTi6IgQFNdOn62uqHlCITY82d9QfpmGTvXwBx1jDLls4XtIx4DekF9H9kjdwwnJmSKGiMn8XbX
 evHMWTi+Wy1L5IstQFfbdBV+/te2AQhnVAthmygNmJ4mwLGTzr0Az1cq96h5AodnrLqjc9yZOU
 dE8=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2021 16:10:43 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 01/14] nvme-core: remove duplicate kfree in init identify
Date: Tue, 16 Feb 2021 16:10:19 -0800
Message-Id: <20210217001032.25741-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
References: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_191045_577104_562DA273 
X-CRM114-Status: GOOD (  12.21  )
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

In nvme_init_identify() once we initialize nvme_mpath_init() we free
the id with kfree(). This is needed since we just return from all the
following calls to nvme_mpath_init(), that also makes kfree() call
duplicate.

Instead of returning after nvme_mpath_init() jump to the lable
out_free and remove the duplicate call to the kfree() since out_free
label already has one..

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d77f3f26d8d3..70042e111efe 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3209,10 +3209,8 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	}
 
 	ret = nvme_mpath_init(ctrl, id);
-	kfree(id);
-
 	if (ret < 0)
-		return ret;
+		goto out_free;
 
 	if (ctrl->apst_enabled && !prev_apst_enabled)
 		dev_pm_qos_expose_latency_tolerance(ctrl->device);
@@ -3221,29 +3219,29 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 
 	ret = nvme_configure_apst(ctrl);
 	if (ret < 0)
-		return ret;
+		goto out_free;
 	
 	ret = nvme_configure_timestamp(ctrl);
 	if (ret < 0)
-		return ret;
+		goto out_free;
 
 	ret = nvme_configure_directives(ctrl);
 	if (ret < 0)
-		return ret;
+		goto out_free;
 
 	ret = nvme_configure_acre(ctrl);
 	if (ret < 0)
-		return ret;
+		goto out_free;
 
 	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl)) {
 		ret = nvme_hwmon_init(ctrl);
 		if (ret < 0)
-			return ret;
+			goto out_free;
 	}
 
 	ctrl->identified = true;
 
-	return 0;
+	ret = 0;
 
 out_free:
 	kfree(id);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
