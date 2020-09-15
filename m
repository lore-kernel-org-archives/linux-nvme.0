Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6952CC43461
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 21:51:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08DEC2078E
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 21:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ii9knilA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lnjThdBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DEC2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bB3pC9EkdvXjQpdtEQKJzv2jXNYi9DLWNAIi2p0Wcm4=; b=Ii9knilA4esMwucjyoEZgB+jU
	16hvLGVZYyTFqwyiA9FyGFdU0VIociulybl2+DT4NyMP7csvBzwIGIVs6Sabjh0jsdCwKrgg8GyRb
	0DdXUvvKcxEyc+AKJDoTm3AcDtgY1wmvTd+CtXaWNNQW3GIJXNUjXLJ4BU9A/awRcw+w5Jm9o3BE3
	An6BzPSAeq+4ybWZFMEH3vu3cXiTsR285KWYT0uTuHF7Ai1Bl7ugFZvS9uFoo7OXT+exv/Q9fKEw/
	fHs+Ny7V3uxMVEUcoeRZuSEefkCW/Rr7d68H/r/ANWHoPBJOvIZkICaIRHiIcjxIaP/xr+Exweus9
	swkMc9+qg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIIri-0001aN-CQ; Tue, 15 Sep 2020 21:51:54 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIIrg-0001Zo-IG
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 21:51:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600206712; x=1631742712;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fyZgeToQld0+VVV9zU6XFmj+ORASH4c/vwsuD6wN2gQ=;
 b=lnjThdBGrb84SbRjksvSfm68XxRqyw9X8GrJTIZH74MEeXDhnRpDfzf3
 QKHjktgPkS8UHaUB1QPw+LYN082Zm0tdvugSczJ4vGjuizHAAQCz7HK+c
 LkozEneZzDm4r6NueEKkBSg5URhHLWeeDRuBxYmE/n9gmQejOllSDvPr8
 Dwm10DMOruN/9DqceYqjMOieyh64JKX985equTbotitSGTzPAW5byS7AT
 WqX/V+yPMIOTiLuJ6VIrvRXwBYL3Fveg71SHY4+7qtNu/sP4HG0HzJ7b7
 bN8Mk/v7Tj4vqCZ8Lu0BHotMdtfgHW7PM9UDViGonEzEMiTQlAVtxr4JZ w==;
IronPort-SDR: Mvz+3hMd+wayySfQa4FpQPs21FxYBtranDwV7McvAbDwxlyRJW5uuToBtxcyCL4BhpIFgnUc0d
 E3z99Uw4A8+Kmnzaqe+hgOLNwgl1FIrI3wbbe5SGMX725Acq9IvYRRdrOshhYXStWznNmvOH/6
 gRcYY4Pd6IcXNDfLHCJIfa4rOoBGFl2N4zvuC4EWcVSFbAAKGsIy10zqf/FqsbFj4y9505o6Ol
 igLM3g4RcDoq+x8am3QaRfmWFFB43CTQnuevQxrLUFM+OsH+6o68esxHhpLTM56henwykWL3Is
 ZtA=
X-IronPort-AV: E=Sophos;i="5.76,430,1592841600"; d="scan'208";a="147473506"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2020 05:51:52 +0800
IronPort-SDR: rw0HmyAln8a+kCJppMSuxMJ6Ca5xbyQh6xmDZLJFJ8s2cqGXlc5ci/80qOUSGrp4iW2pfMnCI3
 ujNhwdT+h70w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2020 14:38:08 -0700
IronPort-SDR: wp4/p2sgfZnDfQg05laJFd5QICVxbVokE/EFs2fT13ZLdTIdtchGdwtvUXvN3xKL55u2QjQrw+
 NgHh2+PCLD3A==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Sep 2020 14:51:52 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 4/7] nvmet: set default timeout for passthru requests
Date: Tue, 15 Sep 2020 14:51:15 -0700
Message-Id: <20200915215118.3934-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200915215118.3934-1-chaitanya.kulkarni@wdc.com>
References: <20200915215118.3934-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_175152_735180_7371A776 
X-CRM114-Status: GOOD (  12.94  )
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

In nvmet_passthru_execute_cmd() we don't set the default timeout values
for passthru requests. Use the default values ro set the passthru
request timeout.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 8bd7f656e240..53a3906bd913 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -242,6 +242,8 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		goto out_put_ns;
 	}
 
+	rq->timeout = q->queuedata ? NVME_IO_TIMEOUT : ADMIN_TIMEOUT;
+
 	if (req->sg_cnt) {
 		ret = nvmet_passthru_map_sg(req, rq);
 		if (unlikely(ret)) {
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
