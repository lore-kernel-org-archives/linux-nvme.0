Return-Path: <SRS0=Eo3O=3I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C13C33CAF
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Jan 2020 21:23:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38B6120678
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Jan 2020 21:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VbcjPhys";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mvSG+OcS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B6120678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zXbX195d41NT/isobt3pcZ5x740b49bCZajpq7RxmhE=; b=VbcjPhysJ57KVJ
	e/Ig2AvD/oHGndM77xpjzl+92sRFlFuQZzm4/D3R/8c8vVjQXf1NchmI4YpW/CssfNVUcD3NBYDt4
	RBhwEdZQBbGXzVKuCFUIIXUx3DO3TxqF36kG1qsF0zaYI8/8Sjjk8vm0NDF9GugSFUUit6BR3OGTZ
	l6PM5XbDC4WKdbV4CBeUFi+7OnwJ7bOtE7pyEF0BtdDDgc1vETdrKRLWx5rrWykjs1qzuDZKgMpk1
	yzu98/PfHFwPj4IrlFmOR7XaWBeCqd96bIp7oGnzKUy8VgE5zL6WEBp3Kgg7Q2Ug4DRqjaRjvenRI
	kiV343Pf+s4SyD7H63Wg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1itI2x-00050V-D5; Sun, 19 Jan 2020 21:23:51 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1itI2e-0004ho-Px
 for linux-nvme@lists.infradead.org; Sun, 19 Jan 2020 21:23:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1579469012; x=1611005012;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eAy4dWCW6XizfXBtyPcdVU3m9hvAbaoGYsEp2E6vnlk=;
 b=mvSG+OcSN/XuqGhaAWv+DMsYlPyye+cTmB0IgN89C+a6Qb7cY8AJTe5X
 wi8F7VE88To+W2NXSp6V/zDrVcMehrDo1yfl+LnWch290PepI5q+UKNnC
 p3X7oqV0p8/5amgXXaUHTJ30XIR2lpTFMkScPF7zPHU0vuLPUs6QlGskd
 G4e4RuJW8MToyJNy4OIZswkYzuQI0cmaNxARXFAjO63gofCcPRGtxJZ+W
 1OoYowomE/vLVjl6uX59u+bQsW8qmkgEkHhYhlakJ7WBsjRHgoduKh72m
 FGKTe1pUWbjJr5QXfqdCaNV8rXdXV5D9WG6TCRXr5YSXBdb0PPqWM7BMB A==;
IronPort-SDR: zTFeZ3mJcYQASRIvbFrqbFNpecoHajFfEUARlOgOoOg7DkQluONSA8ZK7FX6RO5kuBzoI+tKRV
 is6r+tofFEyz8T7V4UMqy8p5NLeMeKao+WjGZJxuD0mSwa/dYFmy8KqXKdD5qd67hBgjSEkM2o
 MCADpHozyCxrVHORivBC5Rzh8K2wVFtUatmDGDAHrAcnbnV1oE55FBNcvhdhlo4R2H5imKo6Bk
 0IEqTSYOqgfCMqgadulBWu75gqyfEJjnP8XKKoFTugZLyX3Ezwv9oEYv4TYA+aOxcEEUw7S0LL
 f2s=
X-IronPort-AV: E=Sophos;i="5.70,339,1574092800"; d="scan'208";a="235845825"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jan 2020 05:23:30 +0800
IronPort-SDR: nUNgXWW56CTugOGjGdJJutut+0fxplf/lxkBNqwTJ0iEscMhsU8KM6YBGSp8yCQ7zSTu1LIC78
 0Jwk8PFz++8N6Zu7XZH0byI/c/7n8bOZ3ImkpCPb5D1waKsfJK9FkgLc8qRZ0+FkOjeXkebZ4u
 vhVx7ncB7PNnpc0UFtK2dJReFNxD7nc66VDAIEb6YKGaD9LZxRyxlj12lXmrvfZDCiYd63iNVL
 XgVqHdp4LwPplPUuWSUSXSo3+t+9AJBRI5Hu+D5M3zW2bcGWi6yQcVGQX3+iVKo7ABZZI5bE8N
 it2kZ1ZEtqo2v4k1uEggi03O
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2020 13:16:59 -0800
IronPort-SDR: EUCJN0PNrS84GIuryAYu6wOYjpw2JoOfeeCbcqgA1tnF51+LvQ4Xeqi5/WxuM/Y9C1tykh3SRy
 TZgRszeW5/l18zMaOLmqEp3FB+4G2APdzqIPEugO84z/iiP+i0VvkEXM5Yh2XFv6TMN0+jfSgI
 9RkO0y6WLZC0naGl54VU2U0XYXWShpR82VMRfqlD3jh1xHIXVOa+iYBNd0p1Ikct2e0zATJZfH
 qSqXrbSTJlLJlizUeipQRu+KFyrCIDEhtYIcbd/zje0p8ZACUEN8bxJbcYDHwfVlg0QBJtnPhx
 Gfw=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 19 Jan 2020 13:23:31 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 3/4] nvmet: check sscanf value for subsys serial attr
Date: Sun, 19 Jan 2020 13:23:25 -0800
Message-Id: <20200119212326.19701-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200119212326.19701-1-chaitanya.kulkarni@wdc.com>
References: <20200119212326.19701-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200119_132332_850906_5B331E26 
X-CRM114-Status: GOOD (  11.16  )
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
Cc: sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 hch@lst.de
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
index ca7c677ae660..bfceece8a702 100644
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
