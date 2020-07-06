Return-Path: <SRS0=+gr8=AS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409A4C433E1
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 00:22:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A22206DF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 00:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UK+pABmc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Go0MeTAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A22206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6k4E2JhaMAPbHmMGN/qBU8+Wo9T55OpAJWBOJGRnqfY=; b=UK+pABmcah/HWgGPmRM9ktMm8
	sUKv8sKIPgi8SaJbHn5vOh27pMQntKG1N300P0wSiprJt+ErKUxPtwW+V30mlT6Mu+GDAstJjCV7q
	ccDrDIpybkx/zCGee7cOj3HYH6tgkD1TZ2AFsk8O3zSrEuIY2puF8V2iYZstW2CXZTSgGEv4fP8LI
	KOGHJNi1vcdCqRfuJTc7npmRUiR9uyW1lRSX7popW0gWS+KlHHq1mxfUMMLtiMYbqkyaFZVjuwoPD
	5VSF+9UFvy3kYzd4plxDl+RJdTcU4tdQbVIWQZUA9venp6kxZTq5ml1tLqbjg4X0T/ubxbBp232sd
	oW2J4wc1Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jsbNP-0001o9-RJ; Tue, 07 Jul 2020 00:22:23 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jsbNN-0001mz-5c
 for linux-nvme@lists.infradead.org; Tue, 07 Jul 2020 00:22:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594081341; x=1625617341;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gKvi7eVQdn+83nrFqth1vu8AAgvdmYFDRZoRzPFA1KA=;
 b=Go0MeTAh1hgIrlPJtPF/X4fXA4Cavxuqua/1Ag2UigIRp2OfQy3NLY5b
 tQwhVcB4uHOMCQAi+itncLbDApm5noQ7cnYtMnPZZYwNMebOZK/mK9k4q
 wYKDMbevcSkbiJjM/P/8do5LmzoaCGWCoRmGhEzbBHZW8qaBMB6n97CbM
 RLGuYnNks2SffblU9y+c+YERrEuRfwl9jDBcl03frWU/RnmFMW7/51GzX
 iQyoYmQeN3c6Lp8m9T8LdAtnGjXY7tPt/oSyQt7ImER/BXdPlRouyup8y
 wcnY6dtzmB3J07oL6wIfA9rBazc9p+DAOFmPYkxJb++N+T5hr+L+h9/sR Q==;
IronPort-SDR: RaGhjCkfculPV5UB9hRlttXpzvo+GUSu3G49W9jPnJguccH1XPBNXRG7nh7eDxc6sqLIaDVLL/
 MwgK7VsK2LRcUoyELUJrHiYZBxKIo1Dlh9LE0An46v3wujig9OZPy/OXj0HC0f5vyTtLEt/ff0
 /OwthAirfdSrevpjPLZoduAYi+vUFpH+T1Z81JPeTSm9nU+Muxy99U9FJezYypRooiWvVHBmfw
 4F7i9QRwZkVXTgxeOOz8oU6fVJTkfdtdRZ5pU+TZl5zwB5IZFhWyJHE2MPqqFXuryIwaGdGIoU
 Qx8=
X-IronPort-AV: E=Sophos;i="5.75,321,1589212800"; d="scan'208";a="146090518"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2020 08:22:04 +0800
IronPort-SDR: WXVVzaaWKzUa0qtgSntdTVXsJJtW9YuFbheVhwUBf5vNHVUheJwgfLgn253NB0gMGs6aJAUxEj
 X1Bgmo7mthV5YV61XGWwfJPaBB7M4kdXQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 17:10:44 -0700
IronPort-SDR: gaL6oWEtGHey8Ah6FCbhJCDAkqigow93zDJrpAEKvTGCnwDl130p2MdhBfIAlXzd2krwZl5C5e
 RBT0T1hsRWgg==
WDCIronportException: Internal
Received: from ioprio.labspan.wdc.com (HELO ioprio.sc.wdc.com) ([10.6.139.89])
 by uls-op-cesaip02.wdc.com with ESMTP; 06 Jul 2020 17:22:03 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: hch@lst.de, james.smart@broadcom.com, kbusch@kernel.org, sagi@grimberg.me
Subject: [RFC PATCH 3/5 COMPILE TESTED] nvme-tcp: reduce
 blk_rq_nr_phys_segments calls
Date: Mon,  6 Jul 2020 16:15:22 -0700
Message-Id: <20200706231524.16831-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200706231524.16831-1-chaitanya.kulkarni@wdc.com>
References: <20200706231524.16831-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200706_202221_351682_DDC396DA 
X-CRM114-Status: GOOD (  12.67  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In the fast patch blk_rq_nr_phys_segments() is called twice for TCP
fabric. The function blk_rq_nr_phys_segments() adds a if check for
special payload. The same check gets repeated number of times we call
the function in the fast path.

In order to minimize repetitive check in the fast path this patch
reduces the number of calls to one and adjust the code in submission
path.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/tcp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 860d7ddc2eee..ca0f8f17ef29 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2173,7 +2173,7 @@ nvme_tcp_timeout(struct request *rq, bool reserved)
 }
 
 static blk_status_t nvme_tcp_map_data(struct nvme_tcp_queue *queue,
-			struct request *rq)
+			struct request *rq, unsigned short nseg)
 {
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_tcp_cmd_pdu *pdu = req->pdu;
@@ -2181,7 +2181,7 @@ static blk_status_t nvme_tcp_map_data(struct nvme_tcp_queue *queue,
 
 	c->common.flags |= NVME_CMD_SGL_METABUF;
 
-	if (!blk_rq_nr_phys_segments(rq))
+	if (!nseg)
 		nvme_tcp_set_sg_null(c);
 	else if (rq_data_dir(rq) == WRITE &&
 	    req->data_len <= nvme_tcp_inline_data_size(queue))
@@ -2196,6 +2196,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 		struct request *rq)
 {
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	unsigned short nseg = blk_rq_nr_phys_segments(rq);
 	struct nvme_tcp_cmd_pdu *pdu = req->pdu;
 	struct nvme_tcp_queue *queue = req->queue;
 	u8 hdgst = nvme_tcp_hdgst_len(queue), ddgst = 0;
@@ -2210,8 +2211,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	req->data_sent = 0;
 	req->pdu_len = 0;
 	req->pdu_sent = 0;
-	req->data_len = blk_rq_nr_phys_segments(rq) ?
-				blk_rq_payload_bytes(rq) : 0;
+	req->data_len = nseg ? blk_rq_payload_bytes(rq) : 0;
 	req->curr_bio = rq->bio;
 
 	if (rq_data_dir(rq) == WRITE &&
@@ -2233,7 +2233,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	pdu->hdr.plen =
 		cpu_to_le32(pdu->hdr.hlen + hdgst + req->pdu_len + ddgst);
 
-	ret = nvme_tcp_map_data(queue, rq);
+	ret = nvme_tcp_map_data(queue, rq, nseg);
 	if (unlikely(ret)) {
 		nvme_cleanup_cmd(rq);
 		dev_err(queue->ctrl->ctrl.device,
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
