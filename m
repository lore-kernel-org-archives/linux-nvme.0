Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85867C77B76
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 13:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aD2VNuD2E1tDKjg0hrOisWghT7bUVIMdKRz/uLa3+d4=; b=d/Wd5d5wjIuWdsKnma29wcmsTq
	bDqTBCLk9wv4x43hleKSFteKiFF36sltNz3X3MGNpwx388Ia2cgA6YNvBZIjNXtt07mFDvlSHudGF
	ymDmZVCqj3gKU/qcPiCrm51GCGM1qu6svCEzB3TN6lw5eBGSIH3EzHnzxiLx3MgtRZple7Pv46m5G
	ZJLiHA0kRRFVrziPWNtE1yJwNxE/vfvrPTKfdYwCjrRzodt0bIweaomjS7bC5N77jAmsbzUCYJtFr
	2cJiKbBQnwtQkQmEFi/PAm1ryWDcij5Q7wI0MeObkpSdGcYb32lUDFsz4zbufbAI3uDwDfbWU5pef
	3dKDuwWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poOW6-00GIDg-0q;
	Mon, 17 Apr 2023 13:03:34 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poOVo-00GHuz-0K
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 13:03:20 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 7880921A8B;
	Mon, 17 Apr 2023 13:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681736584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aD2VNuD2E1tDKjg0hrOisWghT7bUVIMdKRz/uLa3+d4=;
	b=osO1sAppy9HpOE8IAnT8BPgb7cFZXJ/IdUV6Cg0nhW/vg+ygHgDHjHT3NAjle59eGQXS3J
	jMPtM9AEgs8w8mTn1xBV+qO9YP8PpRv1gg1tCMyjsV9TxGj1gqIHK3NCyYHX/QW+Brb726
	BLjJoaz5CDyI1E5eo+ss3zO8Mp9iYCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681736584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aD2VNuD2E1tDKjg0hrOisWghT7bUVIMdKRz/uLa3+d4=;
	b=mSPyrBYx9X7pWndervlxexwCJ+qZhpxUVthbHGh2Dh7AIKo+Uwg0Ax/gg0FJuvIFExJHDV
	Mjherdhu7n5EkxDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 6835C2C165;
	Mon, 17 Apr 2023 13:03:04 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 6493851C25BC; Mon, 17 Apr 2023 15:03:04 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 17/18] nvmet-tcp: control messages for recvmsg()
Date: Mon, 17 Apr 2023 15:03:01 +0200
Message-Id: <20230417130302.86274-18-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230417130302.86274-1-hare@suse.de>
References: <20230417130302.86274-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_060316_291685_A2F157CE 
X-CRM114-Status: GOOD (  16.01  )
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
 drivers/nvme/target/tcp.c | 51 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index ea853658430f..2974abd30b45 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -13,6 +13,7 @@
 #include <linux/nvme-keyring.h>
 #include <net/sock.h>
 #include <net/tcp.h>
+#include <net/tls.h>
 #include <net/handshake.h>
 #include <linux/inet.h>
 #include <linux/llist.h>
@@ -117,6 +118,7 @@ struct nvmet_tcp_cmd {
 	u32				pdu_len;
 	u32				pdu_recv;
 	int				sg_idx;
+	char				recv_cbuf[CMSG_LEN(sizeof(char))];
 	struct msghdr			recv_msg;
 	struct bio_vec			*iov;
 	u32				flags;
@@ -1103,12 +1105,39 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
 	return false;
 }
 
+static bool nvmet_tcp_tls_record_ok(struct msghdr *msg, char *cbuf)
+{
+	struct cmsghdr *cmsg = (struct cmsghdr *)cbuf;
+	unsigned char ctype;
+
+	if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS))
+		return 0;
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
@@ -1117,6 +1146,8 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 			iov.iov_len, msg.msg_flags);
 	if (unlikely(len < 0))
 		return len;
+	if (!nvmet_tcp_tls_record_ok(&msg, cbuf))
+		return -ENOTCONN;
 
 	queue->offset += len;
 	queue->left -= len;
@@ -1176,6 +1207,9 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 			cmd->recv_msg.msg_flags);
 		if (ret <= 0)
 			return ret;
+		if (!nvmet_tcp_tls_record_ok(&cmd->recv_msg,
+					     cmd->recv_cbuf))
+			return -ENOTCONN;
 
 		cmd->pdu_recv += ret;
 		cmd->rbytes_done += ret;
@@ -1197,7 +1231,14 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
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
@@ -1207,6 +1248,8 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 			iov.iov_len, msg.msg_flags);
 	if (unlikely(ret < 0))
 		return ret;
+	if (!nvmet_tcp_tls_record_ok(&msg, cbuf))
+		return -ENOTCONN;
 
 	queue->offset += ret;
 	queue->left -= ret;
@@ -1376,6 +1419,10 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
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


