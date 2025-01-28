Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1365C0218D
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 15:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nuz+CdHcnF/ej8b8Kr4GcOe4Q2thUe/M77D45Y9xy+4=; b=aPUv0WD7968nGfIqS4VhlnpIup
	LyqtEH2owakX1K+okuogKjG92CTevXq7kBO/TNQyF6sPaDhOmGib8OZRTAlKbb0b52BkQxCMmiSwd
	OLakjVcxyfeez0K5oI21XlH0BYMV75Lz6wzR3EawWbioj465143Zg5TgUWNRnUBLPHMOpe7lyB4nD
	N8Q120dhHq6iAJcsji7UIlpHTRTfKCZmJiW2mAHhletYiC+tzMKLItdk/g0c1X8VW1FuFiyLqeaJ7
	NqFLmse3dm5EIG4jSUw2QK+b87KWRwDljQLZtAk3qI+nV9ZXOYQGkCFetQJPtxe4M4XOYDIbWgjKx
	OYI854Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcnUY-000000058WD-03gg;
	Tue, 28 Jan 2025 15:27:06 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcnTt-000000058TW-269S
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 15:26:26 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CCC481F383;
	Tue, 28 Jan 2025 15:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738077983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nuz+CdHcnF/ej8b8Kr4GcOe4Q2thUe/M77D45Y9xy+4=;
	b=UO9dyoA/gCW5IIjn79ZvjIACnD+Jm0n0uhQG7x3Hv4NqvJYcF68R+qU1gdgvTtyUUNvVDb
	Fm0uSvZBRAd7o7tDT5a81npjY45ce4n83vyB0VwFXqJsRhxpadFX8cCSiS7UglGQD/kEiN
	PRH6Skwsbx82r6YcSpInL/tsKuTQCPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738077983;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nuz+CdHcnF/ej8b8Kr4GcOe4Q2thUe/M77D45Y9xy+4=;
	b=sglZ/dRjyCNuGQ5XaIla09Ea3CM9hcedfswm7Sd8nPAP9W10AvY/vdE7Zqq90y7PuU40rl
	5IJxbhI3SVg61gCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738077983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nuz+CdHcnF/ej8b8Kr4GcOe4Q2thUe/M77D45Y9xy+4=;
	b=UO9dyoA/gCW5IIjn79ZvjIACnD+Jm0n0uhQG7x3Hv4NqvJYcF68R+qU1gdgvTtyUUNvVDb
	Fm0uSvZBRAd7o7tDT5a81npjY45ce4n83vyB0VwFXqJsRhxpadFX8cCSiS7UglGQD/kEiN
	PRH6Skwsbx82r6YcSpInL/tsKuTQCPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738077983;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nuz+CdHcnF/ej8b8Kr4GcOe4Q2thUe/M77D45Y9xy+4=;
	b=sglZ/dRjyCNuGQ5XaIla09Ea3CM9hcedfswm7Sd8nPAP9W10AvY/vdE7Zqq90y7PuU40rl
	5IJxbhI3SVg61gCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF96A13625;
	Tue, 28 Jan 2025 15:26:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K1RUKh/3mGdGXwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 28 Jan 2025 15:26:23 +0000
Message-ID: <f49aa2da-5449-4612-b1b1-9b63c815ec83@suse.de>
Date: Tue, 28 Jan 2025 16:26:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] nvme: add nvme_auth_generate_psk()
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20250122165829.11603-1-hare@kernel.org>
 <20250122165829.11603-3-hare@kernel.org> <20250128085336.GA25760@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250128085336.GA25760@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_072625_721482_661399A5 
X-CRM114-Status: GOOD (  15.73  )
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

On 1/28/25 09:53, Christoph Hellwig wrote:
>> + * Generate a PSK for TLS as specified in NVMe base specification, section 8.13.5.9:
> 
> Please fix your comment to stay in 80 characters.  The line wrapping
> here makes the text almost unreadable.
> 
>> +int nvme_auth_generate_psk(u8 hmac_id, u8 *skey, size_t skey_len,
>> +		u8 *c1, u8 *c2, size_t hash_len, u8 **ret_psk,size_t *ret_len)
> 
> Missing whitespace before the last size_t.
> 
>> +{
>> +	struct crypto_shash *tfm;
>> +	struct shash_desc *shash;
>> +	u8 *psk;
>> +	const char *hmac_name;
>> +	int ret, psk_len;
>> +
>> +	if (!c1 || !c2) {
>> +		pr_warn("%s: invalid parameter\n", __func__);
>> +		return -EINVAL;
>> +	}
> 
> No a very useful error message.  Given that this is a violation of
> the API contract either a WARN_ON_ONCE or just letting the crypto
> algorithm fail should be fine.
> 
Okay, will just let it fail.

>> +	tfm = crypto_alloc_shash(hmac_name, 0, 0);
>> +	if (IS_ERR(tfm))
>> +		return PTR_ERR(tfm);
>> +
>> +	psk_len = crypto_shash_digestsize(tfm);
>> +	psk = kzalloc(psk_len, GFP_KERNEL);
>> +	if (!psk) {
>> +		ret = -ENOMEM;
>> +		goto out_free_tfm;
>> +	}
>> +
>> +	shash = kmalloc(sizeof(struct shash_desc) +
>> +			crypto_shash_descsize(tfm),
>> +			GFP_KERNEL);
>> +	if (!shash) {
>> +		ret = -ENOMEM;
>> +		goto out_free_psk;
>> +	}
> 
> Is there a good reason this can't use SHASH_DESC_ON_STACK()?
> 
I'll check.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

