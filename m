Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD8FEB64DD
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Aug 2023 14:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5M3Rzc1cs+dTUvNeC/T8UQdasBhluUn2gOeSKl8kUnE=; b=KE+19NiOEV8XW42RzZCJ42sCGj
	GEWbc3V/YoGkFyWDG+HBgLV7rXlnjR98wspyMzIykM2fcveZdQJ/yQYYhi7IQsT5SGiaWP2QnLY79
	Ip2cP8kDWmlhtA9bixKR+D9qEejOwUiTFQAowS+GmTENXAoH39EOS83B0Xu7TRgwlPsTLubdYMc+s
	r/B2ilf+EbSsq7xEzTtrO07C3b8r6k1uefkn/j0GdeP7mOOMLLPnYE/eMNogQwD+J7jmZgiOSNxxD
	fFj2sJ59aZ4cZyfw3NsfXxR988Sl13yAUdLIzBuPyg4ov/vIrk00xqaHM9/nAXjezM6bq0jVsYYZK
	FbzLtUcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVBet-00FC8v-39;
	Sun, 13 Aug 2023 14:01:31 +0000
Received: from mail-ej1-f45.google.com ([209.85.218.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVBeq-00FC8T-0p
	for linux-nvme@lists.infradead.org;
	Sun, 13 Aug 2023 14:01:29 +0000
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-99c3ca08c09so107240466b.1
        for <linux-nvme@lists.infradead.org>; Sun, 13 Aug 2023 07:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691935286; x=1692540086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5M3Rzc1cs+dTUvNeC/T8UQdasBhluUn2gOeSKl8kUnE=;
        b=EPMCyhnn3vpj2xCMnN3LJOv9A4t7oahxKN84tIaL3VVG22f5i57HyYN6uHjBhrQY5h
         XIdWTIMZ84ygQ2Qugi/fVd5cUBrb6vQHZDuD2iA3gKwHHHPsWux4N0/24a1SX8f0T0NB
         BxjbKvRpAeMFvyVAoPiH00TvZM31Fl4nCDVl5rQQkhpvjaEBFleCAfpOlWgnjR/7GtD0
         RdmfrUhtC/tjTgDIy/G6rSWXM43WlREOKOrOGVkWFqnFUPB4r/Lx8WVX/B8/IfMO0PS4
         nZuWvt/a3yhZCtKghbDAfiJGRzmTFiv29e7OArZJWFDiFPMpMb6qc7Ta/TFZuocqWixI
         7MPA==
X-Gm-Message-State: AOJu0Yw/iHIpvKe6rhECD7dLhZP9yKBVN0dYW0EqNSwemjKUgd+oPDVE
	RE3PEo5Mr1kDaVql6B3Nk68=
X-Google-Smtp-Source: AGHT+IEGbKeFa1oqlRlC60ZiU5WeydE/sB9OsrBPu9xRR2mm6gIf6SB9WQ+tZbFpqPn3oA/pcDkx8Q==
X-Received: by 2002:a17:906:220e:b0:99d:acdb:f709 with SMTP id s14-20020a170906220e00b0099dacdbf709mr277026ejs.5.1691935286191;
        Sun, 13 Aug 2023 07:01:26 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id lz15-20020a170906fb0f00b0099bc2d1429csm4617194ejb.72.2023.08.13.07.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 07:01:25 -0700 (PDT)
Message-ID: <6aa77bb8-8d22-3e40-c8fe-654b5c094b10@grimberg.me>
Date: Sun, 13 Aug 2023 17:01:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 14/17] nvmet-tcp: reference counting for queues
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230811121755.24715-1-hare@suse.de>
 <20230811121755.24715-15-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230811121755.24715-15-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_070128_320856_9E330BEA 
X-CRM114-Status: GOOD (  32.42  )
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



On 8/11/23 15:17, Hannes Reinecke wrote:
> The 'queue' structure is referenced from various places and
> used as an argument of asynchronous functions, so it's really
> hard to figure out if the queue is still valid when the
> asynchronous function triggers.
> So add reference counting to validate the queue structure.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/target/tcp.c | 74 ++++++++++++++++++++++++++++++---------
>   1 file changed, 57 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index f19ea9d923fd..84b726dfc1c4 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -127,6 +127,7 @@ enum nvmet_tcp_queue_state {
>   };
>   
>   struct nvmet_tcp_queue {
> +	struct kref		kref;
>   	struct socket		*sock;
>   	struct nvmet_tcp_port	*port;
>   	struct work_struct	io_work;
> @@ -192,6 +193,9 @@ static struct workqueue_struct *nvmet_tcp_wq;
>   static const struct nvmet_fabrics_ops nvmet_tcp_ops;
>   static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
>   static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
> +static int nvmet_tcp_get_queue(struct nvmet_tcp_queue *queue);
> +static void nvmet_tcp_put_queue(struct nvmet_tcp_queue *queue);
> +static void nvmet_tcp_data_ready(struct sock *sk);
>   
>   static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
>   		struct nvmet_tcp_cmd *cmd)
> @@ -1437,11 +1441,21 @@ static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
>   	struct socket *sock = queue->sock;
>   
>   	write_lock_bh(&sock->sk->sk_callback_lock);
> +	/*
> +	 * Check if nvmet_tcp_set_queue_sock() has been called;
> +	 * if not the queue reference has not been increased
> +	 * and we're getting an refcount error on exit.
> +	 */
> +	if (sock->sk->sk_data_ready != nvmet_tcp_data_ready) {
> +		write_unlock_bh(&sock->sk->sk_callback_lock);
> +		return;
> +	}

This is really ugly I think.

>   	sock->sk->sk_data_ready =  queue->data_ready;
>   	sock->sk->sk_state_change = queue->state_change;
>   	sock->sk->sk_write_space = queue->write_space;
>   	sock->sk->sk_user_data = NULL;
>   	write_unlock_bh(&sock->sk->sk_callback_lock);
> +	nvmet_tcp_put_queue(queue);
>   }
>   
>   static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
> @@ -1474,6 +1488,30 @@ static void nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
>   		nvmet_tcp_free_cmd_buffers(&queue->connect);
>   }
>   
> +static void nvmet_tcp_release_queue_final(struct kref *kref)
> +{
> +	struct nvmet_tcp_queue *queue = container_of(kref, struct nvmet_tcp_queue, kref);
> +
> +	WARN_ON(queue->state != NVMET_TCP_Q_DISCONNECTING);
> +	nvmet_tcp_free_cmds(queue);
> +	ida_free(&nvmet_tcp_queue_ida, queue->idx);
> +	/* ->sock will be released by fput() */
> +	fput(queue->sock->file);
> +	kfree(queue);
> +}
> +
> +static int nvmet_tcp_get_queue(struct nvmet_tcp_queue *queue)
> +{
> +	if (!queue)
> +		return 0;
> +	return kref_get_unless_zero(&queue->kref);
> +}
> +
> +static void nvmet_tcp_put_queue(struct nvmet_tcp_queue *queue)
> +{
> +	kref_put(&queue->kref, nvmet_tcp_release_queue_final);
> +}
> +
>   static void nvmet_tcp_release_queue_work(struct work_struct *w)
>   {
>   	struct page *page;
> @@ -1493,15 +1531,11 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
>   	nvmet_sq_destroy(&queue->nvme_sq);
>   	cancel_work_sync(&queue->io_work);
>   	nvmet_tcp_free_cmd_data_in_buffers(queue);
> -	/* ->sock will be released by fput() */
> -	fput(queue->sock->file);
> -	nvmet_tcp_free_cmds(queue);
>   	if (queue->hdr_digest || queue->data_digest)
>   		nvmet_tcp_free_crypto(queue);
> -	ida_free(&nvmet_tcp_queue_ida, queue->idx);
>   	page = virt_to_head_page(queue->pf_cache.va);
>   	__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
> -	kfree(queue);
> +	nvmet_tcp_put_queue(queue);

What made you pick these vs. the others for before/after the
final reference?

>   }
>   
>   static void nvmet_tcp_data_ready(struct sock *sk)
> @@ -1512,8 +1546,10 @@ static void nvmet_tcp_data_ready(struct sock *sk)
>   
>   	read_lock_bh(&sk->sk_callback_lock);
>   	queue = sk->sk_user_data;
> -	if (likely(queue))
> +	if (likely(nvmet_tcp_get_queue(queue))) {
>   		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
> +		nvmet_tcp_put_queue(queue);
> +	}

