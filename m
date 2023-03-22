Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8A9C7619A
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 12:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eZje8GWFYzH79XJtSrNuDgijglqOqdk4AaKtaxN0tLA=; b=HlEDLwuXUcdr7bdIOYCaePXm/r
	4BrIGD8YVEJxHNJ9owsjBmeSjlRagww1Kpd4q4TaoHf1i9dmsWPwTUH1O9k9ZuWg9rQ4+SoN+OIkG
	wqx3AlAjizGsFOC5RkT3+MIvfKIrq4J6t1K32PxjKpuU52KHrfd9KbtvWG281sn7rPKVf+M9knuk3
	xW8u1qSf2Ivn9JvyjgiwWuavMlHd4frz2tsrNfEba/qzpFWrlSu5ACtmFM4i5+osOi1GVqxKlGBTJ
	fnApSs6Wb1mNwOhYwyqmzYtODBwMq57eVK44Pg7e52ykpSvk2fuWEw6Mi/ipuDKsYgCwmoxiIav78
	knF9Bs/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pexLw-00FtFt-05;
	Wed, 22 Mar 2023 12:14:04 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pexLs-00FtF2-0Y
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 12:14:02 +0000
Received: by mail-wm1-f51.google.com with SMTP id l15-20020a05600c4f0f00b003ed58a9a15eso11308888wmq.5
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 05:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679487238; x=1682079238;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZje8GWFYzH79XJtSrNuDgijglqOqdk4AaKtaxN0tLA=;
        b=H/v0S+SbqG6vivBMFGEUMlzm+YwMo1fdvEpePethrPNNs1Z05N8oH12vLthbuKCPOh
         f0RuTkMPThOrdCmBg1DHCetrY19XFxME2YYRv6f2l0Agfi4SZmujxfSpyeNj0+ktbyXq
         wtITiqNzZZxWR8b0PH9JcAzryDLWw/LWIGDWPq5Ofs3XJY6R0+b6Lj6G+KXtI/fnA26h
         imuDEkv6nm3HopD1Abj9bDHExvQVcDhrmhlX/fAgqkNox8RzmlxEWzsmIYqUxd0uHlKl
         eQJK56hBxvsJUeVgOernsRcG20+U7ReF5xnErEZgX9cGzZ634DznPyqV6ZL6YKa/wPlA
         BaCg==
X-Gm-Message-State: AO0yUKXthuuRGlWwTvQGiTyAeOaPnIxXvLg2rC6y4lbksCA+hohGJ7I2
	E80LLEMkqw6kHpqvR3vd7o8VEo863Ac=
X-Google-Smtp-Source: AK7set+hs2J9/0URpQyc1YOc7BX5oisHmnpYD6ZgRjBLo/6XuuwozZRxW9z63//Gd+EmB/3BrK/3qQ==
X-Received: by 2002:a05:600c:3103:b0:3ed:d2ae:9adb with SMTP id g3-20020a05600c310300b003edd2ae9adbmr6041571wmo.0.1679487238101;
        Wed, 22 Mar 2023 05:13:58 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n6-20020a5d4c46000000b002c55ec7f661sm13733724wrt.5.2023.03.22.05.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 05:13:57 -0700 (PDT)
Message-ID: <6f69983c-17bd-dd72-b941-95f55db10180@grimberg.me>
Date: Wed, 22 Mar 2023 14:13:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 15/18] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-16-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230321124325.77385-16-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_051400_210165_8C082E1E 
X-CRM114-Status: GOOD (  36.50  )
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



On 3/21/23 14:43, Hannes Reinecke wrote:
> Add functions to start the TLS handshake upcall.
> 
> Signed-off-by: Hannes Reincke <hare@suse.de>
> ---
>   drivers/nvme/target/tcp.c | 188 ++++++++++++++++++++++++++++++++++++--
>   1 file changed, 181 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 5c43767c5ecd..6e88e98a2c59 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -9,8 +9,10 @@
>   #include <linux/slab.h>
>   #include <linux/err.h>
>   #include <linux/nvme-tcp.h>
> +#include <linux/nvme-keyring.h>
>   #include <net/sock.h>
>   #include <net/tcp.h>
> +#include <net/handshake.h>
>   #include <linux/inet.h>
>   #include <linux/llist.h>
>   #include <crypto/hash.h>
> @@ -40,6 +42,14 @@ module_param(idle_poll_period_usecs, int, 0644);
>   MODULE_PARM_DESC(idle_poll_period_usecs,
>   		"nvmet tcp io_work poll till idle time period in usecs");
>   
> +/*
> + * TLS handshake timeout
> + */
> +static int tls_handshake_timeout = 30;

30 ?

