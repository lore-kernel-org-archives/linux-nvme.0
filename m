Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B17606A336
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 07:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uiHkEM2d;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NKUybNhg;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=s22wug8P;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NKUybNhg;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=s22wug8P
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=jx9UPICr8TUjnwraIuiW1d+YjlKzR0kQdOlVfdm2FuE=; b=uiHkEM2dq4kg02
	ROtL7wB+ZEMRvArZ2fFYeBc+o19F8gZwtSSIV38upbg5UX+vptr53m6/0+pkeN4qzzZoI+WctzdzR
	1/sS+ZcIpSyu1fpnt6BEDgQ8K1NdHdVVkUA36DRk/OWYje1++NZjWtuQ+rPn9Wqmq1fUpf1xugf+z
	MUNzEWNmpa2yGYtAVWk+giBU0d0409A5gAi1LtPL1WG0BHqm0wEsxtM+y9/BzFmWzClswfCQ09NIl
	IOPD5dDDF1oeZAK4heBGzxqOgUWgDLUObBF0pGRmWMfYFtEg82hAbeL11fKh68OYcrn+S61bFpW3E
	s2eJ9x/eJ/Id+ObmJ2sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLyG6-00000006Tcx-0WX6;
	Wed, 28 Oct 2026 07:39:42 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLyG2-00000006Tca-3Mzd
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 07:39:40 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2E570220D6;
	Wed, 28 Oct 2026 07:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793173175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jx9UPICr8TUjnwraIuiW1d+YjlKzR0kQdOlVfdm2FuE=;
	b=NKUybNhgZIA4qcnPN6KhQAYV2pmrCCQOdKO//lq44/YuOJI5d8Wp9x2z1lY5lr+bfAhF2j
	0bArtD4QKYHEdzVJy1k5XFUMw4g32u5a+ccu2cZkY4VxqNSfnGxJL05msUPSuPpIIWzEFc
	u5LQvjpy9tizJ7/iDIlY9EnxiEo2IJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793173175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jx9UPICr8TUjnwraIuiW1d+YjlKzR0kQdOlVfdm2FuE=;
	b=s22wug8P9y2CaFQFOuTcMmuGbGAMLRyftTLlDg7wRxF6V82fmeBsPlVf87aDunA+jbz2z6
	0aohOxOdh3diw1Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NKUybNhg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=s22wug8P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793173175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jx9UPICr8TUjnwraIuiW1d+YjlKzR0kQdOlVfdm2FuE=;
	b=NKUybNhgZIA4qcnPN6KhQAYV2pmrCCQOdKO//lq44/YuOJI5d8Wp9x2z1lY5lr+bfAhF2j
	0bArtD4QKYHEdzVJy1k5XFUMw4g32u5a+ccu2cZkY4VxqNSfnGxJL05msUPSuPpIIWzEFc
	u5LQvjpy9tizJ7/iDIlY9EnxiEo2IJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793173175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jx9UPICr8TUjnwraIuiW1d+YjlKzR0kQdOlVfdm2FuE=;
	b=s22wug8P9y2CaFQFOuTcMmuGbGAMLRyftTLlDg7wRxF6V82fmeBsPlVf87aDunA+jbz2z6
	0aohOxOdh3diw1Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9935F1321C;
	Wed, 28 Oct 2026 07:39:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tOsEGram4WrMSwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 28 Oct 2026 07:39:34 +0000
Message-ID: <57d42eb1-bcad-40ff-a8c0-8739347a73a1@suse.de>
Date: Wed, 28 Oct 2026 08:39:34 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-tcp: fix NULL queue->ctrl dereference on
 reconnect
To: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>,
 linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 hare@kernel.org, sgogte@purestorage.com, wagi@kernel.org,
 kanie@linux.alibaba.com, nilay@linux.ibm.com, linux-kernel@vger.kernel.org
