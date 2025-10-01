Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA01CAC5BB
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Oct 2025 06:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=woBCeinsl2yhDRlycgTtLA3M5vo8Y9Z+g5BKloQJavA=; b=R26XfmqKGol9iOL91bvEIugMjd
	Cg0BCNcWlD/O3iqIYSGHKP9jMMolqA/KVJychSFWxGxh+u6QWJSU1TnYiZ1V9aOknuaU9YLdgcsI/
	hgOBREYChZoHSbJ+GUqpLSAYkZSN617WQgpLvpIqvdXE4Dn0pRXVUt/3r6NCvufSLRDNO/G8thfo7
	CQyUIbOlp2x3Zxu5caAdN2rHNDmg0RCdwkCn2eGTG9RdIoTz7b79Rlz9hmNuqdFbjzpc3UO8nKSQI
	Or2PUXH/MqQ0QuxyZK/45cY66YNS/y/RgnfpWrxz+QSM0czWXMikXct0avYbQwEW/+jqdk/v7y/5Y
	51kuSk9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3qQ5-00000006oUV-2563;
	Wed, 01 Oct 2025 06:34:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3qQ2-00000006oU8-0XSb
	for linux-nvme@lists.infradead.org;
	Wed, 01 Oct 2025 06:34:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759300469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=woBCeinsl2yhDRlycgTtLA3M5vo8Y9Z+g5BKloQJavA=;
	b=hp4xQ+EUZJygImuaazxv6rjCq1K+jRHDCVJlQbrGeZ+hf4gh4kVTQyPoIQ80hZetIedESr
	DM/xbTrlcn9BR5UdrNAYyP2Mt3wQsT//+szJp60wNAkkANNMrgoM0IzMcvTZtbgJeQrGv5
	j9tTREMpjSrKhF43NliuQNw00BNYAyg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-an3NFwN6PFODZu5Q0_s1Mg-1; Wed,
 01 Oct 2025 02:34:23 -0400
X-MC-Unique: an3NFwN6PFODZu5Q0_s1Mg-1
X-Mimecast-MFC-AGG-ID: an3NFwN6PFODZu5Q0_s1Mg_1759300462
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F5D51800366;
	Wed,  1 Oct 2025 06:34:21 +0000 (UTC)
Received: from my-developer-toolbox-latest (unknown [10.44.32.240])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D05EA19560B4;
	Wed,  1 Oct 2025 06:34:16 +0000 (UTC)
Date: Tue, 30 Sep 2025 23:34:14 -0700
From: Chris Leech <cleech@redhat.com>
To: Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Stuart Hayes <stuart.w.hayes@gmail.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux@yadro.com, stable@vger.kernel.org
Subject: [PATCH] nvme-tcp: switch to per-cpu page_frag_cache
Message-ID: <20250930-tableware-untaxed-6a68b2e1e970@redhat.com>
References: <20250929111951.6961-1-d.bogdanov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929111951.6961-1-d.bogdanov@yadro.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250930_233430_238442_56E53BD6 
X-CRM114-Status: GOOD (  14.80  )
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

nvme-tcp uses page_frag_cache to preallocate PDU for each preallocated
request of block device. Block devices are created in parallel threads,
consequently page_frag_cache is used in not thread-safe manner.
That leads to incorrect refcounting of backstore pages and premature free.

That can be catched by !sendpage_ok inside network stack:

WARNING: CPU: 7 PID: 467 at ../net/core/skbuff.c:6931 skb_splice_from_iter+0xfa/0x310.
        tcp_sendmsg_locked+0x782/0xce0
        tcp_sendmsg+0x27/0x40
        sock_sendmsg+0x8b/0xa0
        nvme_tcp_try_send_cmd_pdu+0x149/0x2a0
Then random panic may occur.

Fix that by switching from having a per-queue page_frag_cache to a
per-cpu page_frag_cache.

Cc: stable@vger.kernel.org # 6.12
Fixes: 4e893ca81170 ("nvme_core: scan namespaces asynchronously")
Reported-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
Signed-off-by: Chris Leech <cleech@redhat.com>
---
 drivers/nvme/host/tcp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1413788ca7d52..a4c4ace5be0f4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -174,7 +174,6 @@ struct nvme_tcp_queue {
 	__le32			recv_ddgst;
 	struct completion       tls_complete;
 	int                     tls_err;
-	struct page_frag_cache	pf_cache;
 
 	void (*state_change)(struct sock *);
 	void (*data_ready)(struct sock *);
@@ -201,6 +200,7 @@ struct nvme_tcp_ctrl {
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
 static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
+static DEFINE_PER_CPU(struct page_frag_cache, pf_cache);
 static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
@@ -556,7 +556,7 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 	struct nvme_tcp_queue *queue = &ctrl->queues[queue_idx];
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
-	req->pdu = page_frag_alloc(&queue->pf_cache,
+	req->pdu = page_frag_alloc(this_cpu_ptr(&pf_cache),
 		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
 		GFP_KERNEL | __GFP_ZERO);
 	if (!req->pdu)
@@ -1420,7 +1420,7 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
 	struct nvme_tcp_request *async = &ctrl->async_req;
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
-	async->pdu = page_frag_alloc(&queue->pf_cache,
+	async->pdu = page_frag_alloc(this_cpu_ptr(&pf_cache),
 		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
 		GFP_KERNEL | __GFP_ZERO);
 	if (!async->pdu)
@@ -1439,7 +1439,7 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	if (!test_and_clear_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
 		return;
 
-	page_frag_cache_drain(&queue->pf_cache);
+	page_frag_cache_drain(this_cpu_ptr(&pf_cache));
 
 	noreclaim_flag = memalloc_noreclaim_save();
 	/* ->sock will be released by fput() */
-- 
2.50.1


