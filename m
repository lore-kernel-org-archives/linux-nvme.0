Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F53C761A6
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 12:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BlkZpGHZPC53irRsKzp6kuuPu4jbfR4ylYoi2Xneehw=; b=2AwGPmWchZjuGcbcVdotBxirg7
	TIaNZh3QqNemZG0YztI5EWIuYZfHG3k7JBcosD52TbTznEhE8GlA0nuHXIYxjKpK4qmNnkxn/PZsg
	IyrpYuSN9C0kPUYYCp2CyqNzAH0P3rY8x9QWnlO7qK9pAkf6frDkWNTeNBVGYQGMBPN9dAEif+0o+
	SCdxsodqifwXxCdCdvOJqzTCwSnBCReMWF5RdDF44e6uqCPZCdjBA4I3S2pWeuKcpZTr2cjPo0I6y
	JuA2zI7WWI8F1/xveoUzu4rZ9nAZWkVI12+CPoLsXCx7PynMA+PkonBBUeGMMI6SI34gkEyGAq8Rd
	oAEH1VbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjJeX-00FLb6-0A;
	Mon, 03 Apr 2023 12:51:17 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjJeT-00FLaG-14
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 12:51:15 +0000
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-2cfe3278da7so507570f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 03 Apr 2023 05:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680526270;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BlkZpGHZPC53irRsKzp6kuuPu4jbfR4ylYoi2Xneehw=;
        b=p1G1DSzhy71TLwKDlYsa8bISj/FtGhYLKmu3f89lTQMptO1FD2eDOoVnIj4HQSksXS
         1WMjMjdrjJMioan5TLZ8j8iPYQew3YXL8xgIK5s2/4IkfX02RFlZRxjPcY3YVDoFN174
         u1hnwD3b8EbgsfbgyS3OVmlYfEWMbeNBvCDd1RG4EsAxSbH6bbV74JDEjxkVUXGE4eSB
         c90/i9Q/zn93AAnGY4FV+i6squ/RrXm8FNpUBmqZ1VLXO2rrq7IzRwSFBKY0SbVkI/pe
         gnV4zf/6GTRRwJX9dV3HZxznmQ85dsB1NkVfP0YQCwf92GT1onEX9ePJcyVgYdp9j+K4
         MsTg==
X-Gm-Message-State: AAQBX9fP/LPmMBzudie15/U75mZrga63oNuBYHSfHyUL2ZL6IaRpaTtl
	KhwPH+o2qfwjibzpZvZyNdpvIU+EwjQ=
X-Google-Smtp-Source: AKy350bp3m28EaDitddBu8G7sYnthzBcQlgUU16HD+Y7QsuedkUkNrfJNAoM+/bpdYgGtgIP5kbuLA==
X-Received: by 2002:a05:600c:1d03:b0:3eb:42f6:ac55 with SMTP id l3-20020a05600c1d0300b003eb42f6ac55mr11911191wms.1.1680526270576;
        Mon, 03 Apr 2023 05:51:10 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k22-20020a7bc316000000b003ee20b4b2dasm11958539wmj.46.2023.04.03.05.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 05:51:10 -0700 (PDT)
Message-ID: <e1cf08ad-de6e-c41b-9fd3-de78b3a7d362@grimberg.me>
Date: Mon, 3 Apr 2023 15:51:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 15/18] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-16-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230329135938.46905-16-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_055113_369898_24A4B48F 
X-CRM114-Status: GOOD (  33.18  )
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


> Add functions to start the TLS handshake upcall when
> the TCP RSAS sectype is set to 'tls1.3'.

TSAS

