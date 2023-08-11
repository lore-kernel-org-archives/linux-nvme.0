Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C5CC0015E
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 10:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NaLyfwOtKSwi5zn5C0ZkpdRqm/uvr6NifNesER+kkvM=; b=ofwDp9VgN5DbnePkmDk2B/sbmX
	4InzoGQGRgdgdnhTG+k/LJDU2LhBq/dUaAcNBhpPryPG63uNOk9Y6mP/hxiJML/Ow6zEgO+bsMY0W
	m6j03mR4pIwoHagB7jOHsUMxRShX0kUXW6LnKIyHAuyZ0iivs7SvMaM7QZbsLYaanp8VEU8Q8ktyp
	XcwTgSJuQSEjNHFq5C6kkUxzqPUH9QiIv6IsyLvFrnW32ca3uRpFq2DnONGFggUyKCVv1uBJpDnIt
	hwchoOQZF41p38hjl4Z2vBSMndonhxjuB/xUKNcY7TwabI1v4Xli63MS8ABsEDUlIaBJyCpBJGvEM
	5604Nj2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUPFO-00A8gs-1V;
	Fri, 11 Aug 2023 10:19:58 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUPFM-00A8fO-0Y
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 10:19:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EC61266DAE;
	Fri, 11 Aug 2023 10:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05D7C433C7;
	Fri, 11 Aug 2023 10:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691749194;
	bh=E04nCDCoEElo4GIeU5ymaI8EKIYj8gGmoaOYtAc6NpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cqiguNGyppu7QC5FxvDPyIzXVoXA8vHP4LuAQz4VVya+3nJRE8kHhTnrrVmOG5yWm
	 dsl3ID3HJ4gbutI7smEsYhlsbHysYlqPIR9HZ0rwGxMbc0a5x4twydhjxvGKhb9Stg
	 xO0nTtTbEuiasoDfrqs03iDsiuYydqOVRMlWjpCnTmwN9+J8ggab4/0ZstxOoImjzs
	 7yUsYkr0nJRDI22VItjwTLtu8XkYsuYcqqDL1bOZr5jmwYsT1aQEkmandKjx+0wEkB
	 Cee1GQsgHOJsodzFOWDtDwTXDbmfEfyFpykLaJjpGB2HQRYMw+s6Ddfmd+Y9/XVFHK
	 m6Zx+uURpgCCQ==
Date: Fri, 11 Aug 2023 12:19:50 +0200
From: Simon Horman <horms@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 07/17] nvme-tcp: allocate socket file
Message-ID: <ZNYLRqZVjr5o3bst@vergenet.net>
References: <20230810150630.134991-1-hare@suse.de>
 <20230810150630.134991-8-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810150630.134991-8-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_031956_278370_8D5CD11C 
X-CRM114-Status: GOOD (  15.48  )
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

On Thu, Aug 10, 2023 at 05:06:20PM +0200, Hannes Reinecke wrote:
> When using the TLS upcall we need to allocate a socket file such
> that the userspace daemon is able to use the socket.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

...

> @@ -1512,6 +1514,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
>  	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>  	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
>  	int ret, rcv_pdu_size;
> +	struct file *sock_file;
>  
>  	mutex_init(&queue->queue_lock);
>  	queue->ctrl = ctrl;
> @@ -1534,6 +1537,13 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
>  		goto err_destroy_mutex;
>  	}
>  
> +	sock_file = sock_alloc_file(queue->sock, O_CLOEXEC, NULL);
> +	if (IS_ERR(sock_file)) {
> +		sock_release(queue->sock);

Hi Hannes,

Is it correct to call sock_release() here?
sock_alloc_file() already does so on error.

Flagged by Smatch.

> +		queue->sock = NULL;
> +		ret = PTR_ERR(sock_file);
> +		goto err_destroy_mutex;
> +	}
>  	nvme_tcp_reclassify_socket(queue->sock);
>  
>  	/* Single syn retry */

...

