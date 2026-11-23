Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE5E606A31F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cQNUrF59;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=SfhQ2ec/;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=2vI4RPDc;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=SfhQ2ec/;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=2vI4RPDc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=A3PkSOCe7exa6vD5VedDuqzXSgVCnaD+BSal1yaiBLs=; b=cQNUrF59YhpPVM
	xWKycVOKASQgohOqTyCnMO3D9S4Wg52I7zPGua9PJyGHUc96HWAOKAVLvhCZlY+68gApHI1dvrKln
	+/wZDHh4Eoalwk/cooQ9MuH8KH4jW1o2xgIKb5TZ168b8x1TQo4JUGNlZm7ZgVCtYoFKuawv/Nmm8
	uPlbKYvR1YN31zDFD/LGOpBhGq7fKRC4yg/ASUqsHoJqEx1nv/bzgEtF907y5QeQryJg4jAQeZuvi
	RYYKIu57fX57/NNkEpIEI5Kl5VeIJpLd78OTjd6ttdZX74CFyMS17EPw527ugZ9RHCjpv9D+P58gC
	PJDPPazgzqEjJjC+sz2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVW7m-000000042MU-3JZa;
	Mon, 23 Nov 2026 15:38:34 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVW7k-000000042Lz-2NOU
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 15:38:34 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8BE7A1F850;
	Mon, 23 Nov 2026 15:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795448310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3PkSOCe7exa6vD5VedDuqzXSgVCnaD+BSal1yaiBLs=;
	b=SfhQ2ec/Qs9bdSWWkM4tPOOyCmv+oua6YHMdxqFmdV9dlx+b8zkUs9l5Ofg0oDI8pgVpx0
	SaQCcAx+r1GYjFCXZVBjCzYdvLZmxSZzgRrYyP5FvMXMk6JOhx9d1Bk2kf4H2yM9En140N
	EyMTbVfK5lEcwrgzXV9536VwSuk72RE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795448310;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3PkSOCe7exa6vD5VedDuqzXSgVCnaD+BSal1yaiBLs=;
	b=2vI4RPDceQba6eiKKCh8GyBaSY+phiqkegB5BEjqpD52BankMJMNr/+0CMeHA/LEJxR7PZ
	ROfGAWLekEnN2wDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="SfhQ2ec/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2vI4RPDc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795448310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3PkSOCe7exa6vD5VedDuqzXSgVCnaD+BSal1yaiBLs=;
	b=SfhQ2ec/Qs9bdSWWkM4tPOOyCmv+oua6YHMdxqFmdV9dlx+b8zkUs9l5Ofg0oDI8pgVpx0
	SaQCcAx+r1GYjFCXZVBjCzYdvLZmxSZzgRrYyP5FvMXMk6JOhx9d1Bk2kf4H2yM9En140N
	EyMTbVfK5lEcwrgzXV9536VwSuk72RE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795448310;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3PkSOCe7exa6vD5VedDuqzXSgVCnaD+BSal1yaiBLs=;
	b=2vI4RPDceQba6eiKKCh8GyBaSY+phiqkegB5BEjqpD52BankMJMNr/+0CMeHA/LEJxR7PZ
	ROfGAWLekEnN2wDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5829713510;
	Mon, 23 Nov 2026 15:38:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id adNkC/ZdBGu2IwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Nov 2026 15:38:30 +0000
Message-ID: <bb31f7cf-a23b-4f19-9fcc-bac4a4163831@suse.de>
Date: Mon, 23 Nov 2026 16:38:29 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] nvmet: add configfs attribute 'dhchap_keyring'
To: sashiko-reviews@lists.linux.dev, Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
 <20261123-dhchap-keyring-v4-v5-9-81eefb4c0724@kernel.org>
 <sashiko-outbox-229228@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sashiko-outbox-229228@kernel.org>
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
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 8BE7A1F850
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_073832_896478_1DDAAC23 
X-CRM114-Status: GOOD (  27.30  )
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

