Return-Path: <SRS0=H+rW=EL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EDBC55178
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 23:28:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B9E220719
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 23:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RRiKizFP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bhHTv6Rg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9E220719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sEVYJkBBcyvZIafk5lJgTcCx4vZbYZii62eVFFPKZKk=; b=RRiKizFPNF3uP94bPgkv3Fm0v
	ZvqWJc40B4cpwkjzn2+2DpBePKrBQ3MF9J6BygkREuDvj5Ics3cgVDUZxmCMzQfxS/E1FWij/FGt4
	+Lc+7iDr6qnjI2VCecBoF8nwhNr6mqrrDNd4beowU27Vc0kY818MvVt3ZjE3Kiajd1oMYxzgcQCBu
	jwJk8+rIi7CDjbrh0ybiR43pJGmD9SvGLE1zolOVCgpNxTRvajflBFHfIlTOxGgcyIjwAsf5cnZic
	ld2LoshxVG4TVeTiTK5OZYD6LcrXuAAW7Sorqk7qFuZR3/UbnB7L22Zdj37MrvDsb+/7o9H/pOCGl
	L3Pn7EWlA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kaogW-00005N-66; Thu, 05 Nov 2020 23:28:52 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaogT-0008WB-9C
 for linux-nvme@lists.infradead.org; Thu, 05 Nov 2020 23:28:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604618929; x=1636154929;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WgDSzbdvnYhEC8+UIILHzv6vASfhMe4+be5KGFcpnMc=;
 b=bhHTv6RgkfRPmV4+xUIWrXim1XI6aowBSyl4Rc2L28fnEO47HjAmMqLT
 y8mIKlEP0G3FK4mz6wPSNs5riCHnnIXAvIxsisQSKitvOs/BdWJlzYp5Q
 Sq0clueb1psNU/BDqCDvu3SY+AK/Yfw8avoZOehGoTpirmK5xjl/2WWuB
 qUOLrpgzqWubgo6TdsileznbFidulHIVYLJ3JYBP57czndAiwiR3aBs37
 mlc9ooZT24hNaSGhZq6Zg3hae1xYk77sbhgsmAWbeTbzIez2ePZvOe4sM
 C6rKhI6SaEnRgp8PJkNiWzpzr5wGcvKuZN9OmFanFeJqbEl6RhD6Oy5ui Q==;
IronPort-SDR: 0WvK+jRSo1AySUGcgCdXx92SSNYnQIbxUjLV1JOtYHQt09B6DCjkIbj+0CaulQM+jk011lWZxU
 qhlj4P1cUHa2Vrp+8f+udtQJynvJ7gJSYIAduS/VRR2Cs3wjZr3kH7XYtdjeLGXaGH/xI0MiE/
 +Z4LaHQUiYpepwk9ZsTUnYhNb80Ynb3r30p7BqlY/4aNX7//acJt1T+NOiqiaC422gPaNddrNo
 kJexUt473CdAMcQhoOQ9JjsO0E/utJtiKt0bDSonPkDRoK1ujvIc/ZjjcdYgv6hfX7Jgn0f9Eb
 lAI=
X-IronPort-AV: E=Sophos;i="5.77,454,1596470400"; d="scan'208";a="152084109"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2020 07:28:46 +0800
IronPort-SDR: uR8Y58HUf+x6MX/+NEwosfIqZwd0v6zHAkoi70dg7wewX6h+cB8XTRxOLgwq4THFC0Tge8AWLD
 /tkt4IG2jjCaY5zMjlMw96wfqITcu7+IgQDELOE1DRvYrbcEryDj6yeoVFaB/xxkAmlMCfPNMR
 zU9uE4+6o6KYxlaYL9optKYeB0XsnfpE4NDSY8KfnTfeuauTe41T2TMutxnNjNPsLRL7eUryl6
 SXJBRXMPbmJimviEh6I7kP+qjhQaaVVL6NgY6qE8bDCCRIwepOcLcWvroyGufY4+0PsaTbJRei
 ARZIdnnjFuePXJDm6bec+sci
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2020 15:14:52 -0800
IronPort-SDR: CHdJ7gX+VTUNBZAXlveMkmG4vNrKWFN5vDcaUQw4Q0LKFdh6QsnoLRWB8Ds8YYnpRyOSouTvEM
 4WXI0MuYj9kaqgz0ZxDxHKZXzQGk3gpwoaicPV9T3ExglGOD8coRdleDfpMM2ZW91guCN2O0H3
 p7r+RvZnJngrnboFp/zGw7EalZjFaxQe2sJYfQNehvZLje2h9C5TfX1/3yekufkt8WUa/1/DtO
 TLmc/VU6iYPGIN6goLiRN20h5z8JKP43XkYosKgNDnMAV0wQvJyxhboMCigZWmAWmNHbrYoawT
 x+Q=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 05 Nov 2020 15:28:46 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V7 1/4] nvme: centralize setting req timeout
Date: Thu,  5 Nov 2020 15:28:29 -0800
Message-Id: <20201105232832.21216-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201105232832.21216-1-chaitanya.kulkarni@wdc.com>
References: <20201105232832.21216-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201105_182849_468091_CCFF0EDF 
X-CRM114-Status: GOOD (  14.59  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The function nvme_alloc_request() is called from different context
(I/O and Admin queue) where callers do not consider the I/O timeout when
called from I/O queue context.

Update nvme_alloc_request() to set the default I/O and Admin timeout
value based on whether the queuedata is set or not.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c     | 9 +++++++--
 drivers/nvme/host/lightnvm.c | 2 +-
 drivers/nvme/host/pci.c      | 2 --
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 40ca71b29bb9..e6195f50a265 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -533,6 +533,11 @@ struct request *nvme_alloc_request(struct request_queue *q,
 	if (IS_ERR(req))
 		return req;
 
+	if (req->q->queuedata)
+		req->timeout = NVME_IO_TIMEOUT;
+	else /* no queuedata implies admin queue */
+		req->timeout = ADMIN_TIMEOUT;
+
 	req->cmd_flags |= REQ_FAILFAST_DRIVER;
 	nvme_clear_nvme_request(req);
 	nvme_req(req)->cmd = cmd;
@@ -901,7 +906,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	req->timeout = timeout ? timeout : req->timeout;
 
 	if (buffer && bufflen) {
 		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
@@ -1071,7 +1076,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	req->timeout = timeout ? timeout : req->timeout;
 	nvme_req(req)->flags |= NVME_REQ_USERCMD;
 
 	if (ubuffer && bufflen) {
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 8e562d0f2c30..0617cd8f2c2c 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -774,7 +774,7 @@ static int nvme_nvm_submit_user_cmd(struct request_queue *q,
 		goto err_cmd;
 	}
 
-	rq->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	rq->timeout = timeout ? timeout : rq->timeout;
 
 	if (ppa_buf && ppa_len) {
 		ppa_list = dma_pool_alloc(dev->dma_pool, GFP_KERNEL, &ppa_dma);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0578ff253c47..76465d335924 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1310,7 +1310,6 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		return BLK_EH_RESET_TIMER;
 	}
 
-	abort_req->timeout = ADMIN_TIMEOUT;
 	abort_req->end_io_data = NULL;
 	blk_execute_rq_nowait(abort_req->q, NULL, abort_req, 0, abort_endio);
 
@@ -2223,7 +2222,6 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	req->timeout = ADMIN_TIMEOUT;
 	req->end_io_data = nvmeq;
 
 	init_completion(&nvmeq->delete_done);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
