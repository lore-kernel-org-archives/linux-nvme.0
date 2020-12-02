Return-Path: <SRS0=R6Dd=FG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4240BC71156
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 06:24:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC00205ED
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 06:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC00205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CSYgwzITO1Z223Tcb29tyPSFl49MxOEXHKBab1nOaDc=; b=BxAxpHRBw/ToEKZJJelB+kOfN
	vsf0JRdt1gsKtZqqjRAOwDr28IAHtDwGCn/zUjSyja8kShj53GIdViHeIGku3UjadqQmcs5twCiik
	xTfgmVkP+EOi9fFRcjdqAhMpJHj1BNxGeHfbkG2ACaE/hhiTZ30XV61lBuAhhZ7inXjXZ30JW/LZi
	SeePdbmwXsJYzC2CvW2nYjDj47gkiaarQk+V1eSk8dpBfn42+TuaCgMIMdy67y3pXxhPxJZMmFLdj
	iL+80UpMMqtL3Hv/W/60vX8OCqN0886hJVT3CwcSkiIx2B9niwp0cwx66Whkw2SQmxJwEgrI3SwAQ
	c3QYg+0Yw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkLYU-0005fG-IP; Wed, 02 Dec 2020 06:23:58 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkLYS-0005eH-Dd
 for linux-nvme@lists.infradead.org; Wed, 02 Dec 2020 06:23:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606890236; x=1638426236;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DGst3WtKZogqGUvuhSXY1Do01tQZeR4MGYSWqYweif8=;
 b=r4OYlcdPKRfVsGx9tbp7SI2LBcl8sVRFVXmEjBYZVhX8AznX3tXavR3h
 RwDdrYjDApyRQGuQkgTiFyhemjtPYqRUM4/RqaYjoB6zYNMvKXmHZM9mO
 3Xa/XvhEBZIzXwwQPIzS6IIj35CWikIncFS89YS+NExSpmgcQGe2xU+gJ
 WIdfQ8s/vLDGEUFDZ/y4FuL5cUlaDQVGnDWjFa6dLpBQTwBbUlXEM5N4w
 MD5h5L7ALahBVABmhART/2SVVyVEMi+vY+sQik5UAJqhl4yO02l/Co7Lz
 4srsowbp/2KYId1BcKtfCAVVt47EcEA6f+Xgn4epgAXDoCq38FZyRJs4r g==;
IronPort-SDR: yZ6jzImFaIxPHxtbKJzLY9wWVxd2ThA8q87sSVEfWhESYnUHJ5oeVMDvAAS/SseyeHfW26a/SZ
 VPKCKV0KSvfoKu+vOUSXQACK2q12D18fHK1riL9dcIet2vQR//VqrAWyEZUU0Yy7fsMq4EhIkx
 dso35MVYUXAA/FH2NDdIKBPcew2ys7S5dBILRxgz/N8qziFlgghFZ2zgCXfAqpzFFhB3Q9JlW7
 MnxAhg821qRVVlcbUvImiYCjC//CzAv29pF8QoEh5y1R7PsbVdU4jH+rajzJsj0lllR3tc1sya
 mEI=
X-IronPort-AV: E=Sophos;i="5.78,385,1599494400"; d="scan'208";a="154060517"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2020 14:23:54 +0800
IronPort-SDR: tFUNmMwDYFFYTY3N+rIj0HYJVWYPCd/nGw5mbUaY7LAoBQmXh6ALiAXy2Funb9JzjxIO4sIVQb
 4SRXNYV5+KL96vRqgOOPvFGUI4P0n4fMA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2020 22:09:29 -0800
IronPort-SDR: njVwyJp2xVsuqJqEziWlWXHeH9JfpNTAWREwm6IRzwIuh12ZmFU0s34CSNf0czw+//YGcXZNQp
 BD2YQhPZ8efg==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 01 Dec 2020 22:23:54 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V4 8/9] nvmet: add zns bdev config support
Date: Tue,  1 Dec 2020 22:22:26 -0800
Message-Id: <20201202062227.9826-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201202_012356_608832_5D6F27FA 
X-CRM114-Status: GOOD (  11.62  )
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
Cc: johannes.thumshirn@wdc.com, damien.lemoal@wdc.com, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

For zbd based bdev backend we need to override the ns->blksize_shift
with the physical block size instead of using the logical block size
so that SMR drives will not result in an error.

Update the nvmet_bdev_ns_enable() to reflect that.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 125dde3f410e..e1f6d59dd341 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -86,6 +86,9 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY_T10))
 		nvmet_bdev_ns_enable_integrity(ns);
 
+	if (bdev_is_zoned(ns->bdev) && !nvmet_bdev_zns_enable(ns))
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
