Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD1D606A31C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Nov 2026 07:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fU0Ylwb2;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KHcsXrjD;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NoNGpXVH;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Bc4Q+dkg;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=U0ALdJHp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=fBmjhE/V6C68f89gyfKTLhS6msoc6WeCZ60pd1YokEk=; b=fU0Ylwb2u1YWWw
	ZxwLci2tS9d7rl8pk5bTlBGXRu/m+rJvRby5l+oHO99aG3bQt1zb73XJFQ4Zye3ZU6EkO6G5tD6qv
	EX/AKlk1WsSdKvuDYJ6JEV/t36p1nGMAQ+ljLXDtjNTP+7esjgoX2zU3hfE0W3jcbDMahLKNbE4pb
	nnpgiQD43em9ulXezFB+JKZKnb6tT3Nru2dGwO1lWDUwLpSCGANdq4QvIxXNG5sy0Lrd3eB+eXBP1
	vvath7YnFjthOvu9hmxx31Mp9eQeogFwDddFFwczH+iMHckhdgPtCunVHNbrcPrQJ6u7poSVXl2HV
	FMxcLy34BL9AnLnmmhTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWqIh-0000000F6gE-2Q74;
	Fri, 27 Nov 2026 07:23:19 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWqIe-0000000F6fP-2J5u
	for linux-nvme@lists.infradead.org;
	Fri, 27 Nov 2026 07:23:17 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DE9FA1F390;
	Fri, 27 Nov 2026 07:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795764193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBmjhE/V6C68f89gyfKTLhS6msoc6WeCZ60pd1YokEk=;
	b=KHcsXrjDV7Sfc6aOYOxnSjXBi2OJQFP28VWxbIt+TxEd/huEW/6BA49reutfy9k4Dbxrn9
	/bw62EcnnfU8BSJdDTnrkYbxuGik2CZQ59YPabE7PDn4Ad9py04LHYGhK3FhGAapJ4af2B
	f8+ZJk+X9JTL8FInyd3jXG/ACRI1KLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795764193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBmjhE/V6C68f89gyfKTLhS6msoc6WeCZ60pd1YokEk=;
	b=NoNGpXVHcI9a0YymeTk0pde8SfbD2qizAf7sKa7yLqm6j5NhR5qwM0fjSC5uPI+sdz6gKh
	WCjW7Fg/wYNZNkCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Bc4Q+dkg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=U0ALdJHp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795764191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBmjhE/V6C68f89gyfKTLhS6msoc6WeCZ60pd1YokEk=;
	b=Bc4Q+dkgSncJ32lEP5eNAKIOhNGfOcklLhxHBjiTHENBhS4N/cBHg79fF2MpNzm3oL7nQ0
	okkkdBdqTvIP59hAhwvBR/LxghpnX9FwFTrVxtEFKmSRjJX6hYtkNmh8p+bf1P84hXQrKD
	IZSqtI24uFAw08/lpIOzluD76IwGzQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795764191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBmjhE/V6C68f89gyfKTLhS6msoc6WeCZ60pd1YokEk=;
	b=U0ALdJHpstQjhOi4j072EhKMclxdHQQQQthPRNPT2sqjCpIUjTpNOyL58RfBqU4FQrcYCh
	5sdEXMuQo0tcTEBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F29A13432;
	Fri, 27 Nov 2026 07:23:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yQLJOd4vCWtYHAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 27 Nov 2026 07:23:11 +0000
Message-ID: <6cb250d6-b566-4ea1-b586-5731ed148c04@suse.de>
Date: Fri, 27 Nov 2026 08:23:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/14] nvme-auth: switch to use 'struct key'
To: sashiko-reviews@lists.linux.dev, Hannes Reinecke <hare@kernel.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Eric Biggers <ebiggers@kernel.org>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, keyrings@vger.kernel.org
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-6-ee438ffea527@kernel.org>
 <sashiko-outbox-235725@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sashiko-outbox-235725@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: DE9FA1F390
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261126_232316_767202_4C4C4250 
X-CRM114-Status: GOOD (  20.75  )
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

On 11/26/26 3:33 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] nvme-keyring: nvme_dhchap_psk_create() overwrites
>    key_create() error codes
> --
> 
> commit d2027ac3b70964c8a70b1644b2224565f8d1e622
> Author: Hannes Reinecke <hare@kernel.org>
> 
> nvme-auth: switch to use 'struct key'
> 
> This commit replaces struct nvme_dhchap_key with the kernel keyring's
> struct key using the "dhchap" key type for storing and transforming
> DH-HMAC-CHAP keys.
> 
>> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
>> index 0fc6b4825c2dd..dc0a4fb9296f1 100644
>> --- a/drivers/nvme/common/keyring.c
>> +++ b/drivers/nvme/common/keyring.c
>> @@ -464,6 +464,91 @@ static struct key_type nvme_dhchap_psk_key_type = {
>>   	.read           = nvme_dhchap_psk_read,
>>   };
>>   
>> +/**
>> + * nvme_dhchap_psk_create - Create DH-HMAC-CHAP key
>> + * @data: Key data
>> + * @data_len: Length of @data
>> + *
>> + * Creates a new DH-HMAC-CHAP key with a random UUID as the key identity.
>> + * Returns the new key or an error pointer on failure.
>> + */
>> +struct key *nvme_dhchap_psk_create(const char *data, size_t data_len)
>> +{
>> +	key_perm_t keyperm =
>> +		KEY_POS_SEARCH | KEY_POS_VIEW | KEY_POS_READ |
>> +		KEY_POS_WRITE | KEY_POS_LINK | KEY_POS_SETATTR |
>> +		KEY_USR_SEARCH | KEY_USR_VIEW | KEY_USR_READ;
>> +	char *identity;
>> +	key_ref_t keyref;
>> +	struct key *key;
>> +	uuid_t key_uuid;
>> +
>> +	if (data == NULL || !data_len)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	generate_random_uuid(key_uuid.b);
>> +	identity = kasprintf(GFP_KERNEL, "%pU", &key_uuid);
>> +	if (!identity)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	pr_debug("generate dhchap psk '%s'\n", identity);
>> +	keyref = key_create(make_key_ref(nvme_keyring, true),
>> +			    "dhchap", identity, data, data_len,
>> +			    keyperm, KEY_ALLOC_NOT_IN_QUOTA |
>> +			    KEY_ALLOC_BUILT_IN |
>> +			    KEY_ALLOC_BYPASS_RESTRICTION);
>> +	if (IS_ERR(keyref)) {
>> +		pr_warn("refresh dhchap psk '%s' failed, error %ld\n",
>> +			identity, PTR_ERR(keyref));
>> +		kfree(identity);
>> +		return ERR_PTR(-ENOKEY);
>> +	}
> 
> [Severity: Medium]
> Should this return ERR_CAST(keyref) instead of ERR_PTR(-ENOKEY)?
> 
> When key_create() fails in nvme_dhchap_psk_preparse(), such as returning
> -EINVAL for a malformed secret or -EKEYREJECTED for a CRC mismatch,
> discarding PTR_ERR(keyref) causes nvme_auth_extract_key() callers like
> dhchap_secret_store() to report -ENOKEY to userspace instead of the
> underlying error code.
> 

Fixed with the next version.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

