Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054DFC00528
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Aug 2023 10:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SR80Jw0LargRfrCHXhqq5k7+Gjk1rN3PpTZUsFx0qJw=; b=zPOwbKZbRLJqIkBra4YVBWLbe2
	NIstvGr+9GPh96ifoaTAAbeW+7jORtlECwMj0JzntwhU2bANxaCAn6mZawHS3WrZ5FpRfyqmlAp2F
	auTGV+2U9O2eTtQsAaIC4oCTHMKKZ+VqvooTldrtAGFGE/RStnlWVaKlWGqcT0/7N2rjBpOOlC+eX
	G6joPetUaRPCkSyaZbejqOQSu2ws2E0Wf8IjRtK5Dg9IFpcqWB6++zSv+tCccdFzem6xhr99Ha1Fw
	BoNpuzMkWlUikkC5YtN1hy/htYbYjSzmNIkpLxxiFHQEQ9bmVlqKGIoP+8HNexaIF/aka60PejzBV
	mkU4SQxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRVxY-007XRy-0g;
	Thu, 03 Aug 2023 10:53:36 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRVxC-007XAN-2N
	for linux-nvme@lists.infradead.org;
	Thu, 03 Aug 2023 10:53:19 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 9ECA41F897;
	Thu,  3 Aug 2023 10:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691059989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SR80Jw0LargRfrCHXhqq5k7+Gjk1rN3PpTZUsFx0qJw=;
	b=hFYQ7n0OA2+783mU4GNJPhRBKqaOQ+QCX4SBX9qvWEOKOmlsQtCLr3rXsI2M3GUIxNaViV
	wuUEnZP4u7MIr3xH+EyaeQvof8qjSSzdcTm08R95u3NPSlKPuwySTSbA8UG0ESkANZZgYx
	+CWFQ/gpkNeAJllPEhIbP8ZubJqpj+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691059989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SR80Jw0LargRfrCHXhqq5k7+Gjk1rN3PpTZUsFx0qJw=;
	b=mNkf/L9ugcN/HwsyXfNUi9F0wmhcJnpk/ZB7wmAGGcsWy/pySh1FR4QGp5RYFa9iPt9b+w
	jkXSyjTl4lFlm1Cw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 918ED2C15F;
	Thu,  3 Aug 2023 10:53:09 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 8E51751CA7DB; Thu,  3 Aug 2023 12:53:09 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 14/14] nvmet-tcp: control messages for recvmsg()
Date: Thu,  3 Aug 2023 12:51:02 +0200
Message-Id: <20230803105102.30949-15-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230803105102.30949-1-hare@suse.de>
References: <20230803105102.30949-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_035314_954519_FFD5ADCD 
X-CRM114-Status: GOOD (  18.00  )
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
 drivers/nvme/target/tcp.c | 87 +++++++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7279c994abd6..e2db573d68d9 100644
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
@@ -1116,12 +1118,49 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
 	return false;
 }
 
+static int nvmet_tcp_tls_record_ok(struct socket *sock, struct msghdr *msg, char *cbuf)
+{
+	struct cmsghdr *cmsg = (struct cmsghdr *)cbuf;
+	u8 ctype, level, description;
+	int ret = 0;
+
+	if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS))
+		return 0;
+
+	ctype = tls_get_record_type(sock->sk, cmsg);
+	switch (ctype) {
+	case 0:
+		break;
+	case TLS_RECORD_TYPE_DATA:
+		break;
+	case TLS_RECORD_TYPE_ALERT:
+		tls_alert_recv(sock->sk, msg, &level, &description);
+		pr_err("TLS Alert level %u desc %u\n", level, description);
+		ret = (level == TLS_ALERT_LEVEL_FATAL) ?
+			-ENOTCONN : -EAGAIN;
+		break;
+	default:
+		/* discard this record type */
+		pr_err("TLS record %d unhandled\n", ctype);
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
-	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
+	struct msghdr msg = {
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+		.msg_control = cbuf,
+		.msg_controllen = sizeof(cbuf),
+#endif
+		.msg_flags = MSG_DONTWAIT
+	};
 
 recv:
 	iov.iov_base = (void *)&queue->pdu + queue->offset;
@@ -1130,6 +1169,9 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 			iov.iov_len, msg.msg_flags);
 	if (unlikely(len < 0))
 		return len;
+	ret = nvmet_tcp_tls_record_ok(queue->sock, &msg, cbuf);
+	if (ret < 0)
+		return ret;
 
 	queue->offset += len;
 	queue->left -= len;
@@ -1182,16 +1224,21 @@ static void nvmet_tcp_prep_recv_ddgst(struct nvmet_tcp_cmd *cmd)
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
+		if (len <= 0)
+			return len;
+		ret = nvmet_tcp_tls_record_ok(cmd->queue->sock,
+					      &cmd->recv_msg,
+					      cmd->recv_cbuf);
+		if (ret < 0)
 			return ret;
 
-		cmd->pdu_recv += ret;
-		cmd->rbytes_done += ret;
+		cmd->pdu_recv += len;
+		cmd->rbytes_done += len;
 	}
 
 	if (queue->data_digest) {
@@ -1209,20 +1256,30 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 {
 	struct nvmet_tcp_cmd *cmd = queue->cmd;
-	int ret;
-	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
+	int ret, len;
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
+	struct msghdr msg = {
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+		.msg_control = cbuf,
+		.msg_controllen = sizeof(cbuf),
+#endif
+		.msg_flags = MSG_DONTWAIT
+	};
 	struct kvec iov = {
 		.iov_base = (void *)&cmd->recv_ddgst + queue->offset,
 		.iov_len = queue->left
 	};
 
-	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
+	len = kernel_recvmsg(queue->sock, &msg, &iov, 1,
 			iov.iov_len, msg.msg_flags);
-	if (unlikely(ret < 0))
+	if (unlikely(len < 0))
+		return len;
+	ret = nvmet_tcp_tls_record_ok(queue->sock, &msg, cbuf);
+	if (ret < 0)
 		return ret;
 
-	queue->offset += ret;
-	queue->left -= ret;
+	queue->offset += len;
+	queue->left -= len;
 	if (queue->left)
 		return -EAGAIN;
 
@@ -1389,6 +1446,10 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
 	if (!c->r2t_pdu)
 		goto out_free_data;
 
+	if (IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS)) {
+		c->recv_msg.msg_control = c->recv_cbuf;
+		c->recv_msg.msg_controllen = sizeof(c->recv_cbuf);
+	}
 	c->recv_msg.msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL;
 
 	list_add_tail(&c->entry, &queue->free_list);
-- 
2.35.3


