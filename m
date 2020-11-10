Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20462C2D0A3
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 02:24:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95DF1206C0
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 02:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tNtbKi4a";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZgoRyK4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DF1206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=X1xCW8eUcka4aUtmXLb5425DlMhgm3nqgsW+PjzMNQQ=; b=tNtbKi4az7l+PBSjO+d5+CnQp
	/q3VuTqUybsLTHB7+T9TIOKWviX9edDt03bYvEAJUR0apOIYJlKxA5AxQCRTGAkKNTMwgD2UdBYSW
	CUJ0Uw+Nr9Q3dpjOW3nQfz2pWrShAE9hMzJdql4LWsz1xuMV0zTvJ6cUUKeON1+R4H6tV63SzcGJG
	N1V6eMwe+r+uczORoP1qy6vRg6rJsnVGBNRQc0b9WMItQvN1wScds86u/1GByfiwa9tP9HO+XBshD
	Dm4GoJrYp4TvC302TzM0K0qcfkVE5EVuKN9ohguLwqFUvHdsWTCePF5r8lNR12b6Cp9OqQ223msBR
	EwsU65kNQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcJKX-00061z-Dc; Tue, 10 Nov 2020 02:24:21 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcJKS-0005uC-91
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 02:24:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604975056; x=1636511056;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ts7dWhWksChe+Ge9MmVR/giRlJQuhaWDRlUWiBwj91A=;
 b=ZgoRyK4QpMuW2rCoZC/0HzHJxcFZJaKjqzLT9/GQpz6nw/T3+b07W+Xb
 CsfwV4Z1OhtYn0DYHW/8zF3vFhhMRTk5PaDjRfNW+QM29zyUdvAuNh92H
 YXR2NXPGIzRfeqSpGA0EGDhR7aDEmnwfeechOggXW3VF1blkjE6E6pHev
 JSNHTmGrI0Og52hkL6klmQc+pxWL3/dd/Ij05NVF4e1x8L7fQSWtxKYGa
 JoWLcOb86AaBXpN26jcJ/ciJREUj+dM8B886WC4IjNIuPGnvfVog7JoND
 kmYmyeFx30ekI7lwHcfIuMukC3oJVDf6zGxPJtuG9TlmBZryMOD6QdqxH w==;
IronPort-SDR: d4xsuvOK7pTContaCpGY1YXToGbztKL8l8Lx/mqQEK1reejw9XcBZ8iBo06Cz9sgkLQ501wA3l
 GEo6DRuS53LQWAVQODek9/lHn54YV2U+CA6U5KNVvc/C5st+H7YjqEuqzvKv2hvL/lbC5mQzdJ
 VnlR5cp8xy5L8FSvFvCeiDPlH5+WFhLk9dgQSQFqmVZKRzPVkKCyj0EkLB26ytOagRwI39JL0v
 vkBtzmGKcb+PmUhSEygZZbpPCqE2ycoHucP2nf6YEhev7O2l1TRFrjCQB724WeSmofP3SQwtgO
 SNA=
X-IronPort-AV: E=Sophos;i="5.77,465,1596470400"; d="scan'208";a="156720731"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 10:24:15 +0800
IronPort-SDR: 5ux7S/BJofC/ljK9zbx1q51ZAW/d5B7W8RdV1TZ0nriDk3T2eejfKcyq7ZikfBY36f75IpsiAP
 d461RctbcLu9S7peKX/eaMOzdXMF8ZsQOcJekMAd3oiMPe0aeVVDYLwKnz99WZoELGucZyTrz+
 GbwfiIUZh1eN46cOy+lV6+hihVZfSG8JRp7jwANwg/+Nm2naujBzWLpxwB8n1iYaGFEK0hET5l
 I9rj3BUGp+YqK9yEzDd6vbxDc4iHG4NUV9TGzYEDSedIpCFJ3HslF4H2SXhABuH51T4sa98lwX
 xr9dM2WDJ+gKw537nR9LevA4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2020 18:10:17 -0800
IronPort-SDR: +vJOryP7guqQjvrSL95yyrjEW62tWwoNWTJk9KKDadTS704hqNHuh+28OpFp9gJun/WoEejMa6
 gYDMddWI7t0thd694WZyTxqUQYm6y80Q5U+BZRKvGiQNo8m1iAcA1VDnqic7j1S/B61RQHrTNp
 ZhhMi1TCHaLPChu6DFZhLC7g1TT/mJYqKz/cHOBDokXivGadJhQWNf4F1Vr9A2NojCnZvzyNGF
 ioQ0Q1D2lYGhHy9EAqdjNWT96IVWl3Qwl4s+OWrzZS9Q/PG+51606bbv7YPAcQ7zDyG2tsezvE
 +UY=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2020 18:24:15 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH V4 1/6] nvme-core: add req init helpers
Date: Mon,  9 Nov 2020 18:24:00 -0800
Message-Id: <20201110022405.6707-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com>
References: <20201110022405.6707-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_212416_637557_99F4E5FC 
X-CRM114-Status: GOOD (  15.35  )
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
Cc: axboe@kernel.dk, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, kbusch@kernel.org,
 Logan Gunthorpe <logang@deltatee.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is a preparation patch which adds a helper that we use in the next
patch that splits the nvme_alloc_request() into
nvme_alloc_request_qid_any() and nvme_alloc_request_qid().

The new functions shares the code to initialize the allocated request
from NVMe cmd, initializing the REQ_OP_XXX from nvme command and setting
the default timeout after request allocation.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/core.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 98bea150e5dc..315ea958d1b7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -518,10 +518,31 @@ static inline void nvme_clear_nvme_request(struct request *req)
 	}
 }
 
+static inline void nvme_init_req_from_cmd(struct request *req,
+		struct nvme_command *cmd)
+{
+	req->cmd_flags |= REQ_FAILFAST_DRIVER;
+	nvme_clear_nvme_request(req);
+	nvme_req(req)->cmd = cmd;
+}
+
+static inline unsigned int nvme_req_op(struct nvme_command *cmd)
+{
+	return nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
+}
+
+static inline void nvme_init_req_default_timeout(struct request *req)
+{
+	if (req->q->queuedata)
+		req->timeout = NVME_IO_TIMEOUT;
+	else /* no queuedata implies admin queue */
+		req->timeout = NVME_ADMIN_TIMEOUT;
+}
+
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, blk_mq_req_flags_t flags, int qid)
 {
-	unsigned op = nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
+	unsigned op = nvme_req_op(cmd);
 	struct request *req;
 
 	if (qid == NVME_QID_ANY) {
@@ -533,14 +554,8 @@ struct request *nvme_alloc_request(struct request_queue *q,
 	if (IS_ERR(req))
 		return req;
 
-	if (req->q->queuedata)
-		req->timeout = NVME_IO_TIMEOUT;
-	else /* no queuedata implies admin queue */
-		req->timeout = NVME_ADMIN_TIMEOUT;
-
-	req->cmd_flags |= REQ_FAILFAST_DRIVER;
-	nvme_clear_nvme_request(req);
-	nvme_req(req)->cmd = cmd;
+	nvme_init_req_timeout(req);
+	nvme_init_req_from_cmd(req, cmd);
 
 	return req;
 }
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
