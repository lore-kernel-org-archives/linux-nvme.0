Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0EDC761A6
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Mar 2023 16:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ToiM3SZACoWFSi8YWylNkFpayS+WfTASFdFSJ9SSeE=; b=UWEEBj0ZlrWWQNLKUvz/N3sEHO
	MQ3imwykBg/7sIpDJZclL+4CXNB4M17vU3LKeRB1xmPBVbD4ZHl/vDXZRD7V6H6TMldB8Xc9z10/E
	kQYtjABFa+b5ussH7SH0G7KY2GJ0MJGmVlngCdlZi9fz1xSrbUf3da/fJBJ6IMrcY/k8Q4djfbkxI
	/O8SiRTNAG7O+5aagCRprvctvD+jOiymEj/ue/ZcLWWuTOUflFysdc+uFlZmFd5PyG2Yu18wUrs7i
	rXyqV/XBdtUlkh+J9LhujrQUm/orWGI2Ztmz8d/ceCjLu8uIJKr0xY11lv0mBQAxwooRGqJsOlHpd
	1Hg4MF3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phup9-004PxL-2q;
	Thu, 30 Mar 2023 16:08:27 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phup7-004PwD-16
	for linux-nvme@lists.infradead.org;
	Thu, 30 Mar 2023 16:08:26 +0000
Received: by mail-wm1-f50.google.com with SMTP id o24-20020a05600c511800b003ef59905f26so12106328wms.2
        for <linux-nvme@lists.infradead.org>; Thu, 30 Mar 2023 09:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192504;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ToiM3SZACoWFSi8YWylNkFpayS+WfTASFdFSJ9SSeE=;
        b=jlKUlNn4Y6qmemNUngWYyZLo7EfaGrJcrOHUNReW6NcnG+0qu+6lmvlWlxVAUYY1GD
         WFu7j+dznPq4LcAkzbl7fsbLIO3tzfyam4W+Q/NGuNjCvQ7BxTmYw7onLJQmuGFJR3P1
         SY2R5UqYa2ClZR5qlG/sqv9nIm7+ZHnvTs1/bZQuUi2LUO5PrkpsfCMrRy+UJrY6yajW
         Jo41xgH44hsKc95PQl62Dq48LQiKfzbsttBffa8+m/pgfbV5zzBgF8dZzU7ZFhkPWtdO
         tGyc2D7tRiXjM0xAY+i9e3Ix4eFGNfq9nETy1Xj4UJ8lJ3hPg+Dv1CE5owosyYZ69SIz
         CvTg==
X-Gm-Message-State: AAQBX9e6QAjSoGrOxQxNd07W2bG3fr0fZLlN43norKgP5pi8i42FraNb
	BkLmrU1eDbUoFHj+SNueq3bqMRAajws=
X-Google-Smtp-Source: AKy350b/HxIP8RvO4xbH+XyjOrw/qR6UdUFHNWAei2Fq7jP+5kRk5jmT7dcov0PL/TqRAldOdqNftw==
X-Received: by 2002:a05:600c:474d:b0:3ed:2a41:8529 with SMTP id w13-20020a05600c474d00b003ed2a418529mr2365935wmo.2.1680192503947;
        Thu, 30 Mar 2023 09:08:23 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c020c00b003ee70225ed2sm6191243wmi.15.2023.03.30.09.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 09:08:23 -0700 (PDT)
Message-ID: <1dfb48db-0d3e-6283-04d0-0481470174d2@grimberg.me>
Date: Thu, 30 Mar 2023 19:08:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 14/18] nvmet-tcp: allocate socket file
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-15-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230329135938.46905-15-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_090825_377368_4B73FBBE 
X-CRM114-Status: GOOD (  22.77  )
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



On 3/29/23 16:59, Hannes Reinecke wrote:
> When using the TLS upcall we need to allocate a socket file such
> that the userspace daemon is able to use the socket.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/target/tcp.c | 51 +++++++++++++++++++++++++++++----------
>   1 file changed, 38 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 66e8f9fd0ca7..5931971d715f 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -96,12 +96,14 @@ struct nvmet_tcp_cmd {
>   
>   enum nvmet_tcp_queue_state {
>   	NVMET_TCP_Q_CONNECTING,
> +	NVMET_TCP_Q_TLS_HANDSHAKE,
>   	NVMET_TCP_Q_LIVE,
>   	NVMET_TCP_Q_DISCONNECTING,
>   };
>   
>   struct nvmet_tcp_queue {
>   	struct socket		*sock;
> +	struct file		*sock_file;
>   	struct nvmet_tcp_port	*port;
>   	struct work_struct	io_work;
>   	struct nvmet_cq		nvme_cq;
> @@ -1406,6 +1408,19 @@ static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
>   	write_unlock_bh(&sock->sk->sk_callback_lock);
>   }
>   
> +static void nvmet_tcp_close_sock(struct nvmet_tcp_queue *queue)
> +{
> +	if (queue->sock_file) {
> +		fput(queue->sock_file);
> +		queue->sock_file = NULL;
> +		queue->sock = NULL;
> +	} else {
> +		WARN_ON(!queue->sock->ops);
> +		sock_release(queue->sock);
> +		queue->sock = NULL;
> +	}
> +}
> +
>   static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
>   {
>   	struct nvmet_tcp_cmd *cmd = queue->cmds;
> @@ -1455,12 +1470,11 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
>   	nvmet_sq_destroy(&queue->nvme_sq);
>   	cancel_work_sync(&queue->io_work);
>   	nvmet_tcp_free_cmd_data_in_buffers(queue);
> -	sock_release(queue->sock);
> +	nvmet_tcp_close_sock(queue);
>   	nvmet_tcp_free_cmds(queue);
>   	if (queue->hdr_digest || queue->data_digest)
>   		nvmet_tcp_free_crypto(queue);
>   	ida_free(&nvmet_tcp_queue_ida, queue->idx);
> -
>   	page = virt_to_head_page(queue->pf_cache.va);
>   	__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
>   	kfree(queue);
> @@ -1583,7 +1597,7 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
>   	return ret;
>   }
>   
> -static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
> +static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>   		struct socket *newsock)
>   {
>   	struct nvmet_tcp_queue *queue;
> @@ -1591,7 +1605,7 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>   
>   	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
>   	if (!queue)
> -		return -ENOMEM;
> +		return;
>   
>   	INIT_WORK(&queue->release_work, nvmet_tcp_release_queue_work);
>   	INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
> @@ -1599,15 +1613,28 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>   	queue->port = port;
>   	queue->nr_cmds = 0;
>   	spin_lock_init(&queue->state_lock);
> -	queue->state = NVMET_TCP_Q_CONNECTING;
> +	if (queue->port->nport->disc_addr.tsas.tcp.sectype ==
> +	    NVMF_TCP_SECTYPE_TLS13)
> +		queue->state = NVMET_TCP_Q_TLS_HANDSHAKE;
> +	else
> +		queue->state = NVMET_TCP_Q_CONNECTING;
>   	INIT_LIST_HEAD(&queue->free_list);
>   	init_llist_head(&queue->resp_list);
>   	INIT_LIST_HEAD(&queue->resp_send_list);
>   
> +	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
> +		queue->sock_file = sock_alloc_file(queue->sock, O_CLOEXEC, NULL);
> +		if (IS_ERR(queue->sock_file)) {
> +			ret = PTR_ERR(queue->sock_file);
> +			queue->sock_file = NULL;
> +			goto out_free_queue;
> +		}
> +	}

Why not always allocate a sock_file? Like in the host?

