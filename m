Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62F2C61DB9
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2026 02:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Eo0TyiLRQ09vI7MoizEuPRiGNQ+an+iHwdlzXwtm1Mc=; b=xZ9skG60ZKnfQilnQtcGZzwMnZ
	ZoERu4EeZ5FWtgYlr2uKBIiY5iAlrZ8AtbQ1kbUmHT43+WPgn61Ipmb28vlAcfpHE+dQHOatJT9qZ
	0cYjz04I5JKW6l4DF1H95VYwp1s+Q8nFXd39ReK3Z3IhDHeeOdDXNbt6ayN3N8ffYhFNUVW1TQtLA
	l10YFBk++WfJDH2zpX05CdW0ENRovCaxLeHTK7/cEEk1MC8n3UO2WcwLIvi3WnGw731grOHY62k8q
	H3qfvL3dD5DNG9NiZv/xvxliRaEw323QtIv2LsZmRFuHuJnM64UTR+SdGVjbUBSqNbG+7i6FoEVob
	zzzpwWwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz3YW-00000001nsd-1Z2J;
	Wed, 26 Aug 2026 02:40:00 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz3YT-00000001nra-2V58
	for linux-nvme@lists.infradead.org;
	Wed, 26 Aug 2026 02:39:59 +0000
X-UUID: 6a384244a0f711f19a56ed5b684f684d-20260826
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:503eab99-a663-407b-99e0-98ec1f88c197,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:89da1cd6a5f991a5a628ca4ea9752b2c,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|865|898,TC:nil,Content:0|15|50,EDM:-3,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6a384244a0f711f19a56ed5b684f684d-20260826
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 229579736; Wed, 26 Aug 2026 10:39:52 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, hare@suse.de, dwagner@suse.de, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v1 1/1] nvme-tcp: fix wrong status on deferred digest error
Date: Wed, 26 Aug 2026 09:30:00 +0800
Message-ID: <1.nvme-tcp-req-status.v1.git.liuxixin@kylinos.cn>
In-Reply-To: <cover.nvme-tcp-req-status.v1.git.liuxixin@kylinos.cn>
References: <cover.nvme-tcp-req-status.v1.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260825_193957_943216_670DD341 
X-CRM114-Status: GOOD (  10.85  )
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

A C2HData digest error stores a host status code in req status. Without
DATA_SUCCESS the request is completed later from the rsp path, which
passed that value straight into complete and could report the wrong
status code.

Keep req status as a host status code. On the rsp path, shift left when
a host error was already stored, otherwise use the completion status
field.

Fixes: 1ba2e507f55c ("nvme-tcp: Do not reset transport on data digest errors")
Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--- a/drivers/nvme/host/tcp.c	2026-08-26 09:24:50.988099281 +0800
+++ b/drivers/nvme/host/tcp.c	2026-08-26 09:25:12.474510519 +0800
@@ -73,7 +73,7 @@
 	u32			h2cdata_left;
 	u32			h2cdata_offset;
 	u16			ttag;
-	__le16			status;
+	u16			status;
 	struct list_head	entry;
 	struct llist_node	lentry;
 	__le32			ddgst;
@@ -617,6 +617,7 @@
 {
 	struct nvme_tcp_request *req;
 	struct request *rq;
+	__le16 status;
 
 	rq = nvme_find_rq(nvme_tcp_tagset(queue), cqe->command_id);
 	if (!rq) {
@@ -628,10 +629,12 @@
 	}
 
 	req = blk_mq_rq_to_pdu(rq);
-	if (req->status == cpu_to_le16(NVME_SC_SUCCESS))
-		req->status = cqe->status;
+	if (req->status != NVME_SC_SUCCESS)
+		status = cpu_to_le16(req->status << 1);
+	else
+		status = cqe->status;
 
-	if (!nvme_try_complete_req(rq, req->status, cqe->result))
+	if (!nvme_try_complete_req(rq, status, cqe->result))
 		nvme_complete_rq(rq);
 	queue->nr_cqe++;
 
@@ -961,8 +964,7 @@
 			queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
 		} else {
 			if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-				nvme_tcp_end_request(rq,
-						le16_to_cpu(req->status));
+				nvme_tcp_end_request(rq, req->status);
 				queue->nr_cqe++;
 			}
 			nvme_tcp_init_recv_ctx(queue);
@@ -996,7 +998,7 @@
 					pdu->command_id);
 		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
-		req->status = cpu_to_le16(NVME_SC_DATA_XFER_ERROR);
+		req->status = NVME_SC_DATA_XFER_ERROR;
 
 		dev_err(queue->ctrl->ctrl.device,
 			"data digest error: recv %#x expected %#x\n",
@@ -1009,7 +1011,7 @@
 					pdu->command_id);
 		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
-		nvme_tcp_end_request(rq, le16_to_cpu(req->status));
+		nvme_tcp_end_request(rq, req->status);
 		queue->nr_cqe++;
 	}
 
@@ -2733,7 +2735,7 @@
 		return ret;
 
 	req->state = NVME_TCP_SEND_CMD_PDU;
-	req->status = cpu_to_le16(NVME_SC_SUCCESS);
+	req->status = NVME_SC_SUCCESS;
 	req->offset = 0;
 	req->data_sent = 0;
 	req->pdu_len = 0;
-- 
2.53.0


