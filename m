Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB34C77B60
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 14:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pAiMmHv8pjsf8sLnSuPYo7Ethu7R24Mz/yuU7mFAo/w=; b=0gTyzTeIbqq558XOMH7qtP+Z3I
	LFJQsyPyGC+GC2pSlJUcqycR7y3skIFEpEI5vDg5W+h0NrhKr+MDxjyAFy3L09MZ4Iu+pWTgM9wck
	2gxj4QMCabQ0P/ckB/Amdkka2vesQRvc02HThLA5/p3UpWpiOzdTT7o+s4wjCcFqEVPPhnRvQ2sCf
	nzY6XZnYyimGxcbKbcW1BoBwoWOXGvTq2g5fG/wwItzIaYlFgRVGcbJXG9CSWFjx5MnYf60gQ08pc
	uNZWkgoxm4IA08ehOcGEssTlju88d77JUaTsLvrl2WpYyXD0wX8AXR4vDT+T54+wKf36SWl2y0wlQ
	LFZBKpyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phWLe-000V6v-1g;
	Wed, 29 Mar 2023 14:00:22 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phWLI-000Ula-0u
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 14:00:06 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 13FC41FE01;
	Wed, 29 Mar 2023 13:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680098390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pAiMmHv8pjsf8sLnSuPYo7Ethu7R24Mz/yuU7mFAo/w=;
	b=aE4+BLgqMvtfQFmulZb4Uj/9LnAMg1TTLawRIAmgA6FYntsd8IEYQbOrG+sf6qcbu8zwfJ
	3N4qHj8t2f/32so4R27yh0P4zpvSSuwCZcfqMM9CS5izWDXXxlOkTwNqp4AcejTobjDJJn
	/QdtlEBv3OWjEm9eAs1IcDL10zdHmj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680098390;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pAiMmHv8pjsf8sLnSuPYo7Ethu7R24Mz/yuU7mFAo/w=;
	b=ac3aIx71cGAh9r/ddxb/3XUVh4pBH88R5FgRga2UQXNy7m1fO6m+YTFWzr8bTLlOJGMymY
	zliPw8HkrlNxHXBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 01F0E2C189;
	Wed, 29 Mar 2023 13:59:50 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 0002951BF394; Wed, 29 Mar 2023 15:59:49 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 17/18] nvmet-tcp: control messages for recvmsg()
Date: Wed, 29 Mar 2023 15:59:37 +0200
Message-Id: <20230329135938.46905-18-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230329135938.46905-1-hare@suse.de>
References: <20230329135938.46905-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_070000_552195_8BEF834A 
X-CRM114-Status: GOOD (  13.83  )
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
 drivers/nvme/target/tcp.c | 71 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 5daf16138471..75017fd5da9f 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -12,6 +12,7 @@
 #include <net/sock.h>
 #include <net/tcp.h>
 #ifdef CONFIG_NVME_TLS
+#include <net/tls.h>
 #include <net/handshake.h>
 #include <linux/nvme-keyring.h>
 #endif
@@ -92,6 +93,7 @@ struct nvmet_tcp_cmd {
 	u32				pdu_len;
 	u32				pdu_recv;
 	int				sg_idx;
+	char				recv_cbuf[CMSG_LEN(sizeof(char))];
 	struct msghdr			recv_msg;
 	struct bio_vec			*iov;
 	u32				flags;
@@ -1086,7 +1088,18 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 	struct nvme_tcp_hdr *hdr = &queue->pdu.cmd.hdr;
 	int len;
 	struct kvec iov;
+#ifdef CONFIG_NVME_TLS
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
+	unsigned char ctype;
+	struct cmsghdr *cmsg;
+	struct msghdr msg = {
+		.msg_control = cbuf,
+		.msg_controllen = sizeof(cbuf),
+		.msg_flags = MSG_DONTWAIT
+	};
+#else
 	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
+#endif
 
 recv:
 	iov.iov_base = (void *)&queue->pdu + queue->offset;
@@ -1095,6 +1108,19 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 			iov.iov_len, msg.msg_flags);
 	if (unlikely(len < 0))
 		return len;
