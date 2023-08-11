Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F632C001B0
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 10:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Amap8jufsmDGn1j7TciVJ16l/PPaZ6lBT3me8drjbnk=; b=PUiOk3lJFojEembv06bXSgcMHt
	VTSh7jc+zhQcoOHuWHPluLu3gZxcW/Iwne4YaP6gwYPcYj7sXb4EVYIy/j/8ZsoMYGcww+IL6jZQr
	cHa+TAz38YMOuabJWn/bc13EXr+kcwUhvkGyHXDtCRe6UI8JpLDkxGwMq+6nXwPFd+fKgtmCikC3C
	EDngvj+LdZ++Sah5163Xp7SOnBFRjVkQ3TRyDpmK8ywDd7U4gtznOATnSXbp0rpWd4Wv6TFxGEsNa
	7/XewYI+1yCmytwmxA2O25xJfy8+lvBmi+7iK7nEEsKaUxdl+rnAfEzAy+DTT29aoQb3b8TOoDpRj
	hanUKvcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUPPJ-00AFfH-2n;
	Fri, 11 Aug 2023 10:30:13 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUPPG-00AFcq-1c
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 10:30:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0C23E66F60;
	Fri, 11 Aug 2023 10:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2BDC433C9;
	Fri, 11 Aug 2023 10:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691749809;
	bh=roMmYrgyQf7KBy7Bht+pmDDNZCxvp/8xKlMP5epKOpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GCdOEFSAuKDu0T4cchKKRFys4NoqU5HU2mrdOwX4nneiER58kVkANE0O0K/m1Zxif
	 LJtmQDAIc8H0x/hX3+Kmub7/2wiMQ4aramaqJ3/N+u3/hcrwko17BshhlzAqfw0/t4
	 YcReQgIvC1GZlX7BhV88sjlIPaJdki9Xbt+N4XPMJ5suolywBGdp1yk3LddxsYYOqg
	 r7Qr3bLaXvk+Y13alMqErWcL/tDMIfy5Gm0BNvvJeISt9V3gx0X6mEKgByO8yyCz1c
	 +cw3bLgBxDycxwaYVnZsp52IyRZNs70nzNI/IGbZrXpJFrv9K+C0vUh25KHV9FiLde
	 BPekgX1aVDuvA==
Date: Fri, 11 Aug 2023 12:30:05 +0200
From: Simon Horman <horms@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 14/17] nvmet-tcp: reference counting for queues
Message-ID: <ZNYNrYXSS02Qqlvn@vergenet.net>
References: <20230810150630.134991-1-hare@suse.de>
 <20230810150630.134991-15-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810150630.134991-15-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_033010_637679_B5DB94DA 
X-CRM114-Status: GOOD (  23.22  )
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

On Thu, Aug 10, 2023 at 05:06:27PM +0200, Hannes Reinecke wrote:
> The 'queue' structure is referenced from various places and
> used as an argument of asynchronous functions, so it's really
> hard to figure out if the queue is still valid when the
> asynchronous function triggers.
> So add reference counting to validate the queue structure.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/target/tcp.c | 73 ++++++++++++++++++++++++++++++---------
>  1 file changed, 56 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index ce1d1c5f4e90..a79ede885865 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -127,6 +127,7 @@ enum nvmet_tcp_queue_state {
>  };
>  
>  struct nvmet_tcp_queue {
> +	struct kref		kref;
>  	struct socket		*sock;
>  	struct nvmet_tcp_port	*port;
>  	struct work_struct	io_work;
> @@ -192,6 +193,8 @@ static struct workqueue_struct *nvmet_tcp_wq;
>  static const struct nvmet_fabrics_ops nvmet_tcp_ops;
>  static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
>  static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
> +static int nvmet_tcp_get_queue(struct nvmet_tcp_queue *queue);
> +static void nvmet_tcp_put_queue(struct nvmet_tcp_queue *queue);
>  
>  static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
>  		struct nvmet_tcp_cmd *cmd)
> @@ -1437,11 +1440,21 @@ static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
>  	struct socket *sock = queue->sock;
>  
>  	write_lock_bh(&sock->sk->sk_callback_lock);
> +	/*
> +	 * Check if nvmet_tcp_set_queue_sock() has been called;
> +	 * if not the queue reference has not been increased
> +	 * and we're getting an refcount error on exit.
> +	 */
> +	if (sock->sk->sk_data_ready != nvmet_tcp_data_ready) {

Hi Hannes,

it seems that nvmet_tcp_data_ready is used here,
but doesn't exist until patch 16/17.

> +		write_unlock_bh(&sock->sk->sk_callback_lock);
> +		return;
> +	}
>  	sock->sk->sk_data_ready =  queue->data_ready;
>  	sock->sk->sk_state_change = queue->state_change;
>  	sock->sk->sk_write_space = queue->write_space;
>  	sock->sk->sk_user_data = NULL;
>  	write_unlock_bh(&sock->sk->sk_callback_lock);
> +	nvmet_tcp_put_queue(queue);
>  }

...

