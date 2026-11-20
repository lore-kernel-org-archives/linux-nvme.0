Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33095606A320
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=suKC4oC/;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FOY6KEZE;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OfVffPc4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FOY6KEZE;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OfVffPc4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=RgOITjIq4jGgZj+xgRbcW8OsF69eO4G5la7I84QrRqE=; b=suKC4oC/AttE/7
	jhJXyQf0Qq3g5JvOS1BJvT7w7loB3MoCLAh7i9w08M+itTl7MMzFAO59ix72+54NJFdyG9hyDmx36
	cpT1KZwERHpz4JmCus4IRRrQUkXbTPwZRywohLhdVUuhkDB+rWYEDo88PFYwUXE64JVUO7I5dO47k
	wzvuMa6aPGljGO9s5LZY4Vms+CGBHbiwWSwsyUi11iZ5lDXZssVzBWxHMre8ar3Zq2ctwLk+Kgwj4
	fzN137eTNby3t1GvumTLpf6Ae08/jvFp7ukKRYRCy8hhQUhxj2dWpo1Hu8TmZ+foUn53xNeO0hHYq
	Dw5CpTyUj6ioIZ2kPljg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUQWd-0000000FQG7-1Jn2;
	Fri, 20 Nov 2026 15:27:43 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUQWX-0000000FQEu-3tLQ
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 15:27:39 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 100CE1F38C;
	Fri, 20 Nov 2026 15:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795188456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgOITjIq4jGgZj+xgRbcW8OsF69eO4G5la7I84QrRqE=;
	b=FOY6KEZE5dJvM3PVCzCl9jX6HVOuWJv9NzTp2lP3k14fwZQuRAUzQmvsmFSa3MZcGoi3Fv
	NpkUVbehxCf+XxkK+PQzOOlLATbqXN16ZSLWmRNH/btjyjsH6Yxcp2WJhlep1z9CFr6w0B
	lLg4E41elMAO5ewYt2c/tfL2KzEO0dE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795188456;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgOITjIq4jGgZj+xgRbcW8OsF69eO4G5la7I84QrRqE=;
	b=OfVffPc40txtAabcUixgqHuC1r8EecraOUPe3NH2MnDhLJfum9c8Wuz1oWWMHoeSM3DzAZ
	zWXmLUEU+39YT3AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FOY6KEZE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OfVffPc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795188456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgOITjIq4jGgZj+xgRbcW8OsF69eO4G5la7I84QrRqE=;
	b=FOY6KEZE5dJvM3PVCzCl9jX6HVOuWJv9NzTp2lP3k14fwZQuRAUzQmvsmFSa3MZcGoi3Fv
	NpkUVbehxCf+XxkK+PQzOOlLATbqXN16ZSLWmRNH/btjyjsH6Yxcp2WJhlep1z9CFr6w0B
	lLg4E41elMAO5ewYt2c/tfL2KzEO0dE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795188456;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgOITjIq4jGgZj+xgRbcW8OsF69eO4G5la7I84QrRqE=;
	b=OfVffPc40txtAabcUixgqHuC1r8EecraOUPe3NH2MnDhLJfum9c8Wuz1oWWMHoeSM3DzAZ
	zWXmLUEU+39YT3AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFF511342D;
	Fri, 20 Nov 2026 15:27:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 72jWL+dmAGu+aAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 20 Nov 2026 15:27:35 +0000
Message-ID: <c9383994-9a83-4133-905e-a3625fc10ece@suse.de>
Date: Fri, 20 Nov 2026 16:27:35 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] nvmet: add configfs attribute 'dhchap_keyring'
To: sashiko-reviews@lists.linux.dev, Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
 <20261120-dhchap-keyring-v4-v4-9-5f8c7d9926ee@kernel.org>
 <sashiko-outbox-225082@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sashiko-outbox-225082@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 100CE1F38C
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.50 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.50
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_072738_342279_432EA160 
X-CRM114-Status: GOOD (  24.25  )
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

