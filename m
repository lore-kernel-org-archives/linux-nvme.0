Return-Path: <SRS0=dhBa=DI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B3EC4363D
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 02:44:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC962087D
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 02:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lLH3qHnO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NVa2HoVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC962087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OpuSK3k48U6a7DFsjmwNjuEOG1PXIUdljlxGfR/0KKk=; b=lLH3qHnOaEW+c/jwbjMMDpGSO
	zZ9GDiP8CPeF8CMM6x8alycvQKLuX/83W+26JIPUF2Kae+DIsTwL36j2jxan0TSDQXlZqBCP0NKPy
	pqBKvjmB4emwkV1TfiDBETZ8hps5rgs6oHPos794u4odVQcuu8ynoM2NSz//aoMQoP+WTHPxqMO7J
	Tf5GqnCmz586o2vBKnHcK6UmvZ1vKR8mTEh6V/4h1tjHccU2NU/yzlGtJeqO1Zwhc0dZtxNGhveVS
	7/9HJhqpwKs8a75vbZH5yZtio0xdGkxUl9gO2LhIrREYcwIuDavSCQFm6UkEq3whTuDwidAaicoSA
	lhZoVKGxg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNoaO-0006VL-6r; Thu, 01 Oct 2020 02:44:48 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNoaL-0006U6-PS
 for linux-nvme@lists.infradead.org; Thu, 01 Oct 2020 02:44:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601520285; x=1633056285;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KtqAuDJJMfStzKdYCyHvLICk/NOOGCTblT2bTdv83/I=;
 b=NVa2HoVYdalu7vTzVxqX9s0xVGh37oR/VJWLNUDpks9QA/LfzvXrusWO
 vJzmPmm7sbOxbDcdIOS8KiN9wX6FDbwpa4UwycFEwls3+uAqjH8FFxg9g
 v5iPM9dGuCAPkRIcIxuvb5oGu8I8DiXBMgm1gzqrw1tRite7dX/lx+Hvu
 vSFciS6ySEmiwloazsUozTrTPvxllGzZaBPMGf2+l4vTii/jmxo30yZq5
 DBTIwZKoVxCco974Eea+y41MvNjoFADdaHaDVFDngLQw96IGhgTRnRW/z
 6Qfa+o6lPney8LWlLx2/NhYeJ3RZQFjSCt6ux0ERtZzcqywl9Z7w5w7pj Q==;
IronPort-SDR: H86s71mdRFfQ7k7/crVsVYuKJm9LDXObu2TFbUtcdaCjdgF60XWD7uocjGiAkx4ZDmL56Vg1C8
 vYBEvus2gsSBYSSNbhu46OdH27x/modsVRn2s0aR9JJWsqIU2YrqyoKm5eabctNLv6a9rWvZ7+
 dQplh5rTmQlpeViUGjz2h/P/FhDqICKZfTZw+la2vVNILcMXQ9qf5a76INwQ6pqS2d2jXH5TH0
 1pAlRXr+xHPS8A6vAmLfjQl08Lk4B5M/mwHHgWWS5zyWnj2M+jq15YbBB0FcxvhpdzY6ig2Yxt
 1Ns=
X-IronPort-AV: E=Sophos;i="5.77,323,1596470400"; d="scan'208";a="148633460"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2020 10:44:45 +0800
IronPort-SDR: Hif8AHjb2dEKNKQ2FSWTVnPXTZaAcH7IaNwnR/HkPd/HIoqvuaIzgjLN/qczkaT1UujORSOY4T
 dARPut1EJaiQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2020 19:30:43 -0700
IronPort-SDR: owbFpiYGZ2noiS4kHmbAIpwlGRG/a7oSiUCTjJLHJ/zsVFsFilNvNgm/ZAP0yrZQw3OuJh782C
 W+1uDhsIAt4g==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 30 Sep 2020 19:44:45 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/3] nvmet: allow readonly bdev-ns to be configured
Date: Wed, 30 Sep 2020 19:44:26 -0700
Message-Id: <20201001024427.40753-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201001024427.40753-1-chaitanya.kulkarni@wdc.com>
References: <20201001024427.40753-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_224445_962694_6B4C82CB 
X-CRM114-Status: GOOD (  15.69  )
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
Cc: mruijter@primelogic.nl, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Right now we open bdev-ns in read-write mode. This doesn't allow us to
export the bdev which is marked read-only using blockdev --setro.

Allow user to export the readonly bdev by considering the ns->readonly
configfs attribute when opening the bdev. Use FMODE_WRITE when
ns->readonly is not set.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 125dde3f410e..781705f671b5 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -65,10 +65,10 @@ static void nvmet_bdev_ns_enable_integrity(struct nvmet_ns *ns)
 
 int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 {
+	fmode_t mode = FMODE_READ | ns->readonly ? 0 : FMODE_WRITE;
 	int ret;
 
-	ns->bdev = blkdev_get_by_path(ns->device_path,
-			FMODE_READ | FMODE_WRITE, NULL);
+	ns->bdev = blkdev_get_by_path(ns->device_path, mode, NULL);
 	if (IS_ERR(ns->bdev)) {
 		ret = PTR_ERR(ns->bdev);
 		if (ret != -ENOTBLK) {
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
