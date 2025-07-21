Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C72C83F1A
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jul 2025 06:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ech/+w0sSOIoPc1Vci7yksj+8dc3cDnpMT9Fmg6b0HU=; b=Guv92Wiw9NheaEVWT97QPw/4Og
	JSAnE/aqAiFx8f3pXqe6QazdSyugKKSyLIL0EoRSslg7K+jVXoeGHL7mDCF8fkhua+7h8J3Yh9JXe
	77/Lb/GuxF1RK5NN3glVHVvSY9/nqPUFef8zDMtCs4nqvKGX8OmgHuinkszJ2WfPfA6rX3/x0eoql
	/ffp+Np50PdkYV56TWXjoQrZ1MC+b2ISXFNmb4G/CLp4kMW19M4hyMwgsujQ5upLshFdInpoo3WEz
	L6TCR6JA7Zk0ZxyySDDjBtZYMD+faUeur7IlyQE1SNYgIviKCN3dl8uY3NqXd7S8u8M8jnQwvDWtQ
	cfDZYPzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udk8B-0000000GO2w-08iM;
	Mon, 21 Jul 2025 06:36:11 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udk85-0000000GNzi-1XDV
	for linux-nvme@lists.infradead.org;
	Mon, 21 Jul 2025 06:36:09 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E235121A6E;
	Mon, 21 Jul 2025 06:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753079762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ech/+w0sSOIoPc1Vci7yksj+8dc3cDnpMT9Fmg6b0HU=;
	b=AqynwZxlTeLKUKdiRWMAr/34/3pEQ4Wf2vd9v+UeJw8uH4EaxRxwwJ3n9uVnLWGxzTGtuB
	/ffWLjAiXtLtH7y4Ka1nyPipye82PxSR0fQrr/SzU4ychS1BKtiC9gthyvTV4Ub2eZlypG
	+KEGYipttqbFMXBLQIVB7w2YlnUBfwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753079762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ech/+w0sSOIoPc1Vci7yksj+8dc3cDnpMT9Fmg6b0HU=;
	b=sOdyudK8GUohLdlcxhAOYWrMvFW7T5Gc3HoxqImqTMr8AzSoUIT+ItRWgkYPiSRw3O2xb+
	e3At0g0POOAvIkCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Dv7sS81E;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=igRCEW7S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753079761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ech/+w0sSOIoPc1Vci7yksj+8dc3cDnpMT9Fmg6b0HU=;
	b=Dv7sS81EHn7uO9KBVMwRvwdNWDPqKN5eOhNIySDCVa6CPyzr0BJExM1lMgHepFefSbx6PK
	r8At6NqHkQtpJiBg05Rwzw0GRX44xozgEY0bCjvAlWnyixS2+NLXoYQkQGnraH7OHryAh6
	/VnNVntjKtKHPyEMCDqr+vuKFQS1z00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753079761;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ech/+w0sSOIoPc1Vci7yksj+8dc3cDnpMT9Fmg6b0HU=;
	b=igRCEW7SxZBmjlioQwRSGHiVP5VjthAKpM1PdWPMM+ZfOj6UfAKLFlY3DzH3Cg0KCgGYXN
	4vsNJNlkhvFcLzDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACC3113A88;
	Mon, 21 Jul 2025 06:36:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GIVKKNHffWhRTwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 21 Jul 2025 06:36:01 +0000
Message-ID: <d8f4ed91-3fcb-45b9-b4d6-900382eb4ae7@suse.de>
Date: Mon, 21 Jul 2025 08:36:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] libnvme: TLS PSK derivation fixes
To: Chris Leech <cleech@redhat.com>, linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>,
 Prashanth Nayak <prashanth.nayak@netapp.com>,
 John Meneghini <jmeneghi@redhat.com>
References: <20250721021718.1159879-1-cleech@redhat.com>
 <20250721021718.1159879-2-cleech@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250721021718.1159879-2-cleech@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email]
X-Rspamd-Queue-Id: E235121A6E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250720_233605_555139_ED2D2F94 
X-CRM114-Status: GOOD (  23.17  )
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