> +module_param(tls_handshake_timeout, int, 0644);
> +MODULE_PARM_DESC(tls_handshake_timeout,
> +		 "nvme TLS handshake timeout in seconds (default 30)");
> +
>   #define NVMET_TCP_RECV_BUDGET		8
>   #define NVMET_TCP_SEND_BUDGET		8
>   #define NVMET_TCP_IO_WORK_BUDGET	64
> @@ -131,6 +141,9 @@ struct nvmet_tcp_queue {
>   	struct ahash_request	*snd_hash;
>   	struct ahash_request	*rcv_hash;
>   
> +	struct key		*tls_psk;
> +	struct delayed_work	tls_handshake_work;
> +
>   	unsigned long           poll_end;
>   
>   	spinlock_t		state_lock;
> @@ -168,6 +181,7 @@ static struct workqueue_struct *nvmet_tcp_wq;
>   static const struct nvmet_fabrics_ops nvmet_tcp_ops;
>   static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
>   static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
> +static void nvmet_tcp_tls_handshake_timeout_work(struct work_struct *work);
>   
>   static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
>   		struct nvmet_tcp_cmd *cmd)
> @@ -1400,6 +1414,8 @@ static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
>   {
>   	struct socket *sock = queue->sock;
>   
> +	if (!sock->sk)
> +		return;

Umm, when will the sock not have an sk?

>   	write_lock_bh(&sock->sk->sk_callback_lock);
>   	sock->sk->sk_data_ready =  queue->data_ready;
>   	sock->sk->sk_state_change = queue->state_change;
> @@ -1448,7 +1464,8 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
>   	list_del_init(&queue->queue_list);
>   	mutex_unlock(&nvmet_tcp_queue_mutex);
>   
> -	nvmet_tcp_restore_socket_callbacks(queue);
> +	if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE)
> +		nvmet_tcp_restore_socket_callbacks(queue);

This is because you only save the callbacks after the handshake
phase is done? Maybe it would be simpler to clear the ops because
the socket is going away anyways...

>   	cancel_work_sync(&queue->io_work);
>   	/* stop accepting incoming data */
>   	queue->rcv_state = NVMET_TCP_RECV_ERR;
> @@ -1469,6 +1486,8 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
>   	nvmet_tcp_free_cmds(queue);
>   	if (queue->hdr_digest || queue->data_digest)
>   		nvmet_tcp_free_crypto(queue);
> +	if (queue->tls_psk)
> +		key_put(queue->tls_psk);
>   	ida_free(&nvmet_tcp_queue_ida, queue->idx);
>   	page = virt_to_head_page(queue->pf_cache.va);
>   	__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
> @@ -1481,11 +1500,15 @@ static void nvmet_tcp_data_ready(struct sock *sk)
>   
>   	trace_sk_data_ready(sk);
>   
> -	read_lock_bh(&sk->sk_callback_lock);
> -	queue = sk->sk_user_data;
> -	if (likely(queue))
> -		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
> -	read_unlock_bh(&sk->sk_callback_lock);
> +	rcu_read_lock_bh();
> +	queue = rcu_dereference_sk_user_data(sk);
> +	if (queue->data_ready)
> +		queue->data_ready(sk);
> +	if (likely(queue) &&
> +	    queue->state != NVMET_TCP_Q_TLS_HANDSHAKE)
> +		queue_work_on(queue_cpu(queue), nvmet_tcp_wq,
> +			      &queue->io_work);
> +	rcu_read_unlock_bh();

Same comment as the host side. separate rcu stuff from data_ready call.

>   }
>   
>   static void nvmet_tcp_write_space(struct sock *sk)
> @@ -1585,13 +1608,139 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
>   		sock->sk->sk_write_space = nvmet_tcp_write_space;
>   		if (idle_poll_period_usecs)
>   			nvmet_tcp_arm_queue_deadline(queue);
> -		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
> +		queue_work_on(queue_cpu(queue), nvmet_tcp_wq,
> +			      &queue->io_work);

Why the change?

>   	}
>   	write_unlock_bh(&sock->sk->sk_callback_lock);
>   
>   	return ret;
>   }
>   
> +static void nvmet_tcp_tls_data_ready(struct sock *sk)
> +{
> +	struct socket_wq *wq;
> +
> +	rcu_read_lock();
> +	/* kTLS will change the callback */
> +	if (sk->sk_data_ready == nvmet_tcp_tls_data_ready) {
> +		wq = rcu_dereference(sk->sk_wq);
> +		if (skwq_has_sleeper(wq))
> +			wake_up_interruptible_all(&wq->wait);
> +	}
> +	rcu_read_unlock();
> +}

Can you explain why this is needed? It looks out-of-place.
Who is this waking up? isn't tls already calling the socket
default data_ready that does something similar for userspace?

> +
> +static void nvmet_tcp_tls_handshake_restart(struct nvmet_tcp_queue *queue)
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

My understanding is that this is the desired end-state, i.e.
tls connection is ready and now we are expecting nvme traffic?

I think that the function name should be changed, it sounds like
it is restarting the handshake, and it does not appear to do that.

