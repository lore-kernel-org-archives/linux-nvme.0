Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A43CECAAD5
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Sep 2022 21:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xjJgai8UIn4qPH5Fu+V3eJ0VDBr70uSfnahlBsvr6Hw=; b=xMzCHHkak5g5h9hh31wAxGJ1Bo
	CMKXB6S1Cd0UixFlRycy0Px2z46lNoarhHR43VLPOjOYGSQ/uMqUVIyhbxVF8RbFn3CLmEESN3ITP
	qZBcW3OuAp+idHpZig0RRmsNNyLBowHqVPjRW5fd06TB4lnTZ9f4shmzPS35Q8pOZM2qZM3MsNzCd
	J/np5i5COmWy6Samz9lhPvv6GLqDHBN9q1e/809Cf2N+LPsXPJDaIhp+GBVHhLmTLrMdyU5ZFyYyg
	n81JoU1wk+spk2KWws+7Topo6RQWjWld994/lXdZg2K00qaiZTYl+nQH3p+oOoWBdJDbMAfY9IwbP
	Pq6x/22Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oUwwK-00Bkof-CC; Sun, 04 Sep 2022 21:14:00 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oUwr1-00Bfaa-Ug
	for linux-nvme@lists.infradead.org; Sun, 04 Sep 2022 21:08:34 +0000
Received: from fcoe-test11.blr.asicdesigners.com (fcoe-test11.blr.asicdesigners.com [10.193.185.180])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 284L853J020935;
	Sun, 4 Sep 2022 14:08:06 -0700
From: Varun Prakash <varun@chelsio.com>
To: sagi@grimberg.me, hch@lst.de
Cc: linux-nvme@lists.infradead.org, varun@chelsio.com
Subject: [PATCH] nvmet-tcp: handle ICReq PDU received in NVMET_TCP_Q_LIVE state
Date: Mon,  5 Sep 2022 03:05:18 +0530
Message-Id: <20220904213518.4532-1-varun@chelsio.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220904_140833_309282_78AC6A50 
X-CRM114-Status: UNSURE (   7.31  )
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

If target receives ICReq PDU in queue state NVMET_TCP_Q_LIVE
then call nvmet_tcp_fatal_error() and return -EPROTO.

Signed-off-by: Varun Prakash <varun@chelsio.com>
---
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


