Return-Path: <SRS0=3UZ0=PO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604C7C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Oct 2021 13:32:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D707A60E74
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Oct 2021 13:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D707A60E74
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yN3XAi/MgBwQVgBCgvSPNjbjDvIdb0De+vjvpdXQu+U=; b=AuaRsXnQALOKUg1q6TUvs1s6Sq
	K4Rq5l3w/jheauLINDpNYYphCjLNMyxql7PzCxSR3fl/dWtDfY3ax7Vj1crQqt7cOqAqSbFwvvDW4
	sSpQO65EL6vIo6ov2TvX5l6Uk8CM/I7LDYlnzS8Wt3lMYOBTq631vnRShXo3uT0doKidTbkcunUZH
	8W6Qijctm9yAFWsVR1XnUTjquTG9iMURfjQhLxJADtsdMKS1wObWp8N7/Gl0+GnrLABtQ/tUMsKEO
	6UMI67bIB3iwMPp2LjPbLjpSBk8sgVipPHdAdJixPTPmx4LpYz6PSVg+r4TkPUjAZGazV9OfoNZ9S
	rEAO3I/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfMYy-001uJp-RK; Tue, 26 Oct 2021 13:32:24 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfMYt-001uIw-H8
 for linux-nvme@lists.infradead.org; Tue, 26 Oct 2021 13:32:20 +0000
Received: from fcoe-test11.asicdesigners.com
 (fcoe-test11.blr.asicdesigners.com [10.193.185.180])
 by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 19QDW6US004548;
 Tue, 26 Oct 2021 06:32:07 -0700
From: Varun Prakash <varun@chelsio.com>
To: sagi@grimberg.me, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, varun@chelsio.com
Subject: [PATCH] nvme-tcp: fix possible req->offset corruption
Date: Tue, 26 Oct 2021 19:01:55 +0530
Message-Id: <1635255115-3028-1-git-send-email-varun@chelsio.com>
X-Mailer: git-send-email 2.0.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211026_063219_608254_610EC74E 
X-CRM114-Status: GOOD (  11.48  )
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

With commit db5ad6b7f8cd ("nvme-tcp: try to send request in queue_rq
context") r2t and response PDU can get processed while send function
is executing.

Current data digest send code uses req->offset after kernel_sendmsg(),
this creates a race condition where req->offset gets reset before it
is used in send function.

This can happen in two cases -
1. Target sends r2t PDU which resets req->offset.
2. Target send response PDU which completes the req and then req is
   used for a new command, nvme_tcp_setup_cmd_pdu() resets req->offset.

Fix this by storing req->offset in a local variable and using
this local variable after kernel_sendmsg().

Fixes: db5ad6b7f8cd ("nvme-tcp: try to send request in queue_rq context")
Signed-off-by: Varun Prakash <varun@chelsio.com>
---
 drivers/nvme/host/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 22da856..2217897 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1048,6 +1048,7 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
 static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
 {
 	struct nvme_tcp_queue *queue = req->queue;
+	size_t offset = req->offset;
 	int ret;
 	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
 	struct kvec iov = {
@@ -1064,7 +1065,7 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
 	if (unlikely(ret <= 0))
 		return ret;
 
-	if (req->offset + ret == NVME_TCP_DIGEST_LENGTH) {
+	if (offset + ret == NVME_TCP_DIGEST_LENGTH) {
 		nvme_tcp_done_send_req(queue);
 		return 1;
 	}
-- 
2.0.2