> +}
> +
> +static void nvmet_tcp_save_tls_callbacks(struct nvmet_tcp_queue *queue)
> +{
> +	struct sock *sk = queue->sock->sk;
> +
> +	write_lock_bh(&sk->sk_callback_lock);
> +	rcu_assign_sk_user_data(sk, queue);
> +	queue->data_ready = sk->sk_data_ready;
> +	sk->sk_data_ready = nvmet_tcp_tls_data_ready;
> +	write_unlock_bh(&sk->sk_callback_lock);
> +}
> +
> +static void nvmet_tcp_restore_tls_callbacks(struct nvmet_tcp_queue *queue)
> +{
> +	struct sock *sk = queue->sock->sk;
> +
> +	if (WARN_ON(!sk))
> +		return;
> +	write_lock_bh(&sk->sk_callback_lock);
> +	/* Only reset the callback if it really is ours */
> +	if (sk->sk_data_ready == nvmet_tcp_tls_data_ready)

I still don't understand why our data_ready for tls is needed.
Who are

> +		sk->sk_data_ready = queue->data_ready;
> +	rcu_assign_sk_user_data(sk, NULL);
> +	queue->data_ready = NULL;
> +	write_unlock_bh(&sk->sk_callback_lock);
> +}
> +
> +static void nvmet_tcp_tls_handshake_done(void *data, int status,
> +					 key_serial_t peerid)
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
> +		}
> +		spin_unlock(&queue->state_lock);
> +	}
> +	cancel_delayed_work_sync(&queue->tls_handshake_work);
> +	nvmet_tcp_restore_tls_callbacks(queue);
> +	if (status)
> +		nvmet_tcp_schedule_release_queue(queue);
> +	else
> +		nvmet_tcp_tls_handshake_restart(queue);
> +}
> +
> +static void nvmet_tcp_tls_handshake_timeout_work(struct work_struct *w)
> +{
> +	struct nvmet_tcp_queue *queue = container_of(to_delayed_work(w),
> +			struct nvmet_tcp_queue, tls_handshake_work);
> +
> +	pr_debug("queue %d: TLS handshake timeout\n", queue->idx);
> +	nvmet_tcp_restore_tls_callbacks(queue);
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
> +	args.ta_sock = queue->sock;
> +	args.ta_done = nvmet_tcp_tls_handshake_done;
> +	args.ta_data = queue;
> +	args.ta_keyring = nvme_keyring_id();
> +	args.ta_timeout_ms = tls_handshake_timeout * 2 * 1024;

  why the 2x timeout?

> +
> +	ret = tls_server_hello_psk(&args, GFP_KERNEL);
> +	if (ret) {
> +		pr_err("failed to start TLS, err=%d\n", ret);
> +	} else {
> +		pr_debug("queue %d wakeup userspace\n", queue->idx);
> +		nvmet_tcp_tls_data_ready(queue->sock->sk);
> +		queue_delayed_work(nvmet_wq, &queue->tls_handshake_work,
> +				   tls_handshake_timeout * HZ);
> +	}
> +	return ret;
> +}
> +
>   static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>   		struct socket *newsock)
>   {
> @@ -1604,6 +1753,8 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>   
>   	INIT_WORK(&queue->release_work, nvmet_tcp_release_queue_work);
>   	INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
> +	INIT_DELAYED_WORK(&queue->tls_handshake_work,
> +			  nvmet_tcp_tls_handshake_timeout_work);
>   	queue->sock = newsock;
>   	queue->port = port;
>   	queue->nr_cmds = 0;
> @@ -1646,6 +1797,29 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>   	list_add_tail(&queue->queue_list, &nvmet_tcp_queue_list);
>   	mutex_unlock(&nvmet_tcp_queue_mutex);
>   
> +	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
> +		nvmet_tcp_save_tls_callbacks(queue);
> +		if (!nvmet_tcp_tls_handshake(queue))
> +			return;
> +		nvmet_tcp_restore_tls_callbacks(queue);
> +
> +		/*
> +		 * If sectype is set to 'tls1.3' TLS is required
> +		 * so terminate the connection if the TLS handshake
> +		 * failed.
> +		 */
> +		if (queue->port->nport->disc_addr.tsas.tcp.sectype ==
> +		    NVMF_TCP_SECTYPE_TLS13) {
> +			pr_debug("queue %d sectype tls1.3, terminate connection\n",
> +				 queue->idx);
> +			goto out_destroy_sq;
> +		}
> +		pr_debug("queue %d fallback to icreq\n", queue->idx);
> +		spin_lock(&queue->state_lock);
> +		queue->state = NVMET_TCP_Q_CONNECTING;
> +		spin_unlock(&queue->state_lock);
> +	}
> +
>   	ret = nvmet_tcp_set_queue_sock(queue);
>   	if (ret)
>   		goto out_destroy_sq;

I'm still trying to learn the state machine here, can you share a few 
words on it? Also please include it in the next round in the change log.

