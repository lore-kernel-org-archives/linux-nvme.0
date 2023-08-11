Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E6BC001DB
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 12:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C4HAFDGJgRtCoHk9PN7cFsTDC3VY7tc+DocJw+qo+Ig=; b=E6mGASrzExc8SZ6riUuNGyvp38
	4/veqIv+Z9Zw4CTma/Zg3lw4frWjZQLU3XnXTi+GK7RnsVhVGarKeLIQ7DvohkLRQQ0/dKSv2XStm
	R3v5Y5EFoGtjcBFyPcRyb91d3JyTsnJnPHBifXmBu28jS17uCVQn9oiaoOxxGixm2zYwo6jLQHtuh
	PhpStecH2IlsZ9ZMUsD5xW47ynwYRqEr6VPhOsdSmfo7G524QZJ5/zVy5eEdpfkV79wqQ6NsJUBeX
	Ox6W0KNLv/nffXLPWCxp5TmZwxCsxoMHWucHNp6hScU4JZuOIKhyJnLMDK5GgfHlc8CRtrKIbb3TP
	SYDThv4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUR6G-00AZTH-2M;
	Fri, 11 Aug 2023 12:18:40 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUR5q-00AZ5w-1T
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 12:18:17 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 7000521887;
	Fri, 11 Aug 2023 12:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691756286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C4HAFDGJgRtCoHk9PN7cFsTDC3VY7tc+DocJw+qo+Ig=;
	b=IIu3GpT7x6T02tvKgYtEeODOMF9BE0kZj2ueLST8NWeRuNCx4oIdIHUSdnKDWBOTATiZZ0
	07Tz3v8fKlCio2mLRetpPp+obQTvGigrT1msKz+LRA/xiqK/L1sC0TVJ9YncB5KeE9e/TE
	a/QYvo7vWZ3Hb7Bv7PI2nCrjqc5KEXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691756286;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C4HAFDGJgRtCoHk9PN7cFsTDC3VY7tc+DocJw+qo+Ig=;
	b=aCvJCN1G7k2eY0vpKtpakTkECU9O/3lDG7jy0pW7qTB0/WuL57HVhaDfdcuuy+gox7OjCB
	UwoemXh0G7HnkrAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 5D04A2C165;
	Fri, 11 Aug 2023 12:18:06 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 5939C51CAF06; Fri, 11 Aug 2023 14:18:06 +0200 (CEST)
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
Subject: [PATCH 17/17] nvmet-tcp: control messages for recvmsg()
Date: Fri, 11 Aug 2023 14:17:55 +0200
Message-Id: <20230811121755.24715-18-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230811121755.24715-1-hare@suse.de>
References: <20230811121755.24715-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_051814_640608_675234A6 
X-CRM114-Status: GOOD (  16.83  )
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
---
 drivers/nvme/target/tcp.c | 94 +++++++++++++++++++++++++++++++++------
 1 file changed, 81 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index ca4aa8870876..6477c50dade2 100644
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
@@ -1122,20 +1124,65 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
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
@@ -1188,16 +1235,22 @@ static void nvmet_tcp_prep_recv_ddgst(struct nvmet_tcp_cmd *cmd)
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
@@ -1215,20 +1268,30 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
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
 
@@ -1396,6 +1459,10 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
 	if (!c->r2t_pdu)
 		goto out_free_data;
 
+	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
+		c->recv_msg.msg_control = c->recv_cbuf;
+		c->recv_msg.msg_controllen = sizeof(c->recv_cbuf);
+	}
 	c->recv_msg.msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL;
 
 	list_add_tail(&c->entry, &queue->free_list);
@@ -1705,6 +1772,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 	}
 	if (!status)
 		queue->tls_pskid = peerid;
+
 	queue->state = NVMET_TCP_Q_CONNECTING;
 	spin_unlock_bh(&queue->state_lock);
 
-- 
2.35.3


