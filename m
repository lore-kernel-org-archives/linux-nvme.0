Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA68EB64DD
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Aug 2023 08:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KgwQC4mOV25bqXtjsrlRBf8D8ivPv8QvJoDwH0UGw8o=; b=3QFUNHz5fkbxKr/CTyWY4k4AS4
	5YWUuZKSAxUVyVA4qG+rLGsgvvHyWsgQQwvT4g052uckdIhu0UPOyljfLx9zSvH6FVQcPVGzZI7wV
	8f8iiBL7qRmu14ewBh2cNo9U73W6mfD/MeymrqC9M2OF0TDtcD/gdY1ZAwsS4JRTBfpEWGQShSSqA
	1nHiKDLMdFYI7vvmuY5f1z6s2SG6bqxie7tQRzkbWG7tvdvqzvMXBOzsK/qvNCZ8CD17KKB4uPHjH
	Np4JbcioziimV07tIccZcowiLoyrgmy4V9eKOp4NrwJ+1F9Qb8ocu/RUj/izcz66MsRQk/Rgqkyi7
	ccjsXhpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSvxr-00GUqN-1M;
	Mon, 07 Aug 2023 08:51:47 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSvxn-00GUpm-1O
	for linux-nvme@lists.infradead.org;
	Mon, 07 Aug 2023 08:51:45 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3175e1bb38cso512343f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 07 Aug 2023 01:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691398300; x=1692003100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KgwQC4mOV25bqXtjsrlRBf8D8ivPv8QvJoDwH0UGw8o=;
        b=Fi06U+6Fwp4Hsh4fiSRfPGAsGVbrAGyh72EUwAnI4itm7yhPUCjRqI0PPUVX/KqRW4
         Ga8PQGP2SBL0hKoMk5aeYop/nJ8TiWAeSlzXcgBpHgqpMfTs48pkXrdf/LIHn4a4WFwH
         NdrzeC/LKuqP/L/8fuEoTTMORHjlyRl0zXCKosO7l1mf+ANsp64PqrbqVmYHlv94c6AZ
         pNJVznb6m1rJCA0VDt1kH03bxEXzZk59RbcSUggbai+PhNXtU4t8BkMpOds3ArD8lUkk
         igwabMSIEHTR+oe74dOAsoYTyKVR/WHQBJwoQQ5W/S65Yt5BDqKaEl9ujpaL8OLP8ara
         mZxg==
X-Gm-Message-State: ABy/qLb/Dqboi8jSl8NOm9HdrY1kycTbOqgHXMx8fJh6yA0+wM4XiDHI
	tDENjLJe7mQIccdifRAPI+QJqn3yxAo=
X-Google-Smtp-Source: APBJJlGfF2fTTLgXJzlpjDyjvSIGIdmkj6joOiqCEIa0Vf1kDDMr788X6C/O1lyRUfUa+jeUNZUMIA==
X-Received: by 2002:adf:ded2:0:b0:317:630d:1e8e with SMTP id i18-20020adfded2000000b00317630d1e8emr18643212wrn.2.1691398300462;
        Mon, 07 Aug 2023 01:51:40 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d4489000000b0031411b7087dsm9904308wrq.20.2023.08.07.01.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 01:51:39 -0700 (PDT)
Message-ID: <7260f07a-2d2a-1f84-722c-8385eda7475a@grimberg.me>
Date: Mon, 7 Aug 2023 11:51:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 13/14] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230803105102.30949-1-hare@suse.de>
 <20230803105102.30949-14-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230803105102.30949-14-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_015143_469970_9FCD19DF 
X-CRM114-Status: GOOD (  37.64  )
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



