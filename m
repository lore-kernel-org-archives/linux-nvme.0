Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D8CC001B0
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 15:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TqBwO+J3t2qylfSRQkB5FK/tZ2zNypcUL7n1uVdZoNc=; b=O2LYeDvjcOZUJeK134US7rDMBE
	LMUDJP4D5f2lum8Fbukr5dkxACyLBWLWkYbj7a375ZPv1rw/9Z8Ct6zHoDu385Z2Nv6MKuIURnspy
	WEiEMrog8SOXEfUx7ezwnDrJLaGazFD0G+GdVg6P5NIEmWRUPZoVfhw1vUmjyOdPKds96yD8qKrnl
	ouuo19qKeM17HtIcPPGHIul7UtOxkN7v3sPcOSrNTCOaA5e5Bwl+dg6u3DVA4FrxTiGxFdzPLvjBF
	bd7Wukwy+e+6YBq62JxPM5Rp66hOd6gkHPAaC5dl8F/0hAZz/7CAwkl4g0u0puSAJFvhl81bjG4+j
	tr40sTog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU7Fm-007yVo-2p;
	Thu, 10 Aug 2023 15:07:10 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU7FQ-007y9r-0k
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 15:06:52 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 2A1DD1F892;
	Thu, 10 Aug 2023 15:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691680001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqBwO+J3t2qylfSRQkB5FK/tZ2zNypcUL7n1uVdZoNc=;
	b=hVIa6uec6LeNivn12lnM+F/8xLLfFiXf+xL6G2xS6bm9An9cbDT+fRzje/Pq+H8cqK4sqQ
	JimHdHqEjMiFxWu4T9LSfqlu2SzNh7WD+zSoiC4OV4FagMfowLCnctEezMhu1B2ERNI0TB
	4xSdT7/xil4G74CT/wcAvRd0q7/+34Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691680001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqBwO+J3t2qylfSRQkB5FK/tZ2zNypcUL7n1uVdZoNc=;
	b=QIypjNr5be56voYmiWcxXgsPdboltcJgrQMsY9CE834sxHeC8EWP3so0XQWUm0eld6x7m3
	cp2vE36P3HhQHlAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 03B3A2C15F;
	Thu, 10 Aug 2023 15:06:41 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 30CFC51CAE54; Thu, 10 Aug 2023 17:06:40 +0200 (CEST)
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
Date: Thu, 10 Aug 2023 17:06:25 +0200
Message-Id: <20230810150630.134991-13-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230810150630.134991-1-hare@suse.de>
References: <20230810150630.134991-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_080648_422888_EC8FBD42 
X-CRM114-Status: GOOD (  12.09  )
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
 drivers/nvme/target/tcp.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 97d07488072d..4d573c3bbd62 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1621,7 +1621,7 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	return ret;
 }
 
-static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
+static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		struct socket *newsock)
 {
 	struct nvmet_tcp_queue *queue;
@@ -1629,7 +1629,7 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 
 	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
 	if (!queue)
-		return -ENOMEM;
+		goto out_release;
 
 	INIT_WORK(&queue->release_work, nvmet_tcp_release_queue_work);
 	INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
@@ -1666,7 +1666,7 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	if (ret)
 		goto out_destroy_sq;
 
-	return 0;
+	return;
 out_destroy_sq:
 	mutex_lock(&nvmet_tcp_queue_mutex);
 	list_del_init(&queue->queue_list);
@@ -1678,7 +1678,9 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	ida_free(&nvmet_tcp_queue_ida, queue->idx);
 out_free_queue:
 	kfree(queue);
-	return ret;
+out_release:
+	pr_err("failed to allocate queue\n");
+	sock_release(newsock);
 }
 
 static void nvmet_tcp_accept_work(struct work_struct *w)
@@ -1695,11 +1697,7 @@ static void nvmet_tcp_accept_work(struct work_struct *w)
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


