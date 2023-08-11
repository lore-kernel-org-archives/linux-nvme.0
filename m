Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC34BC0015E
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 12:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B4aqrTlToa8Jvk+PKaV79W3CRO9BmyXTdg/2F5fZy5Q=; b=Pf0tAIu4h8fubFCY0oqYCTAKzx
	n4mpnJLo+mFcZjZ0Rs8kD0VUQQBYFxJHfUrHlgCQYbHXG3JOuZHVoZ+PdvRH/AWpkhp+7EU7vFMYN
	xzLrVq5D/xuWSnknKvcyxXjEJcoehrIFsbuKwp7x6osHLLoiH3EctJb+q/kTFF1EHT1AHdIfFoq/4
	MaWQmGQQ25vQxfGj2DM4iKjlF62bsVoSp9B3C9fCUdB0wvEaaqfDV6XJQaxWv3d1NYWnI1fJqh9x+
	3z4cBPW5Bd0zomd6DORql1Vx0nXGPJs9FPcZIfZaXgM6ytVN4qypRCQD1BnQLWR7mip947NrRyybH
	NP05vlbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUR6C-00AZOL-18;
	Fri, 11 Aug 2023 12:18:36 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUR5p-00AZ4J-0m
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 12:18:15 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 44B7B21884;
	Fri, 11 Aug 2023 12:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691756286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B4aqrTlToa8Jvk+PKaV79W3CRO9BmyXTdg/2F5fZy5Q=;
	b=LCWg84szKj49t9i3eVb+uJc/Jrfx5rLUwhZSxgl78sLrUgWjj07PJ/B9UaCvE8ACkKTukQ
	i0Jg+Wv7Bx2C+zvcL4Btjnj7R1LSkCCumEx8xezE4GESsrfoEoV0SX4EQSHjmi1NfgZXIb
	n7PqXsWQVzstgD60oPUGTAMvxwSh2CI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691756286;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B4aqrTlToa8Jvk+PKaV79W3CRO9BmyXTdg/2F5fZy5Q=;
	b=tiujmFC5O8kJ4O1fSTvTcbaPb5vhkKtZmszxAlcXS2zbA5iXbeXPs5MrQGELs1AT5Vbu3h
	Cwb0SDpIvvH9ovAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 325842C15C;
	Fri, 11 Aug 2023 12:18:06 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 2EE6351CAEFC; Fri, 11 Aug 2023 14:18:06 +0200 (CEST)
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
Subject: [PATCH 12/17] nvmet-tcp: make nvmet_tcp_alloc_queue() a void function
Date: Fri, 11 Aug 2023 14:17:50 +0200
Message-Id: <20230811121755.24715-13-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230811121755.24715-1-hare@suse.de>
References: <20230811121755.24715-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_051813_451973_6888D686 
X-CRM114-Status: GOOD (  12.96  )
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