On 8/3/23 13:51, Hannes Reinecke wrote:
> Add functions to start the TLS handshake upcall when
> the TCP TSAS sectype is set to 'tls1.3' and add a config
> option NVME_TARGET_TCP_TLS.
> 
> Signed-off-by: Hannes Reincke <hare@suse.de>
> ---
>   drivers/nvme/target/Kconfig    |  14 ++++
>   drivers/nvme/target/configfs.c |  63 +++++++++++++++-
>   drivers/nvme/target/nvmet.h    |   1 +
>   drivers/nvme/target/tcp.c      | 133 +++++++++++++++++++++++++++++++--
>   4 files changed, 203 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
> index 79fc64035ee3..15af2b4341f6 100644
> --- a/drivers/nvme/target/Kconfig
> +++ b/drivers/nvme/target/Kconfig
> @@ -84,6 +84,20 @@ config NVME_TARGET_TCP
>   
>   	  If unsure, say N.
>   
> +config NVME_TARGET_TCP_TLS
> +	bool "NVMe over Fabrics TCP target TLS encryption support"
> +	depends on NVME_TARGET_TCP
> +	select NVME_COMMON
> +	select NVME_KEYRING
> +	select NET_HANDSHAKE
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
> index 7f826ac8b75c..49b407702ad5 100644
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
> @@ -159,10 +160,15 @@ static const struct nvmet_type_name_map nvmet_addr_treq[] = {
>   	{ NVMF_TREQ_NOT_REQUIRED,	"not required" },
>   };
>   
> +static inline u8 nvmet_port_treq(struct nvmet_port *port)
> +{
> +	return (port->disc_addr.treq & NVME_TREQ_SECURE_CHANNEL_MASK);
> +}
> +
>   static ssize_t nvmet_addr_treq_show(struct config_item *item, char *page)
>   {
> -	u8 treq = to_nvmet_port(item)->disc_addr.treq &
> -		NVME_TREQ_SECURE_CHANNEL_MASK;
> +	struct nvmet_port *port = to_nvmet_port(item);
> +	u8 treq = nvmet_port_treq(port);
>   	int i;
>   
>   	for (i = 0; i < ARRAY_SIZE(nvmet_addr_treq); i++) {
> @@ -174,11 +180,16 @@ static ssize_t nvmet_addr_treq_show(struct config_item *item, char *page)
>   	return snprintf(page, PAGE_SIZE, "\n");
>   }
>   
> +static inline u8 nvmet_port_treq_mask(struct nvmet_port *port)
> +{
> +	return (port->disc_addr.treq & ~NVME_TREQ_SECURE_CHANNEL_MASK);
> +}
> +
>   static ssize_t nvmet_addr_treq_store(struct config_item *item,
>   		const char *page, size_t count)
>   {
>   	struct nvmet_port *port = to_nvmet_port(item);
> -	u8 treq = port->disc_addr.treq & ~NVME_TREQ_SECURE_CHANNEL_MASK;
> +	u8 treq = nvmet_port_treq_mask(port);
>   	int i;
>   
>   	if (nvmet_is_port_enabled(port, __func__))
> @@ -193,6 +204,23 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
>   	return -EINVAL;
>   
>   found:
> +	if (port->disc_addr.trtype == NVMF_TRTYPE_TCP) {
> +		if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS)) {
> +			pr_err("TLS is not supported\n");
> +			return -EINVAL;
> +		}
> +		if (!port->keyring) {
> +			pr_err("TLS keyring not configured\n");
> +			return -EINVAL;
> +		}
> +		if (port->disc_addr.tsas.tcp.sectype != NVMF_TCP_SECTYPE_TLS13) {
> +			pr_warn("cannot change TREQ when TLS is not enabled\n");
> +			return -EINVAL;
> +		} else if (nvmet_addr_treq[i].type == NVMF_TREQ_NOT_SPECIFIED) {
> +			pr_warn("cannot set TREQ to 'not specified' when TLS is enabled\n");
> +			return -EINVAL;
> +		}
> +	}
>   	treq |= nvmet_addr_treq[i].type;
>   	port->disc_addr.treq = treq;
>   	return count;
> @@ -371,6 +399,7 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
>   		const char *page, size_t count)
>   {
>   	struct nvmet_port *port = to_nvmet_port(item);
> +	u8 treq = nvmet_port_treq_mask(port);
>   	int i;
>   
>   	if (nvmet_is_port_enabled(port, __func__))
> @@ -379,6 +408,15 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
>   	if (port->disc_addr.trtype != NVMF_TRTYPE_TCP)
>   		return -EINVAL;
>   
> +	if (!IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS)) {
> +		pr_err("TLS is not supported\n");
> +		return -EINVAL;
> +	}
> +	if (!port->keyring) {
> +		pr_err("TLS keyring not configured\n");
> +		return -EINVAL;
> +	}
> +
>   	for (i = 0; i < ARRAY_SIZE(nvmet_addr_tsas_tcp); i++) {
>   		if (sysfs_streq(page, nvmet_addr_tsas_tcp[i].name))
>   			goto found;
> @@ -389,6 +427,16 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
>   
>   found:
>   	nvmet_port_init_tsas_tcp(port, nvmet_addr_tsas_tcp[i].type);
> +	if (nvmet_addr_tsas_tcp[i].type == NVMF_TCP_SECTYPE_TLS13) {
> +		if (nvmet_port_treq(port) == NVMF_TREQ_NOT_SPECIFIED)
> +			treq |= NVMF_TREQ_REQUIRED;
> +		else
> +			treq |= nvmet_port_treq(port);
> +	} else {
> +		/* Set to 'not specified' if TLS is not enabled */
> +		treq |= NVMF_TREQ_NOT_SPECIFIED;
> +	}
> +	port->disc_addr.treq = treq;
>   	return count;
>   }
>   

