Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E17C41513
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Aug 2023 10:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6I0SUjM/HacjzUC2LUm2toUO6JrSnXkUETWiI6JjJOo=; b=gavov0yI/mnPbLE/VZE92iqRM1
	JFxjB+ZP4Dodb2Ei4/Wd9tf3lMw0DhNKWDLhtGF2d3aHbaQobRiOatFUG9N+jLrkHOKjGNrtVwAUs
	oKQO4GxfQ8faL6TDPc9uC6juCJoTE4bIzaAj3XJq2tyY2i69dnY7eR60G24oJ9nQuUFyfAoVR/ZZ9
	/xs/4Vk5LOmKq2UzVITAzvTcIuhMhry8y5gzY8HtEnfOodyWlfK/5U7SAMEbFYURHYCY/0bJklcyF
	x60w3IGxNP1QIcYOT3QW/90NKUBegeR2AU4xdCMrx0Kwy/GlDEOPUT9A4pgfb0NSPUfMTa39tVsbm
	MvPVOYVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRVxH-007XEW-1V;
	Thu, 03 Aug 2023 10:53:19 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRVx8-007X7m-2m
	for linux-nvme@lists.infradead.org;
	Thu, 03 Aug 2023 10:53:14 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 7646B1F88C;
	Thu,  3 Aug 2023 10:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691059989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6I0SUjM/HacjzUC2LUm2toUO6JrSnXkUETWiI6JjJOo=;
	b=PF3IrBIjn4hZB0Co8uONZFOcYYuHmL667Tz8rggNAM9+Rbfvc+is9GiPK/NawVgbtzE2hr
	disE/4bAvfqNMmVc6WvvPKIvr71dl8gKNnrm8gnwXsCi71qfvKGj0gW+WuVQpirtxOapbD
	1kugyhlMQIgMaBBsicy92zRY0H70ycY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691059989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6I0SUjM/HacjzUC2LUm2toUO6JrSnXkUETWiI6JjJOo=;
	b=BycIGlwSpqP3cNzamshi6RdX8idXXUrutu6P6MsSrCL9I1PrjwAwEh6f+Oea6shl+hujTD
	E3bFFANyEzIjOeAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 699692C153;
	Thu,  3 Aug 2023 10:53:09 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 664BA51CA7D1; Thu,  3 Aug 2023 12:53:09 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 09/14] nvme-tcp: control message handling for recvmsg()
Date: Thu,  3 Aug 2023 12:50:57 +0200
Message-Id: <20230803105102.30949-10-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230803105102.30949-1-hare@suse.de>
References: <20230803105102.30949-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_035311_149991_61D24788 
X-CRM114-Status: GOOD (  13.63  )
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
 drivers/nvme/host/tcp.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 98400ad5f969..4d0e3de39c26 100644
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
@@ -1369,6 +1370,10 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_icreq_pdu *icreq;
 	struct nvme_tcp_icresp_pdu *icresp;
+#ifdef CONFIG_NVME_TCP_TLS
+	char cbuf[CMSG_LEN(sizeof(char))] = {};
+	u8 ctype;
+#endif
 	struct msghdr msg = {};
 	struct kvec iov;
 	bool ctrl_hdgst, ctrl_ddgst;
@@ -1406,11 +1411,22 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	memset(&msg, 0, sizeof(msg));
 	iov.iov_base = icresp;
 	iov.iov_len = sizeof(*icresp);
+#ifdef CONFIG_NVME_TCP_TLS
+	msg.msg_control = cbuf;
+	msg.msg_controllen = sizeof(cbuf);
+#endif
 	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
 			iov.iov_len, msg.msg_flags);
 	if (ret < 0)
 		goto free_icresp;
-
+#ifdef CONFIG_NVME_TCP_TLS
+	ctype = tls_get_record_type(queue->sock->sk, (struct cmsghdr *)cbuf);
+	if (ctype != TLS_RECORD_TYPE_DATA) {
+		pr_err("queue %d: unhandled TLS record %d\n",
+		       nvme_tcp_queue_id(queue), ctype);
+		return -ENOTCONN;
+	}
+#endif
 	ret = -EINVAL;
 	if (icresp->hdr.type != nvme_tcp_icresp) {
 		pr_err("queue %d: bad type returned %d\n",
-- 
2.35.3


