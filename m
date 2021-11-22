Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B802C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 11:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=13vxqt+9442TTxFtA/kKg9ZD70GQyveb95W3HcD0fO4=; b=Hdt2eDa8J1qsyF0yqPeoJY4Z39
	Fs3/kbb5NP8WFXu7dV6cotjVPgjZsnxajXuWEsw+eg8B3x/LLblCdALk+SVI5nEr4+s+/jqItPtLG
	iQo0IF6l1DhbKXaCVpwsHB2l3FVGqqpLEdhD+3XNIgKYfjLpopC4cTjZFJXLabIFjJBco/JPxImAD
	YCsw1dEPTqgswvXhT9zeyoX0uI34+4JPBYIDBMGj5nvCEQxG5M20OZQCFJFJ6uwycL9vv+VSjR8cm
	XpIppcJf8ntgF0w8p5aOdWiVYq4jQivdDMCjWuBmZs92fE+x6OWqf9Z4kwr2ftjc8XFYXJRAoTGN+
	x7QBaXCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp7Qg-00G2O4-Dy; Mon, 22 Nov 2021 11:24:10 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp6G0-00Fm1q-O2
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 10:09:06 +0000
Received: from fcoe-test11.asicdesigners.com
 (fcoe-test11.blr.asicdesigners.com [10.193.185.180])
 by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 1AMA8kvM008912;
 Mon, 22 Nov 2021 02:08:47 -0800
From: Varun Prakash <varun@chelsio.com>
To: sagi@grimberg.me, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, varun@chelsio.com
Subject: [PATCH] nvmet-tcp: fix incomplete data digest send
Date: Mon, 22 Nov 2021 15:38:41 +0530
Message-Id: <1637575721-3055-1-git-send-email-varun@chelsio.com>
X-Mailer: git-send-email 2.0.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_020904_852468_9F723781 
X-CRM114-Status: GOOD (  10.35  )
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

Current nvmet_try_send_ddgst() code does not check whether
all data digest bytes are transmitted, fix this by returning
-EAGAIN if all data digest bytes are not transmitted.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Signed-off-by: Varun Prakash <varun@chelsio.com>
---
 drivers/nvme/target/tcp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 84c387e..2b8bab2 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -700,10 +700,11 @@ static int nvmet_try_send_r2t(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
 static int nvmet_try_send_ddgst(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
 {
 	struct nvmet_tcp_queue *queue = cmd->queue;
+	int left = NVME_TCP_DIGEST_LENGTH - cmd->offset;
 	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
 	struct kvec iov = {
 		.iov_base = (u8 *)&cmd->exp_ddgst + cmd->offset,
-		.iov_len = NVME_TCP_DIGEST_LENGTH - cmd->offset
+		.iov_len = left
 	};
 	int ret;
 
@@ -717,6 +718,10 @@ static int nvmet_try_send_ddgst(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
 		return ret;
 
 	cmd->offset += ret;
+	left -= ret;
+
+	if (left)
+		return -EAGAIN;
 
 	if (queue->nvme_sq.sqhd_disabled) {
 		cmd->queue->snd_cmd = NULL;
-- 
2.0.2


