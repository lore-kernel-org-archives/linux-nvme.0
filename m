Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DF9C04A6A
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 15:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o+rfdRH/nb6xmGXhFHCF1Tan3g0xylaNfsbF86yH/lc=; b=wiKRpYwTnwJX/CHo+5y6kvKnAa
	yR0l2Bpz6ForunRwk6po20RkHeVlmK2mp7BJ0uMrZ57s41H+QPsXE6rGkzR9Q/QdKcmG3Piq+ipT9
	+6h7dsi28qZurwkE7xfiQFwSoosKJgVnmK6JW5tbB2geNa3Lb0vJQ6H/5PVZD5f7sLwSX0bVZGsTl
	1lWlOqOqq1O/rHr2t2lI1L7pu1Rt47axFVe5TWkYiK6280OQf8wEs/fsBZxgB9qpJH8fhRApAYEkc
	xHlqPVbMxQniTwDAD982NEc43fZOo50+TPMWOuH2/i3PpfXtsoFOsKSWyOL+HToPzO6JzhYTZiCHe
	Mx8fniPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU7FR-007yBx-1L;
	Thu, 10 Aug 2023 15:06:49 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU7FL-007y4V-0h
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 15:06:45 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 0ADEB1F855;
	Thu, 10 Aug 2023 15:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691680001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+rfdRH/nb6xmGXhFHCF1Tan3g0xylaNfsbF86yH/lc=;
	b=XaghrNYoBANkMvI6L4z7IVsB4Gsdnn4Y3OI0c2J2WpBJmqSoqeIH0WCD4IdYHWN6f/bppi
	o+1+el2n2kTV2rVjHW+shAfN4qkVgvgGewl24sQeRwP/oQuCiY11/bz+i7F6uIEYXcAjT4
	nTl5IOchobkZpuaCXQAqGmWRUlzTFnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691680001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+rfdRH/nb6xmGXhFHCF1Tan3g0xylaNfsbF86yH/lc=;
	b=5p7qn+CfI7JpuoNCM4rmJfSzXjCaC69yLfNEOFMcXd53iANUx+7JWO/AL02XMRLk1ptOoq
	AiMeyBT8lA4wVQCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id E98E42C14F;
	Thu, 10 Aug 2023 15:06:40 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 182D451CAE4E; Thu, 10 Aug 2023 17:06:40 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 09/17] nvme-tcp: control message handling for recvmsg()
Date: Thu, 10 Aug 2023 17:06:22 +0200
Message-Id: <20230810150630.134991-10-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230810150630.134991-1-hare@suse.de>
References: <20230810150630.134991-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_080643_405400_5A32D96E 
X-CRM114-Status: GOOD (  13.37  )
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

kTLS is sending TLS ALERT messages as control messages for recvmsg().
As we can't do anything sensible with it just abort the connection
and let the userspace agent to a re-negotiation.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d5675f2d452e..5d373b089aca 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -14,6 +14,7 @@
 #include <net/sock.h>
 #include <net/tcp.h>
 #include <net/tls.h>
+#include <net/tls_prot.h>
 #include <net/handshake.h>
 #include <linux/blk-mq.h>
 #include <crypto/hash.h>
@@ -1369,6 +1370,8 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_icreq_pdu *icreq;
 	struct nvme_tcp_icresp_pdu *icresp;
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
+	u8 ctype;
 	struct msghdr msg = {};
 	struct kvec iov;
 	bool ctrl_hdgst, ctrl_ddgst;
@@ -1406,11 +1409,23 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	memset(&msg, 0, sizeof(msg));
 	iov.iov_base = icresp;
 	iov.iov_len = sizeof(*icresp);
+	if (queue->ctrl->ctrl.opts->tls) {
+		msg.msg_control = cbuf;
+		msg.msg_controllen = sizeof(cbuf);
+	}
 	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
 			iov.iov_len, msg.msg_flags);
 	if (ret < 0)
 		goto free_icresp;
-
+	if (queue->ctrl->ctrl.opts->tls) {
+		ctype = tls_get_record_type(queue->sock->sk,
+					    (struct cmsghdr *)cbuf);
+		if (ctype != TLS_RECORD_TYPE_DATA) {
+			pr_err("queue %d: unhandled TLS record %d\n",
+			       nvme_tcp_queue_id(queue), ctype);
+			return -ENOTCONN;
+		}
+	}
 	ret = -EINVAL;
 	if (icresp->hdr.type != nvme_tcp_icresp) {
 		pr_err("queue %d: bad type returned %d\n",
-- 
2.35.3


