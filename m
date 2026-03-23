Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0BFD58CBB
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2026 01:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Type:Content-Transfer-Encoding:Date:Message-ID:In-Reply-To:CC:To:From
	:Subject:Mime-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lm3eJzy41fxHu9y8OMr5qQHHqxxNjDpSrF4VTePc+i8=; b=hKvL25K0g8SIft/xaeNrIF94G+
	NVqhgs22TK+SxOIcy+k2NucfF+HAx3QbHIq8T0QZH4PyGvFpAGqXXdyUa0235YmyF14FtKhWRb/JI
	SeVrcyMD7xyYNZWoX1g3H434MGUgLaaMsR1VDys/9Xu5wycefqBL6FaHv+fFHf7zVtv+Oy9VqLpmG
	zGRkzVjRdOUKNM4uYIG87eLSj05cmFVARx6e8Qpg+hlIRn1d5q2xlInUzS/W4Yg7SQdvRnNbNJ9St
	7OG+zhqrD11qFYE1vlWBwzBN6IP+RqsrTuLW9OUuUb+Zzi0B3wohZ+sxYUlvb2OrjvAlxt/a9XwK6
	AG/yI1BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4TjI-0000000Fo4i-3jQI;
	Mon, 23 Mar 2026 01:05:16 +0000
Received: from [203.254.224.25] (helo=mailout2.samsung.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4Tj4-0000000Fo2m-06OK
	for linux-nvme@lists.infradead.org;
	Mon, 23 Mar 2026 01:05:11 +0000
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260323010453epoutp02e5e7183618ced008c5fe777281268f65~fUt5oiKdj1896418964epoutp02N
	for <linux-nvme@lists.infradead.org>; Mon, 23 Mar 2026 01:04:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260323010453epoutp02e5e7183618ced008c5fe777281268f65~fUt5oiKdj1896418964epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774227893;
	bh=lm3eJzy41fxHu9y8OMr5qQHHqxxNjDpSrF4VTePc+i8=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=VK6d4l+XMeEgV8SCEWSHty+Xj8VZIIEaLYkLiW1Xp/KD3bGJqz25m+RU3rrWvVUV6
	 wo7XfcN0/9sjpuV8DBTtyKFnpQToOTeHT35TjI/lSTp5TR2Y/DX36TRk3zTg/s/g2K
	 /8rvNiNvsePp/MZzC1bmEgIfRzsDan8fny8gByR8=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
	20260323010452epcas2p447d6cde507e8a6b13bc49c24b3d48184~fUt5BKSAA1194211942epcas2p4E;
	Mon, 23 Mar 2026 01:04:52 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.38.203]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4ffFM82bXDz6B9m8; Mon, 23 Mar
	2026 01:04:52 +0000 (GMT)
Mime-Version: 1.0
Subject: [PATCH v2] nvme: Move nvme_setup_cmd before hot_pathing
From: =?UTF-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
To: =?UTF-8?B?7Lm47LCs?= <joshi.k@samsung.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "sven@kernel.org" <sven@kernel.org>, "j@jannau.net" <j@jannau.net>,
	"neal@gompa.dev" <neal@gompa.dev>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "justin.tee@broadcom.com"
	<justin.tee@broadcom.com>, "nareshgottumukkala83@gmail.com"
	<nareshgottumukkala83@gmail.com>, "paul.ely@broadcom.com"
	<paul.ely@broadcom.com>, "kch@nvidia.com" <kch@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "asahi@lists.linux.dev"
	<asahi@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?UTF-8?B?7KCE66+87Iud?=
	<hmi.jeon@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <981ab856-9c79-4e08-9906-a81ec298a688@samsung.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260323010451epcms2p38a89259e6c448c3606fe294b6307af45@epcms2p3>
Date: Mon, 23 Mar 2026 10:04:51 +0900
X-CMS-MailID: 20260323010451epcms2p38a89259e6c448c3606fe294b6307af45
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6
References: <981ab856-9c79-4e08-9906-a81ec298a688@samsung.com>
	<20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6@epcms2p4>
	<CGME20260320052101epcms2p42ae135da60b36685e9b7fca6849b57a6@epcms2p3>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260322_180502_724765_F05329B5 
X-CRM114-Status: GOOD (  23.69  )
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
Reply-To: hmi.jeon@samsung.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi kanchan


The reason for calling nvme_cleanup_cmd in the nvme_prep_rq function 
is when it fails after calling the nvme_map_data function.
Therefore, the memory leak does not occur. Did I miss anything?

Additionally, the patch v2 that modifies the warrning detected by
kernel test robot.

>> drivers/nvme/host/rdma.c:2067:1: warning: label 'unmap_qe' defined but not used [-Wunused-label]
    2067 | unmap_qe:
         | ^~~~~~~~


From 53db77a37bbcdc8f8bc1a61452a0586d195ce8da Mon Sep 17 00:00:00 2001
From: Minsik Jeon <hmi.jeon@samsung.com>
Date: Fri, 20 Mar 2026 14:48:07 +0900
Subject: [PATCH v2] nvme: Move nvme_setup_cmd before hot_pathing

we were checking host_pathing_error before calling nvme_setup_cmd().
This is caused the command setup to be skipped entirely when a pathing
error occurred, making it impossible to trace the nvme command via
trace_cmd nvme_complete_rq().

As a result, when nvme_complete_rq() logged a completion with cmdid=0,
it was impossible to correlate the completion with the nvme command
request.

This patch reorders the logic to first call nvme_setup_cmd(), then
perform the host_pathing_error check.