References: <20261028024309.1398623-1-christian.aurichzm@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261028024309.1398623-1-christian.aurichzm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-12.00 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -12.00
X-Spam-Level: 
X-Rspamd-Queue-Id: 2E570220D6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_003939_141741_34A5E68A 
X-CRM114-Status: GOOD (  36.05  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 3:43 AM, Christian Aurich Zanettini Martins wrote:
> Since commit 61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation
> and startup"), a reconnect that gets more I/O queues than before grows
> the tag set before the new queues are allocated. queue->ctrl is only
> set by nvme_tcp_alloc_queue(), so I/O submitted in between reaches
> nvme_tcp_queue_rq() on a queue that was never allocated and
> dereferences a NULL queue->ctrl:
> 
>    BUG: kernel NULL pointer dereference, address: 00000000000002ac
>    RIP: 0010:nvme_tcp_queue_rq+0x33/0x3b0
> 
> Add nvme_tcp_init_queue() for the queue fields that do not depend on
> the connection and call it for every queue when allocating the
> controller. Such requests are then requeued like on any other queue
> that is not live. send_mutex and io_work move there as well, and the
> helper's mutexes are all destroyed when the controller is freed, like
> queue_lock already is.
> 
> Fixes: 61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation and startup")
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
> ---
> v2:
> - Rebase on Guixin's v4 "nvme-tcp: Validate the queue state under the
>    queue lock in the address attribute" and move its queue_lock init
>    into the helper
> - Also move send_mutex and io_work into the helper, and destroy
>    send_mutex and pf_cache_lock next to queue_lock in
>    nvme_tcp_free_ctrl() (Keith)
> - Left in nvme_tcp_alloc_queue(): req_list and send_list, as resetting
>    them drops entries left over from the previous connection, and the
>    lockdep keys, which are per socket instance since commit 19bdb70c77d3
>    ("nvme-tcp: lockdep: use dynamic lockdep keys per socket instance")
> 
> Based on nvme-7.4 (9afc1b71d963) with "nvme-tcp: fix request PDU size
> when header digest is enabled" and Guixin's v4 on top. The last hunk
> assumes the conflict between those two in nvme_tcp_alloc_ctrl() is
> resolved by keeping both loop bodies and both comments. I can resend on
> top of nvme-7.4 once both are there.
> 
> Reproduced in QEMU with nvmet-tcp over loopback and
> CONFIG_NVME_MULTIPATH=n: connect with attr_qid_max=2, keep direct reads
> running on the CPUs that map to the new hw queues, then raise
> attr_qid_max to 4. Before the patch the host oopsed as above within two
> tries in each of three boots; with v2, 8 of 8 tries went live, with and
> without lockdep. 30 resets under digest I/O, with a reader looping on
> the address attribute, also pass and are clean with lockdep.
> 
>   drivers/nvme/host/tcp.c | 58 ++++++++++++++++++++---------------------
>   1 file changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 4ada1ff120e2..77bc530ae0a6 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1559,7 +1559,6 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
>   	memalloc_noio_restore(noio_flag);
>   
>   	kfree(queue->pdu);
> -	mutex_destroy(&queue->send_mutex);
>   
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   	lockdep_unregister_key(&queue->nvme_tcp_sk_key);
> @@ -1987,6 +1986,26 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>   	return ret;
>   }
>   
> +/*
> + * The I/O tag set is allocated, and grown on reconnect, before the queues are
> + * connected, so blk-mq can initialize requests on a queue, and dispatch to it,
> + * before nvme_tcp_alloc_queue() has run for it. Set up the fields that do not
> + * depend on the connection once, when allocating the controller, and keep them
> + * until the controller is freed.
> + */
> +static void nvme_tcp_init_queue(struct nvme_tcp_ctrl *ctrl, int qid)
> +{
> +	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
> +
> +	queue->ctrl = ctrl;
> +	mutex_init(&queue->queue_lock);
> +	mutex_init(&queue->send_mutex);
> +	mutex_init(&queue->pf_cache_lock);
> +	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
> +	queue->hdr_digest = ctrl->ctrl.opts->hdr_digest;
> +	queue->data_digest = ctrl->ctrl.opts->data_digest;
> +}
> +
>   static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>   				key_serial_t pskid)
>   {
> @@ -1995,11 +2014,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>   	int ret, rcv_pdu_size;
>   	struct file *sock_file;
>   
> -	queue->ctrl = ctrl;
>   	init_llist_head(&queue->req_list);
>   	INIT_LIST_HEAD(&queue->send_list);
> -	mutex_init(&queue->send_mutex);
> -	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
>   
>   	if (qid > 0)
>   		queue->cmnd_capsule_len = nctrl->ioccsz * 16;
> @@ -2013,14 +2029,12 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>   	if (ret) {
>   		dev_err(nctrl->device,
>   			"failed to create socket: %d\n", ret);
> -		goto err_destroy_mutex;
> +		return ret;
>   	}
>   
>   	sock_file = sock_alloc_file(queue->sock, O_CLOEXEC, NULL);
> -	if (IS_ERR(sock_file)) {
> -		ret = PTR_ERR(sock_file);
> -		goto err_destroy_mutex;
> -	}
> +	if (IS_ERR(sock_file))
> +		return PTR_ERR(sock_file);
>   
>   	sk_net_refcnt_upgrade(queue->sock->sk);
>   
> @@ -2088,8 +2102,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>   		}
>   	}
>   
> -	queue->data_digest = nctrl->opts->data_digest;
> -
>   	rcv_pdu_size = sizeof(struct nvme_tcp_rsp_pdu) +
>   			nvme_tcp_hdgst_len(queue);
>   	queue->pdu = kmalloc(rcv_pdu_size, GFP_KERNEL);
> @@ -2136,8 +2148,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>   	lockdep_unregister_key(&queue->nvme_tcp_sk_key);
>   	lockdep_unregister_key(&queue->nvme_tcp_slock_key);
>   #endif
> -err_destroy_mutex:
> -	mutex_destroy(&queue->send_mutex);
>   	return ret;
>   }
>   
> @@ -2838,8 +2848,11 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
>   	nvmf_free_options(nctrl->opts);
>   free_ctrl:
>   	put_net(ctrl->net);
> -	for (i = 0; i < nr_queues; i++)
> +	for (i = 0; i < nr_queues; i++) {
>   		mutex_destroy(&ctrl->queues[i].queue_lock);
> +		mutex_destroy(&ctrl->queues[i].send_mutex);
> +		mutex_destroy(&ctrl->queues[i].pf_cache_lock);
> +	}

Might be an idea to use a new function 'nvme_tcp_exit_queue()'
here for symmetry with 'nvme_tcp_init_queue()'.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

