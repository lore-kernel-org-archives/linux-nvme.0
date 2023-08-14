Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B03EC001B0
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Aug 2023 11:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JMzgmQkGcG0qLeLUz5FnmkvxiaBRwbUuqjidCna4Wbs=; b=rfc4+KcK0sazKHmgvvEHOzsoSV
	MQtRGbVD12xbctT5FZaGSXexRCxFpEr62Mjc8HYjWVwDpP8y4XTb05qYKDCFAMiBoz23Xj+IrtUq2
	p1aNGZ+r3iHH4PD+Ni/aMDRCmDcHBwlwflacU6YAfa5/+0dvMLiT/TIDwRk0R+SU80TbNr6o2PXSq
	ppzNRi5jDJWcNvhdK6pQf98r7s7jDdaKC4z5nFrdxQUP2gcUEjo0hHnPyWmodC3CpwjkmVnSJ4NEm
	NogvsOSLU2U6yw/6/HBNZuzWkDobaq9sR7St5bLEkXppiKl2Ep4KdLeX5mDVMCRzhLOI8EawWdjfe
	lcZ3COAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVVcP-00Gv57-2T;
	Mon, 14 Aug 2023 11:20:17 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVVc9-00GunF-0C
	for linux-nvme@lists.infradead.org;
	Mon, 14 Aug 2023 11:20:03 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 705491FD6E;
	Mon, 14 Aug 2023 11:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692011992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JMzgmQkGcG0qLeLUz5FnmkvxiaBRwbUuqjidCna4Wbs=;
	b=HbcXQ6SytIF4OeDVNyKftNrR/xaetAk5aPD0sxVqf9feK7Jz5waSKvBny9PUl1597MUDWw
	9bb+SHSl1QXQZ9VY6Z2642MYk/8FCiHafXQ/9KT+eRFvVaa2uA8kYy6Zm40Z27Yb4+xXuA
	9LlvWZj4DfUgf+QBWwty4GFdmwyQHF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692011992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JMzgmQkGcG0qLeLUz5FnmkvxiaBRwbUuqjidCna4Wbs=;
	b=OwEgA859wzI1vEM2QF3/giV8xkEObBqs1o7P1X0b0KulneJ8T3PdwbQNVxmUKiDZulmPyS
	gR01gsL1dEI0xUCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 5CF252C171;
	Mon, 14 Aug 2023 11:19:52 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 5904C51CB0E1; Mon, 14 Aug 2023 13:19:52 +0200 (CEST)
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
Subject: [PATCH 17/17] nvmet-tcp: peek icreq before starting TLS
Date: Mon, 14 Aug 2023 13:19:43 +0200
Message-Id: <20230814111943.68325-18-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230814111943.68325-1-hare@suse.de>
References: <20230814111943.68325-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230814_042001_265114_20275A84 
X-CRM114-Status: GOOD (  19.39  )
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

Incoming connection might be either 'normal' NVMe-TCP connections
starting with icreq or TLS handshakes. To ensure that 'normal'
connections can still be handled we need to peek the first packet
and only start TLS handshake if it's not an icreq.
With that we can lift the restriction to always set TREQ to
'required' when TLS1.3 is enabled.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/configfs.c | 17 ----------
 drivers/nvme/target/nvmet.h    | 10 ++++++
 drivers/nvme/target/tcp.c      | 61 +++++++++++++++++++++++++++++++---
 3 files changed, 66 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index ad1fb32c7387..56ed6ce4d4d5 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -175,11 +175,6 @@ static ssize_t nvmet_addr_treq_show(struct config_item *item, char *page)
 	return snprintf(page, PAGE_SIZE, "\n");
 }
 
-static inline u8 nvmet_port_disc_addr_treq_mask(struct nvmet_port *port)
-{
-	return (port->disc_addr.treq & ~NVME_TREQ_SECURE_CHANNEL_MASK);
-}
-
 static ssize_t nvmet_addr_treq_store(struct config_item *item,
 		const char *page, size_t count)
 {
@@ -377,7 +372,6 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
-	u8 treq = nvmet_port_disc_addr_treq_mask(port);
 	u8 sectype;
 	int i;
 
@@ -410,17 +404,6 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
 	}
 
 	nvmet_port_init_tsas_tcp(port, sectype);
