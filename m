Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4586606A31A
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KfU3iK1+;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qi2N0Y9q;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ojZIl4B6;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jOeS8eCt;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=d60X7RGx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=gI7E+robBP6vgz9AL/HxFuX0LqTlbehBrFtgVWJIAYw=; b=KfU3iK1+U8DfgT
	CwKU7sDhyBDWCBFytmqv4D2SaV698p5hs/AyvOCQMK/i3M89Bn0pT2Z2uOMDE5AkXht59qsIf19Y+
	OdJDY6eNnlzWHRGt51ANeoE7lyO39Jt0Yib/f91qKx9pBXZq4mL9lGFMBAi25ArhQWnYThwdbZop5
	+TQ49LciWbHDnpCs9J2NePrkavd+iLS6bNsl1KEm35GGLlj2WyI7ciWx+CEoniARAQV+wvoKjj8zw
	AQyQ/RXiBEyuxchTS3EVf6a3sLgF+pmkwKFfhq4oIqDYlni9TWeJsWT0BhfnPL4UkEq7E0W/vuVwF
	aRuK18sjGCavp0sF4TNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLbdz-00000003u4v-1DO8;
	Tue, 27 Oct 2026 07:30:51 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLbdv-00000003u4J-43j9
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 07:30:49 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DF8C51F791;
	Tue, 27 Oct 2026 07:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793086244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gI7E+robBP6vgz9AL/HxFuX0LqTlbehBrFtgVWJIAYw=;
	b=qi2N0Y9qCDuQb8ebeIIjVbVCIG2MJId/A6sTYauxyk5lkMSgBdiYSrrxHlf/inlq6rEULp
	Nuj4w4BlGQ+LGK8xCION3ccvQ5YaOOetRJM/6Jd1f2XxbtSYKvH5H+WlW6aSgH15HIy4TY
	jeuRxp7P54b8b4m8XI4PNYkGlKwoNs8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793086244;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gI7E+robBP6vgz9AL/HxFuX0LqTlbehBrFtgVWJIAYw=;
	b=ojZIl4B6Y1U2DT3tvez4Hpu6htpCXsyM1cm7HyciNBauv+EGgjJQfSoDPtMedA7lRuQsCy
	klNMcSrxrEG4umCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jOeS8eCt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=d60X7RGx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793086243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gI7E+robBP6vgz9AL/HxFuX0LqTlbehBrFtgVWJIAYw=;
	b=jOeS8eCtNCe5WQOCzWHEwVcZUcoPgzmIOF0+PPzxGICFYaGDmUN16NtdNxT1V6MFdFrbis
	dJpgedRnAVBVJJRzD00M4PQvHDN9j4GVbX8wq2dpynobUbUyN6TaNpW3ju4rrgYndiTcHA
	fxFPVgmgTWmBoM6TA24lbfvFsu8OF/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793086243;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gI7E+robBP6vgz9AL/HxFuX0LqTlbehBrFtgVWJIAYw=;
	b=d60X7RGxoTIUrEWST7bIq7YuoPiAsrhrAGO8SgvV1u+UbytXDA1upOejxYLHbXotDIKPDT
	9UIyOLAdFCWrrVCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89CAA13319;
	Tue, 27 Oct 2026 07:30:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fv0TEiNT4Gq1VQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 27 Oct 2026 07:30:43 +0000
Message-ID: <75b7772e-75bb-4976-aec6-d94c37e651ab@suse.de>
Date: Tue, 27 Oct 2026 08:30:42 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-tcp: start error recovery when read_sock fails
To: martin.nvme.dev@gmail.com, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Martin Belanger <martin.belanger@dell.com>
References: <20261026-nvme-tcp-ctrlrec-fixes-v1-0-ebf6ff7eff34@gmail.com>
 <20261026-nvme-tcp-ctrlrec-fixes-v1-1-ebf6ff7eff34@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261026-nvme-tcp-ctrlrec-fixes-v1-1-ebf6ff7eff34@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DF8C51F791
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.00 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email]
X-Spam-Score: -12.00
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_003048_324114_F8822D87 
X-CRM114-Status: GOOD (  22.36  )
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

On 10/26/26 7:09 PM, Martin Belanger via B4 Relay wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> nvme_tcp_recv_skb() disables the queue and starts error recovery for
> errors it detects itself. An error returned by the transport reaches
> nvme_tcp_try_recv() without either action.
> 
> nvme_tcp_io_work() returns on a negative result and does not requeue
> itself, so the queue stops receiving and remains stalled until a command
> times out.
> 
> Report the error and start error recovery when the queue is still
> enabled, which indicates that the error was not handled by the actor.
> 
> Assisted-by: LLM
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> ---
>   drivers/nvme/host/tcp.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 7190eb10c248..a03476f0f69d 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1431,7 +1431,21 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
>   	queue->nr_cqe = 0;
>   	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
>   	release_sock(sk);
> -	return consumed == -EAGAIN ? 0 : consumed;
> +	if (consumed == -EAGAIN)
> +		return 0;
> +
> +	/* nvme_tcp_recv_skb() does both of these itself, so a queue that is
> +	 * still enabled failed inside read_sock() instead
> +	 */
> +	if (unlikely(consumed < 0 && queue->rd_enabled)) {
> +		dev_err(queue->ctrl->ctrl.device,
> +			"queue %d: receive failed: %d\n",
> +			nvme_tcp_queue_id(queue), consumed);
> +		queue->rd_enabled = false;
> +		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> +	}
> +
> +	return consumed;
>   }
>   
>   static void nvme_tcp_io_work(struct work_struct *w)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

