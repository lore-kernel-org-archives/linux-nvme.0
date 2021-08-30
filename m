Return-Path: <SRS0=Glcz=NV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53D1C4320E
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 11:38:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 976D361131
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 11:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 976D361131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sjFKibOEsNRFbpy/JsAwHWV/THnvoL9i45PPMNpJgYA=; b=1NuAmfw2kTVagz
	05Ou2wpmCb5QcAeIusq7MIfog+7OmSJYkz0rzCrtinjYp5Q5csDR8IPiDYSTxFdoXZIzhrgxl9wNF
	OKL7KHxC92r9cE/TCXmBVTLN7uWZB5aQDzs+Jh14pn/D7N1FUK6sKB2EkF/j8uvrDXb/Sn73yDQ5W
	WDOtkyy8Xb5uWBS1xbLnsQBYfr0VJP+AzYcHQxczCKo+kG+IHKvevV19ZYGXa3mxtbaPhWP8rdrc2
	0v6LDN8ippCHzwHHkgSHMRyI3EqVOo5OqrC5b+mwJS06ckVohITDFLeNdxORLxD0kKyaGomfMJKkO
	81r0OIeL/e9PyXMCYcrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mKfcW-00H6Cb-De; Mon, 30 Aug 2021 11:38:32 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mKfcQ-00H6Ay-Na
 for linux-nvme@lists.infradead.org; Mon, 30 Aug 2021 11:38:30 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 2E7502212A;
 Mon, 30 Aug 2021 11:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1630323505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fSfuQ22SzTNGNd9t1JZAkZpVyjkxYu6JIuqPwozZ1cE=;
 b=2Pz9rsGOy43Kq+Kzo8vuii027ExhBsR/EzWdiIIFMM+tRBJ0DupqmhCTUx8DoRUC79Nohu
 CxwAjKn6dCDphc5ePJUFDMIczz7DwMeyH0Bld9EhMXj5HR4qlKtK054nO9C4+NqazPCHC+
 20LPSvz1cr37RoAqIUEOe5qPE2Vam0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1630323505;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fSfuQ22SzTNGNd9t1JZAkZpVyjkxYu6JIuqPwozZ1cE=;
 b=df9AzpVWNygv1w+CmQE6lf9ieT9eFcDE27v1YicNmKOVT9VymvI08i55+kpcaWoedICtuW
 WwhiCbvfynkm0XBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 26A5AA3B9F;
 Mon, 30 Aug 2021 11:38:25 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id 113C0518DCDA; Mon, 30 Aug 2021 13:38:25 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, yi.he@emc.com,
 Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4] nvme-tcp: Do not reset transport on data digest errors
Date: Mon, 30 Aug 2021 13:38:22 +0200
Message-Id: <20210830113822.104516-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210830_043826_967596_A0A7AF2E 
X-CRM114-Status: GOOD (  16.14  )
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

The spec says

  7.4.6.1 Digest Error handling

  When a host detects a data digest error in a C2HData PDU, that host
  shall continue processing C2HData PDUs associated with the command and
  when the command processing has completed, if a successful status was
  returned by the controller, the host shall fail the command with a
  non-fatal transport error.

Currently the transport is reseted when a data digest error is
detected. Instead, when a digest error is detected, mark the final
status as NVME_SC_DATA_XFER_ERROR and let the upper layer handle
the error.

In order to keep track of the final result maintain a status field in
nvme_tcp_request object and use it to overwrite the completion queue
status (which might be successful even though a digest error has been
detected) when completing the request.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
v4:
 - use req->status directly, avoid local variable. Suggested by Sagi.

v3:
 - https://lore.kernel.org/linux-nvme/20210826082137.23826-1-dwagner@suse.de/
 - initialize req->status in nvme_tcp_setup_cmd_pdu()
 - add rb tag from Hannes

v2:
 - https://lore.kernel.org/linux-nvme/20210825124259.28707-1-dwagner@suse.de/
 - moved 'status' from nvme_tcp_queue to nvme_tcp_request.

v1:
 - https://lore.kernel.org/linux-nvme/20210805121541.77613-1-dwagner@suse.de/

 drivers/nvme/host/tcp.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 645025620154..ce1a7f5be72b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -45,6 +45,7 @@ struct nvme_tcp_request {
 	u32			pdu_len;
 	u32			pdu_sent;
 	u16			ttag;
+	u16			status;
 	struct list_head	entry;
 	struct llist_node	lentry;
 	__le32			ddgst;
@@ -485,6 +486,7 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		struct nvme_completion *cqe)
 {
+	struct nvme_tcp_request *req;
 	struct request *rq;
 
 	rq = nvme_find_rq(nvme_tcp_tagset(queue), cqe->command_id);
@@ -496,7 +498,11 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		return -EINVAL;
 	}
 
-	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
+	req = blk_mq_rq_to_pdu(rq);
+	if (req->status == NVME_SC_SUCCESS)
+		req->status = cqe->status;
+
+	if (!nvme_try_complete_req(rq, req->status, cqe->result))
 		nvme_complete_rq(rq);
 	queue->nr_cqe++;
 
@@ -758,7 +764,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 			queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
 		} else {
 			if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-				nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
+				nvme_tcp_end_request(rq, req->status);
 				queue->nr_cqe++;
 			}
 			nvme_tcp_init_recv_ctx(queue);
@@ -788,18 +794,24 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 		return 0;
 
 	if (queue->recv_ddgst != queue->exp_ddgst) {
+		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
+					pdu->command_id);
+		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+		req->status = NVME_SC_DATA_XFER_ERROR;
+
 		dev_err(queue->ctrl->ctrl.device,
 			"data digest error: recv %#x expected %#x\n",
 			le32_to_cpu(queue->recv_ddgst),
 			le32_to_cpu(queue->exp_ddgst));
-		return -EIO;
 	}
 
 	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
 		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
 					pdu->command_id);
+		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
-		nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
+		nvme_tcp_end_request(rq, req->status);
 		queue->nr_cqe++;
 	}
 
@@ -2293,6 +2305,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 		return ret;
 
 	req->state = NVME_TCP_SEND_CMD_PDU;
+	req->status = NVME_SC_SUCCESS;
 	req->offset = 0;
 	req->data_sent = 0;
 	req->pdu_len = 0;
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
