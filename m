Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86116EE4993
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Aug 2023 14:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z8PA6ylgyezkWzqAxIvXlNwaildsQxg0lW+Xq3m6Ivo=; b=HDDjR0f3DAJL16iQpoz9cfDE2p
	CiyiSPK+BoHcdNk/RgvnBmo1BnjPl6frwCGF1rCnICtxgrd/yuNiYBcddyJ5pm5y0FsUk3T8L/MQ9
	pAJ4311wh6go16CHaTs9lz3IzdI1Ifw81fSihL7j9Hb8fQVLDZcN06Lb8muGblxjGWPSbi0+Gyj+N
	SHlsKNOlyiaZL8J7j7SM41GOYqJL97kIRen9bPq1tBdLxgr5FcieE1scujdm3cijqX+CP6H+3hg9Z
	JYoJUFvyAcqcDXk349Y7dZ/04wo6C+a5gjy0i6YN1sI+JRZiTnokPeMsOIc+FEhF9caCXZr+WIgsF
	ocPuIxEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qXjqA-00C3yH-1q;
	Sun, 20 Aug 2023 14:55:42 +0000
Received: from mail-lj1-f181.google.com ([209.85.208.181])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qXjq6-00C3wp-2d
	for linux-nvme@lists.infradead.org;
	Sun, 20 Aug 2023 14:55:40 +0000
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2bcb5423dc7so2213131fa.1
        for <linux-nvme@lists.infradead.org>; Sun, 20 Aug 2023 07:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692543337; x=1693148137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8PA6ylgyezkWzqAxIvXlNwaildsQxg0lW+Xq3m6Ivo=;
        b=bF+ntrM+4pXCKl86YETFVP3qbRKCDiFidekFLr48TYDWoDZgEA9e83v6FtV6GeREvZ
         +SGz4IcXus3OBXE0YS+UedHMh0UQqLa58Xz4rcZIlf1EzKhWhYgwjP3aJy8HKlRZz64H
         GIr+RUlw4GYol7OUTtCP+nAPQRhxrZkcFD3lDMqBtALS9OX5N7jUnZMF5XKZf076/Hk7
         21aWLEnqKLVsdOUmxDqjBW5g/YSij7h1uMbXW7rqDivFvBYDMZC/lxFrIJlfcGg/hd6W
         4BJqnGa1QB7i5+ZmngXFfTvNo2A/9OisOfB43/FEku7fkwtloiZxLPgRbvbpaiFdBr7J
         ZtUQ==
X-Gm-Message-State: AOJu0YzfVafEdTUTq0eA9OK2boU2ic1iK3FsV0BGd/+OoEdTkv4Ve6tp
	/CahZ2NjH3UZsBR0Ig8eXvo=
X-Google-Smtp-Source: AGHT+IHZc3ixv/8yreDHX/kvUPMO+UllA6z8qzjvVPU7WyJIneTYUP4y5I8zRTISbzjHo16weVIicQ==
X-Received: by 2002:a19:f503:0:b0:4f6:a2f:beb with SMTP id j3-20020a19f503000000b004f60a2f0bebmr2491552lfb.5.1692543336606;
        Sun, 20 Aug 2023 07:55:36 -0700 (PDT)
Received: from [10.100.102.14] (46-116-234-112.bb.netvision.net.il. [46.116.234.112])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b009a168ab6ee2sm3865556ejr.164.2023.08.20.07.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 07:55:36 -0700 (PDT)
Message-ID: <87d71462-cadd-f572-c007-1909430fe4ab@grimberg.me>
Date: Sun, 20 Aug 2023 17:55:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 16/18] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230816120608.37135-1-hare@suse.de>
 <20230816120608.37135-17-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230816120608.37135-17-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230820_075538_860610_A763A826 
X-CRM114-Status: GOOD (  37.66  )
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



