Return-Path: <SRS0=vW9m=7P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888B5C433DF
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2020 02:41:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 366802068D
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jun 2020 02:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="euCyxoWS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DCGw2v2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366802068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JWHG6uFx5UHy+gCDdVq+PABnka508wIn+PuV7Lmosx0=; b=euCyxoWSeyV1/H
	RfuyQxOQRGHnapUVwDYe8sOrtNdF3hM4MqkGMMlcYzw7tVspZbWaBK3ET8oJeDYkyxbMneQryL4YL
	byZJUy3iNnliOCLkyzLIoIdxCbb0s5V9Ft070KM8DasIbreZoARHATXiL8ngffj95XMzcbfX2m+Fi
	DK2CeefWXCBhQvkkiElbz+r6EjwlKGrRdmfZzLQ7I/aWgxGeDGZb7ybiRCP8jkafd8cWBDTzDvY54
	f/NpnLni5qXnSJ0xI/iAgI2jWjBmkIMhy7LB1vYc9sCNUHahdE4cW4Btg+rw9LzKAJ+sVLuJNVfyJ
	lpFKwhBj9GLLQv77AyxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jfwrl-0004Ug-W2; Tue, 02 Jun 2020 02:41:25 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jfwri-0004QU-RC
 for linux-nvme@lists.infradead.org; Tue, 02 Jun 2020 02:41:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591065683; x=1622601683;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Gn2J2vgS1bSmf/zU2AodIuJqOS8DpH6WwdriRj1dVaw=;
 b=DCGw2v2T8qNVKha3aNpasI5A0mKrDexQ+e9v6aSoKqBWkDYy6V2RP3nP
 ZPcXi/0DgbUmIBg7qXpBvDbLm+jd8Nhv639UaSA0XXJa1ivFVZvnuH6Uv
 h4V4srrz7xPTEBRVwFFVWjrsyicgEiW6vNbb4Rw4+p85iB/l6y3WTmPuh
 CM1afsy9phCeNHkyu9OBXqyXrVPIdxlTkc15dOFvAQMVsj38saJW9V9DK
 O+WzbuR5+WCFfQkuYHVfF0mQBZQY7Sk+kntMXE/RtAEVKgZz2jwp1/jlI
 3dIrUBSkNrvFYNd/UY8jbRaVi3hTcOwiwHI7BWMoBRaKzUnGu7mUjNadg A==;
IronPort-SDR: j/dT46UG/YBrpwQ2AGTabPAPKAWxdb6uv+izdVWN4zhf7Us61pwRa5NKDhJnCibG874Drf7ZIM
 M8Wzes/fGVp18mRQoEqihfIHwiuIf+fObJ9Pm/EkkMu1ch9+TiB00wCBJuPx2v2/R2wQcp70t5
 oqS1ALJz+smz9ygrqH/6p5d9NbXyu/XHgh4cw3jNUaiUJBE0JWS57hdbjMwLSAKvetUGc66CRN
 hUslXMoL8FA/BHRm0Ajp+GXMUuCZoJV2LQ6qtiyY0G0DpFEvR1YIPIIeUaFEK9hgZmGu+PU7/2
 0UQ=
X-IronPort-AV: E=Sophos;i="5.73,462,1583164800"; d="scan'208";a="139314110"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2020 10:41:22 +0800
IronPort-SDR: 5Zp9OAVPiODS8XuF1FybHjda/IPSOe6cl/2+P3CCyBUeNWY4C8Dwu//ymuRjdtC9qXEQd39Zii
 1k+1ADw1RwjSOUF6Yv070XtB24ZSsdiwk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2020 19:31:03 -0700
IronPort-SDR: u6FG8JwKs3vRb2/NVd93Y7sZl0jtHKqYkaQv/QgXfT5nVoIyYK33xu9wXhu43szknUq+lZIq2A
 K+6+dC0gCzkA==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 01 Jun 2020 19:41:22 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/4] nvme-core: use u16 type for direcives
Date: Mon,  1 Jun 2020 19:41:11 -0700
Message-Id: <20200602024114.5153-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200602024114.5153-1-chaitanya.kulkarni@wdc.com>
References: <20200602024114.5153-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200601_194122_886562_60934E36 
X-CRM114-Status: GOOD (  11.32  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In nvme_configure_directives() when calculating number of streams use
u16 instead of unsigned type in the min_t() since target variable
ctrl->nr_streams is of type u16.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a3a4dbc59af1..8d05dbf29d76 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -555,7 +555,7 @@ static int nvme_configure_directives(struct nvme_ctrl *ctrl)
 		goto out_disable_stream;
 	}
 
-	ctrl->nr_streams = min_t(unsigned, ctrl->nssa, BLK_MAX_WRITE_HINTS - 1);
+	ctrl->nr_streams = min_t(u16, ctrl->nssa, BLK_MAX_WRITE_HINTS - 1);
 	dev_info(ctrl->device, "Using %u streams\n", ctrl->nr_streams);
 	return 0;
 
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