On 11/20/26 12:39 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issues to consider:
> - [High] nvmet: keyring reference leak in nvmet_host_release()
> - [Medium] nvmet: inverted error return sign in
>    nvmet_host_dhchap_keyring_store()
> - [Medium] nvmet: unlocked host->dhchap_keyring access in
>    nvmet_auth_set_key()
> - [Medium] nvmet: 1-byte OOB write in nvmet_host_dhchap_keyring_show()
>    via sprintf()
> --
> 
> commit 7f1bb5c7e432b0938e23615bf24751f61d823e03
> Author: Hannes Reinecke <hare@kernel.org>
> 
> nvmet: add configfs attribute 'dhchap_keyring'
> 
> This commit adds a dhchap_keyring configfs attribute to the nvmet host
> directory so userspace can specify the keyring used for DH-HMAC-CHAP key
> lookups.
> 
>> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
>> index 4f2489c5d894b..d583813ef4f27 100644
>> --- a/drivers/nvme/target/auth.c
>> +++ b/drivers/nvme/target/auth.c
>> @@ -68,7 +68,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
>>   		return 0;
>>   	}
>>   	len = strcspn(secret, "\n");
>> -	key = nvme_auth_extract_key(NULL, secret, len, &generated);
>> +	key = nvme_auth_extract_key(host->dhchap_keyring, secret, len, &generated);
>>   	if (IS_ERR(key)) {
>>   		pr_debug("%s: invalid key specification\n", __func__);
>>   		return PTR_ERR(key);
> 
> [Severity: Medium]
> Can a concurrent write to dhchap_keyring free host->dhchap_keyring while
> nvmet_auth_set_key() is using it?
> 
> CPU0                                    CPU1
> nvmet_host_dhchap_key_store()
>    nvmet_auth_set_key()
>      keyring = host->dhchap_keyring
>                                          nvmet_host_dhchap_keyring_store()
>                                            down_write(&nvmet_config_sem)
>                                            key_put(host->dhchap_keyring)
>                                            host->dhchap_keyring = new_ring
>                                            up_write(&nvmet_config_sem)
>      nvme_auth_extract_key(keyring, ...)
>        ...                               <-- use-after-free
> 
> nvmet_host_dhchap_keyring_store() replaces host->dhchap_keyring and drops
> the old reference under nvmet_config_sem, whereas nvmet_auth_set_key()
> reads and uses host->dhchap_keyring without holding nvmet_config_sem or
> pinning it with key_get().
> 
Fixed with the next version.

>> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
>> index 319947aa0a40f..ffe0f852e59d9 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -2347,6 +2347,62 @@ static ssize_t nvmet_host_dhchap_ctrl_key_store(struct config_item *item,
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
> Can sprintf() write one byte past the end of page here?
> 
> add_key() accepts descriptions up to 4095 bytes (KEY_MAX_DESC_SIZE - 1),
> and configfs fill_write_buffer() accepts a 4095-byte write without a
> trailing newline.  Formatting a 4095-byte keyring->description with "%s\n"
> writes 4097 bytes (including the NUL terminator) into the 4096-byte
> PAGE_SIZE configfs read buffer.  Using sysfs_emit() or snprintf(page,
> PAGE_SIZE, ...) would avoid the overflow.
> 
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
>> +	return ret ? -ret : count;
>> +}
> 
> [Severity: Medium]
> Does negating ret return a positive value when request_key() fails?
> PTR_ERR(keyring) is already negative, so returning -ret causes
> configfs_write_iter() to treat the positive errno as a successful write
> byte count and silently ignore the failure.
> 
Fixed with the new version.

> [ ... ]
> 
>> @@ -2445,6 +2502,11 @@ static struct config_group *nvmet_hosts_make_group(struct config_group *group,
>>   #ifdef CONFIG_NVME_TARGET_AUTH
>>   	/* Default to SHA256 */
>>   	host->dhchap_hash_id = NVME_AUTH_HASH_SHA256;
>> +	host->dhchap_keyring = key_lookup(nvme_keyring_id());
>> +	if (IS_ERR(host->dhchap_keyring)) {
>> +		kfree(host);
>> +		return ERR_PTR(-ENOKEY);
>> +	}
>>   #endif
>>   
>>   	config_group_init_type_name(&host->group, name, &nvmet_host_type);
> 
> [Severity: High]
> Does removing a host group leak host->dhchap_keyring?
> 
> Both key_lookup() here and request_key() in
> nvmet_host_dhchap_keyring_store() acquire a reference on
> host->dhchap_keyring, but nvmet_host_release() never calls
> key_put(host->dhchap_keyring):
> 
> drivers/nvme/target/configfs.c:nvmet_host_release() {
> 	struct nvmet_host *host = to_host(item);
> 
> #ifdef CONFIG_NVME_TARGET_AUTH
> 	nvmet_auth_revoke_key(host, false);
> 	nvmet_auth_revoke_key(host, true);
> #endif
> 	kfree(host);
> }
> 
> Every removed host configfs directory leaks a reference on its configured
> keyring.
> 
Fixed with the next version.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