Can the treq/tsas be split from the actual nvmet-tcp upcall addition?

> @@ -1795,6 +1843,7 @@ static void nvmet_port_release(struct config_item *item)
>   	flush_workqueue(nvmet_wq);
>   	list_del(&port->global_entry);
>   
> +	key_put(port->keyring);
>   	kfree(port->ana_state);
>   	kfree(port);
>   }
> @@ -1844,6 +1893,14 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
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

Nice.

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
> index fdc351f591a4..7279c994abd6 100644
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
> +static int tls_handshake_timeout = 30;
> +module_param(tls_handshake_timeout, int, 0644);
> +MODULE_PARM_DESC(tls_handshake_timeout,
> +		 "nvme TLS handshake timeout in seconds (default 30)");
> +#endif

On the host it is 10 and here 30? what is the source of the assymmetry?

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
> @@ -154,6 +169,8 @@ struct nvmet_tcp_queue {
>   	bool			data_digest;
>   	struct ahash_request	*snd_hash;
>   	struct ahash_request	*rcv_hash;
> +	key_serial_t		tls_pskid;
> +	struct delayed_work	tls_handshake_work;
>   
>   	unsigned long           poll_end;
>   
> @@ -1285,12 +1302,12 @@ static int nvmet_tcp_try_recv(struct nvmet_tcp_queue *queue,
>   
>   static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
>   {
> -	spin_lock(&queue->state_lock);
> +	spin_lock_irq(&queue->state_lock);

Where is this lock taken in irq context that needs disabling irq?

>   	if (queue->state != NVMET_TCP_Q_DISCONNECTING) {
>   		queue->state = NVMET_TCP_Q_DISCONNECTING;
>   		queue_work(nvmet_wq, &queue->release_work);
>   	}
> -	spin_unlock(&queue->state_lock);
> +	spin_unlock_irq(&queue->state_lock);
>   }
>   
>   static inline void nvmet_tcp_arm_queue_deadline(struct nvmet_tcp_queue *queue)
> @@ -1512,8 +1529,12 @@ static void nvmet_tcp_data_ready(struct sock *sk)
>   
>   	read_lock_bh(&sk->sk_callback_lock);
>   	queue = sk->sk_user_data;
> -	if (likely(queue))
> -		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
> +	if (queue->data_ready)
> +		queue->data_ready(sk);
> +	if (likely(queue) &&
> +	    queue->state != NVMET_TCP_Q_TLS_HANDSHAKE)
> +		queue_work_on(queue_cpu(queue), nvmet_tcp_wq,
> +			      &queue->io_work);
>   	read_unlock_bh(&sk->sk_callback_lock);
>   }
>   
> @@ -1621,6 +1642,85 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
>   	return ret;
>   }
>   
> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +static void nvmet_tcp_tls_queue_reset(struct nvmet_tcp_queue *queue)
> +{
> +	spin_lock_irq(&queue->state_lock);
> +	if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
> +		pr_warn("queue %d: TLS handshake already completed\n",
> +			queue->idx);
> +		spin_unlock_irq(&queue->state_lock);
> +		return;

trigger fatal error here?

> +	}
> +	queue->state = NVMET_TCP_Q_CONNECTING;
> +	spin_unlock_irq(&queue->state_lock);
> +
> +	pr_debug("queue %d: resetting queue callbacks after TLS handshake\n",
> +		 queue->idx);
> +	/*
> +	 * Set callbacks after handshake; TLS implementation
> +	 * might have changed the socket callbacks.
> +	 */
> +	nvmet_tcp_set_queue_sock(queue);
> +}
> +
> +static void nvmet_tcp_tls_handshake_done(void *data, int status,
> +					 key_serial_t peerid)

