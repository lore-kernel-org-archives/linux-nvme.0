Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6775ECCA471
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Oct 2025 06:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NpUvoeKLIuqMWTPdrpet/and2sXN8W5qIkfOI+cEG2M=; b=GxNAyB1pnl9YyGUdjtCGc3kslI
	O5eV0ElMS+qxWa6FDZpYyQQhxQNMMLGQjr/Tw8+UJZSduRNFg6zYY5m0jjDefZI5mAtyz/aMtkF3U
	C12pRvNagB2AkSvgyM0gnFMKyvDe2YTrJ/ipwb0ph855jd8qkOaM7AyTmq1qKZ8PGDaGbyk5JTwq4
	hDFfVMTbeNPRK5Cd4i5KnSgy+Dsmfyrq3nL/D1crnKJ7jC/qz6VZWtUvAjKBxEPfcWqR12o/3+9RT
	22gwSEf8ezSFQeTjreN2dsLiBDn15AKgk2rd0sr1e0IeG6KSstrOlUEknFKM9JqWdvPxSsfVsp7Z4
	I8Ubou3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5f1g-0000000H2jk-0ORC;
	Mon, 06 Oct 2025 06:48:52 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5f1d-0000000H2jG-14Pw
	for linux-nvme@lists.infradead.org;
	Mon, 06 Oct 2025 06:48:50 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E52A73373A;
	Mon,  6 Oct 2025 06:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759733327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NpUvoeKLIuqMWTPdrpet/and2sXN8W5qIkfOI+cEG2M=;
	b=yPVzsExuahN6HcqCHykof2acT0mRWibd0R+fEqT16Ko4VhkfC8Oj+QmaykYTVksvqWmJYz
	SfzCFLr7jcbLlqn6mkTryepghUoihNPvSCeT8bIKxf36uv65+orOvroH9UXpunldb7GO8p
	9OBn6kTpHDH6+vEP9Tjw4GoxsyOM/Y0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759733327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NpUvoeKLIuqMWTPdrpet/and2sXN8W5qIkfOI+cEG2M=;
	b=vlNwZdof4iPR4tYwjduG5C5R9bs07NJuO4ysdxagSGdJFm8JrCip0Uf/MZh7padnIJ64kO
	tay4fvJQsSYoMEBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TQ3inaQc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="J/z3+ZDK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759733325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NpUvoeKLIuqMWTPdrpet/and2sXN8W5qIkfOI+cEG2M=;
	b=TQ3inaQc5nz0VhfvuCMo2aWTTXA8u3YO7/xGz4z2IOXMNdyIb95NNz/CNhrjHZI0PIhsIN
	xEf6jr8E0pGvXyBnT+cLxn8YzMti8FqRhgBaA34lYsDl4DNxXztI32/2CwwEFXngebI+GR
	pj8tGrjY2bD107nNdKif+CD2RFRguSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759733325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NpUvoeKLIuqMWTPdrpet/and2sXN8W5qIkfOI+cEG2M=;
	b=J/z3+ZDKo7t3KVOUM6H40w9+izg5ACiN5rdeFjUK5wFio5Iq6Rpo4zHJSmQGiNandlQSzj
	N9OLfvv+a9sKaxAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CDEA13995;
	Mon,  6 Oct 2025 06:48:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UIY7GE1m42jUDgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 06 Oct 2025 06:48:45 +0000
Message-ID: <591a7eb8-563c-4368-b868-880ed081a432@suse.de>
Date: Mon, 6 Oct 2025 08:48:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] nvmet-tcp: Support KeyUpdate
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, Alistair Francis <alistair.francis@wdc.com>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
 <20251003043140.1341958-8-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251003043140.1341958-8-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,ietf.org:url,suse.de:mid,suse.de:dkim,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: E52A73373A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251005_234849_455593_151F7004 
X-CRM114-Status: GOOD (  35.96  )
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

