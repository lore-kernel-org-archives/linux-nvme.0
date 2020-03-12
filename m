Return-Path: <SRS0=qcAl=45=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD56C10DCE
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 23:06:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA5F206F1
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 23:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GGgBubKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA5F206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0KKcrOYBwhmIUd41P6/76Lbk5xP7F5tRMlKJ0YVcHTQ=; b=GGgBubKykkKJfR
	l8lT75ZLndu5YVV6DybxsaQbTN1+sP4vo8nwLvq/1OYKWT4aPJ4WZjdiuf6mRL5TAW14gzHT8Yb2k
	6kBxi35DZgrfTCf1+zIlQF+dIAw7KE+8n1o1wK79U6QP2PsijGwd7OTOOLr/nE6Lfp9iosTUqjOOn
	bNn2xClF2gnzWP7IKVIs9mTaWoRKYXfeKv/O0KoQD0RWlQ7HrTJteSlUYWw78LVo5JyPap924FAJh
	Cbrt+rdbf8mt4nYTXVFGwW8ofSsgqBDCVGrZVIe3Rnc91ZHY9ldVpYRgC5osMOAAAT+GlxbYdJqMb
	URlxwutZnIrD/ieEu/xw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jCWuk-0003gW-H6; Thu, 12 Mar 2020 23:06:54 +0000
Received: from [2600:1700:65a0:78e0:c47a:8519:9343:83b8]
 (helo=sagi-Latitude-E7470.lbits)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCWui-0003d3-4B; Thu, 12 Mar 2020 23:06:52 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 2/2] nvmet-tcp: optimize tcp stack TX when data digest is
 used
Date: Thu, 12 Mar 2020 16:06:39 -0700
Message-Id: <20200312230639.13946-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312230639.13946-1-sagi@grimberg.me>
References: <20200312230639.13946-1-sagi@grimberg.me>
MIME-Version: 1.0
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
Cc: Keith Busch <kbusch@kernel.org>,
 Mark Wunderlich <mark.wunderlich@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If we have a 4-byte data digest to send to the wire, but we
have more data to send, set MSG_MORE to tell the stack
that more is coming.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v1:
- fix compilation error

 drivers/nvme/target/tcp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index e5d000f12059..f4de7b075284 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -628,7 +628,7 @@ static int nvmet_try_send_r2t(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
 	return 1;
 }
 
-static int nvmet_try_send_ddgst(struct nvmet_tcp_cmd *cmd)
+static int nvmet_try_send_ddgst(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
 {
 	struct nvmet_tcp_queue *queue = cmd->queue;
 	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
@@ -638,6 +638,9 @@ static int nvmet_try_send_ddgst(struct nvmet_tcp_cmd *cmd)
 	};
 	int ret;
 
+	if (!last_in_batch && cmd->queue->send_list_len)
+		msg.msg_flags |= MSG_MORE;
+
 	ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
 	if (unlikely(ret <= 0))
 		return ret;
@@ -678,7 +681,7 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
 	}
 
 	if (cmd->state == NVMET_TCP_SEND_DDGST) {
-		ret = nvmet_try_send_ddgst(cmd);
+		ret = nvmet_try_send_ddgst(cmd, last_in_batch);
 		if (ret <= 0)
 			goto done_send;
 	}
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
