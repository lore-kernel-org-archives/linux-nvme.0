Return-Path: <SRS0=DRq2=6V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE32C38A2A
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2020 14:02:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E902083B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2020 14:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JHHvmWUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E902083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=P5hLat5Fwye9Nos5Je4z+/ghT3av9ZsA1dQJsyqLneA=; b=JHHvmWUB3BzT4oZFEh0wUMAlsz
	fKcwjXGb3/9yTI2B9pg6r+OlW11FclvRagb9NJhR6pJg/v2ZaaZCGTSPFDtsrPl/no6q0IiRyruMD
	SOTUa82JtUY5GuCSVNkBjd1q+TCBXKBx6BQC0bxxGWHEXccLsXv6H8ng5zPtLOme32XQ9SlzxHkAY
	+Nr5pC/irbFbH1Pqz2DOH6FaKw4YWOJcj7UKwbtjqBMfjshQha2dnfOjtLDBwXrZOI46uP8DgBks4
	iJ5Hwbt/Rr9kd4y4wbRqIGYpetcwLhu796KW0nNVwsKRR8L8q3GPw/i5SXWiIff9SQSO2DSG9jwM3
	IsvC0n6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWh6t-0006wT-2n; Thu, 07 May 2020 14:02:47 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWh6k-0006oW-EV
 for linux-nvme@lists.infradead.org; Thu, 07 May 2020 14:02:42 +0000
Received: from Internal Mail-Server by MTLPINE2 (envelope-from
 yorayz@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 7 May 2020 17:02:26 +0300
Received: from dev-l-vrt-071.mtl.labs.mlnx (dev-l-vrt-071.mtl.labs.mlnx
 [10.134.71.1])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 047E2QSU022772;
 Thu, 7 May 2020 17:02:26 +0300
From: Yoray Zack <yorayz@mellanox.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/3] nvme-tcp: Add target padding support
Date: Thu,  7 May 2020 17:02:03 +0300
Message-Id: <1588860124-40089-3-git-send-email-yorayz@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588860124-40089-1-git-send-email-yorayz@mellanox.com>
References: <1588860124-40089-1-git-send-email-yorayz@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200507_070239_073096_1876DF61 
X-CRM114-Status: GOOD (  11.58  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, Boris Pismenny <borisp@mellanox.com>,
 linux-nvme@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Align the pdu in c2h capsules according to the icreq->hpda.

Signed-off-by: Yoray Zack <yorayz@mellanox.com>
---
 drivers/nvme/target/tcp.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index f0da04e..9e15785 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -104,6 +104,7 @@ struct nvmet_tcp_queue {
 	struct list_head	free_list;
 	struct llist_head	resp_list;
 	struct list_head	resp_send_list;
+	int			pda;
 	int			send_list_len;
 	struct nvmet_tcp_cmd	*snd_cmd;
 
@@ -219,6 +220,11 @@ static inline u8 nvmet_tcp_hdgst_len(struct nvmet_tcp_queue *queue)
 	return queue->hdr_digest ? NVME_TCP_DIGEST_LENGTH : 0;
 }
 
+static inline u8 nvmet_tcp_pda_size(struct nvmet_tcp_queue *queue)
+{
+	return queue->pda * 4;
+}
+
 static inline u8 nvmet_tcp_ddgst_len(struct nvmet_tcp_queue *queue)
 {
 	return queue->data_digest ? NVME_TCP_DIGEST_LENGTH : 0;
@@ -376,6 +382,7 @@ static void nvmet_setup_c2h_data_pdu(struct nvmet_tcp_cmd *cmd)
 	struct nvmet_tcp_queue *queue = cmd->queue;
 	u8 hdgst = nvmet_tcp_hdgst_len(cmd->queue);
 	u8 ddgst = nvmet_tcp_ddgst_len(cmd->queue);
+	u8 pda_size  = nvmet_tcp_pda_size(cmd->queue);
 
 	cmd->offset = 0;
 	cmd->state = NVMET_TCP_SEND_DATA_PDU;
@@ -384,9 +391,9 @@ static void nvmet_setup_c2h_data_pdu(struct nvmet_tcp_cmd *cmd)
 	pdu->hdr.flags = NVME_TCP_F_DATA_LAST | (queue->nvme_sq.sqhd_disabled ?
 						NVME_TCP_F_DATA_SUCCESS : 0);
 	pdu->hdr.hlen = sizeof(*pdu);
-	pdu->hdr.pdo = pdu->hdr.hlen + hdgst;
+	pdu->hdr.pdo = pdu->hdr.hlen + hdgst + pda_size;
 	pdu->hdr.plen =
-		cpu_to_le32(pdu->hdr.hlen + hdgst +
+		cpu_to_le32(pdu->hdr.hlen + hdgst + pda_size +
 				cmd->req.transfer_len + ddgst);
 	pdu->command_id = cmd->req.cqe->command_id;
 	pdu->data_length = cpu_to_le32(cmd->req.transfer_len);
@@ -505,7 +512,8 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 static int nvmet_try_send_data_pdu(struct nvmet_tcp_cmd *cmd)
 {
 	u8 hdgst = nvmet_tcp_hdgst_len(cmd->queue);
-	int left = sizeof(*cmd->data_pdu) - cmd->offset + hdgst;
+	u8 pda_size = nvmet_tcp_pda_size(cmd->queue);
+	int left = sizeof(*cmd->data_pdu) - cmd->offset + hdgst + pda_size;
 	int ret;
 
 	ret = kernel_sendpage(cmd->queue->sock, virt_to_page(cmd->data_pdu),
@@ -787,12 +795,7 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 		return -EPROTO;
 	}
 
-	if (icreq->hpda != 0) {
-		pr_err("queue %d: unsupported hpda %d\n", queue->idx,
-			icreq->hpda);
-		return -EPROTO;
-	}
-
+	queue->pda = icreq->hpda;
 	queue->hdr_digest = !!(icreq->digest & NVME_TCP_HDR_DIGEST_ENABLE);
 	queue->data_digest = !!(icreq->digest & NVME_TCP_DATA_DIGEST_ENABLE);
 	if (queue->hdr_digest || queue->data_digest) {
@@ -1221,6 +1224,7 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *c)
 {
 	u8 hdgst = nvmet_tcp_hdgst_len(queue);
+	u8 pda_size = nvmet_tcp_pda_size(queue);
 
 	c->queue = queue;
 	c->req.port = queue->port->nport;
@@ -1238,7 +1242,7 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
 	c->req.cqe = &c->rsp_pdu->cqe;
 
 	c->data_pdu = page_frag_alloc(&queue->pf_cache,
-			sizeof(*c->data_pdu) + hdgst, GFP_KERNEL | __GFP_ZERO);
+			sizeof(*c->data_pdu) + hdgst + pda_size, GFP_KERNEL | __GFP_ZERO);
 	if (!c->data_pdu)
 		goto out_free_rsp;
 
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
