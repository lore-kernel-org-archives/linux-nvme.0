Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405CF60A2628
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0erb2sbm;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NHvJhY/3;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vwx43/zW;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fl9BUuuZ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UOMOAio9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=BPT5I+y8uo9yjpkzOY3Iko74xhOAFrTC4kK7nNK/IzM=; b=0erb2sbmTtCsy/
	/dKf1UQIElTpmf/BIyPzgsopb2HpZjphZGZ7F1nmdEjVWRb0yHQw+GaIwooi8DyxIPrRy5JvmOL1K
	ecvdu5bkmk9r1hUU1qK9B3YkpMz9A2t6s20Yw0ILSsIV48ChEYQvSTiZsegjUdOIr278b5Z5noVAF
	2uPAhmMAat2Gki0fZSHD+EMq0e5JTP+ijI9UcC1qgcgEmKaLh/XZm+uCetdCLtgZdFgxHIt0Xsut3
	NY0GUJ9Rnl1fFsQ2Nu7pkJj+7LPgR9KIOGM9T9AkVyTnVqpaw3a46xHd2wGvEHw+u3gt2n4Fd+MYD
	Da2hxTWIMmaD9nTOmgbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQlOy-00000003w0P-3w8h;
	Tue, 10 Nov 2026 12:56:40 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQlOw-00000003vye-1Zem
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 12:56:40 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 69D9F21ECA;
	Tue, 10 Nov 2026 12:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794315396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BPT5I+y8uo9yjpkzOY3Iko74xhOAFrTC4kK7nNK/IzM=;
	b=NHvJhY/3Fq8U+z/HC1L1oLOsbIMa9q9z8IV4IsyovmsVYroa6xI8ZIsiOMsZNGVdmc6r8m
	MnfTYraYybxLXsR+3FNBqJRzq3hKCFqygT6tMmz0H77YPRudpRMpWIlKEiFNJ2LB+vEqXZ
	5ij6jZuzsgq5Gk3MnN/G8q/jCFa0Y+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794315396;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BPT5I+y8uo9yjpkzOY3Iko74xhOAFrTC4kK7nNK/IzM=;
	b=vwx43/zW7gJ7F5Ny7rLZGFoPhXOxZ7tTSSojTnV8mWQLj3hXHdCJEAJcBxqDLHLCKRTORE
	jvZAf3PPjETx+qBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fl9BUuuZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UOMOAio9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794315395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BPT5I+y8uo9yjpkzOY3Iko74xhOAFrTC4kK7nNK/IzM=;
	b=fl9BUuuZocYsoopqQCW53BVGvAF7GUD7+Ejurj5fGtUuTHYuh9NBHJUaewlHlyMvANrnJT
	q81yP5Y8DiYA9z7fbwcZshiG69Yr36ntkUczpHp6WvLfNhpAQjdIqyPnBKDG6KN3SMfRQg
	chnuP4K/ma+5j/DyTROJQdVD67snKOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794315395;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BPT5I+y8uo9yjpkzOY3Iko74xhOAFrTC4kK7nNK/IzM=;
	b=UOMOAio9TMonEel8PAsU2Qd+GBFs4CrOTsAyEFZi5+Y5tsPLg/pKdCmNRvh0T6Lz4SMiVk
	x6rgUPWB2q2CxGDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37D951339F;
	Tue, 10 Nov 2026 12:56:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0SsVA4MU82q4QwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 10 Nov 2026 12:56:35 +0000
Message-ID: <b0671c91-4fcc-4bea-a2c7-1029a54a53ad@suse.de>
Date: Tue, 10 Nov 2026 13:56:34 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: drop the redundant auth check in
 nvmet_parse_io_cmd()
To: shao.mingyin@zte.com.cn, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
References: <20261104211446891tN1QRJiKV3CLPQqfb7gJu@zte.com.cn>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261104211446891tN1QRJiKV3CLPQqfb7gJu@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 69D9F21ECA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_045638_709268_FE426800 
X-CRM114-Status: GOOD (  12.21  )
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

On 11/4/26 2:14 PM, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> nvmet_parse_io_cmd() calls nvmet_check_auth_status() and then
> nvmet_check_ctrl_status(), which performs the same check again.  The
> first call cannot fail either: this path only handles commands from I/O
> queues, and nvmet_check_auth_status() returns true unconditionally for
> qid > 0.  Drop the duplicate.
> 
> No functional change.
> 
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index a8171b88035c..12b82bb7e412 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1120,9 +1120,6 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
>   	if (nvme_is_fabrics(cmd))
>   		return nvmet_parse_fabrics_io_cmd(req);
>   
> -	if (unlikely(!nvmet_check_auth_status(req)))
> -		return NVME_SC_AUTH_REQUIRED | NVME_STATUS_DNR;
> -
>   	ret = nvmet_check_ctrl_status(req);
>   	if (unlikely(ret))
>   		return ret;
> 

If you insist ...

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

