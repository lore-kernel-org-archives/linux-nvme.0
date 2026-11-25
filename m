Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E12606A329
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NCc8x9nZ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sc5leU+w
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=QMKDEQDpnnZom7PZScr8UsEswjYU1+vEljlyVSb0T/E=; b=NCc8x9nZfTkf7ub18hMjIqT/Ka
	Lxfvn4VYDnxEWGYmpFACt6/oTcVO3dx41OErgZ+XsOyQPpLy/8TRwn4qPf788Sao/c6Bqb0itN35h
	s9L80yC58vMjsOi+Uxvm7bYvcfqnuSBuvxP1nVWuuA38FVcLcc5bybNHTaWEiQuL4d9D9txyUi3x7
	w29IRNm4XZ2k1XqjiG18lcML5ptzyE2jECju3ngByRAatOdAyNYAbqiHQiZB4ABMtftjOx9b1uSrY
	qNaX+5vnn/Ts12+n4FT82fAtwNEp31sT2duftWLj1+h5KORPGrL1RyTng2zHo8ZS2697nKhBcJgm/
	ob5cEeYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWDrY-0000000A8Jk-1XNc;
	Wed, 25 Nov 2026 14:20:44 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWDrX-0000000A8Ja-2yNX
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 14:20:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6CE5A44E42;
	Wed, 25 Nov 2026 14:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144351F000C0;
	Wed, 25 Nov 2026 14:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795616443;
	bh=QMKDEQDpnnZom7PZScr8UsEswjYU1+vEljlyVSb0T/E=;
	h=From:To:Cc:Subject:Date;
	b=Sc5leU+wgHyLyXo1KFHTzyB4kgbmA8jBYA6oDhu7EnbHtwpXxnqyGWhY6GxN3PR/d
	 0fNIsm9MShEo4aQT+O2F9RvqN2gevCK4ZWV3WniHNH/x1mKOb8nAknA9PjBbMHTLu1
	 hmyGweALY3l+eA8C7YS2IzX+fWic0VNIJjrnOKT8XSj4P4Q5dwUS2i4+f+KINqxIw4
	 laQoTdlPseYafej1v7SmPfyUqR74/Z24rUXJtzTTq+ZZj0/R01KnbqY+bDkJHWR+Pk
	 vidbNDSTYbEVN39dAFNZGkXHGUvkBv9Jx6K4mVrAgyAiRVw8C4OZCbTguNI1ApQbmG
	 HLO5TbiZwOS2g==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH] nvme-tcp: use correct network namespace to resolve addresses
Date: Wed, 25 Nov 2026 15:20:33 +0100
Message-ID: <20261125142033.4889-1-hare@kernel.org>
X-Mailer: git-send-email 2.51.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Resolving network addresses should use the current network namespace;
the passed-in addresses might not exist in the default network namespace.

Fixes: 87a1ac965502 ("nvme-tcp: store and use the caller's network namespace")

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c3149a9151f5..a4ecd0aa6783 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -3308,6 +3308,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	ctrl->ctrl.queue_count = NVME_TCP_OPT_NR_QUEUES(opts);
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
+	ctrl->net = get_net(current->nsproxy->net_ns);
 
 	INIT_DELAYED_WORK(&ctrl->connect_work,
 			nvme_tcp_reconnect_ctrl_work);
@@ -3324,7 +3325,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		opts->mask |= NVMF_OPT_TRSVCID;
 	}
 
-	ret = inet_pton_with_scope(&init_net, AF_UNSPEC,
+	ret = inet_pton_with_scope(ctrl->net, AF_UNSPEC,
 			opts->traddr, opts->trsvcid, &ctrl->addr);
 	if (ret) {
 		pr_err("malformed address passed: %s:%s\n",
@@ -3333,7 +3334,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	}
 
 	if (opts->mask & NVMF_OPT_HOST_TRADDR) {
-		ret = inet_pton_with_scope(&init_net, AF_UNSPEC,
+		ret = inet_pton_with_scope(ctrl->net, AF_UNSPEC,
 			opts->host_traddr, NULL, &ctrl->src_addr);
 		if (ret) {
 			pr_err("malformed src address passed: %s\n",
@@ -3343,7 +3344,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	}
 
 	if (opts->mask & NVMF_OPT_HOST_IFACE) {
-		if (!__dev_get_by_name(current->nsproxy->net_ns,
+		if (!__dev_get_by_name(ctrl->net,
 				       opts->host_iface)) {
 			pr_err("invalid interface passed: %s\n",
 			       opts->host_iface);
@@ -3367,16 +3368,15 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	for (i = 0; i < ctrl->nr_allocated_queues; i++)
 		nvme_tcp_init_queue(ctrl, i);
 
-	ctrl->net = get_net(current->nsproxy->net_ns);
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_tcp_ctrl_ops, 0);
 	if (ret)
 		goto out_kfree_queues;
 
 	return ctrl;
 out_kfree_queues:
-	put_net(ctrl->net);
 	kfree(ctrl->queues);
 out_free_ctrl:
+	put_net(ctrl->net);
 	kfree(ctrl);
 	return ERR_PTR(ret);
 }
-- 
2.51.0


