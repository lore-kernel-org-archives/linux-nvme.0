Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543DACF8548
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Nov 2025 07:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Type:Content-Transfer-Encoding:Date:Message-ID:CC:To:From:Subject:
	Mime-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=ND09Nwkz2+90smiAmNdPyw59ZMB6NJrulnHGbg09uFk=; b=ANL5DYB2X4QxGjp0YBbA2OBxSM
	Hios9rtWMz9Oq9nGeaHvXemmq5/co53YJ7UA7FPZEDWaD4hg7+6PimoQNaB/EQ1Q4SBasyK8v8vIZ
	x7f4X/QRP3i1PQfPnswUV27WMH5lx1JQEVkI2m3+HCngUrs8Ys2byJN5qrOx7HqXdadi5xIj6afr/
	oG9SssKSn4ozV+VRTGUsl3QghOvJYNNVY3tilGIN90wBFabvsEgAuzKMyD5fu4+Pdu0bl6naLiIyw
	fcQp7RF2h93obLElK/kPZuGMg1kRyq9qlCT+Ya0vSMg3eOE+UhzL4kkLoMocU0SB2Ssoy8h+4W3l6
	0tdOn8Aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLyqw-00000006HVq-218H;
	Thu, 20 Nov 2025 07:13:14 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLyqr-00000006HUO-3g8z
	for linux-nvme@lists.infradead.org;
	Thu, 20 Nov 2025 07:13:13 +0000
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20251120071304epoutp02a20e9e346cb6459cecf1eb37a11384be~5pZQMvNW21601616016epoutp028
	for <linux-nvme@lists.infradead.org>; Thu, 20 Nov 2025 07:13:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20251120071304epoutp02a20e9e346cb6459cecf1eb37a11384be~5pZQMvNW21601616016epoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763622784;
	bh=ND09Nwkz2+90smiAmNdPyw59ZMB6NJrulnHGbg09uFk=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=LdR1FvUbI13QdHI/uuHQ4u12zvdMRAgLq6baMRxw9vKE+fku43QrPwfXHjoO6UmNi
	 mEKFnQuzZiH9gdtdSXWVHM0XFrL1aQeUDlOs0Hh/NAgR41lyyRuTiw59EMS0js+qQ7
	 4J3sZcDBaLCHfJ5zUsJPjgt1M4MnY/xG/w8fodFA=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20251120071303epcas2p2fe5a8d265dfed108cd92a80479af8684~5pZPnarpH3199531995epcas2p2X;
	Thu, 20 Nov 2025 07:13:03 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.38.201]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4dBqLl2d0cz6B9mF; Thu, 20 Nov
	2025 07:13:03 +0000 (GMT)
Mime-Version: 1.0
Subject: Subject: [PATCH] nvme: Call nvme_setup_cmd before check
 host_pathing_error.
From: =?UTF-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "asahi@lists.linux.dev"
	<asahi@lists.linux.dev>
CC: "sven@kernel.org" <sven@kernel.org>, "j@jannau.net" <j@jannau.net>,
	"neal@gompa.dev" <neal@gompa.dev>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "justin.tee@broadcom.com"
	<justin.tee@broadcom.com>, "nareshgottumukkala83@gmail.com"
	<nareshgottumukkala83@gmail.com>, "paul.ely@broadcom.com"
	<paul.ely@broadcom.com>, "kch@nvidia.com" <kch@nvidia.com>,
	=?UTF-8?B?7J207Iq57LKg?= <sc108.lee@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20251120071302epcms2p79062e2da03d95e64d78266f5bdad3f7b@epcms2p7>
Date: Thu, 20 Nov 2025 16:13:02 +0900
X-CMS-MailID: 20251120071302epcms2p79062e2da03d95e64d78266f5bdad3f7b
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251120071302epcms2p79062e2da03d95e64d78266f5bdad3f7b
References: <CGME20251120071302epcms2p79062e2da03d95e64d78266f5bdad3f7b@epcms2p7>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251119_231311_431819_197ED217 
X-CRM114-Status: GOOD (  20.09  )
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

From f77ad0431e08d66be940aaf31d7d79780ac3a3da Mon Sep 17 00:00:00 2001
From: Minsik Jeon <hmi.jeon@samsung.com>
Date: Thu, 20 Nov 2025 14:33:11 +0900
Subject: [PATCH] nvme: Call nvme_setup_cmd before check host_pathing_error.

we were checking host_pathing_error before calling nvme_setup_cmd().
This is caused the command setup to be skipped entirely when a pathing
error occurred, making it impossible to trace the nvme command via
trace_cmd nvme_complete_rq().

As a result, when nvme_complete_rq() logged a completion with cmdid=0,
it was impossible to correlate the completion with the nvme command
request.

This patch reorders the logic to first call nvme_setup_cmd(), then
perform the host_pathing_error check.

trace_nvme_complete_rq()
nvme6: qid=0, cmdid=0, res=0x0, retries=0, flags=0x2, status=0x370

Acked-by: Kibeom Son <kibeom.son@samsung.com>
Co-authored-by: Beomsoo Kim <beomsooo.kim@samsung.com>
Co-authored-by: Eunsoo Lee <euns212.lee@samsung.com>
Co-authored-by: Steven Seungcheol Lee <sc108.lee@samsung.com>
Signed-off-by: Minsik Jeon <hmi.jeon@samsung.com>
---
 drivers/nvme/host/apple.c  | 6 +++---
 drivers/nvme/host/fc.c     | 8 ++++----
 drivers/nvme/host/pci.c    | 8 ++++----
 drivers/nvme/host/rdma.c   | 8 ++++----
 drivers/nvme/host/tcp.c    | 8 ++++----
 drivers/nvme/target/loop.c | 6 +++---
 6 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index f35d3f71d..4e3b0ded9 100644
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
index 03987f497..ad8402d3a 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2764,14 +2764,14 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
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
index 72fb675a6..d57347eb0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1149,10 +1149,6 @@ static blk_status_t nvme_prep_rq(struct request *req)
 	iod->total_len = 0;
 	iod->meta_total_len = 0;
 
-	ret = nvme_setup_cmd(req->q->queuedata, req);
-	if (ret)
-		return ret;
-
 	if (blk_rq_nr_phys_segments(req)) {
 		ret = nvme_map_data(req);
 		if (ret)
@@ -1191,6 +1187,10 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
 		return BLK_STS_IOERR;
 
+	ret = nvme_setup_cmd(req->q->queuedata, req);
+	if (ret)
+		return ret;
+
 	if (unlikely(!nvme_check_ready(&dev->ctrl, req, true)))
 		return nvme_fail_nonready_command(&dev->ctrl, req);
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 190a4cfa8..266531fda 100644
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
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9a96df1a5..d847ca0d6 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2704,10 +2704,6 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	u8 hdgst = nvme_tcp_hdgst_len(queue), ddgst = 0;
 	blk_status_t ret;
 
-	ret = nvme_setup_cmd(ns, rq);
-	if (ret)
-		return ret;
-
 	req->state = NVME_TCP_SEND_CMD_PDU;
 	req->status = cpu_to_le16(NVME_SC_SUCCESS);
 	req->offset = 0;
@@ -2767,6 +2763,10 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 	bool queue_ready = test_bit(NVME_TCP_Q_LIVE, &queue->flags);
 	blk_status_t ret;
 
+	ret = nvme_setup_cmd(ns, rq);
+	if (ret)
+		return ret;
+
 	if (!nvme_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
 		return nvme_fail_nonready_command(&queue->ctrl->ctrl, rq);
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index f85a8441b..b2dcbea2b 100644
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
2.47.1


