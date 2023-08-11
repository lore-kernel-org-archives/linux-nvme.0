Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99C1C0015E
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 12:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/Cvzf6un9zteo6BYtmrMHzIiNQIcezIJ9JwacCOtpBo=; b=VtOTQdTgt3oRZTuoqGYnv6vMhK
	n/X5tf84aZ88i7c2S5Gx1OP/7JHmGap0fxt31B5t/uExok+X52iakY98aYXxdXNdxiCz3xneXsxeH
	QVG2ZK0BEpK59C2o6N8AgYYASTuPqjkYMLuMn2PX4s76ynrfB7/vX9YsbkmPBXcXoOAb+0h43lXoY
	bR1C3MXh8q30GWIyKSQxso2LvPCcvW1aB7caRlKZ938W/swd6kNbWHQ1Hc/wSCAslhCpdSSBD2qZn
	gikl3bS1LhVl6v2NxAi77ks/1JAuK4XVHdkNzOw2z13I78PUyfHMF+mlJQ/gC+tFJBKjRROXLNF1m
	F/OPJZXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUR6F-00AZRP-0Y;
	Fri, 11 Aug 2023 12:18:39 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUR5p-00AZ4f-18
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 12:18:16 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 4D7CB21885;
	Fri, 11 Aug 2023 12:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691756286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Cvzf6un9zteo6BYtmrMHzIiNQIcezIJ9JwacCOtpBo=;
	b=X3r6i91mIDeO8rStr9qlj1PagU98m7jECscj65y4IUH1dZE/WIQPIdARGTthssAFahavlH
	whGXmBEIklmnJwINAVgvaqRw6ROQbtCmhAGcMItceClGVKwdXWV3BA+NslsA71lyX3ZcT1
	BomufHxq6te4exhn86K0BOzo0tFAJ+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691756286;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Cvzf6un9zteo6BYtmrMHzIiNQIcezIJ9JwacCOtpBo=;
	b=VvD4lfXFgahDyQvtn5l/QHpWvNJOX8YTdDw6jLxlLn8L/fGWhy+lwZkZyRIliXtd2P0t2g
	ZQ97+9cWZXMDYsAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 3AD012C15D;
	Fri, 11 Aug 2023 12:18:06 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 3759851CAEFE; Fri, 11 Aug 2023 14:18:06 +0200 (CEST)
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
Subject: [PATCH 13/17] nvmet-tcp: allocate socket file
Date: Fri, 11 Aug 2023 14:17:51 +0200
Message-Id: <20230811121755.24715-14-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230811121755.24715-1-hare@suse.de>
References: <20230811121755.24715-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_051813_561384_14579251 
X-CRM114-Status: GOOD (  13.92  )
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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/tcp.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index d44e9051ddd9..f19ea9d923fd 100644
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
@@ -1644,10 +1645,16 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
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
@@ -1678,11 +1685,14 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	nvmet_tcp_free_cmd(&queue->connect);
 out_ida_remove:
 	ida_free(&nvmet_tcp_queue_ida, queue->idx);
+out_sock:
+	fput(queue->sock->file);
 out_free_queue:
 	kfree(queue);
 out_release:
 	pr_err("failed to allocate queue, error %d\n", ret);
-	sock_release(newsock);
+	if (!sock_file)
+		sock_release(newsock);
 }
 
 static void nvmet_tcp_accept_work(struct work_struct *w)
-- 
2.35.3