On 8/16/23 15:06, Hannes Reinecke wrote:
> TLS handshake is handled in userspace with the
> netlink tls handshake protocol.
> The patch adds a function to start the TLS handshake
> upcall for any incoming network connections if
> the TCP TSAS sectype is set to 'tls1.3'.
> A config option NVME_TARGET_TCP_TLS selects whether
> the TLS handshake upcall should be compiled in.
> The patch also adds reference counting to
> struct nvmet_tcp_queue to ensure the queue is
> always valid when the the TLS handshake completes.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/target/Kconfig    |  15 ++++
>   drivers/nvme/target/configfs.c |  21 +++++
>   drivers/nvme/target/nvmet.h    |   1 +
>   drivers/nvme/target/tcp.c      | 145 ++++++++++++++++++++++++++++++++-
>   4 files changed, 178 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
> index 79fc64035ee3..c56cb1005327 100644
> --- a/drivers/nvme/target/Kconfig
> +++ b/drivers/nvme/target/Kconfig
> @@ -84,6 +84,21 @@ config NVME_TARGET_TCP
>   
>   	  If unsure, say N.
>   
> +config NVME_TARGET_TCP_TLS
> +	bool "NVMe over Fabrics TCP target TLS encryption support"
> +	depends on NVME_TARGET_TCP
> +	select NVME_COMMON
> +	select NVME_KEYRING
> +	select NET_HANDSHAKE
> +	select KEYS
> +	help
> +	  Enables TLS encryption for the NVMe TCP target using the netlink handshake API.
> +
> +	  The TLS handshake daemon is available at
> +	  https://github.com/oracle/ktls-utils.
> +
> +	  If unsure, say N.
> +
>   config NVME_TARGET_AUTH
>   	bool "NVMe over Fabrics In-band Authentication support"
>   	depends on NVME_TARGET
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 483569c3f622..b780ce049163 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -15,6 +15,7 @@
>   #ifdef CONFIG_NVME_TARGET_AUTH
>   #include <linux/nvme-auth.h>
>   #endif
> +#include <linux/nvme-keyring.h>
>   #include <crypto/hash.h>
>   #include <crypto/kpp.h>
>   
> @@ -396,6 +397,17 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
>   	return -EINVAL;
>   
>   found:
> +	if (sectype == NVMF_TCP_SECTYPE_TLS13) {
> +		if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS)) {
> +			pr_err("TLS is not supported\n");
> +			return -EINVAL;
> +		}
> +		if (!port->keyring) {
> +			pr_err("TLS keyring not configured\n");
> +			return -EINVAL;
> +		}
> +	}
> +
>   	nvmet_port_init_tsas_tcp(port, sectype);
>   	/*
>   	 * The TLS implementation currently does not support
> @@ -1814,6 +1826,7 @@ static void nvmet_port_release(struct config_item *item)
>   	flush_workqueue(nvmet_wq);
>   	list_del(&port->global_entry);
>   
> +	key_put(port->keyring);
>   	kfree(port->ana_state);
>   	kfree(port);
>   }
> @@ -1863,6 +1876,14 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
>   		return ERR_PTR(-ENOMEM);
>   	}
>   
> +	if (nvme_keyring_id()) {
> +		port->keyring = key_lookup(nvme_keyring_id());
> +		if (IS_ERR(port->keyring)) {
> +			pr_warn("NVMe keyring not available, disabling TLS\n");
> +			port->keyring = NULL;
> +		}
> +	}
> +
>   	for (i = 1; i <= NVMET_MAX_ANAGRPS; i++) {
>   		if (i == NVMET_DEFAULT_ANA_GRPID)
>   			port->ana_state[1] = NVME_ANA_OPTIMIZED;
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 87da62e4b743..e35a03260f45 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -158,6 +158,7 @@ struct nvmet_port {
>   	struct config_group		ana_groups_group;
>   	struct nvmet_ana_group		ana_default_group;
>   	enum nvme_ana_state		*ana_state;
> +	struct key			*keyring;
>   	void				*priv;
>   	bool				enabled;
>   	int				inline_data_size;
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index f19ea9d923fd..3e447593ea72 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -8,9 +8,13 @@
>   #include <linux/init.h>
>   #include <linux/slab.h>
>   #include <linux/err.h>
> +#include <linux/key.h>
>   #include <linux/nvme-tcp.h>
> +#include <linux/nvme-keyring.h>
>   #include <net/sock.h>
>   #include <net/tcp.h>
> +#include <net/tls.h>
> +#include <net/handshake.h>
>   #include <linux/inet.h>
>   #include <linux/llist.h>
>   #include <crypto/hash.h>
> @@ -66,6 +70,16 @@ device_param_cb(idle_poll_period_usecs, &set_param_ops,
>   MODULE_PARM_DESC(idle_poll_period_usecs,
>   		"nvmet tcp io_work poll till idle time period in usecs: Default 0");
>   
> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +/*
> + * TLS handshake timeout
> + */
> +static int tls_handshake_timeout = 10;
> +module_param(tls_handshake_timeout, int, 0644);
> +MODULE_PARM_DESC(tls_handshake_timeout,
> +		 "nvme TLS handshake timeout in seconds (default 10)");
> +#endif
> +
>   #define NVMET_TCP_RECV_BUDGET		8
>   #define NVMET_TCP_SEND_BUDGET		8
>   #define NVMET_TCP_IO_WORK_BUDGET	64
> @@ -122,6 +136,7 @@ struct nvmet_tcp_cmd {
>   
>   enum nvmet_tcp_queue_state {
>   	NVMET_TCP_Q_CONNECTING,
> +	NVMET_TCP_Q_TLS_HANDSHAKE,
>   	NVMET_TCP_Q_LIVE,
>   	NVMET_TCP_Q_DISCONNECTING,
>   };
> @@ -132,6 +147,7 @@ struct nvmet_tcp_queue {
>   	struct work_struct	io_work;
>   	struct nvmet_cq		nvme_cq;
>   	struct nvmet_sq		nvme_sq;
> +	struct kref		kref;
>   
>   	/* send state */
>   	struct nvmet_tcp_cmd	*cmds;
> @@ -155,6 +171,10 @@ struct nvmet_tcp_queue {
>   	struct ahash_request	*snd_hash;
>   	struct ahash_request	*rcv_hash;
>   
> +	/* TLS state */
> +	key_serial_t		tls_pskid;
> +	struct delayed_work	tls_handshake_tmo_work;
> +
>   	unsigned long           poll_end;
>   
>   	spinlock_t		state_lock;
> @@ -1283,12 +1303,26 @@ static int nvmet_tcp_try_recv(struct nvmet_tcp_queue *queue,
>   	return ret;
>   }
>   
> +static void nvmet_tcp_release_queue(struct kref *kref)
> +{
> +	struct nvmet_tcp_queue *queue =
> +		container_of(kref, struct nvmet_tcp_queue, kref);
> +
> +	WARN_ON(queue->state != NVMET_TCP_Q_DISCONNECTING);
> +	queue_work(nvmet_wq, &queue->release_work);
> +}
> +
>   static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
>   {
>   	spin_lock_bh(&queue->state_lock);
> +	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
> +		/* Socket closed during handshake */
> +		tls_handshake_cancel(queue->sock->sk);

Can you call this under a spinlock?
I think you want the handshake cancel inside the release_work
no?

> +		queue->state = NVMET_TCP_Q_CONNECTING;

This state transition is weird.

> +	}
>   	if (queue->state != NVMET_TCP_Q_DISCONNECTING) {
>   		queue->state = NVMET_TCP_Q_DISCONNECTING;
> -		queue_work(nvmet_wq, &queue->release_work);
> +		kref_put(&queue->kref, nvmet_tcp_release_queue);

This change makes sense, but I think its the only one in this
function.

>   	}
>   	spin_unlock_bh(&queue->state_lock);
>   }
> @@ -1485,6 +1519,7 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
>   	mutex_unlock(&nvmet_tcp_queue_mutex);
>   
>   	nvmet_tcp_restore_socket_callbacks(queue);
> +	cancel_delayed_work_sync(&queue->tls_handshake_tmo_work);
>   	cancel_work_sync(&queue->io_work);
>   	/* stop accepting incoming data */
>   	queue->rcv_state = NVMET_TCP_RECV_ERR;
> @@ -1512,8 +1547,13 @@ static void nvmet_tcp_data_ready(struct sock *sk)
>   
>   	read_lock_bh(&sk->sk_callback_lock);
>   	queue = sk->sk_user_data;
> -	if (likely(queue))
> -		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
> +	if (likely(queue)) {
> +		if (queue->data_ready)
> +			queue->data_ready(sk);
> +		if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE)
> +			queue_work_on(queue_cpu(queue), nvmet_tcp_wq,
> +				      &queue->io_work);
> +	}
>   	read_unlock_bh(&sk->sk_callback_lock);
>   }
>   
> @@ -1621,6 +1661,79 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
>   	return ret;
>   }
>   
> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +static void nvmet_tcp_tls_handshake_done(void *data, int status,
> +					 key_serial_t peerid)
> +{
> +	struct nvmet_tcp_queue *queue = data;
> +
> +	pr_debug("queue %d: TLS handshake done, key %x, status %d\n",
> +		 queue->idx, peerid, status);
> +	spin_lock_bh(&queue->state_lock);
> +	WARN_ON(queue->state != NVMET_TCP_Q_TLS_HANDSHAKE);

If this happens, you probably need to return without doing anything
else...

> +	if (!status)
> +		queue->tls_pskid = peerid;
> +	queue->state = NVMET_TCP_Q_CONNECTING;
> +	spin_unlock_bh(&queue->state_lock);
> +
> +	cancel_delayed_work_sync(&queue->tls_handshake_tmo_work);
> +	if (status)
> +		nvmet_tcp_schedule_release_queue(queue);
> +	else
> +		nvmet_tcp_set_queue_sock(queue);
> +	kref_put(&queue->kref, nvmet_tcp_release_queue);
> +}
> +
> +static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w)
> +{
> +	struct nvmet_tcp_queue *queue = container_of(to_delayed_work(w),
> +			struct nvmet_tcp_queue, tls_handshake_tmo_work);
> +
> +	pr_warn("queue %d: TLS handshake timeout\n", queue->idx);
> +	/*
> +	 * If tls_handshake_cancel() fails we've lost the race with
> +	 * nvmet_tcp_tls_handshake_done() */
> +	if (!tls_handshake_cancel(queue->sock->sk))
> +		return;
> +	spin_lock_bh(&queue->state_lock);
> +	WARN_ON(queue->state != NVMET_TCP_Q_TLS_HANDSHAKE);
> +	queue->state = NVMET_TCP_Q_CONNECTING;

This state change is very weird, why?

> +	spin_unlock_bh(&queue->state_lock);
> +	nvmet_tcp_schedule_release_queue(queue);
> +	kref_put(&queue->kref, nvmet_tcp_release_queue);
> +}
> +
> +static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
> +{
> +	int ret = -EOPNOTSUPP;
> +	struct tls_handshake_args args;
> +
> +	if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
> +		pr_warn("cannot start TLS in state %d\n", queue->state);
> +		return -EINVAL;
> +	}
> +
> +	kref_get(&queue->kref);
> +	pr_debug("queue %d: TLS ServerHello\n", queue->idx);
> +	memset(&args, 0, sizeof(args));
> +	args.ta_sock = queue->sock;
> +	args.ta_done = nvmet_tcp_tls_handshake_done;
> +	args.ta_data = queue;
> +	args.ta_keyring = key_serial(queue->port->nport->keyring);
> +	args.ta_timeout_ms = tls_handshake_timeout * 1000;
> +
> +	ret = tls_server_hello_psk(&args, GFP_KERNEL);
> +	if (ret) {
> +		kref_put(&queue->kref, nvmet_tcp_release_queue);
> +		pr_err("failed to start TLS, err=%d\n", ret);
> +	} else {
> +		queue_delayed_work(nvmet_wq, &queue->tls_handshake_tmo_work,
> +				   tls_handshake_timeout * HZ);
> +	}
> +	return ret;
> +}
> +#endif
> +
>   static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>   		struct socket *newsock)
>   {
> @@ -1636,11 +1749,16 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>   
>   	INIT_WORK(&queue->release_work, nvmet_tcp_release_queue_work);
>   	INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
> +	kref_init(&queue->kref);
>   	queue->sock = newsock;
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
> @@ -1671,6 +1789,25 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>   	list_add_tail(&queue->queue_list, &nvmet_tcp_queue_list);
>   	mutex_unlock(&nvmet_tcp_queue_mutex);
>   
> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +	INIT_DELAYED_WORK(&queue->tls_handshake_tmo_work,
> +			  nvmet_tcp_tls_handshake_timeout);
> +	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
> +		struct sock *sk = queue->sock->sk;
> +
> +		/* Restore the default callbacks before starting upcall */
> +		read_lock_bh(&sk->sk_callback_lock);
> +		sk->sk_user_data = NULL;
> +		sk->sk_data_ready = port->data_ready;
> +		read_unlock_bh(&sk->sk_callback_lock);
> +		if (!nvmet_tcp_tls_handshake(queue))
> +			return;
> +
> +		/* TLS handshake failed, terminate the connection */
> +		goto out_destroy_sq;
> +	}
> +#endif
> +
>   	ret = nvmet_tcp_set_queue_sock(queue);
>   	if (ret)
>   		goto out_destroy_sq;