Co-authored-by: Beomsoo Kim <beomsooo.kim@samsung.com>
Co-authored-by: Eunsoo Lee <euns212.lee@samsung.com>
Co-authored-by: Steven Seungcheol Lee <sc108.lee@samsung.com>
Signed-off-by: Minsik Jeon <hmi.jeon@samsung.com>
---
 drivers/nvme/host/apple.c  |  6 +++---
 drivers/nvme/host/fc.c     |  8 ++++----
 drivers/nvme/host/pci.c    |  8 ++++----
 drivers/nvme/host/rdma.c   | 10 +++++-----
 drivers/nvme/host/tcp.c    |  8 ++++----
 drivers/nvme/target/loop.c |  6 +++---
 6 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index ed61b97fde59..2a28c992d024 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -783,13 +783,13 @@ static blk_status_t apple_nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(!READ_ONCE(q->enabled)))
 		return BLK_STS_IOERR;
 
-	if (!nvme_check_ready(&anv->ctrl, req, true))
-		return nvme_fail_nonready_command(&anv->ctrl, req);
-
 	ret = nvme_setup_cmd(ns, req);
 	if (ret)
 		return ret;
 
+	if (!nvme_check_ready(&anv->ctrl, req, true))
+		return nvme_fail_nonready_command(&anv->ctrl, req);
+
 	if (blk_rq_nr_phys_segments(req)) {
 		ret = apple_nvme_map_data(anv, req, cmnd);
 		if (ret)
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e1bb4707183c..8ea37102a836 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2762,14 +2762,14 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	u32 data_len;
 	blk_status_t ret;
 
-	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE ||
-	    !nvme_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
-		return nvme_fail_nonready_command(&queue->ctrl->ctrl, rq);
-
 	ret = nvme_setup_cmd(ns, rq);
 	if (ret)
 		return ret;
 
+	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE ||
+	    !nvme_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
+		return nvme_fail_nonready_command(&queue->ctrl->ctrl, rq);
+
 	/*
 	 * nvme core doesn't quite treat the rq opaquely. Commands such
 	 * as WRITE ZEROES will return a non-zero rq payload_bytes yet
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b78ba239c8ea..ad0363f7e681 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1376,10 +1376,6 @@ static blk_status_t nvme_prep_rq(struct request *req)
 	iod->meta_total_len = 0;
 	iod->nr_dma_vecs = 0;
 
-	ret = nvme_setup_cmd(req->q->queuedata, req);
-	if (ret)
-		return ret;
-
 	if (blk_rq_nr_phys_segments(req)) {
 		ret = nvme_map_data(req);
 		if (ret)
@@ -1418,6 +1414,10 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
 		return BLK_STS_IOERR;
 
+	ret = nvme_setup_cmd(req->q->queuedata, req);
+	if (ret)
+		return ret;
+
 	if (unlikely(!nvme_check_ready(&dev->ctrl, req, true)))
 		return nvme_fail_nonready_command(&dev->ctrl, req);
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 57111139e84f..36f1a5a41ed9 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2005,6 +2005,10 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	WARN_ON_ONCE(rq->tag < 0);
 
+	ret = nvme_setup_cmd(ns, rq);
+	if (ret)
+		return ret;
+
 	if (!nvme_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
 		return nvme_fail_nonready_command(&queue->ctrl->ctrl, rq);
 
@@ -2020,10 +2024,6 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	ib_dma_sync_single_for_cpu(dev, sqe->dma,
 			sizeof(struct nvme_command), DMA_TO_DEVICE);
 
-	ret = nvme_setup_cmd(ns, rq);
-	if (ret)
-		goto unmap_qe;
-
 	nvme_start_request(rq);
 
 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
@@ -2064,7 +2064,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	else
 		ret = BLK_STS_IOERR;
 	nvme_cleanup_cmd(rq);
-unmap_qe:
+
 	ib_dma_unmap_single(dev, req->sqe.dma, sizeof(struct nvme_command),
 			    DMA_TO_DEVICE);
 	return ret;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 243dab830dc8..1a3640e81b8f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2705,10 +2705,6 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	u8 hdgst = nvme_tcp_hdgst_len(queue), ddgst = 0;
 	blk_status_t ret;
 
-	ret = nvme_setup_cmd(ns, rq);
-	if (ret)
-		return ret;
-
 	req->state = NVME_TCP_SEND_CMD_PDU;
 	req->status = cpu_to_le16(NVME_SC_SUCCESS);
 	req->offset = 0;
@@ -2768,6 +2764,10 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 	bool queue_ready = test_bit(NVME_TCP_Q_LIVE, &queue->flags);
 	blk_status_t ret;
 
+	ret = nvme_setup_cmd(ns, rq);
+	if (ret)
+		return ret;
+
 	if (!nvme_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
 		return nvme_fail_nonready_command(&queue->ctrl->ctrl, rq);
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 4b3f4f11928d..475b532d08e8 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -140,13 +140,13 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	bool queue_ready = test_bit(NVME_LOOP_Q_LIVE, &queue->flags);
 	blk_status_t ret;
 
-	if (!nvme_check_ready(&queue->ctrl->ctrl, req, queue_ready))
-		return nvme_fail_nonready_command(&queue->ctrl->ctrl, req);
-
 	ret = nvme_setup_cmd(ns, req);
 	if (ret)
 		return ret;
 
+	if (!nvme_check_ready(&queue->ctrl->ctrl, req, queue_ready))
+		return nvme_fail_nonready_command(&queue->ctrl->ctrl, req);
+
 	nvme_start_request(req);
 	iod->cmd.common.flags |= NVME_CMD_SGL_METABUF;
 	iod->req.port = queue->ctrl->port;
-- 
2.52.0


