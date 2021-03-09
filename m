Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE47DC433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 04:59:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A0865092
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 04:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A0865092
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Su4PiNdDoY+I2J+eyTDGkGIZ0FzVPCq5I80K1OH++Do=; b=CnbX4NCnYzYIT/NahQlICPStO
	sP7pvuc7D3CJked26EYG9lvr2PKIFF1+A8aT8jPKVFVbBDwJ7w0i5fb6EWfVeAMEeA+pAEdVniohA
	pQoly3EZGfSnyUfNEMKf0IPbFczIG8yMd9vlvL2lpYm5PD+zf99kaDe4pyKK+u2UYzrSPbLUzTvR1
	uRW64AoexsnlHiLHQrFuDbRVHjJMtnGwPn6cOJ7hBnQWG5AdJD6NNcKo4+ZxsigM5Z5tgPGt3RtAB
	h+wf0/wOIdvHvettlOsvwBm0qRC8efzm1sSUQgcV6pXkOVQ6xsbgOrCD38qtd0TzMEFoaGHt3X01W
	3PlDIy96g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJUSf-003lFM-28; Tue, 09 Mar 2021 04:59:13 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJUSM-003lCO-Vg
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 04:58:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615265934; x=1646801934;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8HarYkRK2J3NWwMRBGN61WC8cj4b+NDxbGmLUX9mptE=;
 b=U6X+ko7hT3x0va+A0gfeq2ANNwF7Ut5qV8fOu5kMUjaM8Y5F6Or5d0xb
 tNBIPdrKnaQWsQqWsRc6+poHK+TBUHH+YOGTETWTX7pGc/A3CLjwDr7aW
 n6VRheANpZsxXMhxmeH2/FYZ/UvM2+cR1R28Pwf9G/Odre3jt2PWSbJ+A
 uiCW2EZgg/Uq+FfQCeB+ThNv9cJ6ytyloS5OxKJvrPrgMwqB0PxKX1n64
 etIftTtgairSnHf1A9NU9GCoHFldaONso5juM+oNnXItU0CCs/dwIJEuC
 8xvcSNQbnOpZOQMUieTi9fbyphRCAl2LWve1PT1pyxIfZTtQReED6RbU6 A==;
IronPort-SDR: AwYlo3fiv4an1q9gwap6GyVDucf+0Pkv//Sj2IIUGbLbLw3GF1k0ipzsR0TdD4t7wDRCZ7bdyX
 aoYOQp7uAulMpYe2QTOFQfniMyPPU5j+Z3UbnEnMXLA7NkGVsWRdiV72fK26O/iTDNfstw1Tq5
 Kjry98rO7Cc2qc/KSMimmoFNVHZQLTuBOCAeHzI7qAzpZCF6Rm1kCJ99z9Yw3abhKYiipX2t0U
 E76n+MGs3IgtkxvPF5FY4LmnywliWI5U++c65zj82jSiPG3hRMqQgki0dOqhGi7ab/PguscDR6
 mJQ=
X-IronPort-AV: E=Sophos;i="5.81,234,1610380800"; d="scan'208";a="272349206"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2021 12:58:52 +0800
IronPort-SDR: JIdCFOFjUuXvzXDPjpqVyFabbxXZwpZWm/kveoctmydgZbkTYxNQCiH0EraJ9y/cZYnIvAqQvx
 0Z28CPghTsBbHtxm4ISTj53w7Kh3bJJrZN1y8E6jHeouQO9e27ozP22nVznWJ7d9GlwDMnlOKn
 xSxE4G0K1XkHZ84IrBWVsmWxKTRxVO9TMsoLUTEYpomKl9oooJqdlzK4XqIIy2vNIV5UpP8yOm
 TR6XMzlQF1PSe81AZye8NdQjfLS2ZP6i5vUilUpTpELjGHIdHo2kxJLJaA6ytCS5fd0CrZkacf
 RgMxx2zZHtU5Y7sevBbXrob8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2021 20:39:51 -0800
IronPort-SDR: YBY/zAJVDsTehR2CSZelui41jfDzsvMvDXcFQNkndRUaDeuzZE8qXkG8M1hxIRcqGz8TWSlpZL
 5I1iuCbO1ELY9S6sGCsxcuTPu0XdKUW/4JNmNBwPw/Poht28jvsy9/56MCxWLr1Wne8VPX9IWS
 HCLqaEYAgnVtQjwtaST6pBnQHH6l7pKzwOnULI8O4i372PQEmghKv18s5RzU4Cyxf+xvsMqlYV
 1+CEWXFbBdV95q+2d1R6Dmx6seQ5Td9DBiIGMhzaoU9jXrDip9D2UH4B9syMosdI3Wp/VJQpr8
 DaU=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Mar 2021 20:58:53 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, damien.lemoal@wdc.com,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V10 3/8] nvmet: add command set supported ctrl cap
Date: Mon,  8 Mar 2021 20:58:18 -0800
Message-Id: <20210309045823.18545-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
References: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_045855_525589_97667B24 
X-CRM114-Status: GOOD (  11.07  )
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

Update the ctrl->cap register export the Multiple Command Set Supported
features support.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 7c3dee21474e..0eb171388438 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1115,6 +1115,17 @@ static inline u8 nvmet_cc_iocqes(u32 cc)
 	return (cc >> NVME_CC_IOCQES_SHIFT) & 0xf;
 }
 
+static inline bool nvmet_cc_css_check(u8 cc_css)
+{
+	switch (cc_css <<= NVME_CC_CSS_SHIFT) {
+	case NVME_CC_CSS_NVM:
+	case NVME_CC_CSS_CSI:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 {
 	lockdep_assert_held(&ctrl->lock);
@@ -1123,7 +1134,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 	    nvmet_cc_iocqes(ctrl->cc) != NVME_NVM_IOCQES ||
 	    nvmet_cc_mps(ctrl->cc) != 0 ||
 	    nvmet_cc_ams(ctrl->cc) != 0 ||
-	    nvmet_cc_css(ctrl->cc) != 0) {
+	    !nvmet_cc_css_check(nvmet_cc_css(ctrl->cc))) {
 		ctrl->csts = NVME_CSTS_CFS;
 		return;
 	}
@@ -1174,6 +1185,8 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
 {
 	/* command sets supported: NVMe command set: */
 	ctrl->cap = (1ULL << 37);
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
+		ctrl->cap |= (1ULL << 43);
 	/* CC.EN timeout in 500msec units: */
 	ctrl->cap |= (15ULL << 24);
 	/* maximum queue entries supported: */
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
