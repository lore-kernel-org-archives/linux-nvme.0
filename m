Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFAFC77B78
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Apr 2023 06:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/Hmf4TwUNkp9YwFkZ3givQx6ubEBhewgw4oYiSQmKDw=; b=LUGC7jChDHBUEy944SHCgyl3aB
	CyWKWy6/NhUVmHs1w1NtjAFS5vDcC/y44LNPbZaHuuulkoltYqXGTMeBX9dUy8Bt1nlrAJVDIAP3y
	qhDuJq5GvpZqemQgL43fgabAlzKuzLGKKJvxnjjuuwCErMUPHCX6H4bmXx1gMQqitdpxWpJ21o6x4
	oj3B6cXwjTbPWhdObwO/HeY4uLeSQxBIj8cxETT5oBehRDDwI8ZoWrBwz1BwDuSq72ca0JVy6EPCx
	VwltZd7GXGAoV/qljv0kWwwI1MWNPxJBWO1sShCz32NiXSYe8dnjP4xOCNW4RdkMj2n8jjNQQyQba
	OstXaOuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pp1l1-004IeF-1M;
	Wed, 19 Apr 2023 06:57:35 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pp1kr-004IWj-0W
	for linux-nvme@lists.infradead.org;
	Wed, 19 Apr 2023 06:57:27 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 6C3EE1FD91;
	Wed, 19 Apr 2023 06:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681887438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Hmf4TwUNkp9YwFkZ3givQx6ubEBhewgw4oYiSQmKDw=;
	b=nucnq8VD+tr5EKp3N32B7DtSnibi7kWtcbB7BAwVjg7XfT8Ab/daxfmIjYZY+KTbNjZeev
	Tj9pXdj9JhZSMIxDp/yAPr1dwB4Pgco/mG6hQ+E/kRfiYRtJXTelc1KZOtFuH24cIHyjCh
	OSEkEP3EngUd3RYLkE6ONFwZKfwjTQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681887438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Hmf4TwUNkp9YwFkZ3givQx6ubEBhewgw4oYiSQmKDw=;
	b=WszjrTN+NlCbR5zj2xoXqtfre520XRZVGs5c7WtbfsIkEq3z9NJhoNUkK/0fV8S3IBbliz
	68ShAaPAkRCg0BDQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 5AE862C165;
	Wed, 19 Apr 2023 06:57:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 57BF951C26E9; Wed, 19 Apr 2023 08:57:18 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 17/17] nvmet-tcp: control messages for recvmsg()
Date: Wed, 19 Apr 2023 08:57:14 +0200
Message-Id: <20230419065714.52076-18-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230419065714.52076-1-hare@suse.de>
References: <20230419065714.52076-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_235725_366534_EB51BE28 
X-CRM114-Status: GOOD (  15.58  )
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
 drivers/nvme/target/tcp.c | 50 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 26c911ddc2de..2974abd30b45 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -118,6 +118,7 @@ struct nvmet_tcp_cmd {
 	u32				pdu_len;
 	u32				pdu_recv;
 	int				sg_idx;
+	char				recv_cbuf[CMSG_LEN(sizeof(char))];
 	struct msghdr			recv_msg;
 	struct bio_vec			*iov;
 	u32				flags;
@@ -1104,12 +1105,39 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
 	return false;
 }
 
+static bool nvmet_tcp_tls_record_ok(struct msghdr *msg, char *cbuf)
+{
+	struct cmsghdr *cmsg = (struct cmsghdr *)cbuf;
+	unsigned char ctype;
+
+	if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS))
+		return true;
+
+	if (CMSG_OK(msg, cmsg) &&
+	    cmsg->cmsg_level == SOL_TLS &&
+	    cmsg->cmsg_type == TLS_GET_RECORD_TYPE) {
+		ctype = *((unsigned char *)CMSG_DATA(cmsg));
+		if (ctype != TLS_RECORD_TYPE_DATA) {
+			pr_err("unhandled TLS record %d\n", ctype);
+			return false;
+		}
+	}
+	return true;
+}
+
 static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 {
 	struct nvme_tcp_hdr *hdr = &queue->pdu.cmd.hdr;
 	int len;
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
@@ -1118,6 +1146,8 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 			iov.iov_len, msg.msg_flags);
 	if (unlikely(len < 0))
 		return len;
+	if (!nvmet_tcp_tls_record_ok(&msg, cbuf))
+		return -ENOTCONN;
 
 	queue->offset += len;
 	queue->left -= len;
@@ -1177,6 +1207,9 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 			cmd->recv_msg.msg_flags);
 		if (ret <= 0)
 			return ret;
+		if (!nvmet_tcp_tls_record_ok(&cmd->recv_msg,
+					     cmd->recv_cbuf))
+			return -ENOTCONN;
 
 		cmd->pdu_recv += ret;
 		cmd->rbytes_done += ret;
@@ -1198,7 +1231,14 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 {
 	struct nvmet_tcp_cmd *cmd = queue->cmd;
 	int ret;
-	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
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
@@ -1208,6 +1248,8 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 			iov.iov_len, msg.msg_flags);
 	if (unlikely(ret < 0))
 		return ret;
+	if (!nvmet_tcp_tls_record_ok(&msg, cbuf))
+		return -ENOTCONN;
 
 	queue->offset += ret;
 	queue->left -= ret;
@@ -1377,6 +1419,10 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
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


