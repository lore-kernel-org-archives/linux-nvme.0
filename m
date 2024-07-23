Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8087EC3DA63
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jul 2024 06:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sVaMf9c+l8gM9tbWJVbYHvoX5kYpyszS0eYVw3y7AhA=; b=JyJMMZSPTJkJYcYSctjwMKFHyX
	s1xyQw8Qz06nGcbHwLyBNsalwdE5ZKusjG1zQokQb6DMSah+0Fwt5aEfaQYHDx2s22RLfoM0wch/i
	jgk0B1oY7gRKPG9XiLAC3qrdvpXJutAsH8E8/b17TK1ey8WPy7Lswnl+7Mbzeamtt3fPSSBa3zz85
	wWoiabOyasgawFXPYWVw8yJFmO740ylQDPHfmPG6oiSgTJPuLd9h4oRT8kHTOABG/W7m64sAlBtOx
	yETRjS90QTzDxQ/COCdi+QaYDCmWAhLSqcEA9vich/A/OtQv4MTb6KE9yFLvlql6SIrHxFgJUwo3w
	E+6fYm4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW8yf-0000000BTXV-2Mqc;
	Tue, 23 Jul 2024 06:26:25 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sW8yY-0000000BTVu-3gd3
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jul 2024 06:26:22 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E50541FBA2;
	Tue, 23 Jul 2024 06:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721715976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sVaMf9c+l8gM9tbWJVbYHvoX5kYpyszS0eYVw3y7AhA=;
	b=jKZYmX/htBO1DYvPe0mFjDMOQJ89BnLi+V9i43DyMI8u4L/hdXHXVwhLKyyK0JqUnAGEuE
	D0n7OVVC6kPQ0P7qXQUcA3nBNHCd4ITWJnKftorPteGYgH+OhAquxBiF0dgR2H0lrafWQN
	i+r1XDOLN9UzUqLOw+y/lzMnUpOkhb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721715976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sVaMf9c+l8gM9tbWJVbYHvoX5kYpyszS0eYVw3y7AhA=;
	b=ONlrhsmXd5ATkdjqoNbd0sxywSdSsIX8K0An/VoD8w1fvrRhgdagZNuu7X6fU0fqFyQ0ic
	ZGHCTDVsOwsEvHCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721715975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sVaMf9c+l8gM9tbWJVbYHvoX5kYpyszS0eYVw3y7AhA=;
	b=s94xDyjQGUEBMRpl+guIzC/nThd7sZX7nb8MBstFatd3o9lHgNTnrvP4UGsr65IZLAtsgy
	+UTT64+nnMWpc4338CYdnHAkBSaNg7MyoFKhkOmjzwqlniEL2TgrnAK1ucCj31g27f0e9M
	68vDSYHHfNle2ctBdHndjM7WFOKmycY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721715975;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sVaMf9c+l8gM9tbWJVbYHvoX5kYpyszS0eYVw3y7AhA=;
	b=JAgPTDofH9pvrRIZS+NPbS9h7ieW4q0LNvkb2zXNgqbMMU6QmzX9T+skxrmIUYFQMlf/AS
	Z3wAyDlIF3ppE1Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D99813888;
	Tue, 23 Jul 2024 06:26:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kQrLHgdNn2a2QwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 23 Jul 2024 06:26:15 +0000
Message-ID: <d0101bf1-5f71-4fe4-b391-e6d761c8a9e3@suse.de>
Date: Tue, 23 Jul 2024 08:26:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] nvme: add nvme_auth_derive_tls_psk()
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-crypto@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20240722142122.128258-1-hare@kernel.org>
 <20240722142122.128258-5-hare@kernel.org>
 <20240723014715.GB2319848@google.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240723014715.GB2319848@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.09 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_232619_222825_A86A5CB3 
X-CRM114-Status: GOOD (  21.34  )
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

