Return-Path: <SRS0=9ZED=LE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58151C48BCF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 01:29:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11060613EC
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 01:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11060613EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r2C1HyrXaf3dD/ia0Hy7sutpAPS0KGkEmG23d2Uvjcs=; b=COYQJ7dlmX0+HB
	biXVinI/7g0yMsnEsDdbmz6a7ByKR90Up/mWrQZOGyC8tvS1SDoX5DamZRxK+1QeA1AeqCnxnJxtV
	zGSZ4zymtb4A3/TbnNN5U8KziPw9fNYCE5JEjpRxOpxbFOp16vdiVFh7wJThfqvxuO+g0AvLkz4gA
	IXme3qHAnqTzyG1dtRwo1vRsPYskvV8SBlrhgMoU2T3VamwvJodmmHfoS8VXnL1SlIRFGH3tsNEfm
	3Xrt7miItChIBNLCml1FRfviH10T7yi2Qt8SBumr/WXwygTnz79AnWIaNh/frwIsKUCJodGiyo1Qx
	5WzE9uj42drhDe9HJWwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lr9Uy-00GFxc-3p; Thu, 10 Jun 2021 01:28:44 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lr9Ur-00GFws-QC
 for linux-nvme@lists.infradead.org; Thu, 10 Jun 2021 01:28:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623288538; x=1654824538;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=enEJpd3dLz/9ahaOJ5gz0Pu780miAedLPDUNX3QMYuc=;
 b=I0raNgO5M9T86r4tvUPwBHXovjiPBb0KdW2hjlA1gXtD4kJXNxdS5l8z
 ErbxEkk9f8lfhUlBy6rNYnfVBfQMX4DWrF2cGIRtVY4YhaPg7hKzU4oNO
 VQPZgd6ZeWOZlpEdmANKWUNEVlxX3LlcqLz/MCK7w2a5oW+Zx0MmA9Fed
 9TWwgk3siwUswBDqfPrMY132YOOTWgycG4KHZ7fqdXJ/dSWNLRw5itgVM
 gUEsUq6s2GIEJFxD2TjbBjJOMi2O58vnpsZjdKl9i+R2sJa2bYRTKBfGK
 gL/9aN9p/YPjlJ0NPwrzvsjWV92Au1C2qHoJRqLcTPHZRAVcRKCLbAsKI A==;
IronPort-SDR: FF1/Rgf7JPG1zWvb0zsDyEFPd4dBiA6AfV/IGQW5DasGY963oRn1KM7AyjzOteXFb9yjnb6QKM
 Ns8+G3tyKmUyfYWz9nHHTa23JJqzsq0PS5Vu5MQARIObLQIojBGbrmGvAPK8gEHQcEMO8SuIn6
 niWSme2iIk38qIc43p8iOlsKKUdEcf48Z5DBWnNvChea5zIBuT0MuWPsfF40bxj2EIM5l0zspd
 J79MDmLKGVMqiSjJJLtiXHuqaPoZXgP+09F5NaAhpw0yQXg9P2Aovu/yV7atidIVGdV2WnPccL
 bJU=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; d="scan'208";a="275192441"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 09:28:57 +0800
IronPort-SDR: uGZzXLiBoAB3a0/Ft7OYpEUsb6hK/wYE5hRp25tU27KefCZvnvK6mU+s735eUC5K3tIAAMU/Aq
 k1JieTeE4+GxVT6QMv8FK/0pokUpDoxSZR9RiNLvQzBBaJNACDmA7oAuRpW8bF3aqDvFV8Hsod
 Qw0Wr+4fRNJ9qalaV7isf1vUfIEtx5F8NqhPu3H15gHl3MER6K7WuyBvvhutJqut83slViRo0a
 65hpFUmOA5jNoV5sqqbwx1fEHcbW1in3O6BLDUaSYQeefsLlv3r5+x55D4wj1aNNu5pvfC1UZc
 qZCO+6SePLpRkRogGqrcvjfp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2021 18:06:15 -0700
IronPort-SDR: 1lD2rJqimc+epxxee8BSTJEdbHKdz23EbcxXiT2f6mTEEDmfi9wNZVMHoFfFvePLjFsFnSBnTU
 wovMhRfjKZ0yUlXL+PVYI4wTy9RpSDbWhiUymFQVyznFQO7klKndv6pWJg4csNNiC/6piTVgCd
 ckwGfoft4LChEWEYJJH62X3sGgcxVCaZ2nnOUPkfm9gyJIBRe7VJjZtRnF6KKxRZ3+5HOZzqzb
 trcVBDBZvWEvsUvtVE2lWFPAD7t8bk8xG+PZsb0XgGddWHcIqVTPD/NQgZNhi9oC4Bx7HlsixV
 VVY=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Jun 2021 18:28:36 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/4] nvme: add a helper to check ctrl sgl support
Date: Wed,  9 Jun 2021 18:28:23 -0700
Message-Id: <20210610012826.53398-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210610012826.53398-1-chaitanya.kulkarni@wdc.com>
References: <20210610012826.53398-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_182837_931635_6B1649B6 
X-CRM114-Status: GOOD (  10.49  )
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

For various transports such as fc/tcp/pci it is common to check if
NVMe SGLs are supported or not by the controller.

In this preparation patch we add a helper to avoid the open coding of
such checks in the various transport.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/nvme.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1f397ecba16c..1aab74128d40 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -869,6 +869,14 @@ static inline void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
 }
 #endif
 
+static inline bool nvme_ctrl_sgl_supported(struct nvme_ctrl *ctrl)
+{
+	if (!(ctrl->sgls & ((1 << 0) | (1 << 1))))
+		return true;
+
+	return false;
+}
+
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
 void nvme_execute_passthru_rq(struct request *rq);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
