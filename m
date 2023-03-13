Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841C2C61DA4
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Mar 2023 08:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WKPzzJRbsAtE8gVN+mqeS2P+Vn3NP9FXRntrsjkDiJs=; b=ufZiIQBgKpaJ4RsoAMwggmGCTM
	SjWHfoePWHAPRB5uUiqIvR9wc0dO+uehZTPKSl/5eJ4ylh1SrGkLddB/GSa226C4Yy5yiJFbLFSn2
	XaQ2Mcb+O11iBNpQ/3ulXHfc7MAoyOEtAbr+YizW0rYljSX8RGeZNr0CK6pTg/5zI/pegvyeRAI6I
	BqN0jW85FRZfNaA3sJA7JBcSE6yXS3+1eaO2XH2OGc8Y2sNkKSX3KAjY1Tch/0UGD+jZYNayxic3v
	WA/9OftyzSTi3dWef3tOwoqE3Gy+cBjt9N+tPpMTWMAoKSECBucKVPCx4+/Gj9tI83DkNEtSrkxMO
	7lZ1TIDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbdyr-004sgf-PV; Mon, 13 Mar 2023 08:56:33 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbdym-004seK-RJ
	for linux-nvme@lists.infradead.org; Mon, 13 Mar 2023 08:56:31 +0000
Received: by mail-wr1-f48.google.com with SMTP id l12so2223276wrm.10
        for <linux-nvme@lists.infradead.org>; Mon, 13 Mar 2023 01:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678697786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WKPzzJRbsAtE8gVN+mqeS2P+Vn3NP9FXRntrsjkDiJs=;
        b=qEyavxQsr3hFsIGvP+Cg/8JhIzaGcXEWa6a0fk87Hq+8NxC/87+GjcKCA8LCVdtAzU
         5nDw3I4YXskJJVZJMynELKNhkcHHVBP6s+Z1zzFCo4aSCyGeIgeyF165w2KOlZTjgWSs
         uS4KYDtFjI2WLCbw1cv/YM/k71bbqYEP2h/EDlBR6vKtt3Drg+Vz98Hg3BGlr0RGg9En
         /+oWjDAEp5xilXjy8O2BeJCrTNDAWeGKQL9PQogLGdOB/fMXbL7D2hG0ijofQTPohBuw
         eevy9u4YqGIABKB4wlfg3uuncXFIgb6w9DSOstbgSZ/8MVrXzS8nCBI5028ruNEH0pvA
         cgiw==
X-Gm-Message-State: AO0yUKX5CJEVs3pEeRjPe/tUCHse3ek7ghyG0vUXDCkLq4x3QP+c5bKa
	wJJ9TlSOkQeFTxeeMkPGTb+bBw1KOyo=
X-Google-Smtp-Source: AK7set+vicuNs6An4vqQiBHiC3ZdfpJQgNY6aDDVSKNkhJmDxE6rU95buoKJqn4jUUBj7u4R+2tpcw==
X-Received: by 2002:adf:f950:0:b0:2c8:207d:c10e with SMTP id q16-20020adff950000000b002c8207dc10emr6949657wrr.1.1678697785684;
        Mon, 13 Mar 2023 01:56:25 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id i15-20020adfe48f000000b002c3f9404c45sm7312580wrm.7.2023.03.13.01.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 01:56:25 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 1/2] nvme-tcp: fix opcode reporting in the timeout handler
Date: Mon, 13 Mar 2023 10:56:22 +0200
Message-Id: <20230313085623.9321-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230313_015628_979724_FA660BD1 
X-CRM114-Status: GOOD (  19.13  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

For non in-capsule writes we reuse the request pdu space for a h2cdata
pdu in order to avoid over allocating space (either preallocate or
dynamically upon receving an r2t pdu). However if the request times out
the core expects to find the opcode in the start of the request, which
we override.

In order to prevent that, without sacrificing additional 24 bytes per
request, we just use the tail of the command pdu space instead (last
24 bytes from the 72 bytes command pdu). That should make the command
opcode always available, and we get away from allocating more space.

If in the future we would need the last 24 bytes of the nvme command
available we would need to allocate a dedicated space for it in the
request, but until then we can avoid doing so.

Reported-by: Akinobu Mita <akinobu.mita@gmail.com>
Tested-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ef27122acce6..c73811907afa 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -207,6 +207,18 @@ static inline u8 nvme_tcp_ddgst_len(struct nvme_tcp_queue *queue)
 	return queue->data_digest ? NVME_TCP_DIGEST_LENGTH : 0;
 }
 
+static inline void *nvme_tcp_req_cmd_pdu(struct nvme_tcp_request *req)
+{
+	return req->pdu;
+}
+
+static inline void *nvme_tcp_req_data_pdu(struct nvme_tcp_request *req)
+{
+	/* use the pdu space in the back for the data pdu */
+	return req->pdu + sizeof(struct nvme_tcp_cmd_pdu) -
+		sizeof(struct nvme_tcp_data_pdu);
+}
+
 static inline size_t nvme_tcp_inline_data_size(struct nvme_tcp_request *req)
 {
 	if (nvme_is_fabrics(req->req.cmd))
@@ -613,7 +625,7 @@ static int nvme_tcp_handle_comp(struct nvme_tcp_queue *queue,
 
 static void nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req)
 {
-	struct nvme_tcp_data_pdu *data = req->pdu;
+	struct nvme_tcp_data_pdu *data = nvme_tcp_req_data_pdu(req);
 	struct nvme_tcp_queue *queue = req->queue;
 	struct request *rq = blk_mq_rq_from_pdu(req);
 	u32 h2cdata_sent = req->pdu_len;
@@ -1035,7 +1047,7 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 {
 	struct nvme_tcp_queue *queue = req->queue;
-	struct nvme_tcp_cmd_pdu *pdu = req->pdu;
+	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
 	bool inline_data = nvme_tcp_has_inline_data(req);
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	int len = sizeof(*pdu) + hdgst - req->offset;
@@ -1074,7 +1086,7 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
 {
 	struct nvme_tcp_queue *queue = req->queue;
-	struct nvme_tcp_data_pdu *pdu = req->pdu;
+	struct nvme_tcp_data_pdu *pdu = nvme_tcp_req_data_pdu(req);
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	int len = sizeof(*pdu) - req->offset + hdgst;
 	int ret;
@@ -2281,7 +2293,7 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 {
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
-	struct nvme_tcp_cmd_pdu *pdu = req->pdu;
+	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
 	u8 opc = pdu->cmd.common.opcode, fctype = pdu->cmd.fabrics.fctype;
 	int qid = nvme_tcp_queue_id(req->queue);
 
@@ -2320,7 +2332,7 @@ static blk_status_t nvme_tcp_map_data(struct nvme_tcp_queue *queue,
 			struct request *rq)
 {
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
-	struct nvme_tcp_cmd_pdu *pdu = req->pdu;
+	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
 	struct nvme_command *c = &pdu->cmd;
 
 	c->common.flags |= NVME_CMD_SGL_METABUF;
@@ -2340,7 +2352,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 		struct request *rq)
 {
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
-	struct nvme_tcp_cmd_pdu *pdu = req->pdu;
+	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
 	struct nvme_tcp_queue *queue = req->queue;
 	u8 hdgst = nvme_tcp_hdgst_len(queue), ddgst = 0;
 	blk_status_t ret;
-- 
2.34.1


