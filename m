Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA5EC7EE43
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Aug 2023 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MdQA0BigpQINKroLEOIHPwaFGH2Njw1rdg+sfi0Z2nI=; b=oRfDo6zBCyATQmeVKSSsnxm9Wu
	JfJ7rMPi0J08WzeaA0Jn+ZoF2Y+fNeiSlWSPjYXXHzj6oqlW+GHLHMBlvTiyfF08Y82P40hCF2uY8
	KZ07gw3GfgIbvdJtReM8pa7z/E/d3NeF/EBjLZN35u+f8tX99vRVTU7ruH5H67wMWtj1chs+AYc6b
	3hWhCk4zK2epBpA8kTPNVEhX7ZSyYy6zhqwfSYcC6+pWlf3sm0af1nVJCMFMHZrgo0pYkSK3eix4U
	YGwgEiEZVRdy5sKZz3kKFQbEPO1ze7cmyea2g1zBWWb4YJk06LHF9W+H9JMys7v+HhFsSqqXXARee
	GsTXac8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qZBV4-003FYP-0r;
	Thu, 24 Aug 2023 14:39:54 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qZBUm-003FGu-02
	for linux-nvme@lists.infradead.org;
	Thu, 24 Aug 2023 14:39:40 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 092CD20E2E;
	Thu, 24 Aug 2023 14:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692887967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MdQA0BigpQINKroLEOIHPwaFGH2Njw1rdg+sfi0Z2nI=;
	b=xzSGIjZ8+0y2BnY8aAYfQsz32DEMzwkJYnF89g5B+vT46pFZtt0ZhI3LOH2bVu23Awuj9y
	xMbQ97+WQmzL5bzBAj2s3aTukW1N3aPNLwZOR/zANJAzVCFwAi/D4uT5Ln4hnpCnYU2ztc
	Nyg5php3kyqXDXcKdTpQhyoJdBKQvOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692887967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MdQA0BigpQINKroLEOIHPwaFGH2Njw1rdg+sfi0Z2nI=;
	b=s4/gWYHO1gA7iBOHqlsNQ82fH7GqtQDf3JGVMeWcARBBLBLMg6uL38YrlOyoRJExEvf+Td
	cRhdYoElZ8bGY0Cw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 035952C166;
	Thu, 24 Aug 2023 14:39:27 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 0080D51CB8D9; Thu, 24 Aug 2023 16:39:26 +0200 (CEST)
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
Subject: [PATCH 17/18] nvmet-tcp: control messages for recvmsg()
Date: Thu, 24 Aug 2023 16:39:24 +0200
Message-Id: <20230824143925.9098-18-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230824143925.9098-1-hare@suse.de>
References: <20230824143925.9098-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230824_073936_193923_889467D5 
X-CRM114-Status: GOOD (  16.62  )
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

kTLS requires control messages for recvmsg() to relay any out-of-band
TLS messages (eg TLS alerts) to the caller.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/tcp.c | 93 +++++++++++++++++++++++++++++++++------
 1 file changed, 80 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 1139d40a9ef6..67fffa2e1e4a 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -14,6 +14,7 @@
 #include <net/sock.h>
 #include <net/tcp.h>
 #include <net/tls.h>
+#include <net/tls_prot.h>
 #include <net/handshake.h>
 #include <linux/inet.h>
 #include <linux/llist.h>
@@ -118,6 +119,7 @@ struct nvmet_tcp_cmd {
 	u32				pdu_len;
 	u32				pdu_recv;
 	int				sg_idx;
+	char				recv_cbuf[CMSG_LEN(sizeof(char))];
 	struct msghdr			recv_msg;
 	struct bio_vec			*iov;
 	u32				flags;
@@ -1121,20 +1123,65 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
 	return false;
 }
 
