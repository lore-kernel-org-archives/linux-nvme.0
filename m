Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F4ECCF9E0
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 17:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FN8P1qP90Zu2O6wa+BWw0Mr/smwYzeXhvVoKsSbB6UQ=; b=zFQ8TBJqNo2kQYfRKThvQL/1vv
	tx5dEqXiOcOIqFnSVOpPoT2VxOXIQOqWjEeqOLeiENeoltzStt0T6UqOn1Tfd+18ri4+dJUe7i3vK
	NfqX8WfWLss8LB6BL0s4NqYm2OUt9znbu9nDpTkG7UCTpBxWOGdy4eKTfWZ6uEeQ4jwy/CjEmtoNu
	vksjc0bkxHgnkYQrWwUr+uMSt1Y+ZnGoA1M54Zzc2DoUhAD3i3lDdb4mDzuriHBERAOlT88jTDady
	Zb+1YKWtLZ/wCoLiuiqNHjWsrtqp/B1hYDAlQ/gT5c2Zpu5hsy3QYSMejVzrnx+tCgSpcSy9dI4Yk
	TkpEKAVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDQhX-0000000EOhf-27uK;
	Mon, 27 Oct 2025 17:08:11 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDQhV-0000000EOhX-12rM
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 17:08:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6AB2660147;
	Mon, 27 Oct 2025 17:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FC9C4CEF1;
	Mon, 27 Oct 2025 17:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761584888;
	bh=EilW+nxGrIUIpn2MiL43G+5U1z6hqpgMZANWtWAe0qI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d58SYbVPB+S4nASv/FYx1vUTcI7rYAqA0IL2HECu/iknwt0uJxsm+0yfTlU+dul2X
	 apIp7WafXevK3+wxWdalpq89/F1LlrZA9+01IBpE14YCjuLyZW0+sJ20pZwzBlRvDc
	 XsuICJ86eyNIPqx15FaHw/5TV1ysMLUrjW2dMDID3aivDMagBG+7Fiy1+x6DOrh6Ny
	 FiCWFYrv8ODRM/BuoNKhBIeoJgqrWgozByZpMGB0GvPIDbjCMXIDamuin9zhLnXCCD
	 g8xu7mUlwOl9vkfNrx6c0mJuH/VL/eCH8/v7p5SZgcLnfg36ooBMtHmv/MxJPJrY+O
	 zvVScxptlwPnw==
Date: Mon, 27 Oct 2025 11:08:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux@yadro.com, stable@vger.kernel.org
Subject: Re: [RESEND] [PATCH] nvme-tcp: fix usage of page_frag_cache
Message-ID: <aP-m9btCap_dt32Y@kbusch-mbp>
References: <20251027163627.12289-1-d.bogdanov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027163627.12289-1-d.bogdanov@yadro.com>
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

On Mon, Oct 27, 2025 at 07:36:27PM +0300, Dmitry Bogdanov wrote:
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
> 
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

Just a bit confused by this. Everything related to a specific TCP queue
should still be single threaded on the initialization of its tagset, so
there shouldn't be any block devices accessing the queue's driver
specific data before the tagset is initialized. 

