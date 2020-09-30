Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C35C4363D
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 23:25:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 216E72076A
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 23:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zeix/Rx0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fiOVHZBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216E72076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7LKrY2dbr0kPBIk0HG6lEggPKQKIGT2wil4ceadhzTc=; b=Zeix/Rx0su4ENAr4gKegXxJ/S
	xaNooMFNTPU/rGVux0vAcQl5AfGfmxbxXQDMKgAMPd9xHi7Q21cu4qlEj/HEwwKpZdvA0qzBfvLLQ
	+gWj/+ZVBV1kR76vT2Kr8g7UTpALyeVi7/xBI6r1+f8BHJVP5ebDs6flcJkh0O/Zc8owcyErxcQC5
	rPgHz95QHaSyKRMkAX/5tz0GA8JdNpbWEdgvsI5/qgFxOtfg47NfBfyqrlCIMJwQNkHLArFZfue8c
	D2ZP2fM/Qqn+y/69fTczyuORF7bO3a6ujYU2lFdcH1dJEvZvwE1YxYtDcWaAxyoRFmbNsZb0HyD8O
	EEToOJMQw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNlTM-0006ay-AK; Wed, 30 Sep 2020 23:25:20 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNlTJ-0006aN-Vh
 for linux-nvme@lists.infradead.org; Wed, 30 Sep 2020 23:25:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601508319; x=1633044319;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5c7g/aVyTsy5fed5t+D5pSuHrOUCxLWkUVR/OoiKH7E=;
 b=fiOVHZBI0xg1RRVxcPjMXKQ4gHMwHWN4pO4A0S5CCAJpBf+JHc+zjtad
 T4Iw2/wFOlu+Hr4NUiwMRpJnUmz0YVYKxlSRSqxziotBz05IwK3ZMbH9U
 Es76Egl0qZi/aMx9TLvWMZm/+yaQJZbPs7EEOwv5DGofKfg8ZfPQJtyVb
 hKeqnQNR7jl6QW5gUD0wztK4TrNAeeeUW4Sxj6EY/mAkHXXwmgkM7nk5d
 RhPxQOzsuCTyAtLZhr9K3O4yz1XeHn0llWgCLj9AiuZBpgOnjYsdbw/Aa
 NSsOVO5azfeW4pUIx3Ekj8E4pQV175rJPMCTL4ojosPWt4dRXpb6RZo1f Q==;
IronPort-SDR: xcUht0p1Hf32xPBFADjIRvdRA+/cFoosAvh+Dud72DuRNzAtu3FM4lexSw5kLftfoRG3zNO/V1
 OFVGWoW0He36m1dW7aa00dJLcDjcjLXSTo3KAwc63OFtmEcqMvPyNU3XwklekHoQxx8y4xMYXN
 AoLbrPd/A+RT7giiDQSrf1wSoELS5EzulpmwskVluYEW0I04V6MWt/Cheg8YhALLvsQChzEQF1
 jmgEUsYer4pofllCimYcn84oGkNkMQht3LmF19qnXdDc7x5kj3vRMUj7W2WM8HdtDeGyz7u4Fe
 lf4=
X-IronPort-AV: E=Sophos;i="5.77,322,1596470400"; d="scan'208";a="148730648"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2020 07:25:16 +0800
IronPort-SDR: 2suyHeVDAO1mwl9I2am21/ZBdg8YQoOPK6vwzaxKkDMZJw01eMxX4XXDZYVhvJTSjPbuXyCZxM
 9PWo59THtHtQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2020 16:12:06 -0700
IronPort-SDR: 5LaUHZ5I7UNUV7WD13N+T6sBxRGBYqf4CMuk2fGaO+j5laH5B/EjClQulXdNY69rl4psUty/8H
 LWy0u/fQEQwQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 30 Sep 2020 16:25:14 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvme-core: remove extra condition for vwc
Date: Wed, 30 Sep 2020 16:24:47 -0700
Message-Id: <20200930232447.20677-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200930232447.20677-1-chaitanya.kulkarni@wdc.com>
References: <20200930232447.20677-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_192518_184031_E1B88D8B 
X-CRM114-Status: GOOD (  13.67  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In nvme_set_queue_limits() we initialize vwc to false and later add
a condition to set vwc true. The value of the vwc can be declare
initialized which makes all the blk_queue_XXX() calls uniform.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9a565096e072..611bd43c454c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1970,7 +1970,7 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 		struct request_queue *q)
 {
-	bool vwc = false;
+	bool vwc = ctrl->vwc & NVME_CTRL_VWC_PRESENT ? true : false;
 
 	if (ctrl->max_hw_sectors) {
 		u32 max_segments =
@@ -1982,8 +1982,6 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 	}
 	blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
 	blk_queue_dma_alignment(q, 7);
-	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
-		vwc = true;
 	blk_queue_write_cache(q, vwc, vwc);
 }
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