No... Why?

The shutdown code should serialize perfectly without this. Why add
a kref to the normal I/O path?

I thought we'd simply move release_work to do a kref_put and take
an extra reference when we fire the tls handshake...

>   	read_unlock_bh(&sk->sk_callback_lock);
>   }
>   
> @@ -1523,18 +1559,16 @@ static void nvmet_tcp_write_space(struct sock *sk)
>   
>   	read_lock_bh(&sk->sk_callback_lock);
>   	queue = sk->sk_user_data;
> -	if (unlikely(!queue))
> +	if (unlikely(!nvmet_tcp_get_queue(queue)))
>   		goto out;
>   
>   	if (unlikely(queue->state == NVMET_TCP_Q_CONNECTING)) {
>   		queue->write_space(sk);
> -		goto out;
> -	}
> -
> -	if (sk_stream_is_writeable(sk)) {
> +	} else if (sk_stream_is_writeable(sk)) {
>   		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
>   		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
>   	}
> +	nvmet_tcp_put_queue(queue);

Same here...

Why not simply exclude the kref get/put to the tls handshake where
there is actually a race?

>   out:
>   	read_unlock_bh(&sk->sk_callback_lock);
>   }
> @@ -1545,7 +1579,7 @@ static void nvmet_tcp_state_change(struct sock *sk)
>   
>   	read_lock_bh(&sk->sk_callback_lock);
>   	queue = sk->sk_user_data;
> -	if (!queue)
> +	if (!nvmet_tcp_get_queue(queue))
>   		goto done;
>   
>   	switch (sk->sk_state) {
> @@ -1562,6 +1596,7 @@ static void nvmet_tcp_state_change(struct sock *sk)
>   		pr_warn("queue %d unhandled state %d\n",
>   			queue->idx, sk->sk_state);
>   	}
> +	nvmet_tcp_put_queue(queue);
>   done:
>   	read_unlock_bh(&sk->sk_callback_lock);
>   }
> @@ -1582,6 +1617,9 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
>   	if (ret < 0)
>   		return ret;
>   
> +	if (unlikely(!nvmet_tcp_get_queue(queue)))
> +		return -ECONNRESET;
> +

