Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C671E67A8A
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 07:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aGge6psEBg+tCQ+E544M8G0DoZPwjTYjapOYJenkSK8=; b=3H3TNBXZJc58ZhIUb92PMAteZU
	SGkjjb88W+O+Pnfy902nd7QreA//4qwWP/DZmWYb3FNzVvk/jEgxOvJj2PY1u4+sZ/tNpFEaXArks
	4x+yyUyUhToL9y69N+7m5Trh7A2T4UiPcnss0CGx9mWWM06gvqemtWwcjVfd77J3MelIir/2ZSWT2
	igzW/+iTdSR1VGppPPSY3aXXrB1U/+w2f0ZY4KQAfgSDrE0LNIIkgUVYrPXnWUDEdA7uQ7ISTIHkv
	y2veczGTDVXtYW7LWHeEOV9Z1RCQc4p/e9BzQ4NukUD5nWYc/wKK9uxr2Ahg1yP6vatsKuHNNSx9B
	FTzjoBJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxKOk-0000000Ei3x-0aSD;
	Tue, 03 Mar 2026 07:42:30 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxKOg-0000000Ei3G-2F7D
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 07:42:27 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7849E3F8DB;
	Tue,  3 Mar 2026 07:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772523743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aGge6psEBg+tCQ+E544M8G0DoZPwjTYjapOYJenkSK8=;
	b=KWOlAq6BjyUVJl21q6WEfaVXT1M8InCsImUdpUpEGylXjov9NGA8Tnh+b2ml6fFCaPIMb3
	prMNLauyFFhv4D4uaIewRIZWOW3AmZO/44LGFdKHQLBBY3RQcT2R3T8THfWqQrqpbIsj0S
	e+Y4c4bK8PJ32MzBPgQ1awjpfVEbd0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772523743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aGge6psEBg+tCQ+E544M8G0DoZPwjTYjapOYJenkSK8=;
	b=doE+k2NyGqFj3Ua9FTdY5VuOWqObJD6NFm5WUfWRg6RiklVaablsqCZFYv8XBn/fBYVxOS
	CG9NHKuQY7h+j+Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KWOlAq6B;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=doE+k2Ny
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772523743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aGge6psEBg+tCQ+E544M8G0DoZPwjTYjapOYJenkSK8=;
	b=KWOlAq6BjyUVJl21q6WEfaVXT1M8InCsImUdpUpEGylXjov9NGA8Tnh+b2ml6fFCaPIMb3
	prMNLauyFFhv4D4uaIewRIZWOW3AmZO/44LGFdKHQLBBY3RQcT2R3T8THfWqQrqpbIsj0S
	e+Y4c4bK8PJ32MzBPgQ1awjpfVEbd0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772523743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aGge6psEBg+tCQ+E544M8G0DoZPwjTYjapOYJenkSK8=;
	b=doE+k2NyGqFj3Ua9FTdY5VuOWqObJD6NFm5WUfWRg6RiklVaablsqCZFYv8XBn/fBYVxOS
	CG9NHKuQY7h+j+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D168C3EA69;
	Tue,  3 Mar 2026 07:42:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eR/yLt6QpmlnVwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Mar 2026 07:42:22 +0000
Message-ID: <3ae4fa34-e8e8-47fb-934f-f9c580d78d92@suse.de>
Date: Tue, 3 Mar 2026 08:42:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/21] nvme-auth: host: remove allocation of crypto_shash
To: Eric Biggers <ebiggers@kernel.org>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20260302075959.338638-1-ebiggers@kernel.org>
 <20260302075959.338638-16-ebiggers@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260302075959.338638-16-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 7849E3F8DB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_234226_788328_3A4E6F04 
X-CRM114-Status: GOOD (  10.98  )
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

On 3/2/26 08:59, Eric Biggers wrote:
> Now that the crypto_shash that is being allocated in
> nvme_auth_process_dhchap_challenge() and stored in the
> struct nvme_dhchap_queue_context is no longer used, remove it.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>   drivers/nvme/host/auth.c | 29 ++---------------------------
>   1 file changed, 2 insertions(+), 27 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