-	/*
-	 * The TLS implementation currently does not support
-	 * secure concatenation, so TREQ is always set to 'required'
-	 * if TLS is enabled.
-	 */
-	if (sectype == NVMF_TCP_SECTYPE_TLS13) {
-		treq |= NVMF_TREQ_REQUIRED;
-	} else {
-		treq |= NVMF_TREQ_NOT_SPECIFIED;
-	}
-	port->disc_addr.treq = treq;
 	return count;
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 7f9ae53c1df5..c47bab3281e0 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -179,6 +179,16 @@ static inline struct nvmet_port *ana_groups_to_port(
 			ana_groups_group);
 }
 
+static inline u8 nvmet_port_disc_addr_treq_mask(struct nvmet_port *port)
+{
+	return (port->disc_addr.treq & ~NVME_TREQ_SECURE_CHANNEL_MASK);
+}
+
+static inline bool nvmet_port_secure_channel_required(struct nvmet_port *port)
+{
+    return nvmet_port_disc_addr_treq_mask(port) == NVMF_TREQ_REQUIRED;
+}
+
 struct nvmet_ctrl {
 	struct nvmet_subsys	*subsys;
 	struct nvmet_sq		**sqs;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index ded985efdb66..2b60e6f23cc9 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1156,6 +1156,54 @@ static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
 	return ret;
 }
 
+static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue)
+{
+	struct nvme_tcp_hdr *hdr = &queue->pdu.cmd.hdr;
+	int len, ret;
+	struct kvec iov = {
+		.iov_base = (u8 *)&queue->pdu + queue->offset,
+		.iov_len = sizeof(struct nvme_tcp_hdr),
+	};
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
+	struct msghdr msg = {
+		.msg_control = cbuf,
+		.msg_controllen = sizeof(cbuf),
+		.msg_flags = MSG_PEEK,
+	};
+
+	if (nvmet_port_secure_channel_required(queue->port->nport))
+		return 0;
+
+	len = kernel_recvmsg(queue->sock, &msg, &iov, 1,
+			iov.iov_len, msg.msg_flags);
+	if (unlikely(len < 0)) {
+		pr_debug("queue %d: peek error %d\n",
+			 queue->idx, len);
+		return len;
+	}
+
+	ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
+	if (ret < 0)
+		return ret;
+
+	if (len < sizeof(struct nvme_tcp_hdr)) {
+		pr_debug("queue %d: short read, %d bytes missing\n",
+			 queue->idx, (int)iov.iov_len - len);
+		return -EAGAIN;
+	}
+	pr_debug("queue %d: hdr type %d hlen %d plen %d size %d\n",
+		 queue->idx, hdr->type, hdr->hlen, hdr->plen,
+		 (int)sizeof(struct nvme_tcp_icreq_pdu));
+	if (hdr->type == nvme_tcp_icreq &&
+	    hdr->hlen == sizeof(struct nvme_tcp_icreq_pdu) &&
+	    hdr->plen == sizeof(struct nvme_tcp_icreq_pdu)) {
+		pr_debug("queue %d: icreq detected\n",
+			 queue->idx);
+		return len;
+	}
+	return 0;
+}
+
 static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 {
 	struct nvme_tcp_hdr *hdr = &queue->pdu.cmd.hdr;
@@ -1868,11 +1916,14 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		sk->sk_user_data = NULL;
 		sk->sk_data_ready = port->data_ready;
 		read_unlock_bh(&sk->sk_callback_lock);
-		if (!nvmet_tcp_tls_handshake(queue))
-			return;
-
-		/* TLS handshake failed, terminate the connection */
-		goto out_destroy_sq;
+		if (!nvmet_tcp_try_peek_pdu(queue)) {
+			if (!nvmet_tcp_tls_handshake(queue))
+				return;
+			/* TLS handshake failed, terminate the connection */
+			goto out_destroy_sq;
+		}
+		/* Not a TLS connection, continue with normal processing */
+		queue->state = NVMET_TCP_Q_CONNECTING;
 	}
 #endif
 
-- 
2.35.3


