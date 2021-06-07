Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FDEC47082
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 19:55:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B2561108
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 19:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B2561108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r0ZcudGQeji2AHU0lfWfUJu4d18dib3HiBV1+WXLpBI=; b=nNdGEweDNI5ScG
	2M7ki+a3L33wtgLRy39EgeLCfcuUT3EAJPxGe8VFdWrldipF9+YwoAz+AiEIlIu+FXyXz5jGYrhMu
	G4gw8w0bHK3XUoy8h92jf+P/9Uz2VGn0IetFPVUl2rkFv2cj7Vtv6rTXoX8/99jHWkiEi1lDJ4cP6
	q5m/nAeveaj6TgXod9p6onG839Rn2AyZE1PvRl9eyuv7LF0qg/75DWovAUhr4TSFcUDyqs7bTntog
	XlclO2GU8LbblY1UbDxAJiMoZSL9lGRQ1LnQY03wnxr9JTfGb6aByd5aEhXYaLJ6cbpXH/iDVNWer
	zCCLxom6s0APyJZtOV9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqLLf-005DPF-1C; Mon, 07 Jun 2021 19:55:47 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqLLH-005DIb-PW
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 19:55:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623095723; x=1654631723;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GBuhfie97+OyWuj6Snt+tLy+vHP1vnWZ7uJCWq6CXRA=;
 b=LHRknPyDa5j7q9EM6ouiXK1g6iBPj+5mMt0wkqWsKVJWaqf9TErTT+O4
 bxM05C/iqvRlvd5hL7+T9hcm04t6WAH7wzUGcr8fcj7/O3JCeMDU5ZTHK
 yMcZLepUKzZ5ZQoHQo9YJebfbJWkSlJwT9ZBqVRdhvZibYoRetudzY0PK
 IDl69Vs7To2oO8SPYpJyoRyu4IU8tVUgoRsLk5YqfMzdVyZo6IC7ZpGdu
 ZW68yTAvslYl/cc4HZ+CRtbkeK4R5xk+iLi55BpWDbq96PqpzGFvrwFsH
 7gQ0mFWzXO/Y7QU3kOVpNlkEt61X07mM8miDLqLiLVN0uBkG3RjKOvHMV w==;
IronPort-SDR: VeRKWDoMKBwXav1Dbt/H7hQ85lBMoHGp534EKHeroAnAfdNIdUXjN+5v+OE3RsCpuhxWEHThFM
 o6OOgUqmEerW9yIxvOOcVQj1Ovl1Fp8LcJ9rjofWybMVY8IfN9gq4FEdmjHq78EqtOudMHzUZr
 TFrf95I9UJbeVgSLjUJNsoXom+RANgWXqDPiDkNIqzanYLkKt0BfpwudDdCzBKK8jukF51bya0
 AucScM039gfuN8i846ZX/BHouQApAB6vIkEVz8VuX7FJkqIpNy4UwaZC24PsUChKn6LpgeCb5h
 AL4=
X-IronPort-AV: E=Sophos;i="5.83,255,1616428800"; d="scan'208";a="170343993"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2021 03:55:23 +0800
IronPort-SDR: b89mUCkzEt525HdSsmx1tIvTYktDF7SAbDCjULySwB+nmxNLgUxujoi8udTLKI8wvcERFn5fRN
 1JdsCf+d5sGIJ6L+RNl0v4x1FoQ9UFT9o5h2pKPLLtIBj26SjzsbY1kwFKXWHYGPS4OeNZXgtw
 U+iiqnaH8QrsmWW+zU7ccVCQQ4J+lFvtG1g2LakcJ9bK56pB53ti2T+6RcNVvtpf1sm0+xYGWD
 WYRBWlBVHful6wcg4echnt/RNEQbouYruLj9Dr0YTN+sdjnT9yunWNnnCuXoT1ByG0zG3JusF7
 jpq/hw3bJvcxyPsbuTAoKgMz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2021 12:33:05 -0700
IronPort-SDR: aE3Q6P1s2Ye5SFUNVCYwy3vjYUw4V2XPBDKngd1ZpySDHBQV9RZZYAeo9LYfxMLC6PjyHeInrS
 T42UEcJAfsXSerUliLHQOnc0ZBBL7BrLzixCB+btYiqmKFljJDnxbJXer3birHPO0Gq2pH5357
 1d2mj7sv8KIAdhVlMT+EJGln/cd5kpx2vISVen6Oz7WQIaNAnai1l7Ucznumbk3SdkGH9Yeq9Z
 3a0WsnumFM51IspKrXij98/6k05toyCZ+7Yme3wet6+0lUac6iPfzImg9B+gDRVZYfVmjzpb3U
 k6Q=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2021 12:55:23 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: james.smart@broadcom.com, kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V2 3/5] nvme-tcp: use helper for ctrl sgl check
Date: Mon,  7 Jun 2021 12:54:52 -0700
Message-Id: <20210607195454.16829-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210607195454.16829-1-chaitanya.kulkarni@wdc.com>
References: <20210607195454.16829-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_125523_914545_237E2A1A 
X-CRM114-Status: GOOD (  12.26  )
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
