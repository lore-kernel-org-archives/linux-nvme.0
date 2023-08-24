Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70055C6FA8F
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Aug 2023 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ITYu1hjqxOClLWDWbgknYntck7HWiTKejxuFqlBhZ4g=; b=kD83GFNV+VbGC/hIGkH7uvE/w0
	ogzoBMN1Fk+zSAhAUeO8QFWgO6vFao8uEfuq9mwRCjDoxe5u8N4DkXf21QDyj/V2vGI3Jd/7cWVqM
	5eddhrdLvVnU2D7PHpH3GNdDzXPrjAZrjC0Y2cs8vQPyLQ8md5fgWCpFC31U0pO+ioxhtG0o4n5Bn
	AMcpKz7H1X7SRhsD+g6HxqlQv6tMHEdSSKVUOjsY80G9DAP7FjPjbzzVd5GhJAYQak+MCpjiiwqKd
	pYPjdND+rY600PlTtJZYjy0UWbT7FDx5sFlskGGeHKCqedgFhm3/i3fjcZCoQO9qAYkx8ZGBeWXU5
	nzbYG90A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qZBV5-003FZR-0m;
	Thu, 24 Aug 2023 14:39:55 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qZBUm-003FI8-2m
	for linux-nvme@lists.infradead.org;
	Thu, 24 Aug 2023 14:39:40 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 4259220ECF;
	Thu, 24 Aug 2023 14:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692887967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ITYu1hjqxOClLWDWbgknYntck7HWiTKejxuFqlBhZ4g=;
	b=GSdmDPCyBtECWt/mlE7vuDQQrzMae/hjBXasyK3DaDnfwHNRA4y1hEap/SQ/yB5L16V/hI
	QgKT0yBPf0BMjBv030w1u9rG8zI6Zcjw/3sM3rjPunU4IPj3efDQ2+SnmZbkSWTmaamcps
	Wbvy4REvczZ8kwW3EsMCdQxTWK2fGck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692887967;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ITYu1hjqxOClLWDWbgknYntck7HWiTKejxuFqlBhZ4g=;
	b=nXJ56UyGlt0oFXjxyzA7bfRarZd9vsYxraBLmHIQdaW5Mxjv2q1kYT9DEDLtLfbIYjxEWh
	5D0QQ8NKmOMKF7BA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id DF3222C15F;
	Thu, 24 Aug 2023 14:39:26 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id DBD3051CB8D1; Thu, 24 Aug 2023 16:39:26 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCH 13/18] nvmet-tcp: make nvmet_tcp_alloc_queue() a void function
Date: Thu, 24 Aug 2023 16:39:20 +0200
Message-Id: <20230824143925.9098-14-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230824143925.9098-1-hare@suse.de>
References: <20230824143925.9098-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230824_073937_044158_623B408A 
X-CRM114-Status: GOOD (  13.11  )
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

The return value from nvmet_tcp_alloc_queue() are just used to
figure out if sock_release() need to be called. So this patch
moves sock_release() into nvmet_tcp_alloc_queue() and make it
a void function.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/nvme/target/tcp.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 97d07488072d..d44e9051ddd9 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1621,15 +1621,17 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	return ret;
 }
 
-static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
+static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		struct socket *newsock)
 {
 	struct nvmet_tcp_queue *queue;
 	int ret;
 
 	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
-	if (!queue)
-		return -ENOMEM;
+	if (!queue) {
+		ret = -ENOMEM;
+		goto out_release;
+	}
 
 	INIT_WORK(&queue->release_work, nvmet_tcp_release_queue_work);
 	INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
@@ -1666,7 +1668,7 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	if (ret)
 		goto out_destroy_sq;
 
-	return 0;
+	return;
 out_destroy_sq:
 	mutex_lock(&nvmet_tcp_queue_mutex);
 	list_del_init(&queue->queue_list);
@@ -1678,7 +1680,9 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	ida_free(&nvmet_tcp_queue_ida, queue->idx);
 out_free_queue:
 	kfree(queue);
-	return ret;
+out_release:
+	pr_err("failed to allocate queue, error %d\n", ret);
+	sock_release(newsock);
 }
 
 static void nvmet_tcp_accept_work(struct work_struct *w)
@@ -1695,11 +1699,7 @@ static void nvmet_tcp_accept_work(struct work_struct *w)
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


