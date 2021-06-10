Return-Path: <SRS0=9ZED=LE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753D4C48BCF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 01:29:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 469106140B
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 01:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 469106140B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+QwwGNvIW96tTUcgnwEFFSy/EPuxQsZLAQ9LRwZRJFA=; b=QIwml4Fqd2u+Ae
	9zZOvC9FUYfQkuOCAGkOOhFwA1bqmYHx6ulI091wUFPYF0sGKM3bFSQrpW7IwiMU7LjEjyTPUCmxR
	nj73AECT1UrwrN77XVGW0sqW+HruvcxdnrpA0onBjgaF9Uyi7XcwKObtqAtN2lP1gcUnUPXy4d2Hz
	xVf8AxMpYoOsgkHl/p/vT5DrB4BnDCHSNrjGwrLORJItbnFOqUnCfswUofgFyODMXaCBJze/BjrDh
	udDfawSJVGBxpJpflgIEErc7aeEqhVf3dm7+/W1aYJ0nv/hZ0wBJHkuulaDni8kpWUTUEKxzIgDWr
	XzXy7Eeqy9v9s+tfosXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lr9VS-00GG2q-GG; Thu, 10 Jun 2021 01:29:14 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lr9VE-00GG06-4h
 for linux-nvme@lists.infradead.org; Thu, 10 Jun 2021 01:29:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623288540; x=1654824540;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TlUquPRaGrBtG3reMjpwtEIE8B/J8RmBHNjdDlpi40M=;
 b=baHiZMY0vVIxWindzRcxB5bzwZPSUPDSEdjnGR7EE9ne3JtOlGMWxo4U
 rYibHpOVtj0v5wi9O3J/Zm2KlUBaTeUWq60uX931s+0ssl3yypl9Ri7o7
 42H7X36aVw3lT5E2EO/8/+jR1zE0Xtvu1doNEMHvRTa0bQBsDz9WKEZG4
 lcGOJAobdL5RtV2dXKJuP5TLKNhJp8ReXIoWvJMOWxpoIqih2y9REQwhD
 DGHwkkFCYoUTwpXJKRLHUCFz4NxVMjWGMwa57+q3PINSvmeEJ+4hwVyuC
 oCP+MzYt6sN2e8eWJzmdc3xye4RLbjjRUj+QG5Oqq/QsC21f3O3AY6O7L w==;
IronPort-SDR: ouuKgzlHt1WfibISeXqmiSzm7rOHKI9OkmzLeoOgdrP1/QCtx3JPkT8ZKBeccYFJx30KmsjkWK
 ruCTxgihrcNEaEc3AeYk1dRn4OhLAMTuBC0zRQH1VXHi9Wa00tYTURnUKmYZZamOeMgUzHR92T
 oLIuXvUUg6cUObOZA//p7TJmEg0QG1UGSyK+Vt0PkBZ+ue1P+yn4bQC0a1zX1C+HUUP0tgwNWS
 DPe+whtpOnnWPStlDJbZrd8MgltZfrPncRj9LJ4A76AHgRuvdvaEDxc2+g397dJn73uRwXVRby
 3oU=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; d="scan'208";a="170653290"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 09:28:59 +0800
IronPort-SDR: pLATOSSKC75RpCSbv73vHpbcVnTeX4krH28gTY3KDbgQQqhi16KIzQgXU8sJxgrZ7r8v1jRQwZ
 9blxxt3e84agpc32RjVzNkKFuXt10EsnhUn5S4WZrUPAsqBs+1buhZlvi93jPxVBKrrTue6fL5
 S3m/ZxL2RzMSdxqOuQephtRIRCO43zehdM4pDs2VxtQ1/o5YalT+LUBnky3vSjgDX1ymevsd8Q
 NcLg4gav21TW3gpzO7cnWsMNj/NDFJDNcSuYvxgcAyvKHFEUEkWypFpkFnmpx6wjkobVMC50ne
 D4W2IeoguylunB+T8xKx8C5h
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2021 18:06:38 -0700
IronPort-SDR: wDSFS5JUhFK1OElvHg8JLZoUCZOQgsMf0uaLVMAz7AaH+FQTTAXBYGrl+CB1NA8YU3ae4TAQiS
 PgmVEdx6fymUo1sqsK1NYBIURnlKZiAYP/nu2aMDfEKNjgSdm8DBve4qvkiT238nQGIPflslPl
 kw6jKSjylBYWyPqJWHefZJ5+BQfY3y0BDvDrQ8Y5VUTAd+OOwgBVGvqI2DYkoNe1Mnt22iJ1q5
 D5W0S2lYD81pe5ieLRVXRv4gwfwafTmW2MQo+M+02OHBJ6ml/m19l1pMi7UxUBkJuLW2HoxMgx
 LhM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Jun 2021 18:28:59 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 4/4] nvme-tcp: use ctrl sgl check helper
Date: Wed,  9 Jun 2021 18:28:26 -0700
Message-Id: <20210610012826.53398-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210610012826.53398-1-chaitanya.kulkarni@wdc.com>
References: <20210610012826.53398-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_182900_275360_187E440A 
X-CRM114-Status: GOOD (  12.46  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
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
