Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0E0C77B60
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 14:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BRkyQlOyPPPIk1GeOBBi4Ie8MV1uD0nbm78nhFJnTuU=; b=bon2KQynVrWjzLDH+N+FiGLrn4
	L/oKwIG9U64xck5M+5pGRMCF0LhKSa1VRuE9tWmyv3cI6qVZsjNbL46jtKR0W6KiqZHe1RzAeaWbe
	SG0BIcQB+/UtxWs4jFkObFpORJ0mdtEV5gQERpzdX/RH4LTe1HlwwQ7yepIjtNd2dDvn0xJ5R+KnF
	2mIa43vn0J+kxo1bvCMVijAZU0Nj/XLs9fFP6ySEm+hX84gwJ7zM+JeflvBT244hN27YWmgUhlqc2
	qcKtINfLg21WAXKamgwLXFdBpxQ2x26xWZ+GjKVlJgpHNCNPDKmSa3NCFnU/fbCRbRXQ6Kb87T4aC
	OhYi1yzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phWLb-000V2x-0F;
	Wed, 29 Mar 2023 14:00:19 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phWLH-000UlM-2z
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 14:00:04 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id F12B51FDFD;
	Wed, 29 Mar 2023 13:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680098390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRkyQlOyPPPIk1GeOBBi4Ie8MV1uD0nbm78nhFJnTuU=;
	b=enwAaDKujUoDQb2/dIa1/G8cVwYK6YEdgsQ5rX9AzJMEbObjfobuVQ025G+hpAOsLFEj3i
	xE32ppL8/72shLJmGaQBrvG14j0Yhtk2514tz58l9F7b1HacpLM7FDPDJrTGD5Xwf8lM7A
	+w/LRaFP3eE7Z82SLvROGt+xNYCRXDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680098390;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRkyQlOyPPPIk1GeOBBi4Ie8MV1uD0nbm78nhFJnTuU=;
	b=WB8GOh67ziLc/yrUAPkHL/E7ZpSN0S55eHix+5uJ0c5ycmicWQkpwh5IiRSWJsiAjY+5gc
	G1BbJ7jocwiV2eBQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id DE2092C186;
	Wed, 29 Mar 2023 13:59:49 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id DB69B51BF38E; Wed, 29 Mar 2023 15:59:49 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 14/18] nvmet-tcp: allocate socket file
Date: Wed, 29 Mar 2023 15:59:34 +0200
Message-Id: <20230329135938.46905-15-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230329135938.46905-1-hare@suse.de>
References: <20230329135938.46905-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_070000_171891_661749E3 
X-CRM114-Status: GOOD (  16.77  )
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

When using the TLS upcall we need to allocate a socket file such
that the userspace daemon is able to use the socket.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/tcp.c | 51 +++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 66e8f9fd0ca7..5931971d715f 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -96,12 +96,14 @@ struct nvmet_tcp_cmd {
 
 enum nvmet_tcp_queue_state {
 	NVMET_TCP_Q_CONNECTING,
+	NVMET_TCP_Q_TLS_HANDSHAKE,
 	NVMET_TCP_Q_LIVE,
 	NVMET_TCP_Q_DISCONNECTING,
 };
 
 struct nvmet_tcp_queue {
 	struct socket		*sock;
+	struct file		*sock_file;
 	struct nvmet_tcp_port	*port;
 	struct work_struct	io_work;
 	struct nvmet_cq		nvme_cq;
@@ -1406,6 +1408,19 @@ static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
 	write_unlock_bh(&sock->sk->sk_callback_lock);
 }
 
+static void nvmet_tcp_close_sock(struct nvmet_tcp_queue *queue)
+{
+	if (queue->sock_file) {
+		fput(queue->sock_file);
+		queue->sock_file = NULL;
+		queue->sock = NULL;
+	} else {
+		WARN_ON(!queue->sock->ops);
+		sock_release(queue->sock);
+		queue->sock = NULL;
+	}
+}
+
 static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 {
 	struct nvmet_tcp_cmd *cmd = queue->cmds;
@@ -1455,12 +1470,11 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	nvmet_sq_destroy(&queue->nvme_sq);
 	cancel_work_sync(&queue->io_work);
 	nvmet_tcp_free_cmd_data_in_buffers(queue);
-	sock_release(queue->sock);
+	nvmet_tcp_close_sock(queue);
 	nvmet_tcp_free_cmds(queue);
 	if (queue->hdr_digest || queue->data_digest)
 		nvmet_tcp_free_crypto(queue);
 	ida_free(&nvmet_tcp_queue_ida, queue->idx);
-
 	page = virt_to_head_page(queue->pf_cache.va);
 	__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
 	kfree(queue);
@@ -1583,7 +1597,7 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	return ret;
 }
 
-static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
+static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		struct socket *newsock)
 {
 	struct nvmet_tcp_queue *queue;
@@ -1591,7 +1605,7 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 
 	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
 	if (!queue)
-		return -ENOMEM;
+		return;
 
 	INIT_WORK(&queue->release_work, nvmet_tcp_release_queue_work);
 	INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
@@ -1599,15 +1613,28 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	queue->port = port;
 	queue->nr_cmds = 0;
 	spin_lock_init(&queue->state_lock);
-	queue->state = NVMET_TCP_Q_CONNECTING;
+	if (queue->port->nport->disc_addr.tsas.tcp.sectype ==
+	    NVMF_TCP_SECTYPE_TLS13)
+		queue->state = NVMET_TCP_Q_TLS_HANDSHAKE;
+	else
+		queue->state = NVMET_TCP_Q_CONNECTING;
 	INIT_LIST_HEAD(&queue->free_list);
 	init_llist_head(&queue->resp_list);
 	INIT_LIST_HEAD(&queue->resp_send_list);
 
+	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
+		queue->sock_file = sock_alloc_file(queue->sock, O_CLOEXEC, NULL);
+		if (IS_ERR(queue->sock_file)) {
+			ret = PTR_ERR(queue->sock_file);
+			queue->sock_file = NULL;
+			goto out_free_queue;
+		}
+	}
+
 	queue->idx = ida_alloc(&nvmet_tcp_queue_ida, GFP_KERNEL);
 	if (queue->idx < 0) {
 		ret = queue->idx;
-		goto out_free_queue;
+		goto out_sock;
 	}
 
 	ret = nvmet_tcp_alloc_cmd(queue, &queue->connect);
@@ -1628,7 +1655,7 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	if (ret)
 		goto out_destroy_sq;
 
-	return 0;
+	return;
 out_destroy_sq:
 	mutex_lock(&nvmet_tcp_queue_mutex);
 	list_del_init(&queue->queue_list);
@@ -1638,9 +1665,11 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	nvmet_tcp_free_cmd(&queue->connect);
 out_ida_remove:
 	ida_free(&nvmet_tcp_queue_ida, queue->idx);
+out_sock:
+	nvmet_tcp_close_sock(queue);
 out_free_queue:
 	kfree(queue);
-	return ret;
+	pr_err("failed to allocate queue");
 }
 
 static void nvmet_tcp_accept_work(struct work_struct *w)
@@ -1657,11 +1686,7 @@ static void nvmet_tcp_accept_work(struct work_struct *w)
 				pr_warn("failed to accept err=%d\n", ret);
 			return;
 		}
-		ret = nvmet_tcp_alloc_queue(port, newsock);
-		if (ret) {
-			pr_err("failed to allocate queue\n");
-			sock_release(newsock);
-		}
+		nvmet_tcp_alloc_queue(port, newsock);
 	}
 }
 
-- 
2.35.3


