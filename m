Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2625F606A31A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jcp+GzaE;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ca5zeTkf;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vY5oRYYM;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ghIxIZm6;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qnZBGbnf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=KnaMwCaxt/7le5UHPvV2umlXDPi1rOeNZD6iW8mwuVs=; b=jcp+GzaEeEzrHR
	0csqCjiQWfws2DRjJ5qMRbvj3on8IcrfbTNupxIiCKPhXPzgvM4WBZpw6F2HfpXpMkJ8liTnzNaWK
	eYc/XNbvlFbNK+NGIiyHO92rvrCkcpB0tqMExqgGT8rAsXjugTA80SDgeqXBCZXfEjlCQH5m0vV/f
	iCLDvc2s1pXLUUt2Ev+6y6wnbuQzSdUB9qzW4bt+V2T+v3/bk5GV53/fnk1/tKqI2zsaYSRisPzWh
	+OaH9htgrAhxqc6AV19BLZFRiHOiDcIc1H/fcISg2hxarcJrobwrK3Eqw4hd8yrQnfZmueZqZuFCr
	0SD5k/OTDVYu1I0Iblyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVW26-0000000408w-3TNU;
	Mon, 23 Nov 2026 15:32:42 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVW23-0000000406P-45gZ
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 15:32:41 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D053D220F9;
	Mon, 23 Nov 2026 15:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795447958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnaMwCaxt/7le5UHPvV2umlXDPi1rOeNZD6iW8mwuVs=;
	b=ca5zeTkfPJ+Cw+oVVldW4PoJ73GrM2MYdpwLSe9aAGxSXUN/QLbd1zDVfwuV6GtZfVVVX6
	r01FSQihTcbtyTKk9hLhEOZJ5zXLCi9ng/Uy9aS5IaHGsQFCL6kJxr10pFEXSgJfNsU3Gb
	UVrLkpDBMl/HeZZhJP9sb+/f9eqprPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795447958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnaMwCaxt/7le5UHPvV2umlXDPi1rOeNZD6iW8mwuVs=;
	b=vY5oRYYMClMHA3dEV3/wfefzMwOZZsCitujsU3WTq/b+RYZNdybWQSGRxmulj1QzxWqhZY
	vmrUYFJs6WnAxNAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795447957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnaMwCaxt/7le5UHPvV2umlXDPi1rOeNZD6iW8mwuVs=;
	b=ghIxIZm62Ukn1X4kWEDNutY+ayy6DGpeNth/4nNxZm0zqjim/RtJp0bUGV4+1zRIzIeOZM
	hL52RDdfoeYzprjjz9j2c5AzzGg3fhhYAIJIYDidP/S+ndhbXdfM2OvClQwZugcVMTfyEA
	kE65HyNjUuYZCUilwPpp4CSTOymvITc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795447957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnaMwCaxt/7le5UHPvV2umlXDPi1rOeNZD6iW8mwuVs=;
	b=qnZBGbnfKHJ6wCO4Z3FwmspQky3NAxRFRp+n/UP4B+n22XH0Qr7bYkWrtsHlbmfZ+nWA1k
	JdiWocgJD0Z5iWCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D87E13510;
	Mon, 23 Nov 2026 15:32:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2Q2QHZVcBGu+HQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Nov 2026 15:32:37 +0000
Message-ID: <ba2c735c-f4ce-4492-980b-91933dea7030@suse.de>
Date: Mon, 23 Nov 2026 16:32:37 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] nvme-fabrics: allow to pass in keyring by name
To: sashiko-reviews@lists.linux.dev, Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
 <20261123-dhchap-keyring-v4-v5-8-81eefb4c0724@kernel.org>
 <sashiko-outbox-229220@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sashiko-outbox-229220@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.28 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.995];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.28
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_073240_165889_025998E8 
X-CRM114-Status: GOOD (  22.21  )
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 1:29 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] nvme-fabrics: keyring= fails in nvmf_parse_options() for
>    CONFIG_NVME_KEYRING=m
> - [Medium] nvme-fabrics: match_int() in nvmf_parse_options() misparses
>    keyring names
> --
> 
> commit 357df670b0cbbd8ea5cc07d96b4413e6b84ca631
> Author: Hannes Reinecke <hare@kernel.org>
> 
> nvme-fabrics: allow to pass in keyring by name
> 
> This commit updates the NVMe-oF option parser to accept a keyring name
> in addition to a numeric key serial ID for the keyring= option.
> 
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index 1277749c6e2e3..5dc1e1d5fb462 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
> 
> [ ... ]
> 
>> @@ -697,7 +698,7 @@ static const match_table_t opt_tokens = {
>>   	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
>>   	{ NVMF_OPT_TOS,			"tos=%d"		},
>>   #ifdef CONFIG_NVME_TCP_TLS
>> -	{ NVMF_OPT_KEYRING,		"keyring=%d"		},
>> +	{ NVMF_OPT_KEYRING,		"keyring=%s"		},
>>   	{ NVMF_OPT_TLS_KEY,		"tls_key=%d"		},
>>   #endif
>>   	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
>> @@ -992,17 +993,33 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>>   			opts->tos = token;
>>   			break;
>>   		case NVMF_OPT_KEYRING:
>> +#ifdef CONFIG_NVME_KEYRING
>>   			if (match_int(args, &key_id) || key_id <= 0) {
> 
> [Severity: Medium]
> Can match_int() misparse a keyring name that starts with a positive
> number (such as "1nvme") as a numeric key serial ID?
> 
> Because opt_tokens now matches keyring=%s instead of %d, args[0] spans
> the entire string without requiring all characters to be digits.
> match_int() -> match_number() calls simple_strtol(buf, &endp, 0) and
> only checks endp == buf, ignoring trailing non-numeric characters on
> strings under 24 bytes.  A keyring name with a leading positive integer
> will therefore take the else branch and pass that prefix to
> nvmf_parse_key(key_id) instead of looking up the keyring by name via
> request_key().
> 
Yes, it can. but this will be a user error.

>> -				ret = -EINVAL;
>> -				goto out;
>> -			}
>> -			key = nvmf_parse_key(key_id);
>> -			if (IS_ERR(key)) {
>> -				ret = PTR_ERR(key);
>> -				goto out;
>> +				p = match_strdup(args);
>> +				if (!p) {
>> +					ret = -ENOMEM;
>> +					goto out;
>> +				}
>> +				key = request_key(&key_type_keyring, p, NULL);
>> +				kfree(p);
>> +				if (IS_ERR(key)) {
>> +					ret = PTR_ERR(key);
>> +					goto out;
>> +				}
>> +			} else {
>> +				key = nvmf_parse_key(key_id);
>> +				if (IS_ERR(key)) {
>> +					ret = PTR_ERR(key);
>> +					goto out;
>> +				}
>>   			}
>>   			key_put(opts->keyring);
>>   			opts->keyring = key;
>> +#else
>> +			pr_warn("nvme keyring is disabled\n");
>> +			ret = -EINVAL;
>> +			goto out;
>> +#endif
> 
> [Severity: High]
> Does #ifdef CONFIG_NVME_KEYRING reject all keyring= options with
> -EINVAL when CONFIG_NVME_KEYRING=m?
> 
> NVME_KEYRING is a tristate Kconfig symbol, so modular builds define
> CONFIG_NVME_KEYRING_MODULE rather than CONFIG_NVME_KEYRING, causing
> nvmf_parse_options() to compile the #else branch and fail controller
> creation.  Should this use #if IS_ENABLED(CONFIG_NVME_KEYRING) (like
> include/linux/nvme-keyring.h)?
> 
Fixed with the next version.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

