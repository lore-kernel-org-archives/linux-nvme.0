Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311A1C4743F
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 19:11:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D4E61027
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 19:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D4E61027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B/CxyNTULj1rS//Dv0DTp41vv4+P/0F4OK06oU7UYP8=; b=mePzh8Lb84APEj
	829+lFjskgEf/bLNiVGv5YckKX9RBz3Wlut0otYuDASwKD+ubOI3rRDIl45PcqLnVL3Vu4gqd4n8j
	z21p8kp7sNRvZNFH3TqLupCMlqFEd6eRtJQjknUEaSxysAwLDjTbKzB9rb7lbH4lYI54BqQua/bxU
	26MLTDEui7shUdrbrQXvgx8JlAysdrnYDd05lJ1RyaX/grBdooK4ABxv6cBFsR/xljZUFqKtP/Cto
	2BkixgWWys+7NgnfcOyy95Tk6uyIU7dJN3x2PeiMESlnoXTaLv1iyW0BOOBcyvMmsSIHnwhgPji3h
	yL3Vy2tNllC1bJIij9Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqh7s-00ACNP-0F; Tue, 08 Jun 2021 19:11:00 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqh7j-00ACLV-5z
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 19:10:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623179451; x=1654715451;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nd9Dl26wgSsrPXPE1BGjerzyUdvW67ANgcz2RZWCmzE=;
 b=q3jRLG9J1N9b1Q1AHGurSCyZZGD2cSzt9ObORaSbJt4In+P8C67uzs4L
 RAI5xQQtQWYwTSH7LZgT2BiFSlic1eeNcHdTlb1bfELnP6PXRICHpSBzy
 PTsSDI9KSluTpi/uwDUCdrBzSG4IzbJYORsUkswtPwooq1fpCGQtMCAhY
 8BAwyYK3HyX/4mL0Y6kXjXTT5RRKdOt6RGcbZoxQ3TfedezVtNdY0uSXc
 RmPKWYhfUOuHRI7txetxYXMFTRvkM4fqWg72W25BUAEZSb6O5WAkNaXAw
 RKZlakm6NpyHVxUVxHSD1IeTA5/w1MmqfdA2T18FrRFxQ+WZY7tNqBo8I Q==;
IronPort-SDR: ghVZpIEFmIk9Lyi1jansVW0ctT6mxMP9LCe99Ghx2UtZxTLMLdqx8HHNIAdJZxoUmuY+GCAiEQ
 EGFuPuWOLlXJOtgf3Vkm4ry4W+2M9wOF2JA7zz+lDkwbyfUyc1aZyYqEG/8NUM4/EqjzOZZK57
 UO/yjv9DpOjZ51IEMuZd2ecpLnJ7RrrDPHaNQKA4jgdYDK75f7aafMyHCbkAXBaNPdV2+Hzknm
 SiDRNaD1GlH6BSmX+QRA2iv6yr4kh1tNyp7xr11W+VvpFbH7DGIwU4OZMMJFBpc2gCw2699WSI
 zt4=
X-IronPort-AV: E=Sophos;i="5.83,259,1616428800"; d="scan'208";a="282623233"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2021 03:10:49 +0800
IronPort-SDR: OJMZuy8rmn2t1TBgcLLv4It8se+8Xu0CpFWQKFtpVNllkuHtTT/omyQLNkzc/MnE8+VL8DAs6/
 sp608z8UxPcmwfKze6hOe55MwZ9niFLrVrNUMEpeB001VKR7UjwwaQAUu5R1NwzgWbLScJoRBG
 2VP6jVgrgABCZjg85N0Gzq0te3/BiR9gEw8SUbE2GKNr/PORcVAjCgJ1mtN5qWVAxyCaOOpFcv
 B5sJngkZ1qDaUqyOyEYhy7ZRw6jQqXFpXDu2gO2D8U60Qhd96oyX/7WmpElU6CwpWZfr/J9da6
 mNZiQPibJgrnb+J6Amyu/5hh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2021 11:48:30 -0700
IronPort-SDR: bCCx+Gxpzq3XiQiCKox4tmOG6jxWBU8JbGwvzrjwHlwS7+JfCW7O5NtE376uBe+y/s4xQtBEgT
 8EB6kS2K/Immz2a77GFauG9RrhB0kfRXum0OXgRggPLgdlmDHpx9Th2ORTthoz4BQJYveOniBI
 asn2ogWixCCWpQZIF7yHw6BGqgZeYQby31yOv+oQAKwIINN0PVRL9Ji/D80SIqPDToMju52B2R
 TBcUyz0+wVkcRmg5ZOOdgyLq9wQSesOYpAiY6A/SIO1BxOIlMmsDTIwekqxv/7ACk6KJZjsJOO
 8nU=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 08 Jun 2021 12:10:50 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH RESEND 2/2] nvme-tcp: use helper for ctrl sgl check
Date: Tue,  8 Jun 2021 12:10:37 -0700
Message-Id: <20210608191037.44251-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210608191037.44251-1-chaitanya.kulkarni@wdc.com>
References: <20210608191037.44251-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_121051_262628_B06BB829 
X-CRM114-Status: GOOD (  12.14  )
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

Use helper to check the controller's SGL support instead of open coding.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 6a65b0516180..c7bd37103cf4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1993,7 +1993,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 		goto destroy_admin;
 	}
 
-	if (!(ctrl->sgls & ((1 << 0) | (1 << 1)))) {
+	if (!nvme_ctrl_sgl_supported(ctrl)) {
 		ret = -EOPNOTSUPP;
 		dev_err(ctrl->device, "Mandatory sgls are not supported!\n");
 		goto destroy_admin;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
