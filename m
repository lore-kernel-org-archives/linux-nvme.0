Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B649EC47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 05:47:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 831FE61108
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 05:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831FE61108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tQJMbMq1Dtlwbvx8pHfSRlbAQIKPZVt+8EcfBkXkcbM=; b=X7vb1Djf8rnPuQ
	aEhtmjzs/g4yPWgodFY2U8z2pkAEjsaBoECQCEusG9VaP50Ei/rc/R9eg5DeKJk4kDJnsPFoWLSrz
	JNN67gwl647ZEOYn+y6RgKrFzWH0Daj3kkM4t7y9WI+lP6BbOIxIDNhACfVRHPCOzMj2liHYJfkXa
	L6b0DVd5BCF5PWjdImgbskKlli54TtJkuUwCf5V1dYYYaXi65YNfbDtj6qn0btgNOxxKnw9C10sPo
	f2X1Zue03spE4vYmJau4K8svkOO2TldVQxVdTENk9qtJuWf7m3KfVpMDa84158xHdQlOckc9z18Pv
	iQ4nto2JEgKN8FZrmpQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqUa3-006aUp-AJ; Tue, 08 Jun 2021 05:47:15 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqUZm-006aOI-D7
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 05:46:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623131234; x=1654667234;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oGJlNKTNKIZe+MZHLgPTOEnkFSiSRkX8iKNLjxK5slA=;
 b=MfbmGpYHpzHEmdF2t2hDZgotTa31AXoPLCuD6ss+LfFKoQRMMk64QxVg
 ne7UP4V5vg8yIYPAgOcP77uO4n0ZFpzfabmyywD+RbCT5HIWAd5iR3IBC
 lMfabeHiwwGwDnMK7+0K6yX2ee1S+GYkQ0tkYj+5AfqNJKFbsPs4x6Tqv
 ofo0NsglR0GN8BrrBa+Vpp2iqitoIouL7oWP42dKXp6ndcDv7Dd8rI0au
 xeESbZmwsGmxKz26wmWBEwTN/rJrHY+XgYGG4Vp7iuGt0XV519HO3iTSG
 ZXk5jiNJtdHvahksKIoueUof5TnyVo5+16HeOM6U8Vv3WdCgcgZkhnXro A==;
IronPort-SDR: CNLD6+kMmhFk3e7KZzyhPo1UkQkNGngY57HGtt0q9gdhR90zPsOVhiJZJB2OAHIQj4DPb8qc4f
 fBqFrw1xLYyxqiAiK6SV/g+sdKlqHzV0tRCNE5S2YSX1pKAy01DI6WNrpERp8oM9qBn+SNO4Uj
 jJEq1DQnpaahcyO1Hvn3hgv+nfJW0F9ISnOg15O0R99YtEhwQ3jxN7IFcFqTHijfqge5yBq+Tk
 tQu87uUem5B2j1uwaEV+XIF+ObAfIL8tJYEREJOseX/D9NOtN4fR4+voR+WnERDIwHEMY824Yd
 iww=
X-IronPort-AV: E=Sophos;i="5.83,256,1616428800"; d="scan'208";a="274935956"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2021 13:47:12 +0800
IronPort-SDR: dIlLjHnTxtvTNCTjIFi/WkGqWZso9opstWFoA2442qcU2kASAfWTzRfRW5XU1+g0k3d0F/+mvi
 irrUXEriTSNhXi7qao/dprhzGhd0BUK+mVUoBjpnR2qXdQOp+Y+d3hfu6ZxeaQbDsbvHHp4Mm+
 rrJD0tWOl2XAcGCOn/jd9Mmt5tvo9loj0jrW5Obj43O4CUTnImI53g5Zs9YrwxVQG2WgwuzSXK
 digW2I6n1Eb5wsq0gKC4fdW4ugAa+7w8fX4503cavRctN9Rwz1T17Ktvd4xarA7+GHCdFM/hUR
 lrBczhFdQdG5JwB/zLpuDNQe
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2021 22:24:37 -0700
IronPort-SDR: vvRobu9T8pK03HXFRyUOmHx2SVTtO2gDKThS53Qj+Y7lNFw8ciV+2AeVtLORlJEkn/mUroSx3J
 gM3CzwJhGY+WDnfI/D8E+Lp42vtdxAAgAlfnV6ngaqg0QBXRD+eMcY1wRtuQuNH6b4v5sHkGlR
 0lzLvQfIucQFmt7PQ7LzEjTkZSjTFcKhSSJjV+lMUg6nFiBml3OJ3PaK180DJ6VSV6N2ppBU7F
 8rE/yIb1A7wa7t5MCHnrguwP1beBPb/au7Ctgi08CI29JnZjOUe8FNS/EBzT8exTQEfcPckS4K
 OEk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 07 Jun 2021 22:46:57 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, damien.lemoal@wdc.com,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/5] nvmet: add req cns error complete helper
Date: Mon,  7 Jun 2021 22:46:32 -0700
Message-Id: <20210608054635.5661-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210608054635.5661-1-chaitanya.kulkarni@wdc.com>
References: <20210608054635.5661-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_224658_555035_FC869E32 
X-CRM114-Status: GOOD (  12.36  )
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

We report error and complete the request when identify cns value is not
handled in nvmet_execute_identify(). This error reporting is also needed
for Zone Block Device backend for NVMeOF target.

Add a helper nvmet_req_cns_error_compplete() to report an error and
complete the request when idenitfy command cns not handled value.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 5 +----
 drivers/nvme/target/nvmet.h     | 8 ++++++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index dcd49a72f2f3..94230803c75a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -659,10 +659,7 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 		return nvmet_execute_identify_desclist(req);
 	}
 
-	pr_debug("unhandled identify cns %d on qid %d\n",
-	       req->cmd->identify.cns, req->sq->qid);
-	req->error_loc = offsetof(struct nvme_identify, cns);
-	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
+	nvmet_req_cns_error_complete(req);
 }
 
 /*
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index d69a409515d6..058b6d3d48fa 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -622,4 +622,12 @@ static inline bool nvmet_use_inline_bvec(struct nvmet_req *req)
 	       req->sg_cnt <= NVMET_MAX_INLINE_BIOVEC;
 }
 
+static inline void nvmet_req_cns_error_complete(struct nvmet_req *req)
+{
+	pr_debug("unhandled identify cns %d on qid %d\n",
+	       req->cmd->identify.cns, req->sq->qid);
+	req->error_loc = offsetof(struct nvme_identify, cns);
+	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
+}
+
 #endif /* _NVMET_H */
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
