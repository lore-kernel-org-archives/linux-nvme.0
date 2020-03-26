Return-Path: <SRS0=sW0/=5L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB4AC2D0ED
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 23:25:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4097220774
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 23:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qJONz/Ao";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1TSV/FMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4097220774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6l9BaeivscyqpTPVjGFP4fNdMdzMWy/k8K900aEXuOI=; b=qJONz/AowFa5lj
	0QjRwuH9FPQDINeuy/sIvydJKmIAceBNjehz1zpJIwwh33xFtQ2SduoHihS5E8Wu67WruJzTXHQRW
	0Zqz83JMJuNS05K7NyKHLDBAAB959DlQBW9++qUd4M3si+iXgsUMRupuntuaJi1nn0I3/wHDjCAGT
	0PN78Knf2JgNB95dC4rlDGeD1N3gR4ajFct9DOgntTN+oLxXOwwXkgKEQm/C8OUMEVmUOSO4G0xZb
	r+LjYL7fMM3BDidQ4b4dM08F/HvSH+5lx4DQ4bgcQhVdQDJyL1iRKbhdfKHyVYb3pNuRvAFbUR57z
	uCbqR1IbiEt+RpalUiHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHbsE-0002jG-46; Thu, 26 Mar 2020 23:25:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHbrk-0001Ye-Ff
 for linux-nvme@lists.infradead.org; Thu, 26 Mar 2020 23:24:49 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 51EC920B80;
 Thu, 26 Mar 2020 23:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585265088;
 bh=x1oBz/4EeoEH0IuRsxGJH5wWdqksV4YEUNXQ3V7mBW8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=1TSV/FMmIrwy8gO8AdhkiEjMdh/nBQPYu2bZKkF4eBplDVx9JXOpcXbe3DLQ1Q+IJ
 l1jegLEnluZ6dZLNpdn6E5mcap3UIw6psvnpCJfdtw08eH1wcn4qW5M4nX48FdSPiQ
 OH0upsGm1YPmpJTT/6X0Y74meOk20/qVXO0AhD6I=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 14/19] nvmet-tcp: set MSG_MORE only if we actually
 have more to send
Date: Thu, 26 Mar 2020 19:24:26 -0400
Message-Id: <20200326232431.7816-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326232431.7816-1-sashal@kernel.org>
References: <20200326232431.7816-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200326_162448_555324_1BB7EC70 
X-CRM114-Status: GOOD (  12.42  )
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
Cc: Keith Busch <kbusch@kernel.org>, Sasha Levin <sashal@kernel.org>,
 Mark Wunderlich <mark.wunderlich@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 98fd5c723730f560e5bea919a64ac5b83d45eb72 ]

When we send PDU data, we want to optimize the tcp stack
operation if we have more data to send. So when we set MSG_MORE
when:
- We have more fragments coming in the batch, or
- We have a more data to send in this PDU
- We don't have a data digest trailer
- We optimize with the SUCCESS flag and omit the NVMe completion
  (used if sq_head pointer update is disabled)

This addresses a regression in QD=1 with SUCCESS flag optimization
as we unconditionally set MSG_MORE when we didn't actually have
more data to send.

Fixes: 70583295388a ("nvmet-tcp: implement C2HData SUCCESS optimization")
Reported-by: Mark Wunderlich <mark.wunderlich@intel.com>
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index d535080b781f9..2fe34fd4c3f3b 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -515,7 +515,7 @@ static int nvmet_try_send_data_pdu(struct nvmet_tcp_cmd *cmd)
 	return 1;
 }
 
-static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd)
+static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
 {
 	struct nvmet_tcp_queue *queue = cmd->queue;
 	int ret;
@@ -523,9 +523,15 @@ static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd)
 	while (cmd->cur_sg) {
 		struct page *page = sg_page(cmd->cur_sg);
 		u32 left = cmd->cur_sg->length - cmd->offset;
+		int flags = MSG_DONTWAIT;
+
+		if ((!last_in_batch && cmd->queue->send_list_len) ||
+		    cmd->wbytes_done + left < cmd->req.transfer_len ||
+		    queue->data_digest || !queue->nvme_sq.sqhd_disabled)
+			flags |= MSG_MORE;
 
 		ret = kernel_sendpage(cmd->queue->sock, page, cmd->offset,
-					left, MSG_DONTWAIT | MSG_MORE);
+					left, flags);
 		if (ret <= 0)
 			return ret;
 
@@ -660,7 +666,7 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
 	}
 
 	if (cmd->state == NVMET_TCP_SEND_DATA) {
-		ret = nvmet_try_send_data(cmd);
+		ret = nvmet_try_send_data(cmd, last_in_batch);
 		if (ret <= 0)
 			goto done_send;
 	}
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