lets call peerid psk_id throughout.

> +{
> +	struct nvmet_tcp_queue *queue = data;
> +
> +	pr_debug("queue %d: TLS handshake done, key %x, status %d\n",
> +		 queue->idx, peerid, status);
> +	if (!status) {
> +		spin_lock_irq(&queue->state_lock);
> +		queue->tls_pskid = peerid;
> +		spin_unlock_irq(&queue->state_lock);
> +	}
> +	cancel_delayed_work_sync(&queue->tls_handshake_work);

Hmm, the cancel_delayed_work_sync is scary.

What happens if it ran and already scheduled a release (which
already ran and completed)?

> +	if (status)
> +		nvmet_tcp_schedule_release_queue(queue);
> +	else
> +		nvmet_tcp_tls_queue_reset(queue);

What I think you need is an atomic state that one or the
other access, and then you are fine with a normal async
cancel of the delayed_work.

> +}
> +
> +static void nvmet_tcp_tls_handshake_timeout_work(struct work_struct *w)
> +{
> +	struct nvmet_tcp_queue *queue = container_of(to_delayed_work(w),
> +			struct nvmet_tcp_queue, tls_handshake_work);
> +
> +	pr_debug("queue %d: TLS handshake timeout\n", queue->idx);
> +	nvmet_tcp_schedule_release_queue(queue);
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
> +	pr_debug("queue %d: TLS ServerHello\n", queue->idx);
> +	memset(&args, 0, sizeof(args));
> +	args.ta_sock = queue->sock;
> +	args.ta_done = nvmet_tcp_tls_handshake_done;
> +	args.ta_data = queue;
> +	args.ta_keyring = key_serial(queue->port->nport->keyring);
> +	args.ta_timeout_ms = tls_handshake_timeout * 2 * 1024;

* 2 * 1024 ? I didn't know we have 2048 ms in a second...

> +
> +	ret = tls_server_hello_psk(&args, GFP_KERNEL);
> +	if (ret) {
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
> @@ -1638,7 +1738,11 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
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
> @@ -1669,6 +1773,25 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>   	list_add_tail(&queue->queue_list, &nvmet_tcp_queue_list);
>   	mutex_unlock(&nvmet_tcp_queue_mutex);
>   
> +#ifdef CONFIG_NVME_TARGET_TCP_TLS

maybe the ifdef can be avoided with stubs?

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

