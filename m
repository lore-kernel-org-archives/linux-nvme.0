Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27669C38145
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Sep 2022 10:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xOWdfsa32WImVXqXQI8AwgmguXpI6p8y1pjRnLIo8es=; b=sEGOcdJtfkfP5/yNgPeLrp7e6W
	LQg8kMnLN+ky4CPPi3cDXImqxDhXyIUlGkmKvq1h2q90aQjQtxED+D0HJee8ZTifD6NdhdupfO/k6
	zWkxuGe+m+q0ar9ZZ09nds2FsjLfA14a4eeeefIFsrDtdZnIhjOZ+UQSdjPAFxOk46BJ8pOn5IynX
	DNlxOJk4zawjD1QxrfMHDhSVtA6hdPhwV9bmfXr/oj6//0e1VAuruyKsOUA/Mce4G/VebkGe0tBpH
	wL9mfz4CLpKGkfgHPFDUeVJzEiJPzDmgAliHO7JEjWl9wTu8zAAIYlKHk/jfELP0SQgSfcB4cR6GE
	D8vEkP+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWF2s-002PEL-4L; Thu, 08 Sep 2022 10:46:06 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWF2f-002P0H-6w
	for linux-nvme@lists.infradead.org; Thu, 08 Sep 2022 10:45:56 +0000
Received: from fcoe-test11.blr.asicdesigners.com (fcoe-test11.blr.asicdesigners.com [10.193.185.180])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 288AjW1h023895;
	Thu, 8 Sep 2022 03:45:33 -0700
From: Varun Prakash <varun@chelsio.com>
To: sagi@grimberg.me, hch@lst.de, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org, varun@chelsio.com
Subject: [PATCH v2] nvmet-tcp: handle ICReq PDU received in NVMET_TCP_Q_LIVE state
Date: Thu,  8 Sep 2022 16:42:44 +0530
Message-Id: <20220908111244.5585-1-varun@chelsio.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220908_034553_307741_74C16D43 
X-CRM114-Status: UNSURE (   9.47  )
X-CRM114-Notice: Please train this message.
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

As per NVMe/TCP transport specification ICReq PDU is the first PDU received
by the controller and controller should receive only one ICReq PDU.

If controller receives more than one ICReq PDU then this can be considered
as fatal error.

nvmet-tcp driver does not check for ICReq PDU opcode if queue state is
NVMET_TCP_Q_LIVE. In LIVE state ICReq PDU is treated as CapsuleCmd PDU,
this can result in abnormal behavior.

Add a check for ICReq PDU in nvmet_tcp_done_recv_pdu() to fix this issue.

Signed-off-by: Varun Prakash <varun@chelsio.com>
---

v2:
 updated commit message

 drivers/nvme/target/tcp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index a3694a32f6d5..02df2fc7dfe7 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -976,6 +976,13 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 		return nvmet_tcp_handle_icreq(queue);
 	}
 
+	if (unlikely(hdr->type == nvme_tcp_icreq)) {
+		pr_err("queue %d: received icreq pdu in state %d\n",
+			queue->idx, queue->state);
+		nvmet_tcp_fatal_error(queue);
+		return -EPROTO;
+	}
+
 	if (hdr->type == nvme_tcp_h2c_data) {
 		ret = nvmet_tcp_handle_h2c_data_pdu(queue);
 		if (unlikely(ret))
-- 
2.31.1