Can this actually fail?

>   	/*
>   	 * Cleanup whatever is sitting in the TCP transmit queue on socket
>   	 * close. This is done to prevent stale data from being sent should
> @@ -1603,6 +1641,7 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
>   		 * If the socket is already closing, don't even start
>   		 * consuming it
>   		 */
> +		nvmet_tcp_put_queue(queue);
>   		ret = -ENOTCONN;
>   	} else {
>   		sock->sk->sk_user_data = queue;
> @@ -1636,6 +1675,7 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>   
>   	INIT_WORK(&queue->release_work, nvmet_tcp_release_queue_work);
>   	INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
> +	kref_init(&queue->kref);
>   	queue->sock = newsock;
>   	queue->port = port;
>   	queue->nr_cmds = 0;
> @@ -1672,15 +1712,15 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>   	mutex_unlock(&nvmet_tcp_queue_mutex);
>   
>   	ret = nvmet_tcp_set_queue_sock(queue);
> -	if (ret)
> -		goto out_destroy_sq;
> +	if (!ret)
> +		return;
>   
> -	return;
> -out_destroy_sq:
> +	queue->state = NVMET_TCP_Q_DISCONNECTING;
>   	mutex_lock(&nvmet_tcp_queue_mutex);
>   	list_del_init(&queue->queue_list);
>   	mutex_unlock(&nvmet_tcp_queue_mutex);
> -	nvmet_sq_destroy(&queue->nvme_sq);
> +	nvmet_tcp_put_queue(queue);
> +	return;
>   out_free_connect:
>   	nvmet_tcp_free_cmd(&queue->connect);
>   out_ida_remove:

