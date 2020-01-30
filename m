Return-Path: <SRS0=3CeD=3T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7D8C2D0DB
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2020 18:30:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE3F20658
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2020 18:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A8hGf4kT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OEE6VCLx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE3F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GQl2O2eBWh6NQV1mJMO4IGzsq9J3ok/2idapzhrzQt0=; b=A8hGf4kT6/Nv0p
	UUEODj+Pp58ya27Tpee4Sae8vaeeIFRxqtoitupn8/P2sL6RrBal+eyT4/+X3XTNGGg8mrxq+Zz1B
	aASaf41YMYLvdM+V/QEvvj13ePcvPKtZNf+0AIAYUbUS1jGSyqeVj8fJOqfbyD85rf0RiqMcH2nAR
	8F99i608L6PetsVZ+MSZO29SUormnF09ssDr/aF90HOvyfj2OiqugCWz0Or/0AKFHJlhQzJInoXyB
	wz14qXVfx/oTsoQRxX/kzcMIOrYudgsIURPLrk/VbPkDu1uq9oqi00Nh4Ocpo5AI7Lp6LHv6LV4JD
	POek8gH3mXxPiRsKvPIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ixEaE-0006i3-7n; Thu, 30 Jan 2020 18:30:30 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ixEZe-00056U-Bu
 for linux-nvme@lists.infradead.org; Thu, 30 Jan 2020 18:29:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580408995; x=1611944995;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=POw9WfeDld+bbKL/l5+H4IjfGxXUK9vF+Vm/SSH1WF4=;
 b=OEE6VCLxpRL2/E69PHEbmKjVFvYFoRRMm6q1HZO/BUTnJoJZLJl/jJbF
 hZ6FXvpoI40B99PjmyPkAQ4I5WLI4Bj091xbJPJPdRAgOsVqLvXohhhUe
 d85a12c3qen53BItjnjKnXcUmiho2XLHuUGL51DqlfwLASacV+Q8vuaUW
 FygDE6/V1EnUyfezeh4iPZW9+UAboQ7cEgUP1mcn5SZdle2U5HKYEhM1c
 f5KZkQdizAI3/HtXKcOuXAc1+EbDJrHH/+sL04eR1LWwa9lpNaf2XNCmE
 QMR6tWKVEB9haWnMZyuayKyZhGBvCgWz14DMVd73WWcwhvP2yxfDPo10J A==;
IronPort-SDR: E36GCLp8Tbj/1quZJzu1e9xkvO7xKmwAdUS2WqjxR2jtRLG+9n1YU4Lf52sTBHSCwAV1OC3y67
 is6SaTW5AvWhIFmzMRrFm2A/fNJbJsHJ2cNojUc07d9CFBlSMO8aZIGhvFetOEkUGAzO/3bA+e
 WNSNYhlGYOQ1CDCOIIF7T/D/ulkgECai6W+rW4Ar4w5X2Mtwcaj4R6gGlRAIS+GtpIvj/N2ayY
 0ejFUmUajz6ojlABiqFnS0+rLy3+u6AsNq5bwq4ilRbyYAnJb2VWB2iFn4ZoMzhobQm63j8Tgz
 w/0=
X-IronPort-AV: E=Sophos;i="5.70,382,1574092800"; d="scan'208";a="130231438"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2020 02:29:54 +0800
IronPort-SDR: LEf6w9gyvdJSUIjbBVREqiU1vN60z6cMjm+JjnCCPYn8hVO7cvl7E4KptxDreWrr2hZN6Metw5
 1FVI0ouANzylb1e/pqoFpeeD1bkC1E5HpCHGFhrOiWCno4GxtLAQHalLw2P7Ne8lcs+PjYcoW1
 ngX4kQT7GrYGiK7334B6HBlVuiXKKwMCauj5IIWyojLXf/qFkZ6elbxZS1rYQooENyzc63EJ5Y
 8zFBWrB931cq7QXD2TKeppeuEjgw6hf0oavBNSd8P7qZyuyTxuyiGLOaQPTNi3DD6Bc2t/JuYV
 +bN+6nY1PZxXrCo56UDyGZ78
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2020 10:23:03 -0800
IronPort-SDR: QSIclrTT8fAvAx3piamtq6vsxzRAnfd5hzMoSVr6KRZ+wl5dksy0YY3i5LvaXuKgarfaIGOWuq
 iuq9O32vbkLMCfQpvtZTgC3XeiMzpYmoA3gQC4YLbyCYTd/y6rTM12UUlvRSEtCmwI3IjMEPED
 bV+kd/9M61zumL0edaFHgrM5xuRw6Axgla6yLRE/xMkwJFhp74QahJ6R4g5K0S+GkvJpAOGWyt
 sen+5y6PTYV6fmR3oua65PnOLu0iWi4PfFqDjwgdQcpmqGJYnPpshAA8CXmjXTH6p+7g9M/8ZX
 4DA=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 30 Jan 2020 10:29:52 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 3/4] nvmet: check sscanf value for subsys serial attr
Date: Thu, 30 Jan 2020 10:29:33 -0800
Message-Id: <20200130182934.6109-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130182934.6109-1-chaitanya.kulkarni@wdc.com>
References: <20200130182934.6109-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200130_102954_458236_13F9D9A3 
X-CRM114-Status: GOOD (  12.32  )
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

For nvmet in configfs.c we check return values for all the sscanf()
calls. Add similar check into the nvmet_subsys_attr_serial_store().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
Changes from V1:-

1. Use temp variable to scan the new serial value and retain original
   value if sscanf() fails.
---
 drivers/nvme/target/configfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index a03d79488943..3e9acc5faeb9 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -852,10 +852,13 @@ static ssize_t nvmet_subsys_attr_serial_show(struct config_item *item,
 static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
 					      const char *page, size_t count)
 {
-	struct nvmet_subsys *subsys = to_subsys(item);
+	u64 serial;
+
+	if (sscanf(page, "%llx\n", &serial) != 1)
+		return -EINVAL;
 
 	down_write(&nvmet_config_sem);
-	sscanf(page, "%llx\n", &subsys->serial);
+	to_subsys(item)->serial = serial;
 	up_write(&nvmet_config_sem);
 
 	return count;
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