+#ifdef CONFIG_NVME_TLS
+	cmsg = (struct cmsghdr *)cbuf;
+	if (CMSG_OK(&msg, cmsg) &&
+	    cmsg->cmsg_level == SOL_TLS &&
+	    cmsg->cmsg_type == TLS_GET_RECORD_TYPE) {
+		ctype = *((unsigned char *)CMSG_DATA(cmsg));
+		if (ctype != TLS_RECORD_TYPE_DATA) {
+			pr_err("queue %d unhandled TLS record %d\n",
+				queue->idx, ctype);
+			return -ENOTCONN;
+		}
+	}
+#endif
 
 	queue->offset += len;
 	queue->left -= len;
@@ -1150,10 +1176,27 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 	int ret;
 
 	while (msg_data_left(&cmd->recv_msg)) {
+#ifdef CONFIG_NVME_TLS
+		struct cmsghdr *cmsg;
+		unsigned char ctype;
+#endif
 		ret = sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
 			cmd->recv_msg.msg_flags);
 		if (ret <= 0)
 			return ret;
+#ifdef CONFIG_NVME_TLS
+		cmsg = (struct cmsghdr *)cmd->recv_cbuf;
+		if (CMSG_OK(&cmd->recv_msg, cmsg) &&
+		    cmsg->cmsg_level == SOL_TLS &&
+		    cmsg->cmsg_type == TLS_GET_RECORD_TYPE) {
+			ctype = *((unsigned char *)CMSG_DATA(cmsg));
+			if (ctype != TLS_RECORD_TYPE_DATA) {
+				pr_err("queue %d unhandled TLS record %d\n",
+				       queue->idx, ctype);
+				return -ENOTCONN;
+			}
+		}
+#endif
 
 		cmd->pdu_recv += ret;
 		cmd->rbytes_done += ret;
@@ -1175,7 +1218,18 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 {
 	struct nvmet_tcp_cmd *cmd = queue->cmd;
 	int ret;
+#ifdef CONFIG_NVME_TLS
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
+	unsigned char ctype;
+	struct cmsghdr *cmsg;
+	struct msghdr msg = {
+		.msg_control = cbuf,
+		.msg_controllen = sizeof(cbuf),
+		.msg_flags = MSG_DONTWAIT
+	};
+#else
 	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
+#endif
 	struct kvec iov = {
 		.iov_base = (void *)&cmd->recv_ddgst + queue->offset,
 		.iov_len = queue->left
@@ -1185,6 +1239,19 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 			iov.iov_len, msg.msg_flags);
 	if (unlikely(ret < 0))
 		return ret;
+#ifdef CONFIG_NVME_TLS
+	cmsg = (struct cmsghdr *)cbuf;
+	if (CMSG_OK(&msg, cmsg) &&
+	    cmsg->cmsg_level == SOL_TLS &&
+	    cmsg->cmsg_type == TLS_GET_RECORD_TYPE) {
+		ctype = *((unsigned char *)CMSG_DATA(cmsg));
+		if (ctype != TLS_RECORD_TYPE_DATA) {
+			pr_err("queue %d unhandled TLS record %d\n",
+				queue->idx, ctype);
+			return -ENOTCONN;
+		}
+	}
+#endif
 
 	queue->offset += ret;
 	queue->left -= ret;
@@ -1354,6 +1421,10 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
 	if (!c->r2t_pdu)
 		goto out_free_data;
 
+#ifdef CONFIG_NVME_TLS
+	c->recv_msg.msg_control = c->recv_cbuf;
+	c->recv_msg.msg_controllen = sizeof(c->recv_cbuf);
+#endif
 	c->recv_msg.msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL;
 
 	list_add_tail(&c->entry, &queue->free_list);
-- 
2.35.3