On 7/23/24 03:47, Eric Biggers wrote:
> On Mon, Jul 22, 2024 at 04:21:17PM +0200, Hannes Reinecke wrote:
>> +/*
>> + * Derive a TLS PSK as specified in TP8018 Section 3.6.1.3:
>> + *   TLS PSK and PSK identity Derivation
>> + *
>> + * The TLS PSK shall be derived as follows from an input PSK
>> + * (i.e., either a retained PSK or a generated PSK) and a PSK
>> + * identity using the HKDF-Extract and HKDF-Expand-Label operations
>> + * (refer to RFC 5869 and RFC 8446) where the hash function is the
>> + * one specified by the hash specifier of the PSK identity:
>> + * 1. PRK = HKDF-Extract(0, Input PSK); and
>> + * 2. TLS PSK = HKDF-Expand-Label(PRK, "nvme-tls-psk", PskIdentityContext, L),
>> + * where PskIdentityContext is the hash identifier indicated in
>> + * the PSK identity concatenated to a space character and to the
>> + * Base64 PSK digest (i.e., "<hash> <PSK digest>") and L is the
>> + * output size in bytes of the hash function (i.e., 32 for SHA-256
>> + * and 48 for SHA-384).
>> + */
>> +int nvme_auth_derive_tls_psk(int hmac_id, u8 *psk, size_t psk_len,
>> +		u8 *psk_digest, u8 **ret_psk)
>> +{
>> +	struct crypto_shash *hmac_tfm;
>> +	const char *hmac_name;
>> +	const char *psk_prefix = "tls13 nvme-tls-psk";
>> +	size_t info_len, prk_len;
>> +	char *info;
>> +	unsigned char *prk, *tls_key;
>> +	int ret;
>> +
>> +	hmac_name = nvme_auth_hmac_name(hmac_id);
>> +	if (!hmac_name) {
>> +		pr_warn("%s: invalid hash algoritm %d\n",
>> +			__func__, hmac_id);
>> +		return -EINVAL;
>> +	}
>> +	if (hmac_id == NVME_AUTH_HASH_SHA512) {
>> +		pr_warn("%s: unsupported hash algorithm %s\n",
>> +			__func__, hmac_name);
>> +		return -EINVAL;
>> +	}
>> +
>> +	hmac_tfm = crypto_alloc_shash(hmac_name, 0, 0);
>> +	if (IS_ERR(hmac_tfm))
>> +		return PTR_ERR(hmac_tfm);
>> +
>> +	prk_len = crypto_shash_digestsize(hmac_tfm);
>> +	prk = kzalloc(prk_len, GFP_KERNEL);
>> +	if (!prk) {
>> +		ret = -ENOMEM;
>> +		goto out_free_shash;
>> +	}
>> +
>> +	ret = hkdf_extract(hmac_tfm, psk, psk_len, prk);
>> +	if (ret)
>> +		goto out_free_prk;
>> +
>> +	ret = crypto_shash_setkey(hmac_tfm, prk, prk_len);
>> +	if (ret)
>> +		goto out_free_prk;
>> +
>> +	info_len = strlen(psk_digest) + strlen(psk_prefix) + 1;
>> +	info = kzalloc(info_len, GFP_KERNEL);
>> +	if (!info)
>> +		goto out_free_prk;
>> +
>> +	memcpy(info, psk_prefix, strlen(psk_prefix));
>> +	memcpy(info + strlen(psk_prefix), psk_digest, strlen(psk_digest));
> 
> The code doesn't match the description given in the function comment (which
> looks like it was quoted from a specification).
> 
> The code does HKDF-Expand with info="tls13 nvme-tls-psk<PSK digest>".
> 
> The description does HKDF-Expand-Label with Label="nvme-tls-psk",
> Context="<hash identifier> <PSK digest>", Length=digest_size.
> 
> Not only does the code not actually use <hash identifier>, but it doesn't follow
> the definition of HKDF-Expand-Label from RFC8446
> (https://datatracker.ietf.org/doc/html/rfc8446#section-7.1) in that it's missing
> all the length fields.  So the info string used by the actual code ends up being
> quite different from the one specified.
> 
Aw. Guess you are right. Will be fixing it up.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


