Return-Path: <SRS0=DYpX=NR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB649C432BE
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Aug 2021 08:22:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6627160C51
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Aug 2021 08:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6627160C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=AqBc8PA/YWkVDNygR5fiCqrcXhwB8UuZ46e6/P8fjJ4=; b=4UqxeKoobwim7T
	HiKOAufSOfwsjW80TtiMS6FFTqetGTJN3QDsuzDVsk85Midd4V6WPpsvJBb4iVAc+4Y+fUWc1Y/5z
	iU5IeagoEwjf1t13qMk0bGu9rLGZpG/4HKlxnvQ4OnA/g58ymvPL7Xejof63v94goH628TQb0JI5z
	+YdKTFd0Po4oZGZov3Z8+22o34nt+eOTeGZ/9vJEzkSa/dbrAFQiTqIuh8MU2Et+juSFXcDrbBqAv
	qlQbwjRb+1Haq35IjGEfA1Jr3HJRFwqQ8UkWySZMnk/IisieiyHhZkY+pWSmKHrkGsEDpMbpiLVJE
	ryDSdPb7OYiO4KelyCjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mJAdu-009XY7-Nf; Thu, 26 Aug 2021 08:21:46 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJAdp-009XWw-5l
 for linux-nvme@lists.infradead.org; Thu, 26 Aug 2021 08:21:45 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 8187E2017A;
 Thu, 26 Aug 2021 08:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1629966099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2iSC0bMkKyyjxpmFWuT/8zxFMT2G1HpI75c5mPtL46w=;
 b=jgQZg27amns9iHMWnPYVFwdwOD45rGNt5JGfGtxZk3T0owXflkbC+QCLIyLg3MPzr6o2pD
 nNPZrpnjE4xkrP1wZ7m8xDXpykoBdMjK2QYU3dwAbEb6d2ZvVQF72kRVAHLOWQC8uVvY08
 DcTMix5HUCDlHjeXD8+P5cso/UQJ9Q4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1629966099;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2iSC0bMkKyyjxpmFWuT/8zxFMT2G1HpI75c5mPtL46w=;
 b=gSTipNnWTSLcbLsYVjl0uixb3F7k/M8eOQgxZcDSB3sutgBmVhujS1G9cXHU+zozstkVtK
 Rd9H+3QyToNlqQCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id AE6A2A3C1D;
 Thu, 26 Aug 2021 08:21:35 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id 65732518DA6D; Thu, 26 Aug 2021 10:21:39 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, yi.he@emc.com,
 Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3] nvme-tcp: Do not reset transport on data digest errors
Date: Thu, 26 Aug 2021 10:21:37 +0200
Message-Id: <20210826082137.23826-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210826_012141_391749_A6C75447 
X-CRM114-Status: GOOD (  17.66  )
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
The status member placed so that it fills up a hole in struct
nvme_tcp_request:

struct nvme_tcp_request {
        struct nvme_request        req;                  /*     0    32 */
        void *                     pdu;                  /*    32     8 */
        struct nvme_tcp_queue *    queue;                /*    40     8 */
        u32                        data_len;             /*    48     4 */
        u32                        pdu_len;              /*    52     4 */
        u32                        pdu_sent;             /*    56     4 */
        u16                        ttag;                 /*    60     2 */
        u16                        status;               /*    62     2 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        struct list_head           entry;                /*    64    16 */
        struct llist_node          lentry;               /*    80     8 */
        __le32                     ddgst;                /*    88     4 */

        /* XXX 4 bytes hole, try to pack */

        struct bio *               curr_bio;             /*    96     8 */
        struct iov_iter            iter;                 /*   104    40 */
        /* --- cacheline 2 boundary (128 bytes) was 16 bytes ago --- */
        size_t                     offset;               /*   144     8 */
        size_t                     data_sent;            /*   152     8 */
        enum nvme_tcp_send_state   state;                /*   160     4 */

        /* size: 168, cachelines: 3, members: 16 */
        /* sum members: 160, holes: 1, sum holes: 4 */
        /* padding: 4 */
        /* last cacheline: 40 bytes */
};

v3:
 - initialize req->status in nvme_tcp_setup_cmd_pdu()
 - add rb tag from Hannes

v2:
 - https://lore.kernel.org/linux-nvme/20210825124259.28707-1-dwagner@suse.de/
 - moved 'status' from nvme_tcp_queue to nvme_tcp_request.

v1:
 - https://lore.kernel.org/linux-nvme/20210805121541.77613-1-dwagner@suse.de/

drivers/nvme/host/tcp.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 645025620154..29ef0f74f620 100644
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
@@ -485,7 +486,9 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		struct nvme_completion *cqe)
 {
+	struct nvme_tcp_request *req;
 	struct request *rq;
+	u16 status;
 
 	rq = nvme_find_rq(nvme_tcp_tagset(queue), cqe->command_id);
 	if (!rq) {
@@ -496,7 +499,12 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		return -EINVAL;
 	}
 
-	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
+	req = blk_mq_rq_to_pdu(rq);
+	status = req->status;
+	if (status == NVME_SC_SUCCESS)
+		status = cqe->status;
+
+	if (!nvme_try_complete_req(rq, status, cqe->result))
 		nvme_complete_rq(rq);
 	queue->nr_cqe++;
 
@@ -758,7 +766,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 			queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
 		} else {
 			if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-				nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
+				nvme_tcp_end_request(rq, req->status);
 				queue->nr_cqe++;
 			}
 			nvme_tcp_init_recv_ctx(queue);
@@ -788,18 +796,24 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
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
 
@@ -2293,6 +2307,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
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
