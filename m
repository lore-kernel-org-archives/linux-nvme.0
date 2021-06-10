Return-Path: <SRS0=9ZED=LE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2382C48BCF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 01:29:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D62613EC
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 01:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D62613EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Viu1/p3hGtZyDMYRh8jrP5hb2diCjCVrepG+lRxNero=; b=WoQcxevPcCmZiT
	we9psFSKWX1+dtTZLWDZJJkhYHrVUpLVp19MV7lK16Xw7M3dVhvmNNWKrn/XekuM5tA9nSyyBmnLy
	fAjAlyq2uFJ5ts3aPG/3lniwn7K3+2o4zzBNup14mARbU7ZCUSQJBl7wbjc7FvMzb4ncxYkDFZFbd
	zU5rvVxGVn5iNZmVagVN60A9maJLdmEQmOfZNKuvOSiX4hEX3hOV5/nluZFTMAaEsDU2ds60TyBiP
	Mve7Nr2SVeoxko2ZwdveQpueecwRKWSUm8n5krlqB3PY8Ime3CUYmdASn8Bcp2UnuTB22nCXaDGnm
	z7hg5f8cdhEcPtTn0s4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lr9V7-00GFyp-Vp; Thu, 10 Jun 2021 01:28:54 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lr9Uz-00GFxk-Gq
 for linux-nvme@lists.infradead.org; Thu, 10 Jun 2021 01:28:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623288525; x=1654824525;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AoIWIhIQCd8veBbXPTGwRhINWcqRM2MRLGmf1riilKw=;
 b=rUjRuR/tTP0CHOjP1fVbxJjjtnnJz1hVwebADNpe2SA7KX9p5BQOi9lZ
 drEnJtwvIzrm3hSflEtPkFjDxR73kPHPEegsBDRF1y3gbEebx7boQFfcW
 cr/BIbuLo6It/8p8heEIgDZULe2ArzklYfut97LTxD4/21o2Ecp03wY5S
 Nu748fLXS0+Y1x6LOYtQ1dZzzTRM21kFrN5JjJQXGCDGXMOstzby+fzfz
 O18Ok5SXY/mWn1fnH3+8wV2/2vxV1FzqeLF8BjUFzxOpnAcDTTLSqfHnt
 bonrxOBcFAW7S5xwblKWvOQ9X/YAkUXUHuTt6MNnjrl9BuCSPXmJPY4R0 g==;
IronPort-SDR: D2aabeQvbejPtBQaZah3ZiYOW5CRua+NoC8sOMnp660J5cenQKQGsstUqEygb1sfjynBqoH+ei
 I/Tt+z7P0nCi9aZCJkDqx5IrC2+n+nGmaMdNmc0vB08MsjdU0elz7FLbPfAdRIbCnaviaswexB
 1Ff1cEKoTyL+VbG9SWhTEbrKe4eneN2yHSprgLfTWtZ+MXRxono+Whh0JOhku180E/9YY7a63G
 n4Fxl3iHDKRT1Q6GXlYWMnLbaAqMYJletKJjMKPa5TECbTKj4XOY5Wj+xqkjzNLUblOUozFrfG
 m9Q=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; d="scan'208";a="171929516"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 09:28:44 +0800
IronPort-SDR: h3or+oWWcAjTzAArsVRknEoie0DO6n7A3wx7iN8fPjS1hgUwmLZHNCwe1ZkaQWGMSlXEGLc6nv
 sX14fOtgfmE9C9IsWY1ncTTwlx3kALWBBTP5pio0c6vWJsutxSJtAbnfv9NgiN/3yF/+sKsvJ+
 2o62S6dQFbN5M7eQtVRZmZHPBW90PLDQ4R1fAt4+EPQTDTZ4gmXaiP7ZSno5hChT3xfEX3rLfp
 HSglIKvLNtGMDGPYOv7bp116AhfFcDWSCSN4oV7+ynoBxLU5DkoYig55Mvg+79GAFCRr7+OdIn
 SnH8uQs4nOW1OwulAJlwUq2q
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2021 18:06:23 -0700
IronPort-SDR: WGlcvpRePD3SCmNftghtBf33rHhHKlmi/Rp142sGdW7u0S1b+Hjy1Xnlu3750ulhexpYWb1EJ+
 EDRr2Iu/a3VLXUp2Kf6H/HJRYFOJwawt9EJvyNeAvApLMJOghZ/814hGupEvsjxrDQxKmBniUW
 L4XZy7AxDpvwJQaRv3/NEB7ZAGX8LIJixK3t36dHm5a+JhZrEvxeu0FgF72YfO/l8tcPI+ir1X
 x6O4EXeCyt5dpnGiLPl57xm8SuqCyAAFD1yHZpWOf9sJTtg2jvb9qtBbR5Q76BsGn5ZMVJTuXM
 AXM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Jun 2021 18:28:44 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 James Smart <jsmart2021@gmail.com>
Subject: [PATCH 2/4] nvme-fc: use ctrl sgl check helper
Date: Wed,  9 Jun 2021 18:28:24 -0700
Message-Id: <20210610012826.53398-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210610012826.53398-1-chaitanya.kulkarni@wdc.com>
References: <20210610012826.53398-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_182845_638733_E95D6B2D 
X-CRM114-Status: GOOD (  13.81  )
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

Use the helper to check NVMe controller's SGL support.

Reviewed-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index f183f9fa03d0..7600863f7752 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3112,7 +3112,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	}
 
 	/* FC-NVME supports normal SGL Data Block Descriptors */
-	if (!(ctrl->ctrl.sgls & ((1 << 0) | (1 << 1)))) {
+	if (!nvme_ctrl_sgl_supported(&ctrl->ctrl)) {
 		dev_err(ctrl->ctrl.device,
 			"Mandatory sgls are not supported!\n");
 		ret = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
