Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D23CCA470
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Oct 2025 06:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Rz+qqYLXcweI5rmzquO5nvJ1eJ440qoev3IK/G1Kv8=; b=ymuJY3cC8Tw+1aiHkB2Tx37eXY
	y0tUdZF7GlYzBpUqIwWtNrbtnal2M6biZANl7WHOjps6OCyOti+YJ4VYZ+Y30oP8TpgKIEhzZFxbE
	y1BScbEg+x/fmeJIJQqfSy2P5lNhJq7cvSq/uGAMcbOsvHZsDAfvTBQfv6isnBFJGYRYLeDLcdjLd
	f7/nhpFSxbtG9IgS++6A5SJHr+BqLi6G+Cuexx+izCVZhtVvmgaQjh3kXhiVV4rHagzW0BZnFaOJH
	UE+/W/0eX3iV3KUfv8YsqHJB0mePWB6uKbjDAXM76FAZ/MBXy+sjCWImUGp7dA1CeNqf8B7Q+qp5q
	8j+ymIgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3qNM-00000006oGB-45Uy;
	Wed, 01 Oct 2025 06:31:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3qNJ-00000006oFf-1f0r
	for linux-nvme@lists.infradead.org;
	Wed, 01 Oct 2025 06:31:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759300298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Rz+qqYLXcweI5rmzquO5nvJ1eJ440qoev3IK/G1Kv8=;
	b=cibIS0T9flnTPsLiIb/ytDTtVeUZeo8CnORRN5Qe9IFwxDkan/0kL0GliZofTV4DFHHcaq
	Q/oP+fhlu3m4pIONDHUe+HXqADOjGkRhDrI8ITyP5NsaxeviCgVJTy6++UsPpZ6LwUCa4J
	VNAim9VqObm7cUGqsgRzrsRjgQ03Jyo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-7MSqDb0XPg-2g8oUUsPvWQ-1; Wed,
 01 Oct 2025 02:31:35 -0400
X-MC-Unique: 7MSqDb0XPg-2g8oUUsPvWQ-1
X-Mimecast-MFC-AGG-ID: 7MSqDb0XPg-2g8oUUsPvWQ_1759300293
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F822195609F;
	Wed,  1 Oct 2025 06:31:32 +0000 (UTC)
Received: from my-developer-toolbox-latest (unknown [10.44.32.240])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E02CB19560B4;
	Wed,  1 Oct 2025 06:31:27 +0000 (UTC)
Date: Tue, 30 Sep 2025 23:31:26 -0700
From: Chris Leech <cleech@redhat.com>
To: Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Stuart Hayes <stuart.w.hayes@gmail.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux@yadro.com, stable@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: fix usage of page_frag_cache
Message-ID: <20250930-feminine-dry-42d2705c778a@redhat.com>
References: <20250929111951.6961-1-d.bogdanov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929111951.6961-1-d.bogdanov@yadro.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250930_233141_510936_1B1ADF08 
X-CRM114-Status: GOOD (  26.10  )
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

On Mon, Sep 29, 2025 at 02:19:51PM +0300, Dmitry Bogdanov wrote:
> nvme uses page_frag_cache to preallocate PDU for each preallocated request
> of block device. Block devices are created in parallel threads,
> consequently page_frag_cache is used in not thread-safe manner.
> That leads to incorrect refcounting of backstore pages and premature free.
> 
> That can be catched by !sendpage_ok inside network stack:
> 
> WARNING: CPU: 7 PID: 467 at ../net/core/skbuff.c:6931 skb_splice_from_iter+0xfa/0x310.
> 	tcp_sendmsg_locked+0x782/0xce0
> 	tcp_sendmsg+0x27/0x40
> 	sock_sendmsg+0x8b/0xa0
> 	nvme_tcp_try_send_cmd_pdu+0x149/0x2a0
> Then random panic may occur.
> 
> Fix that by serializing the usage of page_frag_cache.

Thank you for reporting this. I think we can fix it without blocking the
async namespace scanning with a mutex, by switching from a per-queue
page_frag_cache to per-cpu. There shouldn't be a need to keep the
page_frag allocations isolated by queue anyway.

It would be great if you could test the patch which I'll send after
this.

- Chris
 
> Cc: stable@vger.kernel.org # 6.12
> Fixes: 4e893ca81170 ("nvme_core: scan namespaces asynchronously")
> Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
> ---
>  drivers/nvme/host/tcp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 1413788ca7d52..823e07759e0d3 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -145,6 +145,7 @@ struct nvme_tcp_queue {
>  
>  	struct mutex		queue_lock;
>  	struct mutex		send_mutex;
> +	struct mutex		pf_cache_lock;
>  	struct llist_head	req_list;
>  	struct list_head	send_list;
>  
> @@ -556,9 +557,11 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
>  	struct nvme_tcp_queue *queue = &ctrl->queues[queue_idx];
>  	u8 hdgst = nvme_tcp_hdgst_len(queue);
>  
> +	mutex_lock(&queue->pf_cache_lock);
>  	req->pdu = page_frag_alloc(&queue->pf_cache,
>  		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
>  		GFP_KERNEL | __GFP_ZERO);
> +	mutex_unlock(&queue->pf_cache_lock);
>  	if (!req->pdu)
>  		return -ENOMEM;
>  
> @@ -1420,9 +1423,11 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
>  	struct nvme_tcp_request *async = &ctrl->async_req;
>  	u8 hdgst = nvme_tcp_hdgst_len(queue);
>  
> +	mutex_lock(&queue->pf_cache_lock);
>  	async->pdu = page_frag_alloc(&queue->pf_cache,
>  		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
>  		GFP_KERNEL | __GFP_ZERO);
> +	mutex_unlock(&queue->pf_cache_lock);
>  	if (!async->pdu)
>  		return -ENOMEM;
>  
> @@ -1450,6 +1455,7 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
>  	kfree(queue->pdu);
>  	mutex_destroy(&queue->send_mutex);
>  	mutex_destroy(&queue->queue_lock);
> +	mutex_destroy(&queue->pf_cache_lock);
>  }
>  
>  static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
> @@ -1772,6 +1778,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>  	INIT_LIST_HEAD(&queue->send_list);
>  	mutex_init(&queue->send_mutex);
>  	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
> +	mutex_init(&queue->pf_cache_lock);
>  
>  	if (qid > 0)
>  		queue->cmnd_capsule_len = nctrl->ioccsz * 16;
> @@ -1903,6 +1910,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>  err_destroy_mutex:
>  	mutex_destroy(&queue->send_mutex);
>  	mutex_destroy(&queue->queue_lock);
> +	mutex_destroy(&queue->pf_cache_lock);
>  	return ret;
>  }
>  
> -- 
> 2.25.1
> 
> 


