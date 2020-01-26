Return-Path: <SRS0=KthH=3P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2F0C2D0DB
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jan 2020 20:36:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE4A72070A
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jan 2020 20:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AroeIPJq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Z0A91dKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4A72070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=J2g+7I9JbswxnLuaZAi4orNzpfMOQSA0+UfH2NWAiAQ=; b=AroeIPJqUW/fTJ
	I42dR+UDtlJaf2O8v/IjzKecGQY8CKr9ukkzdmqo21mS+d1xmXdkrcgIY66rTgABLCg8O/GOyk8hn
	+EJKqq+GOapguCRaOLGvZFQ6je8miSd6VUlNW5Pf9D7/DYbBYtrylvpFZx7P0yBLNtRS4E4pJYA8L
	IzN6S++ZWiM7mmZU6jdLfbnOgUPDwX0b4pDh2+i4JLww8UORS7CIzqJ3n2dZAH3rq7qNHEUtshdi9
	ddyDhjisY5T8D5nZhy+Dv23L13E6+IutWdsz6/6aEn9IggDq6389Toh7sKfNqDUU66Tb1ZBzJGvQb
	gpx1PU1cuAlBlzz6pmNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ivodS-0002kr-QW; Sun, 26 Jan 2020 20:35:58 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ivodQ-0002kX-Lx
 for linux-nvme@lists.infradead.org; Sun, 26 Jan 2020 20:35:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580070957; x=1611606957;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=PfTLamaktmqCu50VFXwUP6oImrSxinoAzfEVKBTjtks=;
 b=Z0A91dKnTIB4SouPSricR1Q2tNxywUrMAJU8YcWGk+Ldwp5piNevvwYO
 B1eyGxWY0ZSogcKJ0h9dXLIMEeOaJqu0gsmeTk0O6Oss6f5v2qGtq5cBI
 q1PtE1UPB5/GF8ocuLjqo25iAtQ7p5ykZiB33n/tq6hwd6lNMi7lxZU39
 T+mKEpNfYbOcDgQ2BD4snx/yJ+kIRUWTpBccAJbS3iz3W/S/hnUoOZIAQ
 r0xGIjJKBuXPFw71zbKB2HWHN+nlJVbP7v4INNo5u07mY/sx0ByT53hZm
 YGoW+nXgEE72+TWytGrmfqqAX3mHM89VCb2QCW0+4tvtrr7ymBQv8H8o7 g==;
IronPort-SDR: DWh3blM0H10iIsEWPCsXNhn/M/xXi3pyHvvoiUBSo/G9eidZbnoBV5xICN86Nnq2iVr6LV874h
 LFT9YTgsJ47PSrJLYoLc094NUlWSdpmQzgUPOQbws716NCD3OyesoEMIovwlTvVj8sqx4959t5
 qfXDE/t6g5bhV1Ch61pSPrd8GInhJIiHOsWoudIdGzyYgvsibawI0SJZiEU0fx81JRDTSpKCGn
 HJlU7PyBoVyed2VziM1wWtLmo0X0xxKiXFIVBfwfGjhIW9iPZ4bepgW7hluyqbMXiLCYr9XUo8
 leQ=
X-IronPort-AV: E=Sophos;i="5.70,366,1574092800"; d="scan'208";a="132789730"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2020 04:35:46 +0800
IronPort-SDR: siVIeboPUxFKvqHkF0Ogeof9tR7jeu0LpNZRlXwn7w/v1OGtX3DU2EifmMspio/Tp0K1xthJ9A
 2umbH8d59/tDPIHgpJ2fx1yzCkPriSta5P15qBMIHfIrxXSa+9tPx1dj23b54t7Fuimx5UKLk2
 WR8UVMjgfRjo2VqgqN/aPZEYFbHR0wi0myqT3yUO4SYaxg9ygNYIO7+J8V1MzRFRfKPyIYs4iN
 P7/iJSRQW9EDpzFuHa31HsBMDO+kiEN6Rh0hHnGXX2Vzl+cTBoCTQrNsdWG+xQj63PayK7iI6g
 GB9davpeCdhJ8/a4xFeov38x
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2020 12:29:03 -0800
IronPort-SDR: Z6ikZ2cyNhAP3AveMzOL6okMh1K4HhO+wqrmVyxjttiogD+nxBOahViujWFFJ0LB+8xN9AkzoD
 Mtcevtj8yCPb5XEiLhktICRDW63UeFAkDFXQi8eQgXUrb8tcwtM4y6je8covpt3jZjMvTWysKP
 3TgH88L9U73Lg6jJ89oTB9NBnNKrOJ0cV8Qn98DUFNkx2ccMrNtScpTNxf7o6uQ76QQ5CNhqFq
 qdFWlDKMG7DCPk3LHydSOUuuKH4Abm3DUx5DJreLJZT/x9BAe7BrqppkjuenucpC9Aha/+W2Dt
 5fk=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 26 Jan 2020 12:35:46 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: configfs code cleanup
Date: Sun, 26 Jan 2020 12:35:44 -0800
Message-Id: <20200126203544.4819-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200126_123556_730086_9A351F39 
X-CRM114-Status: GOOD (  10.60  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is a pure code cleanup patch which does not change any
functionality. This patch removes the extra lines, get rid of
else which is duplicate for return.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/configfs.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 98613a45bd3b..403508a52e17 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -395,14 +395,12 @@ static ssize_t nvmet_ns_device_uuid_store(struct config_item *item,
 	struct nvmet_subsys *subsys = ns->subsys;
 	int ret = 0;
 
-
 	mutex_lock(&subsys->lock);
 	if (ns->enabled) {
 		ret = -EBUSY;
 		goto out_unlock;
 	}
 
-
 	if (uuid_parse(page, &ns->uuid))
 		ret = -EINVAL;
 
@@ -815,10 +813,10 @@ static ssize_t nvmet_subsys_attr_version_show(struct config_item *item,
 				(int)NVME_MAJOR(subsys->ver),
 				(int)NVME_MINOR(subsys->ver),
 				(int)NVME_TERTIARY(subsys->ver));
-	else
-		return snprintf(page, PAGE_SIZE, "%d.%d\n",
-				(int)NVME_MAJOR(subsys->ver),
-				(int)NVME_MINOR(subsys->ver));
+
+	return snprintf(page, PAGE_SIZE, "%d.%d\n",
+			(int)NVME_MAJOR(subsys->ver),
+			(int)NVME_MINOR(subsys->ver));
 }
 
 static ssize_t nvmet_subsys_attr_version_store(struct config_item *item,
@@ -828,7 +826,6 @@ static ssize_t nvmet_subsys_attr_version_store(struct config_item *item,
 	int major, minor, tertiary = 0;
 	int ret;
 
-
 	ret = sscanf(page, "%d.%d.%d\n", &major, &minor, &tertiary);
 	if (ret != 2 && ret != 3)
 		return -EINVAL;
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
