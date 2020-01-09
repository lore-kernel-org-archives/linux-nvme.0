Return-Path: <SRS0=Ii44=26=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDECC32771
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 05:03:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A07D206ED
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 05:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dd2hkEiV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TPTMEDqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A07D206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8uYBr34mzDqADRzFrzAkH9ai/410VA34Tcy0vhmrs2M=; b=dd2hkEiVjixeyx
	a/crSx7bbT/icAREHIopuAGtmGCtsQ/9CKL2+UawEbaIZ56D3eSTtMyZRkCjtyGz9AT4Mk0TDgDb+
	wwHKnaJNG67xLAZB8QYyfDkZABuT3UJDOqZqF1t0xSBN/RAVqo6H8Au5l8EgvOv1NSyXwnWHPY00y
	EYp7F6OUW/9OT2ESCG9anboZ29wwOnZXiFB2e8pcSweOs8ZNugE1vjZTJ2pF8Dw5kG5JNf4tGVRSt
	aCjc/E08yBSSYqkEbXOtbd0DKTQwQma+Ezz0kB0iVoCLyXTH5HW3HvKtmcjCpP0OAjwnmMfxrwy4e
	5cfxQKvQ3z8niClcbEDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipPyX-0003jU-3o; Thu, 09 Jan 2020 05:03:17 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipPy5-0003Jt-Q9
 for linux-nvme@lists.infradead.org; Thu, 09 Jan 2020 05:02:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1578546169; x=1610082169;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ODBrz247bj5KE/h03v2dGt4qqwpAX/V898jvzVH9aZo=;
 b=TPTMEDqMkuYQ3CTfttMtMiimh6emSngo7/b9lDluCJsW/bmIZK1oKdWs
 YQf7bj0zBympDiqWzJwtWAlGHC1sXznHuT9okPbpK7tAFKgUeGCyAgEze
 R4FRfAaqnLt9DpPy3DGrjVxwQoS7CXstklEmRQbJziJs6XSj4jefvFJVp
 acJjOzNjy9Yzd37eNcW+4powyR8bQzBvxeQBPseefDyZtpSjNj0RgoGhB
 opZTHwTip5vkZkP2PsN0hAjtj6J4Bm41hPrjdfbtHPz1zI/v5pqv06Fnw
 X3saOLz+LeYipp5ry3UIr2HEHgZQEgMrTwsPoHi4luq6VnmGnrmOytHPu Q==;
IronPort-SDR: QizzJsnO1IJaUrWH4AVQOo391/CwjtFVSi2qLrq6odlswHfJmf+gi98hqSaZblXSkeRDcHTwp1
 k8kOV278Bj6xR7R/ngtLHO09ovH0x8WwMU0Rhrtny6sXuBrKPgaLfneJvKahLSfzfo91SyT7Gp
 wWm/+hBCZhCIMVU7MlSar9KUhtgnc7Dr6kSHgTc8uzd46VI20WKYZqsDCGyH9DDAVXUN84JV1F
 P9HIxUjm3ul8epg3L2kcrKnsjUAFi4qmUuDCBiyIogTnyKoLLaEcGU9TaG5RtpuVrkiBViNrUY
 Tlg=
X-IronPort-AV: E=Sophos;i="5.69,412,1571673600"; d="scan'208";a="127021382"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2020 13:02:48 +0800
IronPort-SDR: Ef65CnPkWP5UqBtK2Vi/pnw9E+arBewgio+Vu+h368OhxiVTy3taXbE0iD8GaCdo1KnoKZpHUf
 DT4bueNbwe0W+wFBoYYtgEdyqfHfgyPTPqYqpsK2sPBs2PoTF9x4rDNHRIcAnbKPoEij/PtBlk
 nV7RuLzdT2gOnRHVBYdc29bLq/vHtccY7i4lfuP+u7plLkt83YCdpOujCNLuVBdpu4+i2NsbN9
 91fOYZWcJ1j4cE/F+zXTsBf8GM3tTMSN7WbD9imB8+9Qgxbc92CvBmbcPT5Ni63se6MQG7qDnK
 LwbNLI55dbgcOeWfBGv39Hfm
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2020 20:56:35 -0800
IronPort-SDR: S3WMF5M79ksiS9sP4139idPEhLfrDY9enmbX6ce36jzt+fosM620gJL096XuP8JWOOszr1UuhI
 YMTcnEY4P4iKvZmtl3cgULph63XHQJ+ZffMMYPgmFCN29z0SMFxRIA1P381uxe+rF7ptG9dGmf
 m3R3PhGT38TB7ZdYeGzkoZI28W9tXlK4g3ISion53ZZIp6gHnRMXkrZA8dT5t6SUpMoEWHGn74
 N9PrLHM9gmvXqubt2hTkAnOS8THUpWPLoyqa7X04t0ctTAE3T2UWP0TOXzesgs5RQ3OgSdc8dp
 Eq0=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Jan 2020 21:02:48 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 3/4] nvmet: check sscanf value for subsys serial attr
Date: Wed,  8 Jan 2020 21:02:43 -0800
Message-Id: <20200109050244.5493-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200109050244.5493-1-chaitanya.kulkarni@wdc.com>
References: <20200109050244.5493-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200108_210249_882317_5B1145A8 
X-CRM114-Status: GOOD (  10.74  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
Changes from V1:-

1. Use temp variable to scan the new serial value and retain original
   value if sscanf() fails.
---
 drivers/nvme/target/configfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index b3237c2a1858..6ae6e5c9c2ca 100644
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
