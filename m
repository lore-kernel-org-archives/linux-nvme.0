Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D28C87FCA
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Jul 2025 18:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XgDTg6o9aZfig0iHBAAhNM0B4m3NdMq96NVOVqq6qlE=; b=4Y5vf9NjDCSSneesvRUeiKABSt
	F94KUc0J3dHyZqpiMD25DjxeRDidYRgMA/n7wiAhLpxx1zDdq7coPAhsHTT+OOWi+whWTEH4OU6hD
	jlim7l0EpNezEvH0qM5NRkssIeGSbTZdi0qiR9fXlncGdLwA3rBdPxzIAixK8zGsV+W+1XFXop3QH
	qV8qW4N6xoEYGeEwqeDkSNZkckM5JKnR8gNyeDnLnZLRM92l+5MHB3B8R/HXnQsF0XcTXYGdmbS+5
	PU1S2XK08+sntiP1/zm8Li8iYF/USifUOwExHjAAXdVx+Z6DFgSYGd5JGaozXVGqXiXKdgS8DFVr4
	2j5fqnEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhXas-00000004DW1-1sBx;
	Thu, 31 Jul 2025 18:01:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhXaq-00000004DUu-2VQy
	for linux-nvme@lists.infradead.org;
	Thu, 31 Jul 2025 18:01:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753984887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XgDTg6o9aZfig0iHBAAhNM0B4m3NdMq96NVOVqq6qlE=;
	b=Hd25AoEjuNvS/HgPFAL8BINQ9a4DoDy6kb5gGcWcwFeHDhTIaSw1Z8a5VDocBO+kD9iBXN
	YzsRyt0uS45lc3luXkbzexaZKW/6X6H+JCiZ3LUOGCLdWguO6Ou87FH+vsBVtAUC/cEVmz
	8j2YPrfgWXQpSRq4JgnuvCDSMk8P47A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-CKAe2FdYOz2Wb91LQcmHfA-1; Thu,
 31 Jul 2025 14:01:23 -0400
X-MC-Unique: CKAe2FdYOz2Wb91LQcmHfA-1
X-Mimecast-MFC-AGG-ID: CKAe2FdYOz2Wb91LQcmHfA_1753984879
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 144DB19560AF;
	Thu, 31 Jul 2025 18:01:19 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.82.42])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1788B30001B9;
	Thu, 31 Jul 2025 18:01:14 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	trondmy@hammerspace.com,
	anna.schumaker@oracle.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-nfs@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	neil@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	hare@suse.de,
	horms@kernel.org,
	kbusch@kernel.org
Subject: [PATCH v2 3/4] nvmet-tcp: fix handling of tls alerts
Date: Thu, 31 Jul 2025 14:00:57 -0400
Message-Id: <20250731180058.4669-4-okorniev@redhat.com>
In-Reply-To: <20250731180058.4669-1-okorniev@redhat.com>
References: <20250731180058.4669-1-okorniev@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250731_110128_708425_F1101D2C 
X-CRM114-Status: GOOD (  17.58  )
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

Revert kvec msg iterator before trying to process a TLS alert
when possible.

In nvmet_tcp_try_recv_data(), it's assumed that no msg control
message buffer is set prior to sock_recvmsg(). Hannes suggested
that upon detecting that TLS control message is received log a
message and error out. Left comments in the code for the future
improvements.

Fixes: a1c5dd8355b1 ("nvmet-tcp: control messages for recvmsg()")
Suggested-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Hannes Reinecky <hare@susu.de>
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 drivers/nvme/target/tcp.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 688033b88d38..98cee10de713 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -120,7 +120,6 @@ struct nvmet_tcp_cmd {
 	u32				pdu_len;
 	u32				pdu_recv;
 	int				sg_idx;
-	char				recv_cbuf[CMSG_LEN(sizeof(char))];
 	struct msghdr			recv_msg;
 	struct bio_vec			*iov;
 	u32				flags;
@@ -1161,6 +1160,7 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 	if (unlikely(len < 0))
 		return len;
 	if (queue->tls_pskid) {
+		iov_iter_revert(&msg.msg_iter, len);
 		ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
 		if (ret < 0)
 			return ret;
@@ -1217,19 +1217,28 @@ static void nvmet_tcp_prep_recv_ddgst(struct nvmet_tcp_cmd *cmd)
 static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 {
 	struct nvmet_tcp_cmd  *cmd = queue->cmd;
-	int len, ret;
+	int len;
 
 	while (msg_data_left(&cmd->recv_msg)) {
+		/* to detect that we received a TlS alert, we assumed that
+		 * cmg->recv_msg's control buffer is not setup. kTLS will
+		 * return an error when no control buffer is set and
+		 * non-tls-data payload is received.
+		 */
 		len = sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
 			cmd->recv_msg.msg_flags);
+		if (cmd->recv_msg.msg_flags & MSG_CTRUNC) {
+			if (len == 0 || len == -EIO) {
+				pr_err("queue %d: unhandled control message\n",
+				       queue->idx);
+				/* note that unconsumed TLS control message such
+				 * as TLS alert is still on the socket.
+				 */
+				return -EAGAIN;
+			}
+		}
 		if (len <= 0)
 			return len;
-		if (queue->tls_pskid) {
-			ret = nvmet_tcp_tls_record_ok(cmd->queue,
-					&cmd->recv_msg, cmd->recv_cbuf);
-			if (ret < 0)
-				return ret;
-		}
 
 		cmd->pdu_recv += len;
 		cmd->rbytes_done += len;
@@ -1267,6 +1276,7 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 	if (unlikely(len < 0))
 		return len;
 	if (queue->tls_pskid) {
+		iov_iter_revert(&msg.msg_iter, len);
 		ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
 		if (ret < 0)
 			return ret;
@@ -1453,10 +1463,6 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
 	if (!c->r2t_pdu)
 		goto out_free_data;
 
-	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
-		c->recv_msg.msg_control = c->recv_cbuf;
-		c->recv_msg.msg_controllen = sizeof(c->recv_cbuf);
-	}
 	c->recv_msg.msg_flags = MSG_DONTWAIT | MSG_NOSIGNAL;
 
 	list_add_tail(&c->entry, &queue->free_list);
@@ -1736,6 +1742,7 @@ static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue)
 		return len;
 	}
 
+	iov_iter_revert(&msg.msg_iter, len);
 	ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
 	if (ret < 0)
 		return ret;
-- 
2.47.1


