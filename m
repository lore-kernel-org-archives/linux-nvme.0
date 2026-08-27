Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2132EC61DC4
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2026 22:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EvtJJsw7v4EROBNhwu+vSqrIh4k0LdD47fdLJjTypVM=; b=lA4aLMIDfS579UKMmANk8msFhh
	TRhA+hjDpSOkb3yyYXICACERc+CN+eXy34FZkgOBhx96+q8Y6oFMJWBnUA7gvHhouFT6kQc95Ns0S
	8zWB0HtfSP7+Uj/HfviUBM+rvvaEFtxhCfiJQ6tmx+F2lDfmOOAcxEW89kswPUwa/2wSnI3qR38db
	OrfuXDbWrFld/N1gRtkHBpML/c7dM/cmpz+OMuW9x8EEjquM4qW9DcYuxm55ciQbxNGQLJZByQynt
	M/h/ve6j2DCk1WuOjNt1IqkRH2RvsylK9dhf/Lylrql8Re0th9g+Cq3VHaGIFDIiySilcwIUYnh+w
	S1yVL/xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wziSR-00000004qnf-3wva;
	Thu, 27 Aug 2026 22:20:27 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wziSP-00000004qnR-1Fog
	for linux-nvme@lists.infradead.org;
	Thu, 27 Aug 2026 22:20:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5755D601F0;
	Thu, 27 Aug 2026 22:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD581F00A3A;
	Thu, 27 Aug 2026 22:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787869224;
	bh=EvtJJsw7v4EROBNhwu+vSqrIh4k0LdD47fdLJjTypVM=;
	h=From:To:Cc:Subject:Date;
	b=l2GOT9nHlYXVch/YAJNnf3oZ1wMkmcs9hO8HmB0amVJpHUYP1MT3uF1EGwajv3TWc
	 piaiw/TjRVsMF85KK+reKkOEww7gnWgnnPP7VVnCrhYAs+iB+rPg/6WN8LaGxGZZ9T
	 V4Mm9GXqTceI5bKXuFtfiTtSVCLwLEvf7gO7N4A0x21f60L5NiDpJCf6rmACbP1SS6
	 9Sp2QeBw8hYm8z18ArjB7sigqRJYrT7zlHBxsjnMzYLpllRuCMpBMfGf3e4nJZauY4
	 o5+VCumxG7DqsNpDALHLl9jwqN9Pq91t4fYtsejQPw+dka+YR9GXnUfi06vFGeUOkJ
	 eDY7VbdL+96bA==
From: "Carlos Bilbao (Lambda)" <carlos.bilbao@kernel.org>
To: stable@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	d.bogdanov@yadro.com,
	wagi@kernel.org,
	linux-nvme@lists.infradead.org,
	bilbao@vt.edu,
	ryan.arnold@lambdal.com,
	krishna.mohan@lambdal.com,
	christian.jones@lambdal.com,
	eduardo.habkost@lambdal.com,
	brian.kopp@lambdal.com,
	Carlos Bilbao <carlos.bilbao@kernel.org>
Subject: [PATCH 6.18.y] nvme-tcp: fix usage of page_frag_cache
Date: Thu, 27 Aug 2026 15:20:22 -0700
Message-ID: <20260827222022.45428-1-carlos.bilbao@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Dmitry Bogdanov <d.bogdanov@yadro.com>

commit 36ac05f7cfd59d90c597071304b14e98090d5dd1 upstream.

nvme uses page_frag_cache to preallocate PDU for each preallocated request
of block device. Block devices are created in parallel threads,
consequently page_frag_cache is used in not thread-safe manner.
That leads to incorrect refcounting of backstore pages and premature free.

That can be catched by !sendpage_ok inside network stack:

WARNING: CPU: 7 PID: 467 at ../net/core/skbuff.c:6931 skb_splice_from_iter+0xfa/0x310.
	tcp_sendmsg_locked+0x782/0xce0
	tcp_sendmsg+0x27/0x40
	sock_sendmsg+0x8b/0xa0
	nvme_tcp_try_send_cmd_pdu+0x149/0x2a0
Then random panic may occur.

Fix that by serializing the usage of page_frag_cache.

Fixes: 4e893ca81170 ("nvme_core: scan namespaces asynchronously")
Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[carlos.bilbao: adjust context in nvme_tcp_free_queue; branch predates
19bdb70c77d3 ("nvme-tcp: lockdep: use dynamic lockdep keys per socket
instance")]
Signed-off-by: Carlos Bilbao (Lambda) <carlos.bilbao@kernel.org>
---
Context conflict in nvme_tcp_free_queue due to 19bdb70c77d3; context-only
adjustment, no functional change.

Build-tested: 6.18.47 (x86_64 defconfig + CONFIG_NVME_TCP=m).
Also needed in 6.12.y, 7.1.y (backports submitted separately); 7.2.y
takes the upstream commit cleanly.

 drivers/nvme/host/tcp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index afdbcff..04c074a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -145,6 +145,7 @@ struct nvme_tcp_queue {
 
 	struct mutex		queue_lock;
 	struct mutex		send_mutex;
+	struct mutex		pf_cache_lock;
 	struct llist_head	req_list;
 	struct list_head	send_list;
 
@@ -556,9 +557,11 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 	struct nvme_tcp_queue *queue = &ctrl->queues[queue_idx];
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
+	mutex_lock(&queue->pf_cache_lock);
 	req->pdu = page_frag_alloc(&queue->pf_cache,
 		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
 		GFP_KERNEL | __GFP_ZERO);
+	mutex_unlock(&queue->pf_cache_lock);
 	if (!req->pdu)
 		return -ENOMEM;
 
@@ -1423,9 +1426,11 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
 	struct nvme_tcp_request *async = &ctrl->async_req;
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
+	mutex_lock(&queue->pf_cache_lock);
 	async->pdu = page_frag_alloc(&queue->pf_cache,
 		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
 		GFP_KERNEL | __GFP_ZERO);
+	mutex_unlock(&queue->pf_cache_lock);
 	if (!async->pdu)
 		return -ENOMEM;
 
@@ -1453,6 +1458,7 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	kfree(queue->pdu);
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
+	mutex_destroy(&queue->pf_cache_lock);
 }
 
 static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
@@ -1775,6 +1781,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	INIT_LIST_HEAD(&queue->send_list);
 	mutex_init(&queue->send_mutex);
 	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
+	mutex_init(&queue->pf_cache_lock);
 
 	if (qid > 0)
 		queue->cmnd_capsule_len = nctrl->ioccsz * 16;
@@ -1906,6 +1913,7 @@ err_sock:
 err_destroy_mutex:
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
+	mutex_destroy(&queue->pf_cache_lock);
 	return ret;
 }
 
-- 
2.50.1 (Apple Git-155)