On 11/23/26 1:35 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issues to consider:
> - [High] nvmet: NULL pointer dereference in nvmet_auth_set_key() when
>    clearing key
> - [Medium] nvmet: cannot write or reset .nvme in
>    nvmet_host_dhchap_keyring_store()
> - [Medium] nvmet: 1-byte OOB write in nvmet_host_dhchap_keyring_show()
>    via sprintf()
> --
> 
> commit 1e868858e36190db74c6e7c75fe1ba260a535d71
> Author: Hannes Reinecke <hare@kernel.org>
> 
> nvmet: add configfs attribute 'dhchap_keyring'
> 
> This commit adds a dhchap_keyring configfs attribute to the nvmet host
> group so userspace can select which keyring is used to look up DH-HMAC-CHAP
> keys.
> 
>> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
>> index 7204ace149565..84091803af300 100644
>> --- a/drivers/nvme/target/auth.c
>> +++ b/drivers/nvme/target/auth.c
>> @@ -68,7 +68,9 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
>>   		return 0;
>>   	}
>>   	len = strcspn(secret, "\n");
>> -	key = nvme_auth_extract_key(NULL, secret, len, &generated);
>> +	down_read(&nvmet_config_sem);
>> +	key = nvme_auth_extract_key(host->dhchap_keyring, secret, len, &generated);
>> +	up_read(&nvmet_config_sem);
>>   	if (IS_ERR(key)) {
>>   		pr_debug("%s: invalid key specification\n", __func__);
>>   		return PTR_ERR(key);
> 
> [Severity: High]
> Does nvmet_auth_set_key() dereference a NULL secret when clearing a key via
> configfs?
> 
> Earlier in this series, commit "nvmet-auth: parse dhchap key from configfs
> attribute" updated nvmet_host_dhchap_key_store() and
> nvmet_host_dhchap_ctrl_key_store() to leave keydata as NULL when an empty
> line is written:
> 
> drivers/nvme/target/configfs.c:nvmet_host_dhchap_key_store() {
> 	...
> 	len = strcspn(page, "\n");
> 	if (len) {
> 		keydata = kstrndup(page, len, GFP_KERNEL);
> 		if (!keydata)
> 			return -ENOMEM;
> 	}
> 
> 	ret = nvmet_auth_set_key(host, keydata, false);
> 	...
> }
> 
> nvmet_auth_set_key() then checks if (!strlen(secret)) without testing
> !secret first, triggering a NULL pointer dereference whenever an empty
> string or newline is written to dhchap_key or dhchap_ctrl_key to revoke a
> configured key.
> 

Fixed with the next version.

>> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
>> index bc46d760aaa4a..eb20599cf372d 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -2348,6 +2348,62 @@ static ssize_t nvmet_host_dhchap_ctrl_key_store(struct config_item *item,
>>   
>>   CONFIGFS_ATTR(nvmet_host_, dhchap_ctrl_key);
>>   
>> +static ssize_t nvmet_host_dhchap_keyring_show(struct config_item *item,
>> +		char *page)
>> +{
>> +	struct nvmet_host *host = to_host(item);
>> +	struct key *keyring;
>> +	ssize_t ret;
>> +
>> +	down_read(&nvmet_config_sem);
>> +	keyring = key_get(host->dhchap_keyring);
>> +	if (!keyring) {
>> +		page[0] = '\0';
>> +		ret = 0;
>> +	} else {
>> +		down_read(&keyring->sem);
>> +		if (key_validate(keyring))
>> +			ret = sprintf(page, "<invalidated>\n");
>> +		else
>> +			ret = sprintf(page, "%s\n", keyring->description);
>> +		up_read(&keyring->sem);
>> +		key_put(keyring);
>> +	}
>> +	up_read(&nvmet_config_sem);
>> +	return ret;
>> +}
> 
> [Severity: Medium]
> Can sprintf(page, "%s\n", keyring->description) write one byte past the end
> of the PAGE_SIZE configfs read buffer?
> 
> add_key() allows keyring descriptions of up to KEY_MAX_DESC_SIZE - 1 (4095)
> bytes, and writing a 4095-byte description without a trailing newline to
> dhchap_keyring succeeds in nvmet_host_dhchap_keyring_store().  Reading
> dhchap_keyring afterwards writes 4095 description bytes, a newline, and a
> NUL terminator at page[4096], overflowing the 4096-byte buffer by one byte.
> Using snprintf(page, PAGE_SIZE, ...) avoids the out-of-bounds write.
> 

Fixed with the next version.

>> +
>> +static ssize_t nvmet_host_dhchap_keyring_store(struct config_item *item,
>> +		const char *page, size_t count)
>> +{
>> +	struct nvmet_host *host = to_host(item);
>> +	struct key *keyring;
>> +	char *desc;
>> +	size_t len;
>> +	int ret = 0;
>> +
>> +	len = strcspn(page, "\n");
>> +	if (!len)
>> +		return -EINVAL;
>> +	desc = kstrndup(page, len, GFP_KERNEL);
>> +	if (!desc)
>> +		return -ENOMEM;
>> +	keyring = request_key(&key_type_keyring, desc, NULL);
>> +	if (IS_ERR(keyring)) {
>> +		ret = PTR_ERR(keyring);
>> +	} else {
>> +		down_write(&nvmet_config_sem);
>> +		key_put(host->dhchap_keyring);
>> +		host->dhchap_keyring = keyring;
>> +		up_write(&nvmet_config_sem);
>> +	}
>> +	kfree(desc);
>> +
>> +	return ret < 0 ? ret : count;
>> +}
> 
> [ ... ]
> 
>> @@ -2446,6 +2504,11 @@ static struct config_group *nvmet_hosts_make_group(struct config_group *group,
>>   #ifdef CONFIG_NVME_TARGET_AUTH
>>   	/* Default to SHA256 */
>>   	host->dhchap_hash_id = NVME_AUTH_HASH_SHA256;
>> +	host->dhchap_keyring = key_lookup(nvme_keyring_id());
>> +	if (IS_ERR(host->dhchap_keyring)) {
>> +		kfree(host);
>> +		return ERR_PTR(-ENOKEY);
>> +	}
>>   #endif
> 
> [Severity: Medium]
> Can userspace restore or reset dhchap_keyring back to the default .nvme
> keyring through nvmet_host_dhchap_keyring_store()?
> 
> nvmet_hosts_make_group() initializes host->dhchap_keyring to the .nvme
> keyring via key_lookup(nvme_keyring_id()), so reading dhchap_keyring shows
> ".nvme" (and the !keyring branch in nvmet_host_dhchap_keyring_show() is
> unreachable).  However, nvme_keyring_init() allocates .nvme without linking
> it into any process keyring, while nvmet_host_dhchap_keyring_store() looks
> up desc via request_key(&key_type_keyring, desc, NULL), which only searches
> the calling process's keyrings and rejects empty writes with -EINVAL.
> 
> As a result, tools such as nvmetcli that save and restore configfs
> attributes fail with -ENOKEY when writing ".nvme" back unless .nvme was
> manually linked into the caller's session keyring, and writing an empty
> value to reset dhchap_keyring to the default fails with -EINVAL.
> 
Fixed with the next version.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

