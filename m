Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2C1C04A6A
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Aug 2023 12:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ffgi8sdzt4mElKNGL2sdufwPEtWxnhNpy3RZRQL38UM=; b=bFAUveFoxENxlsoaJb5X04zpre
	6iOXQ5IOcUGafrFY8e+Xp9g3WBTW7zKAEikm19uGzXxy7xoTFqtifv2le83D833vFTQ0nKTCOxRKZ
	eEseyHzoSMgu1vNY9lHIH0B103ppas2/1Q+BjJkcahafEZI34MyYm9PSLHE796ADQVfHJvmOcshe5
	pdlnHJqXZvjtHZN7fiAf1RVpvNLwDyHKC5oMvFhFd66YmsLNyKXiYdjSlNzOHAdJ07WtGAxjHyEYT
	Bydd1sWGlCP+C8ou3nYZ6SDZUB44D5cgB6b6MSGlkMh8XmNTMz+EwZdBkYpG/+OjGDTb3+LDDKFfh
	KVkAgoyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVWzm-00H4ri-0b;
	Mon, 14 Aug 2023 12:48:30 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVWzj-00H4r8-0n
	for linux-nvme@lists.infradead.org;
	Mon, 14 Aug 2023 12:48:29 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3fe1b6192e8so12659635e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 14 Aug 2023 05:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692017305; x=1692622105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ffgi8sdzt4mElKNGL2sdufwPEtWxnhNpy3RZRQL38UM=;
        b=GXOf6pIs9FBRXpQZxh9/0j5omwJNizdL9Ezt+Td96OpfhP6q87eviju3XMYIpe8t69
         CE3RWcsGqtpKjOCAYDYKFkapgE01GhvNo+sEaaxhvz1icVYruRIIm/mtMOsfm9yzdOV+
         dsc71E2q9sHkD1+kf4EeKywvHCF6BAAhadBCOZtGVmplX1dtXWCm4B3QHfNmNJbVlyRM
         syiVSUuxi65kyQGcZsyeCfYriNIu36DMnvevWorjkPbUhGClcM1aIlDESTmpFs6F8PP4
         N91OBYXgRd/cWq26vHRBSE75blPSPl+f63Q4Cap6J9CfffWen1ykVkFAy2BNtpbIBOqy
         wmGA==
X-Gm-Message-State: AOJu0YwvcEFtbI7YQX3++/OUosyT61VUFqNc0rQtBvHhI4Bj6Z9vCEC0
	S1LcztOWHguPNH4GKz/Tg2oTDrzsJiA=
X-Google-Smtp-Source: AGHT+IGdPO0kaMt0P9JRVsxMQoti9Y3FVW76w3PQi33nLzP58STEhESWDkBvhFIQHj3Ql2ysZ3B7wQ==
X-Received: by 2002:a05:600c:1c07:b0:3fe:5228:b792 with SMTP id j7-20020a05600c1c0700b003fe5228b792mr7757179wms.3.1692017304769;
        Mon, 14 Aug 2023 05:48:24 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c6-20020a7bc846000000b003fe0a0e03fcsm16908991wml.12.2023.08.14.05.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 05:48:24 -0700 (PDT)
Message-ID: <cf21000c-177e-c882-ac30-fe3190748bae@grimberg.me>
Date: Mon, 14 Aug 2023 15:48:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 15/17] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230814111943.68325-1-hare@suse.de>
 <20230814111943.68325-16-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230814111943.68325-16-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230814_054827_284112_880D5CB9 
X-CRM114-Status: GOOD (  37.02  )
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



On 8/14/23 14:19, Hannes Reinecke wrote:
> Add functions to start the TLS handshake upcall when
> the TCP TSAS sectype is set to 'tls1.3' and add a config
> option NVME_TARGET_TCP_TLS.