On 7/21/25 04:17, Chris Leech wrote:
> There are issues with the Retained and TLS PSK derivations due to the
> implementation not adhering to the RFC 8446 definition of the
> HKDF-Expand-Label function.
> 
>    1) The 16-bit HkdfLabel.length value must be converted to network byte
>       order.
> 
>    2) The variable length HkdfLabel.label and HkdfLabel.context vectors
>       must be prefixed with a length byte.
> 
> Signed-off-by: Chris Leech <cleech@redhat.com>
> ---
>   src/nvme/linux.c | 86 ++++++++++++++++++++++++++++++++----------------
>   1 file changed, 57 insertions(+), 29 deletions(-)
> 
> diff --git a/src/nvme/linux.c b/src/nvme/linux.c
> index ae4aa526..674b20b5 100644
> --- a/src/nvme/linux.c
> +++ b/src/nvme/linux.c
> @@ -618,6 +618,46 @@ static DEFINE_CLEANUP_FUNC(
>   	cleanup_evp_pkey_ctx, EVP_PKEY_CTX *, EVP_PKEY_CTX_free)
>   #define _cleanup_evp_pkey_ctx_ __cleanup__(cleanup_evp_pkey_ctx)
>   
> +/*
> + * hkdf_info_printf()
> + *
> + * Helper function to append variable length label and context to an HkdfLabel
> + *
> + * RFC 8446 (TLS 1.3) Section 7.1 defines the HKDF-Expand-Label function as a
> + * specialization of the HKDF-Expand function (RFC 5869), where the info
> + * parameter is structured as an HkdfLabel.
> + *
> + * An HkdfLabel structure includes two variable length vectors (label and
> + * context) which must be preceded by their content length as per RFC 8446
> + * Section 3.4 (and not NUL terminated as per Section 7.1). Additionally,
> + * HkdfLabel.label must begin with "tls13 "
> + *
> + * Returns the number of bytes appended to the HKDF info buffer, or -1 on an
> + * error.
> + */
> +__attribute__((format(printf, 2, 3)))
> +static int hkdf_info_printf(EVP_PKEY_CTX *ctx, char *fmt, ...)
> +{
> +	_cleanup_free_ char *str;
> +	uint8_t len;
> +	int ret;
> +
> +	va_list myargs;
> +	va_start(myargs, fmt);
> +	ret = vasprintf(&str, fmt, myargs);
> +	va_end(myargs);
> +	if (ret < 0)
> +		return ret;
> +	if (ret > 255)
> +		return -1;
> +	len = ret;
> +	if (EVP_PKEY_CTX_add1_hkdf_info(ctx, (unsigned char *)&len, 1) <= 0)
> +		return -1;
> +	if (EVP_PKEY_CTX_add1_hkdf_info(ctx, (unsigned char *)str, len) <= 0)
> +		return -1;
> +	return (ret + 1);
> +}
> +
>   /*
>    * derive_retained_key()
>    *
> @@ -652,7 +692,7 @@ static int derive_retained_key(int hmac, const char *hostnqn,
>   			       size_t key_len)
>   {
>   	_cleanup_evp_pkey_ctx_ EVP_PKEY_CTX *ctx = NULL;
> -	uint16_t length = key_len & 0xFFFF;
> +	uint16_t length = htons(key_len & 0xFFFF);
>   	const EVP_MD *md;
>   	size_t hmac_len;
>   
> @@ -690,18 +730,11 @@ static int derive_retained_key(int hmac, const char *hostnqn,
>   		errno = ENOKEY;
>   		return -1;
>   	}
> -	if (EVP_PKEY_CTX_add1_hkdf_info(ctx,
> -			(const unsigned char *)"tls13 ", 6) <= 0) {
> -		errno = ENOKEY;
> -		return -1;
> -	}
> -	if (EVP_PKEY_CTX_add1_hkdf_info(ctx,
> -			(const unsigned char *)"HostNQN", 7) <= 0) {
> +	if (hkdf_info_printf(ctx, "tls13 HostNQN") <= 0) {
>   		errno = ENOKEY;
>   		return -1;
>   	}
> -	if (EVP_PKEY_CTX_add1_hkdf_info(ctx,
> -			(const unsigned char *)hostnqn, strlen(hostnqn)) <= 0) {
> +	if (hkdf_info_printf(ctx, "%s", hostnqn) <= 0) {
>   		errno = ENOKEY;
>   		return -1;
>   	}
> @@ -736,12 +769,13 @@ static int derive_retained_key(int hmac, const char *hostnqn,
>    *
>    * and the value '0' is invalid here.
>    */
> +
>   static int derive_tls_key(int version, unsigned char cipher,
>   			  const char *context, unsigned char *retained,
>   			  unsigned char *psk, size_t key_len)
>   {
>   	_cleanup_evp_pkey_ctx_ EVP_PKEY_CTX *ctx = NULL;
> -	uint16_t length = key_len & 0xFFFF;
> +	uint16_t length = htons(key_len & 0xFFFF);
>   	const EVP_MD *md;
>   	size_t hmac_len;
>   
> @@ -774,30 +808,24 @@ static int derive_tls_key(int version, unsigned char cipher,
>   		errno = ENOKEY;
>   		return -1;
>   	}
> -	if (EVP_PKEY_CTX_add1_hkdf_info(ctx,
> -			(const unsigned char *)"tls13 ", 6) <= 0) {
> -		errno = ENOKEY;
> -		return -1;
> -	}
> -	if (EVP_PKEY_CTX_add1_hkdf_info(ctx,
> -			(const unsigned char *)"nvme-tls-psk", 12) <= 0) {
> +	if (hkdf_info_printf(ctx, "tls13 nvme-tls-psk") <= 0) {
>   		errno = ENOKEY;
>   		return -1;
>   	}
> -	if (version == 1) {
> -		char hash_str[5];
> -
> -		sprintf(hash_str, "%02d ", cipher);
> -		if (EVP_PKEY_CTX_add1_hkdf_info(ctx,
> -				(const unsigned char *)hash_str,
> -				strlen(hash_str)) <= 0) {
> +	switch (version) {
> +	case 0:
> +		if (hkdf_info_printf(ctx, "%s", context) <= 0) {
>   			errno = ENOKEY;
>   			return -1;
>   		}
> -	}
> -	if (EVP_PKEY_CTX_add1_hkdf_info(ctx,
> -			(const unsigned char *)context,
> -			strlen(context)) <= 0) {
> +		break;
> +	case 1:
> +		if (hkdf_info_printf(ctx, "%02d %s", cipher, context) <= 0) {
> +			errno = ENOKEY;
> +			return -1;
> +		}
> +		break;
> +	default:
>   		errno = ENOKEY;
>   		return -1;
>   	}

Hmm. I _thought_ we had it all fixed...
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

