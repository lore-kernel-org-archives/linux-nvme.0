Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6A1E67A8A
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 07:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2BH4cVTR346OxZ9Nd+HiNV4zlvPtz1v2wgxn2sOYm0E=; b=h0uVm67SlHwfONeGMk5TiAodDA
	mlhLHWsUSViLGXpi6PabIQQwa4v9Y3WvuDfTo/b9MNb8U/DkUUgW6uz12Tvejoiz0RdVxz6ipV68f
	sJDwsdXITlT7txOpbvcZZbwYMfWS3UYgQMOxXyEOLl/7gCr56oyTmCZ1TqmcqXJ8+5Em6Se9nqaoK
	NnsgTkjgn1sYJoUTpO0yAoIlPW3e2SK8ihDqsjR5mE1QfQDg7e8FWduj7ozsdUI4bs7n5eR0A3IZx
	mCIxbM05H3Zq9ET2+GXQOGExIhF+Mw6fg2vROvOIvbNfpnbW1pnNtJdlca3aBSaFM2I7GrprsaNEX
	Cm7TxUFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxKRs-0000000EijI-24ek;
	Tue, 03 Mar 2026 07:45:44 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxKRq-0000000Eihp-3rLH
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 07:45:44 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3DB925BDE6;
	Tue,  3 Mar 2026 07:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772523941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2BH4cVTR346OxZ9Nd+HiNV4zlvPtz1v2wgxn2sOYm0E=;
	b=zC+AYLb7+iGeKXe3oChAdfiZy9839z+KxQ2aLvvqMeHBBTV03No4b1t1OrMRPJDtOe44e3
	oFEJV2b7hPVOPbLF2WIaLWG0NhhX8MqGyKc7+HYXR8QpwjuqDT8iUvD+Z6t4SVET7CAh3B
	MHSfkR2kvErPOB0cxMoGSW2LDw94kjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772523941;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2BH4cVTR346OxZ9Nd+HiNV4zlvPtz1v2wgxn2sOYm0E=;
	b=ZMzm1Fo6xIk7k7KKkt5Zwbyxwsg46KsXG2L80F4p9ekc5Yqz1tjrVGGSHhPqyqUqrOa75d
	rBMl3S4vY4epcSBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zC+AYLb7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZMzm1Fo6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772523941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2BH4cVTR346OxZ9Nd+HiNV4zlvPtz1v2wgxn2sOYm0E=;
	b=zC+AYLb7+iGeKXe3oChAdfiZy9839z+KxQ2aLvvqMeHBBTV03No4b1t1OrMRPJDtOe44e3
	oFEJV2b7hPVOPbLF2WIaLWG0NhhX8MqGyKc7+HYXR8QpwjuqDT8iUvD+Z6t4SVET7CAh3B
	MHSfkR2kvErPOB0cxMoGSW2LDw94kjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772523941;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2BH4cVTR346OxZ9Nd+HiNV4zlvPtz1v2wgxn2sOYm0E=;
	b=ZMzm1Fo6xIk7k7KKkt5Zwbyxwsg46KsXG2L80F4p9ekc5Yqz1tjrVGGSHhPqyqUqrOa75d
	rBMl3S4vY4epcSBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB62C3EA69;
	Tue,  3 Mar 2026 07:45:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xCUKK6SRpmkyWwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Mar 2026 07:45:40 +0000
Message-ID: <4fbdb2aa-dacb-4669-a487-86bf03914ea6@suse.de>
Date: Tue, 3 Mar 2026 08:45:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/21] nvme-auth: common: remove selections of no-longer
 used crypto modules
To: Eric Biggers <ebiggers@kernel.org>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20260302075959.338638-1-ebiggers@kernel.org>
 <20260302075959.338638-21-ebiggers@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260302075959.338638-21-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3DB925BDE6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_234543_115302_578D5391 
X-CRM114-Status: GOOD (  12.37  )
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
> Now that nvme-auth uses the crypto library instead of crypto_shash,
> remove obsolete selections from the NVME_AUTH kconfig option.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>   drivers/nvme/common/Kconfig | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
> index 1ec507d1f9b5f..f1639db65fd38 100644
> --- a/drivers/nvme/common/Kconfig
> +++ b/drivers/nvme/common/Kconfig
> @@ -5,16 +5,12 @@ config NVME_KEYRING
>          select KEYS
>   
>   config NVME_AUTH
>   	tristate
>   	select CRYPTO
> -	select CRYPTO_HMAC
> -	select CRYPTO_SHA256
> -	select CRYPTO_SHA512
>   	select CRYPTO_DH
>   	select CRYPTO_DH_RFC7919_GROUPS
> -	select CRYPTO_HKDF
>   	select CRYPTO_LIB_SHA256
>   	select CRYPTO_LIB_SHA512
>   
>   config NVME_AUTH_KUNIT_TEST
>   	tristate "KUnit tests for NVMe authentication" if !KUNIT_ALL_TESTS

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