Need to document the refcount added.
Also the general design with upcalling tls handshake in
userspace and continue from there...

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/target/Kconfig    |  15 ++++
>   drivers/nvme/target/configfs.c |  21 +++++
>   drivers/nvme/target/nvmet.h    |   1 +
>   drivers/nvme/target/tcp.c      | 146 ++++++++++++++++++++++++++++++++-
>   4 files changed, 179 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
> index 79fc64035ee3..8a6c9cae804c 100644
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
> +	  The TLS handshake daemon is availble at
> +	  https://github.com/oracle/ktls-utils.
> +
> +	  If unsure, say N.
> +
>   config NVME_TARGET_AUTH
>   	bool "NVMe over Fabrics In-band Authentication support"
>   	depends on NVME_TARGET
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index efbfed310370..ad1fb32c7387 100644
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
> @@ -397,6 +398,17 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
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
> @@ -1815,6 +1827,7 @@ static void nvmet_port_release(struct config_item *item)
>   	flush_workqueue(nvmet_wq);
>   	list_del(&port->global_entry);
>   
> +	key_put(port->keyring);
>   	kfree(port->ana_state);
>   	kfree(port);
>   }
> @@ -1864,6 +1877,14 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
>   		return ERR_PTR(-ENOMEM);
>   	}
>   
> +	if (nvme_keyring_id()) {
> +		port->keyring = key_lookup(nvme_keyring_id());
> +		if (IS_ERR(port->keyring)) {
> +			pr_warn("NVMe keyring not available, disabling TLS\n");
> +			port->keyring = NULL;

why setting this to NULL?

> +		}
> +	}
> +
>   	for (i = 1; i <= NVMET_MAX_ANAGRPS; i++) {
>   		if (i == NVMET_DEFAULT_ANA_GRPID)
>   			port->ana_state[1] = NVME_ANA_OPTIMIZED;
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 8cfd60f3b564..7f9ae53c1df5 100644
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
> index f19ea9d923fd..77fa339008e1 100644
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
> @@ -122,11 +136,13 @@ struct nvmet_tcp_cmd {
>   
>   enum nvmet_tcp_queue_state {
>   	NVMET_TCP_Q_CONNECTING,
> +	NVMET_TCP_Q_TLS_HANDSHAKE,
>   	NVMET_TCP_Q_LIVE,
>   	NVMET_TCP_Q_DISCONNECTING,
>   };
>   
>   struct nvmet_tcp_queue {
> +	struct kref		kref;

Why is kref the first member of the struct?

>   	struct socket		*sock;
>   	struct nvmet_tcp_port	*port;
>   	struct work_struct	io_work;
> @@ -155,6 +171,10 @@ struct nvmet_tcp_queue {
>   	struct ahash_request	*snd_hash;
>   	struct ahash_request	*rcv_hash;
>   
> +	/* TLS state */
> +	key_serial_t		tls_pskid;
> +	struct delayed_work	tls_handshake_work;
> +
>   	unsigned long           poll_end;
>   
>   	spinlock_t		state_lock;
> @@ -1283,12 +1303,21 @@ static int nvmet_tcp_try_recv(struct nvmet_tcp_queue *queue,
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
>   	if (queue->state != NVMET_TCP_Q_DISCONNECTING) {
>   		queue->state = NVMET_TCP_Q_DISCONNECTING;
> -		queue_work(nvmet_wq, &queue->release_work);
> +		kref_put(&queue->kref, nvmet_tcp_release_queue);
>   	}
>   	spin_unlock_bh(&queue->state_lock);
>   }
> @@ -1485,6 +1514,8 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
>   	mutex_unlock(&nvmet_tcp_queue_mutex);
>   
>   	nvmet_tcp_restore_socket_callbacks(queue);
> +	tls_handshake_cancel(queue->sock->sk);
> +	cancel_delayed_work_sync(&queue->tls_handshake_work);

We should call it tls_handshake_tmo_work or something to make it
clear it is a timeout work.

>   	cancel_work_sync(&queue->io_work);
>   	/* stop accepting incoming data */
>   	queue->rcv_state = NVMET_TCP_RECV_ERR;
> @@ -1512,8 +1543,13 @@ static void nvmet_tcp_data_ready(struct sock *sk)
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
> @@ -1621,6 +1657,83 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
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
> +	if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {

Is this even possible?

> +		pr_warn("queue %d: TLS handshake already completed\n",
> +			queue->idx);
> +		spin_unlock_bh(&queue->state_lock);
> +		kref_put(&queue->kref, nvmet_tcp_release_queue);

How can we get here?

> +		return;
> +	}
> +	if (!status)
> +		queue->tls_pskid = peerid;
> +	queue->state = NVMET_TCP_Q_CONNECTING;
> +	spin_unlock_bh(&queue->state_lock);
> +
> +	cancel_delayed_work_sync(&queue->tls_handshake_work);
> +	if (status) {

Wait, did we assign the sk_state_change in this stage? What will
sock shutdown trigger?

> +		kernel_sock_shutdown(queue->sock, SHUT_RDWR);

Probably the put can be moved to a out: label in the end.

> +		kref_put(&queue->kref, nvmet_tcp_release_queue);
> +		return;
> +	}
> +
> +	pr_debug("queue %d: resetting queue callbacks after TLS handshake\n",
> +		 queue->idx);
> +	nvmet_tcp_set_queue_sock(queue);
> +	kref_put(&queue->kref, nvmet_tcp_release_queue);
> +}
> +
> +static void nvmet_tcp_tls_handshake_timeout_work(struct work_struct *w)
> +{
> +	struct nvmet_tcp_queue *queue = container_of(to_delayed_work(w),
> +			struct nvmet_tcp_queue, tls_handshake_work);
> +
> +	pr_debug("queue %d: TLS handshake timeout\n", queue->idx);

Probably its better to make this pr_warn...

> +	if (!tls_handshake_cancel(queue->sock->sk))
> +		return;
> +	kernel_sock_shutdown(queue->sock, SHUT_RDWR);

Same question here, did we assign sk_state_change yet?

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
> +		queue_delayed_work(nvmet_wq, &queue->tls_handshake_work,
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
> @@ -1671,12 +1789,32 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>   	list_add_tail(&queue->queue_list, &nvmet_tcp_queue_list);
>   	mutex_unlock(&nvmet_tcp_queue_mutex);
>   
> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +	INIT_DELAYED_WORK(&queue->tls_handshake_work,
> +			  nvmet_tcp_tls_handshake_timeout_work);
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
>   
>   	return;
>   out_destroy_sq:
> +	queue->state = NVMET_TCP_Q_DISCONNECTING;

Can you clarify what this is used for?

>   	mutex_lock(&nvmet_tcp_queue_mutex);
>   	list_del_init(&queue->queue_list);
>   	mutex_unlock(&nvmet_tcp_queue_mutex);

