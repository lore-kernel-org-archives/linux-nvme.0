Return-Path: <SRS0=DRq2=6V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3F5C54E49
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2020 14:02:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 442852082E
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2020 14:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NeZM7FH6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 442852082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=KtOHaT7jQF8n8iWd2B4/evnDzVHnq8ZTNOmvz07diHY=; b=NeZM7FH6OKCGtedbU4kKzNCrAZ
	+CeT8CZnM9KZK1GOGZ8aUkLn/TzBcMXjT8iEv0IQwCYKevjkXDQfrX5IdfbJhN8maOhGMa9iFw1DI
	3nOx+sjKy4K0X2PnvC19vrrou00SPFfoHUAqo2wXGP5h+085GV+DFgKLiXPKY7DaCJrEQuravOljE
	p1N5lB2kk8nwC4MdoxoD8GnDibSRSmWSY6rfD2P3qIiPHLgukrU6dDcyyJ7UgoiHEMUh/X8r+auMk
	zXqfOSnzkJcvDfLOqy5NeP/ue1as4HbBe9oVf4Am4e54s0kyck3GCFtQmGndD3DVW5bFDxj1f+s6e
	19nGfCfA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWh70-00076p-FY; Thu, 07 May 2020 14:02:54 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWh6k-0006oT-6C
 for linux-nvme@lists.infradead.org; Thu, 07 May 2020 14:02:42 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 yorayz@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 7 May 2020 17:02:26 +0300
Received: from dev-l-vrt-071.mtl.labs.mlnx (dev-l-vrt-071.mtl.labs.mlnx
 [10.134.71.1])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 047E2QSV022772;
 Thu, 7 May 2020 17:02:26 +0300
From: Yoray Zack <yorayz@mellanox.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/3] nvme-tcp: Add Host hpda support
Date: Thu,  7 May 2020 17:02:04 +0300
Message-Id: <1588860124-40089-4-git-send-email-yorayz@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588860124-40089-1-git-send-email-yorayz@mellanox.com>
References: <1588860124-40089-1-git-send-email-yorayz@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200507_070238_674421_5A20EFE5 
X-CRM114-Status: GOOD (  12.41  )
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

1. Send the requested hpda to the target.

2. Parse the recv nvme caps as having pdu alignment.

Signed-off-by: Yoray Zack <yorayz@mellanox.com>
---
 drivers/nvme/host/tcp.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c15a921..42b3f06 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -81,6 +81,8 @@ struct nvme_tcp_queue {
 	void			*pdu;
 	int			pdu_remaining;
 	int			pdu_offset;
+	int			pda_remaining;
+	int			pda;
 	size_t			data_remaining;
 	size_t			ddgst_remaining;
 	unsigned int		nr_cqe;
@@ -423,6 +425,7 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 	queue->pdu_offset = 0;
 	queue->data_remaining = -1;
 	queue->ddgst_remaining = 0;
+	queue->pda_remaining = 0;
 }
 
 static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
@@ -474,6 +477,7 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
 	}
 
 	queue->data_remaining = le32_to_cpu(pdu->data_length);
+	queue->pda_remaining = queue->pda * 4;
 
 	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS &&
 	    unlikely(!(pdu->hdr.flags & NVME_TCP_F_DATA_LAST))) {
@@ -646,6 +650,17 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
 	struct nvme_tcp_request *req;
 	struct request *rq;
+	size_t recv_pda;
+
+	if (queue->pda_remaining) {
+		recv_pda = min_t(size_t, *len, queue->pda_remaining);
+		queue->pda_remaining -= recv_pda;
+		*offset += recv_pda;
+		*len -= recv_pda;
+
+		if (queue->pda_remaining)
+			return 0;
+	}
 
 	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	if (!rq) {
@@ -1181,7 +1196,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	icreq->hdr.plen = cpu_to_le32(icreq->hdr.hlen);
 	icreq->pfv = cpu_to_le16(NVME_TCP_PFV_1_0);
 	icreq->maxr2t = 0; /* single inflight r2t supported */
-	icreq->hpda = 0; /* no alignment constraint */
+	icreq->hpda = queue->pda;
 	if (queue->hdr_digest)
 		icreq->digest |= NVME_TCP_HDR_DIGEST_ENABLE;
 	if (queue->data_digest)
@@ -1398,6 +1413,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	queue->data_remaining = 0;
 	queue->ddgst_remaining = 0;
 	queue->pdu_remaining = 0;
+	queue->pda_remaining = 0;
+	queue->pda = nctrl->opts->pda;
 	queue->pdu_offset = 0;
 	sk_set_memalloc(queue->sock->sk);
 
@@ -2464,7 +2481,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
 			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
 			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
-			  NVMF_OPT_TOS,
+			  NVMF_OPT_TOS | NVMF_OPT_PDA,
 	.create_ctrl	= nvme_tcp_create_ctrl,
 };
 
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