> 
> Signed-off-by: Hannes Reincke <hare@suse.de>
> ---
>   drivers/nvme/target/configfs.c |  32 +++++++-
>   drivers/nvme/target/tcp.c      | 135 ++++++++++++++++++++++++++++++++-
>   2 files changed, 163 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index ca66ee6dc153..36fbf6a22d09 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -159,10 +159,12 @@ static const struct nvmet_type_name_map nvmet_addr_treq[] = {
>   	{ NVMF_TREQ_NOT_REQUIRED,	"not required" },
>   };
>   
> +#define NVMET_PORT_TREQ(port) ((port)->disc_addr.treq & NVME_TREQ_SECURE_CHANNEL_MASK)

Can you make it a static inline?

> +
>   static ssize_t nvmet_addr_treq_show(struct config_item *item, char *page)
>   {
> -	u8 treq = to_nvmet_port(item)->disc_addr.treq &
> -		NVME_TREQ_SECURE_CHANNEL_MASK;
> +	struct nvmet_port *port = to_nvmet_port(item);
> +	u8 treq = NVMET_PORT_TREQ(port);
>   	int i;
>   
>   	for (i = 0; i < ARRAY_SIZE(nvmet_addr_treq); i++) {
> @@ -193,6 +195,17 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
>   	return -EINVAL;
>   
>   found:
> +#ifdef CONFIG_NVME_TLS
> +	if (port->disc_addr.trtype == NVMF_TRTYPE_TCP) {
> +		if (port->disc_addr.tsas.tcp.sectype != NVMF_TCP_SECTYPE_TLS13) {
> +			pr_warn("cannot change TREQ when TLS is not enabled\n");
> +			return -EINVAL;
> +		} else if (nvmet_addr_treq[i].type == NVMF_TREQ_NOT_SPECIFIED) {
> +			pr_warn("cannot set TREQ to 'not specified' when TLS is enabled\n");
> +			return -EINVAL;
> +		}
> +	}

Is this code wrong if CONFIG_NVME_TLS is not enabled?

> +#endif
>   	treq |= nvmet_addr_treq[i].type;
>   	port->disc_addr.treq = treq;
>   	return count;
> @@ -373,6 +386,7 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
>   		const char *page, size_t count)
>   {
>   	struct nvmet_port *port = to_nvmet_port(item);
> +	u8 treq = port->disc_addr.treq & ~NVME_TREQ_SECURE_CHANNEL_MASK;
>   	int i;
>   
>   	if (nvmet_is_port_enabled(port, __func__))
> @@ -391,6 +405,20 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
>   
>   found:
>   	nvmet_port_init_tsas_tcp(port, nvmet_addr_tsas_tcp[i].type);
> +	if (nvmet_addr_tsas_tcp[i].type == NVMF_TCP_SECTYPE_TLS13) {
> +#ifdef CONFIG_NVME_TLS

Maybe in the start of the function just do:

	if (!IS_ENABLED(CONFIG_NVME_TLS)) {
		pr_err("TLS not supported\n");
		return -EINVAL;
	}

Instead of incorporating it here.

> +		if (NVMET_PORT_TREQ(port) == NVMF_TREQ_NOT_SPECIFIED)
> +			treq |= NVMF_TREQ_REQUIRED;
> +		else
> +			treq |= NVMET_PORT_TREQ(port);
> +#else
> +		pr_err("TLS not supported\n");
> +		return -EINVAL;
> +#endif
> +	} else {
> +		/* Set to 'not specified' if TLS is not enabled */
> +		treq |= NVMF_TREQ_NOT_SPECIFIED;
> +	}
>   	return count;
>   }
>   
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 5931971d715f..ebec882120fd 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -11,6 +11,10 @@
>   #include <linux/nvme-tcp.h>
>   #include <net/sock.h>
>   #include <net/tcp.h>
> +#ifdef CONFIG_NVME_TLS
> +#include <net/handshake.h>

Is net/handshake.h under an ifdef? If so, CONFIG_NVME_TLS should
select it.

> +#include <linux/nvme-keyring.h>

will this include not work if CONFIG_NVME_TLS not work?
<linux/nvme-auth.h> is not under CONFIG_NVME_AUTH for example.

> +#endif
>   #include <linux/inet.h>
>   #include <linux/llist.h>
>   #include <crypto/hash.h>
> @@ -40,6 +44,16 @@ module_param(idle_poll_period_usecs, int, 0644);
>   MODULE_PARM_DESC(idle_poll_period_usecs,
>   		"nvmet tcp io_work poll till idle time period in usecs");
>   
> +#ifdef CONFIG_NVME_TLS
> +/*
> + * TLS handshake timeout
> + */
> +static int tls_handshake_timeout = 30;
> +module_param(tls_handshake_timeout, int, 0644);
> +MODULE_PARM_DESC(tls_handshake_timeout,
> +		 "nvme TLS handshake timeout in seconds (default 30)");
> +#endif
> +
>   #define NVMET_TCP_RECV_BUDGET		8
>   #define NVMET_TCP_SEND_BUDGET		8
>   #define NVMET_TCP_IO_WORK_BUDGET	64
> @@ -130,6 +144,10 @@ struct nvmet_tcp_queue {
>   	bool			data_digest;
>   	struct ahash_request	*snd_hash;
>   	struct ahash_request	*rcv_hash;
> +#ifdef CONFIG_NVME_TLS
> +	struct key		*tls_psk;
> +	struct delayed_work	tls_handshake_work;
> +#endif

If these won't be under CONFIG_NVME_TLS will it save a lot of the other
ifdefs in the code?

>   
>   	unsigned long           poll_end;
>   
> @@ -1474,6 +1492,10 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
>   	nvmet_tcp_free_cmds(queue);
>   	if (queue->hdr_digest || queue->data_digest)
>   		nvmet_tcp_free_crypto(queue);
> +#ifdef CONFIG_NVME_TLS
> +	if (queue->tls_psk)
> +		key_put(queue->tls_psk);

key_put is NULL safe.

> +#endif
>   	ida_free(&nvmet_tcp_queue_ida, queue->idx);
>   	page = virt_to_head_page(queue->pf_cache.va);
>   	__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
> @@ -1488,8 +1510,12 @@ static void nvmet_tcp_data_ready(struct sock *sk)
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
> @@ -1597,6 +1623,89 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
>   	return ret;
>   }
>   
> +#ifdef CONFIG_NVME_TLS
> +static void nvmet_tcp_tls_queue_restart(struct nvmet_tcp_queue *queue)
> +{
> +	spin_lock(&queue->state_lock);
> +	if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
> +		pr_warn("queue %d: TLS handshake already completed\n",
> +			queue->idx);
> +		spin_unlock(&queue->state_lock);
> +		return;
> +	}
> +	queue->state = NVMET_TCP_Q_CONNECTING;
> +	spin_unlock(&queue->state_lock);
> +
> +	pr_debug("queue %d: restarting queue after TLS handshake\n",
> +		 queue->idx);
> +	/*
> +	 * Set callbacks after handshake; TLS implementation
> +	 * might have changed the socket callbacks.
> +	 */
> +	nvmet_tcp_set_queue_sock(queue);

Maybe fold it into the caller? The name is confusing anyways.
The queue is not restarted, it is post-configured for lack of
a better term.

> +}
> +
> +static void nvmet_tcp_tls_handshake_done(void *data, int status,
> +					 key_serial_t peerid)

					pskid.

> +{
> +	struct nvmet_tcp_queue *queue = data;
> +
> +	pr_debug("queue %d: TLS handshake done, key %x, status %d\n",
> +		 queue->idx, peerid, status);
> +	if (!status) {
> +		spin_lock(&queue->state_lock);
> +		queue->tls_psk = key_lookup(peerid);
> +		if (IS_ERR(queue->tls_psk)) {
> +			pr_warn("queue %d: TLS key %x not found\n",
> +				queue->idx, peerid);
> +			queue->tls_psk = NULL;

Here you let the timeout take care of it later?

