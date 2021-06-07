Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F649C4743F
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 00:38:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42408613BC
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 00:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42408613BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r0ZcudGQeji2AHU0lfWfUJu4d18dib3HiBV1+WXLpBI=; b=Y4Y+MjsnoUBmGN
	I24jHIQrQiGqt4ZJ+k89tObnl6Ryjb8qw9XSR2BdgGVv5whSH7srp+3XFjL+DWr0KhU9pwbiZLQYe
	gJVs764YY1g/taenPsQR+smwsPi5TeZEsPyslJsr4IaPDZfIG0aW05GH/8Zm1vS8gL1KjA0XNlIc3
	kfExct8gaLmaW2h4XCvi2VKfXs8Pufox+qw8oBeTm6iJr/V6HP7fT1hoG430nbCMurWZqKVZPNFI8
	bnfcBCBoJIynqjYVWzclJ3P9yHl55W3Yrn1qLlk1m4ic+FR6vDBzepUGjZtM+58pE4Ld/vVAHpqch
	roykXpbV15TmbDSXAqzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lq3HF-0016IR-UK; Mon, 07 Jun 2021 00:38:01 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lq3Gm-0016Fr-P4
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 00:37:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623026253; x=1654562253;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GBuhfie97+OyWuj6Snt+tLy+vHP1vnWZ7uJCWq6CXRA=;
 b=hJd2MUekdiCFfSFNC2lbR6Kob8WKQEbdfuO/sceuCpy9nVyBoqMoPVwn
 hLCVzzAjOmXt6u/AikG3A8XPMCsKNb+jRIp7v2dnIE5mkTrj9eiheb719
 RI9hvW7W8drhi+c6bzbqwUInnQGfNRge8er3PGTQN7Uz7b2/HXyMOXVts
 Hce5JthjTHRL/zExkFNGO9vqyvSzzs1Cq+E7/ir5UDKkkOr/K79tHawN6
 +U/lL9rkksyo4uVUM3hYTuRi+7KLjlCUmm60fQy9NacJ/U1GGcyg5+xA1
 JHcMi/LlZ3hYJ+bKBBC1NTOak0bWFp6RPaRs12iolAsds4ccSc9B6v3c5 A==;
IronPort-SDR: oHuV63qvRIhilSj1UADQZ4gbQuP++iguZl4EoruGeBMkv/+ey5vLlbj6fqTGRNFCeDF9x8Yb9o
 krrGXg2XhI1iqr9dp+0y5uSI8TFaReCfMp4udXrB+pCGZbUIj+DWhup1uGBsqd7XCM1FA9glGJ
 alPZxzwTJkFaXqyrueLZen/b8nNuh4DxACNx5EiGcoKNKMpWM2myoDXHKVKJAIVCtHH4/orUr/
 Yb2ezmhxYXNIwkEiBkbjFnnST2jaRBjAj7gJXFUnEfG0VoMqyhphPEuwwnL5OatXV9MVfvDGyU
 H4U=
X-IronPort-AV: E=Sophos;i="5.83,254,1616428800"; d="scan'208";a="274797374"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2021 08:37:31 +0800
IronPort-SDR: BxH75BoHzHCGU99faIggAW8drgKQdKQMRONIPDl1m6kdCYs1weUvUx++BSpoIiVkiil957+d1h
 1I21Ug9QsIkTlqHG3fzXZaGE0xGKGt6SJNiUYlBo/sbTHYUwwJLGK7po7ZVm1lK/dlN9yp82MC
 MUqxw3ixB6QmIJnly+z7hPMcZOvdLqq8TbKsFtKPMZnLi1o4fRNZ/MFOaHUbNiy2GEX6gYsTv3
 Rx2/sgWT82i2WDXgxPZt6nwPAjBKUirDoLBHdmaY+zL8xHQvZIGUgWj5R2jCgzufHrSUdh0U6a
 uDbuQC1hk2xYvTjX1jAdxiFd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2021 17:16:38 -0700
IronPort-SDR: szFdlN/apc2tQ0iPLnTRd1YaQN5Ri32DqGf0Pk2AmN4VYvebOp3R81j8yHT1/JUGNxHL7bqRQI
 tl5QJ2OUYCwk5JH+TK7U91K9TNld0Ath10OAPzVjudA/7GpSkD4KnwccfMmI7opBlSU+bWjNMP
 aXtLuzL6yFfyRXaj2RJ/vrOHH+GJXzs7L079x6ta8mOU9xUA7SMzdx4KIvIi22FTGv6ajwu4sr
 aLvZj1ZJ5Txd/qA1p87Bxjt5PpDdmyhYiitDfY3BYSdl27ALaNCPQPZBkKE3spIKJC5j3SSAYr
 CBM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 06 Jun 2021 17:37:30 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: james.smart@broadcom.com, kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 3/5] nvme-tcp: use helper for ctrl sgl check
Date: Sun,  6 Jun 2021 17:37:03 -0700
Message-Id: <20210607003705.21784-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210607003705.21784-1-chaitanya.kulkarni@wdc.com>
References: <20210607003705.21784-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210606_173732_897133_E0D9793D 
X-CRM114-Status: GOOD (  13.00  )
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
index 5fc6c568c626..8d279aacb027 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1992,7 +1992,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 		goto destroy_admin;
 	}
 
-	if (!(ctrl->sgls & ((1 << 0) | (1 << 1)))) {
+	if (!nvme_ctrl_sgl_supported(ctrl)) {
 		dev_err(ctrl->device, "Mandatory sgls are not supported!\n");
 		goto destroy_admin;
 	}
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
