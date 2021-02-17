Return-Path: <SRS0=TApw=HT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1560C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 01:16:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D66264E2F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 01:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D66264E2F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XJsLrrOFK45xwzc6KlNtr3QtylLqX8a/8Wb403hZsQY=; b=wb/oRsHS8LMX8HVuOG2CtECNP
	oFmDvjBHgplmbBX6STPsg9IUgsdkWVUFgARIx+ihIf0Vz08pAmpY7MC+l0CsHZ5GQvEkAgU17d+rF
	+kWtzEK09MO5aV3HBp9JxVr6PTfaizIouOIiVTFK3ZYLbrVMLnRuYdbqw95o9BiXC/QgZIX/Kw2pL
	MPBT0JlbwhDYEyWOTib7u7snxwu7Hsfq+y1eICL4sN87uhNvdgROJ4u2hKqteL9HVy2z11HYBEBxD
	Dki+v469Bp1fIJppdxfzhWq0c7j+nLSbnP2IOI84hpu/BGudNWQN1VWwBAo5bsPlNN+JSLE8nzh7A
	ucLklLYBg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCBRw-00056J-13; Wed, 17 Feb 2021 01:16:16 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCARe-0007uJ-Qu
 for linux-nvme@lists.infradead.org; Wed, 17 Feb 2021 00:11:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613520715; x=1645056715;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oxqI8KrK4sKBKVnJHHhqIxcSYPTGc/xL6+8fR+ie+2s=;
 b=oRfoKJJVDLgSRt4ZLnxaLK4nV1AxzD5TsLJQqLT2BJC65O7ZwjxnYIlR
 h9fX8Ot5/hm95VaKBUZBmbWAoK9TlHUP1GKUqhCGg7KudkvY2CAvsId0Y
 gKuC55Br7pcgt+qIzCA2EOkg5SsNaQOfwqfIHdYFX8frrkvme++KD+vex
 SjB6mNs7S2pTVQ1MukBTdF9lJFD+xMe4H96hca2Ud/LFxwXvjTT+HwNgR
 fhh0uV/Q7y11OOGzM08gRqsPVFX/a7o8sZEr1iUjlcjHc21tg6nGPmI9b
 h/6ZoWEjHrdEFMUFF6lZTvytGluMgBnQTpncnfVOBi1L7Bx0lhn+Pfpfz Q==;
IronPort-SDR: cmDsWOeyXmmvQlXiH2FgnrsuUVf0lz8NMzehUYnPvgi+PeXXb8Rsp8WD3kc4hcik9HlYeTPs9o
 BELvHxM8w+p+PQZx6QE1K6Zxz3IfG47HBzy+D2nu4/8X23hJWFjeJ+FTXPRdUqblZ0M6K+URZu
 Yf8SdO1pXXAza2YRCT2fmZ/dF1fvCv2rRqPgJ/XcMuq4rNYf4pMABVxUuYTVkFS4xT9Oku/cvq
 M0ci64DAfymjneTa9dzOE6XKEex90HjDVx5VUuOsE5N5/qY5enk/4CjiLCsVZyvOhZScrkQvG9
 vMM=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; d="scan'208";a="161280088"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 08:11:54 +0800
IronPort-SDR: Nx6XoTzMjp/2EMm6z8iZjKf+KewV2Uxtf/TYO+3BQHSM9cyLAA052Q6AF9htnBGTr9MzYmbSYt
 3U2fwkPxyW0IbyuJzjf9qkARnuYUJK89nrNNg2Lhn1Hg6GqdEGJsc29Ga90P3sM5serBtR45Lq
 AcD2/0AbTofLJGJim06YI8h4tKtbJPKsq4B0xRkvk4axcNyiNIJriIHeDJ5t0J+ataQY5GsRaq
 OJZNrkWuadcSoiXTHximfZJgRsM4iIeQIcPwA3D1fWs8BD62OfC9dhz7TNa0naY7Ja6Pl0V+n/
 SrapxJAGeajfDoQ5xntFhSTR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 15:53:38 -0800
IronPort-SDR: HhCbwzXefSbDS4Wzu7EAOViV5C4mJLKP536l5GxkE5XFkUBbjEb1rt6Lje5PZaqx4sliSbV9AC
 IE8p5/eIpTrbR8DJfIHqzOUjF7t7DN6QbITb2XyFdYCUsh0AK6cKx9glFYUzMjoDvs4y8xnEhk
 bpI7gyB1YB2Ap0S0m7NhhEWI6kkdufk6FlPo01xyBf0TixgtrvGR2X26039CDYXx1F9GSKnQLc
 wzbaEemLpIl+q3vvJfuVe7YnWlfBdHifybx4i5a45a3rCp8tiJst8uE0UvHGVtQ4lDGJkJ4U0r
 Y9s=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2021 16:11:54 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 11/14] nvme-core: use likely in nvme_init_request()
Date: Tue, 16 Feb 2021 16:10:29 -0800
Message-Id: <20210217001032.25741-12-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
References: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_191155_157175_F76012BA 
X-CRM114-Status: GOOD (  14.60  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

For NVMeOF Target passthru backend we allocate the passthru request with
nvme_alloc_request(). The functions :-

nvmet_passthru_execute_cmd()
 nvme_alloc_request()
  nvme_init_request()

are in the fast path for I/O commands.

In nvme_init_request() we set the timeout based on the
req->q->queuedata check & that is always true for the I/O commands
coming from the passthru backend which are high frequency commands.

Annotate req->q->queuedata with likely() in nvme_init_request().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 139cbeb11c7d..a0d0c3a5abff 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -652,7 +652,7 @@ static inline unsigned int nvme_req_op(struct nvme_command *cmd)
 static inline void nvme_init_request(struct request *req,
 		struct nvme_command *cmd)
 {
-	if (req->q->queuedata)
+	if (likely(req->q->queuedata))
 		req->timeout = NVME_IO_TIMEOUT;
 	else /* no queuedata implies admin queue */
 		req->timeout = NVME_ADMIN_TIMEOUT;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
