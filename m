Return-Path: <SRS0=eYGd=M4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F63C432BE
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 12:16:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B4E6105A
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 12:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 44B4E6105A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=uLXXXQk64x4DjmvBLZoZ39i2AGFzLOlvl/rOOZ/dvZo=; b=kPxwy4E+z/DGY3
	fSU6VCgMYpbTAn00gvWtebq+iM5+8wBPu3dzfytjs3nSco7IFuo2+FEFaaFGwaLr76XrLIJRCEtKA
	lqk4jt/pGs1NVAiukz2UsCOK3y83ZB0dwEQmURBpg216S5IsyF3SJ9JYSumDHkuX79BKRylU7xufC
	MIvC4JRTklML60XJpnDvoXCMFqhnzR/yJ5QYaanrD/9aupGf7ITN496/KMy5OkDJQ5qSdfixI4aCG
	4ptQC6M6Ots8iv392c9SzMk9PCb0bVYHeZpv+097++FIZkeDZYsKjBB7mrV9V9UG2n0HoLB3yDVpq
	dxP8MYQQ99wFgBpPgoJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBcI3-009Qhe-C3; Thu, 05 Aug 2021 12:15:59 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBcI0-009Qec-BL
 for linux-nvme@lists.infradead.org; Thu, 05 Aug 2021 12:15:57 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id CC07220231;
 Thu,  5 Aug 2021 12:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628165752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Cst26t9NjVGD4Ogh3bGKp0IaNkcfUTEKl3siw2LT0dg=;
 b=D3EovsqUGGr/thltOMMCBf8NgIniq7Uojb5v9ejKl5228pVV7ZEfsAAUPPaSgeFhPJjxKI
 RYnaOR/TYOjF72dG14sqUyCLM3bRTwhrygBD2sjQvWqK8uL2US1Fz+l04fVLwT4t6c42KQ
 ECP2IQTUK7Ie4ROlqd1s63FnClEI/gY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628165752;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Cst26t9NjVGD4Ogh3bGKp0IaNkcfUTEKl3siw2LT0dg=;
 b=C9WDK3SnRp7AsJyzBS/ZO5P3eau52XlZZJJSVY+xqTo5YxPZDh8xQjqYHIANxT1cKshYK5
 hLWOCclsK97RqiCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 0CD22A3B94;
 Thu,  5 Aug 2021 12:15:51 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id DB07D518C254; Thu,  5 Aug 2021 14:15:51 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@suse.de>, yi.he@emc.com,
 Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] nvme-tcp: Do not reset transport on data digest errors
Date: Thu,  5 Aug 2021 14:15:41 +0200
Message-Id: <20210805121541.77613-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210805_051556_599488_4F7F5D23 
X-CRM114-Status: GOOD (  16.76  )
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
detected. To fix this, keep track of the final status in the queue
object and use it when completing the request.

The new member can be placed adjacent to the receive related members and
fits in the cacheline as there is a 4 byte hole.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

Hi,

I've tested this by modifying the receive path. Via the fault_inject
interface I injecting wrong hash values. The request would then be
completed with status != 0 and nvme_decide_disposition decices to
retry the request. So this seems be in more sync with what the spec
says on this topic.

Daniel

 drivers/nvme/host/tcp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 097f7dd10ed3..5253147df4c7 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -89,6 +89,7 @@ struct nvme_tcp_queue {
 	size_t			data_remaining;
 	size_t			ddgst_remaining;
 	unsigned int		nr_cqe;
+	u16			status;
 
 	/* send state */
 	struct nvme_tcp_request *request;
@@ -496,7 +497,8 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		return -EINVAL;
 	}
 
-	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
+	if (!nvme_try_complete_req(rq, queue->status ?
+			queue->status : cqe->status, cqe->result))
 		nvme_complete_rq(rq);
 	queue->nr_cqe++;
 
@@ -676,6 +678,7 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 
 	switch (hdr->type) {
 	case nvme_tcp_c2h_data:
+		queue->status = NVME_SC_SUCCESS;
 		return nvme_tcp_handle_c2h_data(queue, (void *)queue->pdu);
 	case nvme_tcp_rsp:
 		nvme_tcp_init_recv_ctx(queue);
@@ -758,7 +761,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 			queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
 		} else {
 			if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-				nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
+				nvme_tcp_end_request(rq, queue->status);
 				queue->nr_cqe++;
 			}
 			nvme_tcp_init_recv_ctx(queue);
@@ -792,14 +795,14 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 			"data digest error: recv %#x expected %#x\n",
 			le32_to_cpu(queue->recv_ddgst),
 			le32_to_cpu(queue->exp_ddgst));
-		return -EIO;
+		queue->status = NVME_SC_DATA_XFER_ERROR;
 	}
 
 	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
 		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
 					pdu->command_id);
 
-		nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
+		nvme_tcp_end_request(rq, queue->status);
 		queue->nr_cqe++;
 	}
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
