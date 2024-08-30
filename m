Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966A7CA0EE5
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2024 06:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pV/uib85aoMSJZhQQkM2Mb2iy1KGc01xl+Lsov8x6NA=; b=eO25WLEOoFNuSBIwJu1FvLUfCS
	fs7PLpBV8V3sVBuM/rd58b6oJdl3XQVnbe7aYLiGPLxs7hq+7KH2syHjhxNEFtZ4J9D0PVn3m5YfA
	0qowZ5nlv/UH8rWK2TjyozoaB+mRynhQPf2ztUkGtghAlJwRMhAWVzcrICQypSfoQehiWromuMfYp
	51wtyuFhvNGK1PNHc7k2S4OOq1R1epmiC6Of6yo1/q95GPLjdbGS+I174/fAy2JQCti4vGmlvcQq/
	k6IwukQzcdeSIQR0z4a5RAWC8XIgyPRo22erjtQqxk7cu92Y3DphUSMIl0Bms6ParW1YX9o07lPxC
	cocCYHlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjuuI-00000004uyt-2vHf;
	Fri, 30 Aug 2024 06:14:50 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjusz-00000004ubL-0Bvj
	for linux-nvme@lists.infradead.org;
	Fri, 30 Aug 2024 06:13:32 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1ECB41F7A0;
	Fri, 30 Aug 2024 06:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724998407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pV/uib85aoMSJZhQQkM2Mb2iy1KGc01xl+Lsov8x6NA=;
	b=WKUw61tEsIsLhX9UMWxyG6ZXXIzMNzLlOR/LGlfSeWa/xlV/7QIGkB+g1SxrhgdUinVD0y
	Ztf0CjCiWvClQpFg0DlDlsB4MJG/FO6EMKe92OqQsJ/mIsWh1bd/yUImBBCL/Cl4k+bYQv
	bGc4+WGlraRRVR1JZDD0i4opQ1LB4mM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724998407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pV/uib85aoMSJZhQQkM2Mb2iy1KGc01xl+Lsov8x6NA=;
	b=GxvfqR31Ds9TFjnSPwtk8MsUKhZNlC9HCdQybt8EpVKMbQgTJpcKWgDWUS8H+7/HANrxO+
	XcZ2TYAwZpOEetBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WKUw61tE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GxvfqR31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724998407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pV/uib85aoMSJZhQQkM2Mb2iy1KGc01xl+Lsov8x6NA=;
	b=WKUw61tEsIsLhX9UMWxyG6ZXXIzMNzLlOR/LGlfSeWa/xlV/7QIGkB+g1SxrhgdUinVD0y
	Ztf0CjCiWvClQpFg0DlDlsB4MJG/FO6EMKe92OqQsJ/mIsWh1bd/yUImBBCL/Cl4k+bYQv
	bGc4+WGlraRRVR1JZDD0i4opQ1LB4mM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724998407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pV/uib85aoMSJZhQQkM2Mb2iy1KGc01xl+Lsov8x6NA=;
	b=GxvfqR31Ds9TFjnSPwtk8MsUKhZNlC9HCdQybt8EpVKMbQgTJpcKWgDWUS8H+7/HANrxO+
	XcZ2TYAwZpOEetBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD87B13A3D;
	Fri, 30 Aug 2024 06:13:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CVRWLAZj0WbNTQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 30 Aug 2024 06:13:26 +0000
Message-ID: <a63ca273-bd64-4821-af16-05004205d8d9@suse.de>
Date: Fri, 30 Aug 2024 08:13:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] crypto,fs: Separate out hkdf_extract() and
 hkdf_expand()
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org
References: <20240813111512.135634-1-hare@kernel.org>
 <20240813111512.135634-2-hare@kernel.org>
 <20240827175225.GA2049@sol.localdomain>
 <0697a6c9-85a3-4f56-879c-b096fb5072b8@suse.de>
 <20240829215404.GA3058135@google.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240829215404.GA3058135@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1ECB41F7A0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_231329_258142_4E84096A 
X-CRM114-Status: GOOD (  21.65  )
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

On 8/29/24 23:54, Eric Biggers wrote:
> On Thu, Aug 29, 2024 at 12:39:33PM +0200, Hannes Reinecke wrote:
>> On 8/27/24 19:52, Eric Biggers wrote:
>>> On Tue, Aug 13, 2024 at 01:15:04PM +0200, Hannes Reinecke wrote:
>>>> Separate out the HKDF functions into a separate module to
>>>> to make them available to other callers.
>>>> And add a testsuite to the module with test vectors
>>>> from RFC 5869 to ensure the integrity of the algorithm.
>> [ .. ]
>>>> +	desc->tfm = hmac_tfm;
>>>> +
>>>> +	for (i = 0; i < okmlen; i += hashlen) {
>>>> +
>>>> +		err = crypto_shash_init(desc);
>>>> +		if (err)
>>>> +			goto out;
>>>> +
>>>> +		if (prev) {
>>>> +			err = crypto_shash_update(desc, prev, hashlen);
>>>> +			if (err)
>>>> +				goto out;
>>>> +		}
>>>> +
>>>> +		if (info && infolen) {
>>>
>>> 'if (infolen)' instead of 'if (info && infolen)'.  The latter is a bad practice
>>> because it can hide bugs.
>>>
>> Do I need to set a 'WARN_ON(!info)' (or something) in this case? Or are the
>> '->update' callbacks expected to handle it themselves?
> 
> No, if someone does pass NULL with a nonzero length there will be a crash.  But
> the same will happen with another invalid pointer that is not NULL.  It's just a
> bad practice to insert random NULL checks like this because it can hide bugs.
> Really a call like info=NULL, infolen=10 is ambiguous --- you've made it
> silently override infolen to 0 but how do you know the caller wanted that?
> 
Just wanted to clarify; different maintainers have different styles ...

>>>> +#ifdef CONFIG_CRYPTO_HKDF
>>>> +int hkdf_extract(struct crypto_shash *hmac_tfm, const u8 *ikm,
>>>> +		 unsigned int ikmlen, const u8 *salt, unsigned int saltlen,
>>>> +		 u8 *prk);
>>>> +int hkdf_expand(struct crypto_shash *hmac_tfm,
>>>> +		const u8 *info, unsigned int infolen,
>>>> +		u8 *okm, unsigned int okmlen);
>>>> +#else
>>>> +static inline int hkdf_extract(struct crypto_shash *hmac_tfm,
>>>> +			       const u8 *ikm, unsigned int ikmlen,
>>>> +			       const u8 *salt, unsigned int saltlen,
>>>> +			       u8 *prk)
>>>> +{
>>>> +	return -ENOTSUP;
>>>> +}
>>>> +static inline int hkdf_expand(struct crypto_shash *hmac_tfm,
>>>> +			      const u8 *info, unsigned int infolen,
>>>> +			      u8 *okm, unsigned int okmlen)
>>>> +{
>>>> +	return -ENOTSUP;
>>>> +}
>>>> +#endif
>>>> +#endif
>>>
>>> This header is missing <crypto/hash.h> which it depends on.
>>>
>>> Also the !CONFIG_CRYPTO_HKDF stubs are unnecessary and should not be included.
>>>
>> But that would mean that every call to '#include <crypto/hkdf.h>' would need
>> to be encapsulated by 'CONFIG_CRYPTO_HKDF' (or the file itself is
>> conditionally compiled on that symbol).
> 
> No, it doesn't mean that.  As long as the functions are not called when
> !CONFIG_CRYPTO_HKDF, it doesn't hurt to have declarations of them.
> 
Guess that is correct. Will be reposting the series.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


