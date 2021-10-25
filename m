Return-Path: <SRS0=jIqL=PN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB95C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Oct 2021 17:17:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CDB560F4F
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Oct 2021 17:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1CDB560F4F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/gVkhhhViRLy3psyfLfm9QrOl53+skcaiOjDkCA36wc=; b=TH036j52HyaRZGRAaPuwjJqEvw
	fe+sm583hnAlJ37NV7Y7F+aiQLyRHbO+EZttpHMTGQzp+yUAEPrl0nZYozCSu3z5xZp764VG5u4G3
	2qehDIszJt2fWUJM+UpQdj+DJPLn/tkVOGcK97gHk9Oxg2KrObgvMdp+U+hEZDTxHOnVCAN/ll0Zw
	u2S196hQWr0V95vYdTS6IzlUvojt51emZWg1V3V/6tA+Xg6OdmT4ZVxLMXV+TXA/6z/HvPjr6ZK4K
	fi0T6g+hJ2+wcqWi11vyMYigYBupMYn00IeVfZ7Q0Za+fNMbhq8rO5JBWGkPbRxDOtiYe4cyZmqz/
	+IT0oZug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mf3bK-00HE5k-LR; Mon, 25 Oct 2021 17:17:34 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mf3bH-00HE53-Le
 for linux-nvme@lists.infradead.org; Mon, 25 Oct 2021 17:17:33 +0000
Received: from fcoe-test11.asicdesigners.com
 (fcoe-test11.blr.asicdesigners.com [10.193.185.180])
 by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 19PHHCI8001369;
 Mon, 25 Oct 2021 10:17:13 -0700
From: Varun Prakash <varun@chelsio.com>
To: sagi@grimberg.me, hch@lst.de
Cc: linux-nvme@lists.infradead.org, varun@chelsio.com
Subject: [PATCH] nvmet-tcp: fix data digest pointer calculation
Date: Mon, 25 Oct 2021 22:46:54 +0530
Message-Id: <1635182214-3958-1-git-send-email-varun@chelsio.com>
X-Mailer: git-send-email 2.0.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211025_101731_739837_B5395E54 
X-CRM114-Status: GOOD (  10.10  )
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

exp_ddgst is of type __le32, &cmd->exp_ddgst + cmd->offset
increases &cmd->exp_ddgst by 4 * cmd->offset, fix this by
type casting &cmd->exp_ddgst to u8 *.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Signed-off-by: Varun Prakash <varun@chelsio.com>
---
 drivers/nvme/target/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 07ee347..d641bfa 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -702,7 +702,7 @@ static int nvmet_try_send_ddgst(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
 	struct nvmet_tcp_queue *queue = cmd->queue;
 	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
 	struct kvec iov = {
-		.iov_base = &cmd->exp_ddgst + cmd->offset,
+		.iov_base = (u8 *)&cmd->exp_ddgst + cmd->offset,
 		.iov_len = NVME_TCP_DIGEST_LENGTH - cmd->offset
 	};
 	int ret;
-- 
2.0.2