On 10/3/25 06:31, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> If the nvmet_tcp_try_recv() function return EKEYEXPIRED or if we receive
> a KeyUpdate handshake type then the underlying TLS keys need to be
> updated.
> 
> If the NVMe Host (TLS client) initiates a KeyUpdate this patch will
> allow the NVMe layer to process the KeyUpdate request and forward the
> request to userspace. Userspace must then update the key to keep the
> connection alive.
> 
> This patch allows us to handle the NVMe host sending a KeyUpdate
> request without aborting the connection. At this time we don't support
> initiating a KeyUpdate.
> 
> Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v3:
>   - Use a write lock for sk_user_data
>   - Fix build with CONFIG_NVME_TARGET_TCP_TLS disabled
>   - Remove unused variable
> v2:
>   - Use a helper function for KeyUpdates
>   - Ensure keep alive timer is stopped
>   - Wait for TLS KeyUpdate to complete
> 
>   drivers/nvme/target/tcp.c | 90 ++++++++++++++++++++++++++++++++++++---
>   1 file changed, 85 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index bee0355195f5..fd59dd3ca632 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -175,6 +175,7 @@ struct nvmet_tcp_queue {
>   
>   	/* TLS state */
>   	key_serial_t		tls_pskid;
> +	key_serial_t		user_session_id;
>   	struct delayed_work	tls_handshake_tmo_work;
>   
>   	unsigned long           poll_end;
> @@ -186,6 +187,8 @@ struct nvmet_tcp_queue {
>   	struct sockaddr_storage	sockaddr_peer;
>   	struct work_struct	release_work;
>   
> +	struct completion       tls_complete;
> +
>   	int			idx;
>   	struct list_head	queue_list;
>   
> @@ -836,6 +839,11 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
>   	return 1;
>   }
>   
> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue);
> +static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w);
> +#endif
> +
>   static int nvmet_tcp_try_send(struct nvmet_tcp_queue *queue,
>   		int budget, int *sends)
>   {

And we need this why?

> @@ -844,6 +852,13 @@ static int nvmet_tcp_try_send(struct nvmet_tcp_queue *queue,
>   	for (i = 0; i < budget; i++) {
>   		ret = nvmet_tcp_try_send_one(queue, i == budget - 1);
>   		if (unlikely(ret < 0)) {
> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +			if (ret == -EKEYEXPIRED &&
> +				queue->state != NVMET_TCP_Q_DISCONNECTING &&
> +				queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
> +					goto done;
> +			}
> +#endif
>   			nvmet_tcp_socket_error(queue, ret);
>   			goto done;
>   		} else if (ret == 0) {

See my comment to the host patches. Handling an incoming KeyUpdate is
vastly different than initiating a KeyUpdate. _and_ the network stack
will only ever return -EKEYEXPIRED on receive.
So please split the patches in handling an incoming KeyUpdate and
initiating a KeyUpdate.

> @@ -1110,6 +1125,45 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
>   	return false;
>   }
>   
> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +static int update_tls_keys(struct nvmet_tcp_queue *queue)
> +{
> +	int ret;
> +
> +	cancel_work(&queue->io_work);
> +	queue->state = NVMET_TCP_Q_TLS_HANDSHAKE;
> +
> +	/* Restore the default callbacks before starting upcall */
> +	write_lock_bh(&queue->sock->sk->sk_callback_lock);
> +	queue->sock->sk->sk_data_ready =  queue->data_ready;
> +	queue->sock->sk->sk_state_change = queue->state_change;
> +	queue->sock->sk->sk_write_space = queue->write_space;
> +	queue->sock->sk->sk_user_data = NULL;
> +	write_unlock_bh(&queue->sock->sk->sk_callback_lock);
> +
We do have a function for this ...

> +	nvmet_stop_keep_alive_timer(queue->nvme_sq.ctrl);
> +
> +	INIT_DELAYED_WORK(&queue->tls_handshake_tmo_work,
> +			  nvmet_tcp_tls_handshake_timeout);
> +
> +	ret = nvmet_tcp_tls_handshake(queue, HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = wait_for_completion_interruptible_timeout(&queue->tls_complete, 10 * HZ);
> +
> +	if (ret <= 0) {
> +		tls_handshake_cancel(queue->sock->sk);
> +		return ret;
> +	}
> +
> +	queue->state = NVMET_TCP_Q_LIVE;
> +
> +	return ret;
> +}
> +#endif
> +
>   static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
>   		struct msghdr *msg, char *cbuf)
>   {
> @@ -1135,6 +1189,9 @@ static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
>   			ret = -EAGAIN;
>   		}
>   		break;
> +	case TLS_RECORD_TYPE_HANDSHAKE:
> +		ret = -EAGAIN;
> +		break;

Shouldn't this be rather -EKEYEXPIRED?

>   	default:
>   		/* discard this record type */
>   		pr_err("queue %d: TLS record %d unhandled\n",
> @@ -1344,6 +1401,13 @@ static int nvmet_tcp_try_recv(struct nvmet_tcp_queue *queue,
>   	for (i = 0; i < budget; i++) {
>   		ret = nvmet_tcp_try_recv_one(queue);
>   		if (unlikely(ret < 0)) {
> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +			if (ret == -EKEYEXPIRED &&
> +				queue->state != NVMET_TCP_Q_DISCONNECTING &&
> +				queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
> +					goto done;
> +			}
> +#endif
>   			nvmet_tcp_socket_error(queue, ret);
>   			goto done;
>   		} else if (ret == 0) {
> @@ -1408,14 +1472,26 @@ static void nvmet_tcp_io_work(struct work_struct *w)
>   		ret = nvmet_tcp_try_recv(queue, NVMET_TCP_RECV_BUDGET, &ops);
>   		if (ret > 0)
>   			pending = true;
> -		else if (ret < 0)
> -			return;
> +		else if (ret < 0) {
> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +			if (ret == -EKEYEXPIRED)
> +				update_tls_keys(queue);
> +			else
> +#endif
> +				return;
> +		}
>   
>   		ret = nvmet_tcp_try_send(queue, NVMET_TCP_SEND_BUDGET, &ops);
>   		if (ret > 0)
>   			pending = true;
> -		else if (ret < 0)
> -			return;
> +		else if (ret < 0) {
> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +			if (ret == -EKEYEXPIRED)
> +				update_tls_keys(queue);
> +			else
> +#endif
> +				return;
> +		}
>   
>   	} while (pending && ops < NVMET_TCP_IO_WORK_BUDGET);
>   
Wouldn't it be better to move the call to 'update_tls_keys()' out of
the loop and just requeue io_work afterwards?
> @@ -1798,6 +1874,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
>   	}
>   	if (!status) {
>   		queue->tls_pskid = peerid;
> +		queue->user_session_id = user_session_id;
>   		queue->state = NVMET_TCP_Q_CONNECTING;
>   	} else
>   		queue->state = NVMET_TCP_Q_FAILED;
> @@ -1813,6 +1890,7 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
>   	else
>   		nvmet_tcp_set_queue_sock(queue);
>   	kref_put(&queue->kref, nvmet_tcp_release_queue);
> +	complete(&queue->tls_complete);
>   }
>   
>   static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w)
> @@ -1843,7 +1921,7 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
>   	int ret = -EOPNOTSUPP;
>   	struct tls_handshake_args args;
>   
> -	if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
> +	if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE && !keyupdate) {
>   		pr_warn("cannot start TLS in state %d\n", queue->state);
>   		return -EINVAL;
> 
Why? Shouldn't we always set the HANDSHAKE state?

> @@ -1856,7 +1934,9 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
>   	args.ta_data = queue;
>   	args.ta_keyring = key_serial(queue->port->nport->keyring);
>   	args.ta_timeout_ms = tls_handshake_timeout * 1000;
> +	args.user_session_id = queue->user_session_id;
>   
> +	init_completion(&queue->tls_complete);
>   	ret = tls_server_hello_psk(&args, GFP_KERNEL, keyupdate);
>   	if (ret) {
>   		kref_put(&queue->kref, nvmet_tcp_release_queue)

Cheers,
Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

