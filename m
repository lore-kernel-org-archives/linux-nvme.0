Return-Path: <SRS0=+1uq=AT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3EEC433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 00:59:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B9A6206DF
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 00:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aESv/KCq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mNN9ne2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9A6206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jg0vWzuGWpP8lblfTWHiHtxv3uWa0FoHNJGdWE6bUIY=; b=aESv/KCqYjr00W5hwZh4qkvZf
	3Fn0VWCKEG8qbTsC6H4vp/rIsHyOfaTTAZJHdUXirpiDYSuKOjiErZgQC08A8eITF+RlniYeE03FM
	rtqC5Ris5enmT8YZN1QLvEAQ+hptP0PeHe/JWv3vuMF/9Jer4zOFzlFWYCW90ZOqkw/lgwsZChnHg
	jI71o8KKO2bD1KFIca2RaZJcfLd04DgsznWKkWii9s6mx3gmFbOR9V5uEUfM0kZdOTObUDBlTTjFt
	FLLcbsJW6CGZGKPAEIfo7PuD4sc+WRRo17nhjaKyG9uugXRSTEUsAmOcHA9ZDJH80vNtJgZXiVkLg
	lbkm//N5A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jsyQF-0007Oi-C4; Wed, 08 Jul 2020 00:58:51 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jsyQ9-0007N8-3p
 for linux-nvme@lists.infradead.org; Wed, 08 Jul 2020 00:58:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594169925; x=1625705925;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vjlHpkEnjiynaz3H+nElqO/MjCCd4DrS1CeVTP65/40=;
 b=mNN9ne2jIrCHrwSrxtsa1edZnMJKJAmogCHuxwPTXwYNP2wI/66h1vQp
 2Y71EkYgJpLbFz0K27Q7AlLYC6PTaEld9/GsAz2xFmsiFmfsfkO7C+3ci
 Q+cWcoT1iW8IqZ3j47wZAixR5uNdUyYCFxMI9KnVG6FPyIJVyJWuViFwm
 7nR5FSKIALYibRY2Bbfzp2iW+lRTmFq8Qc3v2zyr2/EI2gJj3touDfq2o
 ts4N+UCKF7g6/sDic5xF5vXtrq4aK5ppA6ifXqcYZeeasbXuKzffCc9fg
 PULIkUtDDKI+sJxYsj5pzM2j20DyVs5fIgLiEh/SRGciX623gpQ6o8Rlc A==;
IronPort-SDR: RS9u18/c9B7AtxTWWV/w8TtI7E+T3FmzskcVqgH9wmuyV5T3TznYQBB0dTnp7/E3SQMOgIPdds
 ptUl1wJX92OJHkvx2/M6p/dftM5Ea8rWkP2tEsG3DR+88YD5l8Es5I1r484KIIy+1WMcoOF3tJ
 +shAw4FTf4goVhXPH80mmVK1esNXL5dx6wEvf7ow7dJZPHG7UwGLgDLmCJkL5FevNB94ICo6Wx
 iBTHF5OqIFonBXnZS2dakrWKsadT5DYJNZ0fWlrek5bFS4GrNFwt7n8f39NO03YiI1tbvOLc9X
 jqM=
X-IronPort-AV: E=Sophos;i="5.75,325,1589212800"; d="scan'208";a="143204232"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2020 08:58:43 +0800
IronPort-SDR: XogYf7QxWDWyPk8lSWAd/iHy2eTcldc236jOjSF2MXdoWlifEsjrmKCZuMYerEgQ3jCDGNKRld
 DjL7ZASDDwi2oRvPsLohrCXVxkq6lLsoQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 17:47:22 -0700
IronPort-SDR: IZOTo6RLFHr//BvlpXXy5PXRBeR7D2+n/whibgTalCmG/lduQ8lo+R40FoJK9GGs7sU9tj1mBF
 vOVcxtWYCjCg==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jul 2020 17:58:44 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me
Subject: [PATCH 1/4] nvme-core: use macro for ctrl page size default value
Date: Tue,  7 Jul 2020 17:58:28 -0700
Message-Id: <20200708005831.10013-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200708005831.10013-1-chaitanya.kulkarni@wdc.com>
References: <20200708005831.10013-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200707_205845_292734_B0C094A4 
X-CRM114-Status: GOOD (  15.19  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is a preparation patch which is needed to centralize the page shift
value for the have ctrl->page_size.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 15 +++++----------
 drivers/nvme/host/nvme.h |  7 +++++++
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 898885630ad8..e0b47e77cbca 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2344,12 +2344,7 @@ EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
 
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 {
-	/*
-	 * Default to a 4K page size, with the intention to update this
-	 * path in the future to accomodate architectures with differing
-	 * kernel and IO page sizes.
-	 */
-	unsigned dev_page_min, page_shift = 12;
+	unsigned dev_page_min;
 	int ret;
 
 	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
@@ -2359,20 +2354,20 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	}
 	dev_page_min = NVME_CAP_MPSMIN(ctrl->cap) + 12;
 
-	if (page_shift < dev_page_min) {
+	if (NVME_CTRL_PAGE_SHIFT < dev_page_min) {
 		dev_err(ctrl->device,
 			"Minimum device page size %u too large for host (%u)\n",
-			1 << dev_page_min, 1 << page_shift);
+			1 << dev_page_min, 1 << NVME_CTRL_PAGE_SHIFT);
 		return -ENODEV;
 	}
 
-	ctrl->page_size = 1 << page_shift;
+	ctrl->page_size = 1 << NVME_CTRL_PAGE_SHIFT;
 
 	if (NVME_CAP_CSS(ctrl->cap) & NVME_CAP_CSS_CSI)
 		ctrl->ctrl_config = NVME_CC_CSS_CSI;
 	else
 		ctrl->ctrl_config = NVME_CC_CSS_NVM;
-	ctrl->ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
+	ctrl->ctrl_config |= (NVME_CTRL_PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
 	ctrl->ctrl_config |= NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
 	ctrl->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
 	ctrl->ctrl_config |= NVME_CC_ENABLE;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 85d76981b66e..4a56897e9081 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -37,6 +37,13 @@ extern unsigned int admin_timeout;
 #define  NVME_INLINE_METADATA_SG_CNT  1
 #endif
 
+/*
+ * Default to a 4K page size, with the intention to update this
+ * path in the future to accomodate architectures with differing
+ * kernel and IO page sizes.
+ */
+#define NVME_CTRL_PAGE_SHIFT	12
+
 extern struct workqueue_struct *nvme_wq;
 extern struct workqueue_struct *nvme_reset_wq;
 extern struct workqueue_struct *nvme_delete_wq;
-- 
2.26.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
