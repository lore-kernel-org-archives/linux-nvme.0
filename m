Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3BDC04FDF
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 16:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3TYlYGd7wtL+/0BG34+Ic98pY1gDdyGwN4BmFQHrADQ=; b=iLSVWaSKKUDCXGJ88oJGe+B3LO
	p91qRjS9V4OxM/uCnn03PTo53KLuQIoWtKVydHbUfXSVcgZF5jHd3uYLwvhaZWHTOqlcw339mY6yw
	J664DECw5eE9PDIdVApLJan+2Lzi26O1eiJyYNDzwZbgmy5yxyucNwOT8lefDyd8eGpAkTPWqxZS/
	CXQ+i1bGFmyctssz2pDctNR1IMBkfJQgu5uecGnWL1RLHhRDvHSpAEUe+PQ3KzUIZMIh7l4tQxIEV
	onUbIFDo79+Z3FuGrTwpFTljiUDpGxQFJSteN/hBIzwTOXM++zPp9IILYT6F8QvRarlNKNK9AYXFR
	hvFeCz4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTPyY-0032BT-13;
	Tue, 08 Aug 2023 16:54:30 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTPyL-0031zC-1h
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 16:54:20 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 631D720310;
	Tue,  8 Aug 2023 16:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691513648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TYlYGd7wtL+/0BG34+Ic98pY1gDdyGwN4BmFQHrADQ=;
	b=VOMQiSJF16Y/WONV+4ORsgaNyLBp9C3/7PpfmgM9QCjw0C5wPPLEAut1+ZpHyuEJ73z82k
	xFCFx8CCDCfQ7suVT/bmyfgUnMqJsxb/Udlpl3zUtNSvSeq0dqjLuUqckKK/aCD0hxYzKV
	HiG4OhKgL9It9v6cZofsI500MLPKGXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691513648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TYlYGd7wtL+/0BG34+Ic98pY1gDdyGwN4BmFQHrADQ=;
	b=U7He3dNhtLEvYE77UXJAtBOoeA+AxLPmtn8rAeuo8ER+UR0TB+QygffhDcW8F2AELlm+Bp
	Jdenwifxu1M9c3BQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 570FC2C15D;
	Tue,  8 Aug 2023 16:54:08 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 53CB551CACFF; Tue,  8 Aug 2023 18:54:08 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 13/16] nvmet-tcp: allocate socket file
Date: Tue,  8 Aug 2023 18:53:51 +0200
Message-Id: <20230808165354.123499-14-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230808165354.123499-1-hare@suse.de>
References: <20230808165354.123499-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_095417_707600_B9CF3774 
X-CRM114-Status: GOOD (  14.01  )
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

For the TLS upcall we need to allocate a socket file such
that the userspace daemon is able to use the socket.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/tcp.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 019b2598d8d1..a8ceef6e5a7b 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1493,12 +1493,12 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	nvmet_sq_destroy(&queue->nvme_sq);
 	cancel_work_sync(&queue->io_work);
 	nvmet_tcp_free_cmd_data_in_buffers(queue);
-	sock_release(queue->sock);
+	/* ->sock will be released by fput() */
+	fput(queue->sock->file);
 	nvmet_tcp_free_cmds(queue);
 	if (queue->hdr_digest || queue->data_digest)
 		nvmet_tcp_free_crypto(queue);
 	ida_free(&nvmet_tcp_queue_ida, queue->idx);
-
 	page = virt_to_head_page(queue->pf_cache.va);
 	__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
 	kfree(queue);
@@ -1625,6 +1625,7 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		struct socket *newsock)
 {
 	struct nvmet_tcp_queue *queue;
+	struct file *sock_file = NULL;
 	int ret;
 
 	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
@@ -1642,10 +1643,16 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	init_llist_head(&queue->resp_list);
 	INIT_LIST_HEAD(&queue->resp_send_list);
 
+	sock_file = sock_alloc_file(queue->sock, O_CLOEXEC, NULL);
+	if (IS_ERR(sock_file)) {
+		ret = PTR_ERR(sock_file);
+		goto out_free_queue;
+	}
+
 	queue->idx = ida_alloc(&nvmet_tcp_queue_ida, GFP_KERNEL);
 	if (queue->idx < 0) {
 		ret = queue->idx;
-		goto out_free_queue;
+		goto out_sock;
 	}
 
 	ret = nvmet_tcp_alloc_cmd(queue, &queue->connect);
@@ -1676,11 +1683,14 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	nvmet_tcp_free_cmd(&queue->connect);
 out_ida_remove:
 	ida_free(&nvmet_tcp_queue_ida, queue->idx);
+out_sock:
+	fput(queue->sock->file);
 out_free_queue:
 	kfree(queue);
 out_release:
 	pr_err("failed to allocate queue\n");
-	sock_release(newsock);
+	if (!sock_file)
+		sock_release(newsock);
 }
 
 static void nvmet_tcp_accept_work(struct work_struct *w)
-- 
2.35.3


