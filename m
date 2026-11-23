Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4540A606A31F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 08:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4mWa5KSS;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bwHeyV4e;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7TQ6p7yx;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=S3aMWpnQ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=EEVVx+f4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=cVdkjZcu7zAJ6PrpW5zx6rDzwJZVY4gtOGIBtdWuyS4=; b=4mWa5KSSXJbnHB
	4nAJ2Yn9bzyO0j3WOCUChNBeOnMBTyxEPP5CKFXD4gU+ZFJVIHP6MjEriQDZ3Ipdx5rZKLg7gzZRd
	dQDdkBv2URefttDJn+NQrioBZymQYpUeswYBHHDqbvYzUzEik770sbAPcun4gDZ8gJL9lpHtusiT7
	CMd5VosJImdnZcExTaHFfP1rWQW2XlCcR0HQONc5I8qnZLTX6mopJMgcZr6PbzBgGncFVbwULKiI0
	Dz3d7QjvfhqwFqSJGENYVQhqdL1SgsagYDZpFZpehWepXiA8stZ7M+D3MhF7yA86emhhacpvk2mKP
	HpNIAGENTAS6JP8qBo3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVPAA-00000002XjS-16At;
	Mon, 23 Nov 2026 08:12:34 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVP9u-00000002Xim-3F1t
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 08:12:25 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A5F911F7D4;
	Mon, 23 Nov 2026 08:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795421534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVdkjZcu7zAJ6PrpW5zx6rDzwJZVY4gtOGIBtdWuyS4=;
	b=bwHeyV4eAH2ONzs/qod/qQYwV+4gg9OvRg41XQBh/L/Ic9h28SfIREL2fof4Ljbc+7m16C
	hjMOZd0HinWLsk92fEwGNpZRxmtvBFe7snFaBJgXUyP5wkMlZyx799iNulGL69NFxfUc//
	UIPHJmj5LnsQaefm8voIlVBVKIbJfCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795421534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVdkjZcu7zAJ6PrpW5zx6rDzwJZVY4gtOGIBtdWuyS4=;
	b=7TQ6p7yxKlPwp5S1jG7Kr8KveOV8NXg/pcSkKqHlAdVRVGQ+onlyvdvHN0d0+oj+ZacfeO
	7OSY/NtZytp32hDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=S3aMWpnQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EEVVx+f4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795421532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVdkjZcu7zAJ6PrpW5zx6rDzwJZVY4gtOGIBtdWuyS4=;
	b=S3aMWpnQY0E8YwNsoMOBVtAxTByOyn4Bna3tsmXwgrnjnTld0QN68yzRVXlPPLjvhG3s0O
	8lblUanrrLrAp3VQviG8nfpONwWLoyZ9ZU2Qb9jcvzhqTaMIWTIm+hVMXBWG/pzbw9FBae
	1DcnAG/TP1hcLYJVs8Td+Q3jFucG990=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795421532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVdkjZcu7zAJ6PrpW5zx6rDzwJZVY4gtOGIBtdWuyS4=;
	b=EEVVx+f4zqkyCAhUsVYrdXtcqB72NgpAlLnJFUYvD0bGbOF+dIGfmVfqKNir+jpRvcqp85
	ITv2fjhN/6oD6vBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5130F13510;
	Mon, 23 Nov 2026 08:12:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id buuCBlz1A2tqUwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Nov 2026 08:12:12 +0000
Message-ID: <95a4bbac-9f88-4da1-9a48-406a6152344a@suse.de>
Date: Mon, 23 Nov 2026 09:12:11 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvmet: Synchronize the TLS key debugfs read with admin
 queue teardown
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261116075447.1713255-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261116075447.1713255-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A5F911F7D4
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.50
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_001220_511264_D14D7DB6 
X-CRM114-Status: GOOD (  25.08  )
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

On 11/16/26 8:54 AM, Guixin Liu wrote:
> nvmet_ctrl_tls_key_show() dereferences ctrl->sqs[0] and its tls_key
> without any synchronization.  The admin queue may not be installed
> yet or be destroyed concurrently, and nvmet_sq_put_tls_key() can drop
> the key reference while a reader is looking at it, leading to NULL or
> use-after-free dereferences.
> 
> Take the admin queue's percpu reference for the duration of the read
> so the queue cannot be torn down, and use ctrl->lock to serialize with
> nvmet_sq_put_tls_key() so the key cannot be dropped mid-read.
> 
> Fixes: 316dabe6089fe ("nvmet: add tls_concat and tls_key debugfs entries")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> 
> Changes since v2:
> - Take the admin queue's percpu reference during the read and use
>    ctrl->lock to serialize with nvmet_sq_put_tls_key(), so the queue
>    and its key cannot go away mid-read (Christoph Hellwig)
> Link: https://lore.kernel.org/all/20261029034306.3626274-1-kanie@linux.alibaba.com/
> 
> Changes since v1:
> - Simply return 0 when the admin queue is absent in
>    nvmet_queue_tls_keyid() instead of dereferencing it, covering the
>    not-yet-created and already-destroyed windows (Hannes Reinecke)
> Link: https://lore.kernel.org/all/20261028064417.548948-1-kanie@linux.alibaba.com/
>   drivers/nvme/target/debugfs.c | 15 +++++++++++++--
>   drivers/nvme/target/nvmet.h   |  4 ++++
>   2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
> index e85fe1d4c9f8..cc451e25ea1d 100644
> --- a/drivers/nvme/target/debugfs.c
> +++ b/drivers/nvme/target/debugfs.c
> @@ -136,8 +136,19 @@ NVMET_DEBUGFS_ATTR(nvmet_ctrl_host_traddr);
>   static int nvmet_ctrl_tls_key_show(struct seq_file *m, void *p)
>   {
>   	struct nvmet_ctrl *ctrl = m->private;
> -	key_serial_t keyid = nvmet_queue_tls_keyid(ctrl->sqs[0]);
> -
> +	struct nvmet_sq *sq = ctrl->sqs[0];
> +	key_serial_t keyid = 0;
> +
> +	/*
> +	 * Pin the admin queue against teardown, and serialize with
> +	 * nvmet_sq_put_tls_key() so the key cannot be dropped mid-read.
> +	 */
> +	if (sq && percpu_ref_tryget_live(&sq->ref)) {
> +		mutex_lock(&ctrl->lock);
> +		keyid = nvmet_queue_tls_keyid(sq);
> +		mutex_unlock(&ctrl->lock);
> +		percpu_ref_put(&sq->ref);
> +	}
>   	seq_printf(m, "%08x\n", keyid);
>   	return 0;
>   }
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index e315f1c24e73..24df9e4a1e1c 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -957,13 +957,17 @@ static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
>   #ifdef CONFIG_NVME_TARGET_TCP_TLS
>   static inline key_serial_t nvmet_queue_tls_keyid(struct nvmet_sq *sq)
>   {
> +	if (!sq)
> +		return 0;
>   	return sq->tls_key ? key_serial(sq->tls_key) : 0;
>   }
>   static inline void nvmet_sq_put_tls_key(struct nvmet_sq *sq)
>   {
>   	if (sq->tls_key) {
> +		mutex_lock(&sq->ctrl->lock);
>   		key_put(sq->tls_key);
>   		sq->tls_key = NULL;
> +		mutex_unlock(&sq->ctrl->lock);
>   	}
>   }
>   #else

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

