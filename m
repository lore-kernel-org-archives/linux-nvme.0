Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC3D606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 06:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lr7JbPCj;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gZVHdfnV;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Q4TxoMZM;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gZVHdfnV;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Q4TxoMZM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=+upM9FcdM21Y3pHiUV+kEBBTYJ7A8bNcoDc1BYiymQU=; b=lr7JbPCjp1XIoi
	SqxJWS0b2cCw7zYgNrk5gRpzFNPkXXuXWQNQI/xkmxurwSvrxSj5QlGKMrLM6L4dgDAjHJ9OGN41W
	tTxJcSXXikzQaF+/9uBeuDjq41+nCpgODW0zae2EK3KuZe92OCeX0y71r6WDd2SzwwbxUhAY1SW3d
	Z+pcZS4QTlKKHt85cyNeV+QLIYVbw33k7h3/2xSe73ThgszxdGzZSktq2IjyCvT5wt6AepX6T2NJT
	QbivUadz4FiayScVnYCNDbPiEOXhp1I4LL/Im/B1GU+mbinjjpIkwycTFO15JmSGO+JVmUDtRz+ei
	AGfE2gYJwkTzgaKfGTpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK8uo-0000000FazR-37gf;
	Fri, 23 Oct 2026 06:38:10 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK8um-0000000Fayr-2WK1
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 06:38:09 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F08822262;
	Fri, 23 Oct 2026 06:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792737485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+upM9FcdM21Y3pHiUV+kEBBTYJ7A8bNcoDc1BYiymQU=;
	b=gZVHdfnVPEvuySbIcGqlW0+8yJn4crvt/kqK7cK1HztPKg5rSFOBqXKEeLw/IplNEgMu0G
	Eo8BWs3bHS/tkVF75JIcvBhII/DqPRFEjzN81bk0jg686+8vMPjPMNkySQICr3VzahlCZ8
	1d4mkxD7stCPtEiTnS0WWsSeLnQBtSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792737485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+upM9FcdM21Y3pHiUV+kEBBTYJ7A8bNcoDc1BYiymQU=;
	b=Q4TxoMZM2ZsQhs1ja775M5drNOMgv1sM99uG9l7a21yl+pFeG77TxFDLXrWu+y+aDugNnA
	wjfSqkX0U3GpdoDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792737485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+upM9FcdM21Y3pHiUV+kEBBTYJ7A8bNcoDc1BYiymQU=;
	b=gZVHdfnVPEvuySbIcGqlW0+8yJn4crvt/kqK7cK1HztPKg5rSFOBqXKEeLw/IplNEgMu0G
	Eo8BWs3bHS/tkVF75JIcvBhII/DqPRFEjzN81bk0jg686+8vMPjPMNkySQICr3VzahlCZ8
	1d4mkxD7stCPtEiTnS0WWsSeLnQBtSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792737485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+upM9FcdM21Y3pHiUV+kEBBTYJ7A8bNcoDc1BYiymQU=;
	b=Q4TxoMZM2ZsQhs1ja775M5drNOMgv1sM99uG9l7a21yl+pFeG77TxFDLXrWu+y+aDugNnA
	wjfSqkX0U3GpdoDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5B9D133F6;
	Fri, 23 Oct 2026 06:38:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ItevHswA22o9EQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 23 Oct 2026 06:38:04 +0000
Message-ID: <b7f546ea-2365-461f-a103-09cdaeeac31f@suse.de>
Date: Fri, 23 Oct 2026 08:38:04 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: wait for in-flight TLS handshake callback
To: Avi Weiss <thnkslprpt@gmail.com>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20261022071934.3818224-1-thnkslprpt@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261022071934.3818224-1-thnkslprpt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.29
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_233808_787600_A8F69C4C 
X-CRM114-Status: GOOD (  19.42  )
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
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 9:19 AM, Avi Weiss wrote:
> When nvme_tcp_start_tls() times out or is interrupted,
> tls_handshake_cancel() can return false after handshake_complete()
> marks the request completed, but before nvme_tcp_tls_done()
> finishes. Error cleanup can then release the queue while the
> callback still accesses it.
> 
> Wait for queue->tls_complete when cancellation loses, before
> continuing cleanup. Preserve the original timeout or signal error.
> 
> This follows the cancellation/completion synchronization used
> in SunRPC for:
> - commit d00e32f84ca1 ("sunrpc: wait for in-flight TLS handshake
>    callback when cancel loses race")
> - commit a89dd5974588 ("SUNRPC: wait for in-flight client TLS
>    handshake callback")
> 
> Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
> ---
>   drivers/nvme/host/tcp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 7eec983c0ead..26a626abef7b 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1816,7 +1816,8 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>   		dev_err(nctrl->device,
>   			"queue %d: TLS handshake failed, error %d\n",
>   			qid, ret);
> -		tls_handshake_cancel(queue->sock->sk);
> +		if (!tls_handshake_cancel(queue->sock->sk))
> +			wait_for_completion(&queue->tls_complete);
>   	} else {
>   		if (queue->tls_err) {
>   			dev_err(nctrl->device,
> 
> base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