+static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
+		struct msghdr *msg, char *cbuf)
+{
+	struct cmsghdr *cmsg = (struct cmsghdr *)cbuf;
+	u8 ctype, level, description;
+	int ret = 0;
+
+	ctype = tls_get_record_type(queue->sock->sk, cmsg);
+	switch (ctype) {
+	case 0:
+		break;
+	case TLS_RECORD_TYPE_DATA:
+		break;
+	case TLS_RECORD_TYPE_ALERT:
+		tls_alert_recv(queue->sock->sk, msg, &level, &description);
+		if (level == TLS_ALERT_LEVEL_FATAL) {
+			pr_err("queue %d: TLS Alert desc %u\n",
+			       queue->idx, description);
+			ret = -ENOTCONN;
+		} else {
+			pr_warn("queue %d: TLS Alert desc %u\n",
+			       queue->idx, description);
+			ret = -EAGAIN;
+		}
+		break;
+	default:
+		/* discard this record type */
+		pr_err("queue %d: TLS record %d unhandled\n",
+		       queue->idx, ctype);
+		ret = -EAGAIN;
+		break;
+	}
+	return ret;
+}
+
 static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 {
 	struct nvme_tcp_hdr *hdr = &queue->pdu.cmd.hdr;
-	int len;
+	int len, ret;
 	struct kvec iov;
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
 	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
 
 recv:
 	iov.iov_base = (void *)&queue->pdu + queue->offset;
 	iov.iov_len = queue->left;
+	if (queue->tls_pskid) {
+		msg.msg_control = cbuf;
+		msg.msg_controllen = sizeof(cbuf);
+	}
 	len = kernel_recvmsg(queue->sock, &msg, &iov, 1,
 			iov.iov_len, msg.msg_flags);
 	if (unlikely(len < 0))
 		return len;
+	if (queue->tls_pskid) {
+		ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
+		if (ret < 0)
+			return ret;
+	}
 
 	queue->offset += len;
 	queue->left -= len;
@@ -1187,16 +1234,22 @@ static void nvmet_tcp_prep_recv_ddgst(struct nvmet_tcp_cmd *cmd)
 static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 {
 	struct nvmet_tcp_cmd  *cmd = queue->cmd;
-	int ret;
+	int len, ret;
 
 	while (msg_data_left(&cmd->recv_msg)) {
-		ret = sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
+		len = sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
 			cmd->recv_msg.msg_flags);
-		if (ret <= 0)
-			return ret;
+		if (len <= 0)
+			return len;
+		if (queue->tls_pskid) {
+			ret = nvmet_tcp_tls_record_ok(cmd->queue,
+					&cmd->recv_msg, cmd->recv_cbuf);
+			if (ret < 0)
+				return ret;
+		}
 
-		cmd->pdu_recv += ret;
-		cmd->rbytes_done += ret;
+		cmd->pdu_recv += len;
+		cmd->rbytes_done += len;
 	}
 
 	if (queue->data_digest) {
@@ -1214,20 +1267,30 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 {
 	struct nvmet_tcp_cmd *cmd = queue->cmd;
-	int ret;
+	int ret, len;
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
 	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
 	struct kvec iov = {
 		.iov_base = (void *)&cmd->recv_ddgst + queue->offset,
 		.iov_len = queue->left
 	};
 
-	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
+	if (queue->tls_pskid) {
+		msg.msg_control = cbuf;
+		msg.msg_controllen = sizeof(cbuf);
+	}
+	len = kernel_recvmsg(queue->sock, &msg, &iov, 1,
 			iov.iov_len, msg.msg_flags);
-	if (unlikely(ret < 0))
-		return ret;
+	if (unlikely(len < 0))
+		return len;
+	if (queue->tls_pskid) {
+		ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
+		if (ret < 0)
+			return ret;
+	}
 
-	queue->offset += ret;
-	queue->left -= ret;
+	queue->offset += len;
+	queue->left -= len;
 	if (queue->left)
 		return -EAGAIN;
 
@@ -1407,6 +1470,10 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
 	if (!c->r2t_pdu)
 		goto out_free_data;
 
+	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
+		c->recv_msg.msg_control = c->recv_cbuf;
+		c->recv_msg.msg_controllen = sizeof(c->recv_cbuf);
+	}
 	c->recv_msg.msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL;
 
 	list_add_tail(&c->entry, &queue->free_list);
-- 
2.35.3


