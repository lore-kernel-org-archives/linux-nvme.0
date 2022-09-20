Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC72C6FA90
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 18:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vpdvsSQ8LWF1d8HHEZDRAgluPnDtm4thfzhmhTUjjTc=; b=CRA/84qDTFJanm/iyIPBp0t3tz
	I7BF3Dgx2s77HEQOxHQ16mL1GftvmkKkmmmlot3n1PtCZob6H1Dkm072bx/66L4PrXOtNYFByzXzW
	uYa1n56rxr4v7MKZL4h1K3+WKqaz8IfvY9jxrrxonfDVWGEH6cYAgncNCemqrXePcQ6OOByTQee0o
	AenRuS6Iufk5xtUWw/Ay9W2/oFHMdQHM5TFIdHJ4U+HAt92svx4DtOTygdIti9t+C0dn+oQRKM9Mo
	T9yb/vPhn1001GX27kk1+ZqioxOPKpmltsKyJTgQmSZrnoMmFXvAIUt4f50i268ACmgb2JSwaTKU6
	RuU7SSnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oahfQ-005dUF-6G; Tue, 20 Sep 2022 18:08:20 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oahfN-005dPq-96
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 18:08:18 +0000
Received: from fcoe-test11.blr.asicdesigners.com (fcoe-test11.blr.asicdesigners.com [10.193.185.180])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 28KI7jxx032399;
	Tue, 20 Sep 2022 11:07:46 -0700
From: Varun Prakash <varun@chelsio.com>
To: sagi@grimberg.me, hch@lst.de
Cc: linux-nvme@lists.infradead.org, varun@chelsio.com
Subject: [PATCH v2 RESEND] nvmet-tcp: handle ICReq PDU received in NVMET_TCP_Q_LIVE state
Date: Wed, 21 Sep 2022 00:04:44 +0530
Message-Id: <20220920183444.5115-1-varun@chelsio.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_110817_370674_31318499 
X-CRM114-Status: UNSURE (   9.88  )
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


