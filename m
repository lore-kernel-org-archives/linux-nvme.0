Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6FA606A320
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qYlQzsLj;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=PIQF/vc/;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=75DUBq8G;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=welM6Cm/;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qAdSAaXq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9kII+jywt/ta+JHRA+V7ZiU0gWh3jMuIzZ0cJW4CYoY=; b=qYlQzsLjC5fZjK
	b/U+SorarNYBSyACPz45HQTJMnoXiZwkctH0l0S18T6xZM6rrC9G7lUk1SmXjazkm3YoXWHcewg+r
	Ddh7hUPqFWxM7lfB0SrIo/YZeIDwzfLfHoVzxbPfUe7LxKKlJPuItqWI6xN7Jb+2qpjebfu1GAuQh
	NO8ihnNBWBwJzQTUVDX2vMFeNpFFGOl9LYqpN2OyMPNa2YemFcR1a0f5cqjggAkLzwOB2sXxKSs08
	81vbZjmoawStQeFaFLUfJ+hptan6eGSDmpSqcaQyIx+IWgK6cFnIX1Es5Usmo1d3GFFML7JknN9yU
	/z5STjK3aIoYMBHKsGXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUPvG-0000000FJ7R-2SUx;
	Fri, 20 Nov 2026 14:49:06 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUPvB-0000000FJ6T-3Sll
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 14:49:05 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DCC6D1F7C5;
	Fri, 20 Nov 2026 14:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795186140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9kII+jywt/ta+JHRA+V7ZiU0gWh3jMuIzZ0cJW4CYoY=;
	b=PIQF/vc/FP3l2xnPtg0zXnbz/gTs91U3QcqbTxS08zZiWQG8XnO4AQm5oie5Zq+X3FRIXc
	Hgk0d/iUawahbq5YOookfDwWmzzsdpJmBBcMCcdG3WqUj/L4regEAGrGRtCDBqIaeU6zTH
	2HqMt766o81CpW7BVJGvs8GhGfwZDmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795186140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9kII+jywt/ta+JHRA+V7ZiU0gWh3jMuIzZ0cJW4CYoY=;
	b=75DUBq8GvGl6oAdy1XUcYip57vYCIcDjH9ZFyyNpCKANZQUd8mwWRoIUsjh/rbfl/dGg/f
	kSiJ6c5Qv1iRJEBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795186139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9kII+jywt/ta+JHRA+V7ZiU0gWh3jMuIzZ0cJW4CYoY=;
	b=welM6Cm/9/2DxCudG7p59pdqCwAqQnl7UDsRqg37WPKAvMZoT8O8L2Cj2feKLLveHFatSQ
	tRqaMzHKilUaYAqthLgJ8oyNb7rHfjTAt3ncIDiTdaNiX3/2edhsG60LuZeVBKlTtTJZXW
	gt5aStb5ytkVLtiNxoV9iGcaadJHkRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795186139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9kII+jywt/ta+JHRA+V7ZiU0gWh3jMuIzZ0cJW4CYoY=;
	b=qAdSAaXq5n7lvKNJ7k7AgJ6sSSkTnNDBQfnppWgvVihZ+ws8y8kN3K1Xn29cAch/GaTJ9C
	xxCmj9V0m6npMvDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6C8A1342D;
	Fri, 20 Nov 2026 14:48:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3MhOINtdAGvsQQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 20 Nov 2026 14:48:59 +0000
Message-ID: <c19b8afa-8a14-4ba5-a1f7-2d2a89ec5e9d@suse.de>
Date: Fri, 20 Nov 2026 15:48:59 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] nvme: allow to pass in key description as dhchap
 secret
To: sashiko-reviews@lists.linux.dev, Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
 <20261120-dhchap-keyring-v4-v4-6-5f8c7d9926ee@kernel.org>
 <sashiko-outbox-225046@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sashiko-outbox-225046@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.996];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Score: -13.29
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_064902_180667_92823B45 
X-CRM114-Status: GOOD (  34.95  )
X-Spam-Score: -4.4 (----)
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

On 11/20/26 12:31 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 9 potential
> issues to consider:
> - [High] nvme-fabrics: wrong key revoked in nvmf_free_options() for
>    dhchap_ctrl_key
> - [High] nvme-auth: empty/prefix match and self-revocation in
>    nvme_auth_extract_key()
> - [High] nvme-fabrics: link failure calling nvme_auth_extract_key()
>    without NVME_AUTH
> - [Medium] nvme: unlocked access to dhchap keys and flags in sysfs show
>    callbacks
> - [Medium] nvme: broken sysfs visibility for dhchap_key in
>    nvme_dev_attrs_are_visible()
> - [Medium] nvme-auth: host_key leak and stale flags on
>    nvme_auth_init_ctrl() error
> - [Medium] nvmet: memory leak of keydata buffer in
>    nvmet_host_dhchap_ctrl_key_store()
> - [Low] nvme: unsigned count and missing newline in
>    dhchap_ctrl_secret_show()
> - [Low] nvme-auth: missing keyring param in nvme_auth_extract_key()
>    kernel-doc
> --
> 
> commit 2b7a36fa0b1a7939d6a4d7f1cdc10818701d7d40
> Author: Hannes Reinecke <hare@kernel.org>
> 
> nvme: allow to pass in key description as dhchap secret
> 
> This commit updates nvme_auth_extract_key() to look up pre-populated
> DH-HMAC-CHAP keys in the keyring before falling back to generating an
> ephemeral key from raw secret material, and tracks whether keys were
> auto-generated across the host and target drivers so only generated keys
> are revoked on release.
> 
>> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
>> index b7092deed9b06..c65bfafe9e3fc 100644
>> --- a/drivers/nvme/common/auth.c
>> +++ b/drivers/nvme/common/auth.c
>> @@ -143,20 +143,32 @@ EXPORT_SYMBOL_GPL(nvme_auth_hmac_hash_len);
>>   /**
>>    * nvme_auth_extract_key - extract the DH-HMAC-CHAP key
>>    *
>> - * @secret: key data
>> - * @secret_len: length of @secret
>> + * @input: key serial or key data
>> + * @input_len: length of @input
>> + * @generated: indicate whether a key has been generated
>>    *
>> - * Extracts a dhchap key from @secret.
>> + * Extracts or generates a key from @input.
>> + * @input can either be a key serial or raw key data; in
>> + * the latter case a key is generated from @input and
>> + * @generated is set to 'true'.
>>    *
>>    * Returns the dhchap key or an error pointer on failure.
>>    */
>> -struct key *nvme_auth_extract_key(struct key *keyring, const char *secret,
>> -				  size_t secret_len)
>> +struct key *nvme_auth_extract_key(struct key *keyring, const char *input,
>> +				  size_t input_len, bool *generated)
> 
> [Severity: Low]
> The kernel-doc comment for nvme_auth_extract_key() omits the @keyring
> parameter, which triggers a W=1 kernel-doc warning.  Also, the comment and
> commit message describe @input as a key serial number even though
> nvme_dhchap_psk_lookup() searches by key description, and the prototype in
> include/linux/nvme-auth.h still names the parameters secret and secret_len.
> 
>>   {
>>   	struct key *key;
>>   
>> -	key = nvme_dhchap_psk_create(keyring, secret, secret_len);
>> +	/* Check if @input is a key serial number */
>> +	key = nvme_dhchap_psk_lookup(keyring, input);
>>   	if (!IS_ERR(key)) {
>> +		*generated = false;
>> +		return key;
>> +	}
>> +	/* Generate a key from @input data */
>> +	key = nvme_dhchap_psk_create(keyring, input, input_len);
>> +	if (!IS_ERR(key)) {
>> +		*generated = true;
>>   		pr_debug("generated dhchap key %s\n",
>>   			 key->description);
>>   	}
> 
> [Severity: High]
> Can calling nvme_dhchap_psk_lookup() here match the wrong key, read out of
> bounds, or cause the caller to revoke the key it just looked up?
> 
> nvme_dhchap_psk_lookup() searches with nvme_dhchap_psk_match():
> 
> drivers/nvme/common/keyring.c:nvme_dhchap_psk_match() {
> 	...
> 	match_id = match_data->raw_data;
> 	match_len = strlen(match_id);
> 	pr_debug("%s: match '%s' '%s' len %zd\n",
> 		 __func__, match_id, key->description, match_len);
> 
> 	return !memcmp(key->description, match_id, match_len);
> }
> 
> Because nvme_dhchap_psk_match() compares match_len bytes with memcmp()
> instead of strcmp(), and nvme_auth_extract_key() does not reject
> input_len == 0:
> 
> 1. Writing a single newline to sysfs dhchap_secret_store() or
>     dhchap_ctrl_secret_store() passes an empty string (match_len == 0), so
>     !memcmp(key->description, "", 0) matches the first dhchap key in the
>     keyring with *generated = false.
> 2. For non-empty inputs, memcmp() prefix-matches any key whose description
>     starts with input when match_len < strlen(key->description), and reads
>     past the end of the key->description allocation when match_len >
>     strlen(key->description) (for example, when passing a raw DHHC-1:...
>     secret while a key with a shorter description is in the keyring).
> 3. If nvme_dhchap_psk_lookup() returns the controller's or target host's
>     currently active auto-generated key (either via an empty write or by
>     writing the current key's UUID description to dhchap_secret_store(),
>     dhchap_ctrl_secret_store(), or nvmet_auth_set_key()), the store path
>     sees that old_key was auto-generated and calls key_revoke(old_key)
>     without checking key == old_key, revoking the key it then keeps active.
> 
key parsing has been fixed up with the updated version of the previous 
patch.

>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>> index c189096f825ea..470a6e7e43644 100644
>> --- a/drivers/nvme/host/auth.c
>> +++ b/drivers/nvme/host/auth.c
> [ ... ]
>> @@ -1071,6 +1081,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
>>   			 key_serial(ctrl->opts->dhchap_key));
>>   		return -ENOKEY;
>>   	}
>> +	ctrl->host_key_generated = ctrl->opts->dhchap_key_generated;
>>   	down_read(&ctrl->host_key->sem);
>>   	ret = key_validate(ctrl->host_key);
>>   	up_read(&ctrl->host_key->sem);
>> @@ -1097,6 +1108,8 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
>>   				 key_serial(ctrl->opts->dhchap_ctrl_key));
>>   			return -ENOKEY;
>>   		}
>> +		ctrl->ctrl_key_generated =
>> +			ctrl->opts->dhchap_ctrl_key_generated;
>>   		down_read(&ctrl->ctrl_key->sem);
>>   		ret = key_validate(ctrl->ctrl_key);
>>   		up_read(&ctrl->ctrl_key->sem);
> 
> [Severity: Medium]
> If acquiring or validating ctrl->ctrl_key fails in nvme_auth_init_ctrl(),
> does this leak ctrl->host_key and leave stale *_key_generated flags set?
> 
> On failure of key_get(ctrl->opts->dhchap_ctrl_key) or
> key_validate(ctrl->ctrl_key), nvme_auth_init_ctrl() returns -ENOKEY or
> -EKEYREVOKED without calling nvme_auth_clear_host_key(ctrl).  In
> nvme_init_ctrl(), a failure from nvme_auth_init_ctrl() jumps to
> out_release_instance before device_initialize(&ctrl->ctrl_device), so
> nvme_auth_free() never runs and the ctrl->host_key reference is leaked.
> The error paths after setting ctrl->host_key_generated and
> ctrl->ctrl_key_generated also clear the key pointer without resetting the
> corresponding generated boolean to false.
> 

Fixed with the next version.

>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index 7ed8618257ca9..cd728768a68fc 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
> [ ... ]
>> @@ -1089,7 +1091,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>>   	if (host_secret) {
>>   		pr_debug("lookup host identity '%s'\n", host_secret);
>>   		key = nvme_auth_extract_key(opts->keyring, host_secret,
>> -					    strlen(host_secret));
>> +					    strlen(host_secret),
>> +					    &opts->dhchap_key_generated);
>>   		if (IS_ERR(key)) {
>>   			ret = PTR_ERR(key);
>>   			goto out;
>> @@ -1104,7 +1107,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>>   		}
>>   		pr_debug("lookup ctrl identity '%s'\n", ctrl_secret);
>>   		key = nvme_auth_extract_key(opts->keyring, ctrl_secret,
>> -					    strlen(ctrl_secret));
>> +					    strlen(ctrl_secret),
>> +					    &opts->dhchap_ctrl_key_generated);
>>   		if (IS_ERR(key)) {
>>   			ret = PTR_ERR(key);
>>   			goto out;
> 
> [Severity: High]
> Does calling nvme_auth_extract_key() unconditionally in nvmf_parse_options()
> break linking when CONFIG_NVME_FABRICS is enabled without CONFIG_NVME_AUTH?
> 
> CONFIG_NVME_FABRICS does not select CONFIG_NVME_AUTH, and
> include/linux/nvme-auth.h does not provide a !CONFIG_NVME_AUTH stub for
> nvme_auth_extract_key(), so builds with CONFIG_NVME_HOST_AUTH disabled (or
> CONFIG_NVME_FABRICS=y and CONFIG_NVME_AUTH=m) fail to link.
> 
Fixed with the next version.

>> @@ -1327,15 +1331,23 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
>>   	kfree(opts->host_traddr);
>>   	kfree(opts->host_iface);
>>   	if (opts->dhchap_key) {
>> -		pr_debug("revoke dhchap host key %08x\n",
>> +		if (opts->dhchap_key_generated) {
>> +			pr_debug("revoke dhchap host key %08x\n",
>> +				 key_serial(opts->dhchap_key));
>> +			key_revoke(opts->dhchap_key);
>> +		}
>> +		pr_debug("drop dhchap host key %08x\n",
>>   			 key_serial(opts->dhchap_key));
>> -		key_revoke(opts->dhchap_key);
>>   		key_put(opts->dhchap_key);
>>   	}
>>   	if (opts->dhchap_ctrl_key) {
>> -		pr_debug("revoke dhchap ctrl key %08x\n",
>> +		if (opts->dhchap_ctrl_key_generated) {
>> +			pr_debug("revoke dhchap ctrl key %08x\n",
>> +				 key_serial(opts->dhchap_ctrl_key));
>> +			key_revoke(opts->dhchap_key);
>> +		}
>> +		pr_debug("drop dhchap ctrl key %08x\n",
>>   			 key_serial(opts->dhchap_ctrl_key));
>> -		key_revoke(opts->dhchap_key);
>>   		key_put(opts->dhchap_ctrl_key);
>>   	}
>>   	kfree(opts);
> 
> [Severity: High]
> In the opts->dhchap_ctrl_key block, should key_revoke(opts->dhchap_key) be
> key_revoke(opts->dhchap_ctrl_key)?
> 
> Passing opts->dhchap_key here accesses it after key_put(opts->dhchap_key)
> has already dropped the reference (risking a use-after-free), revokes a
> pre-populated host key when only the controller key was auto-generated, and
> leaves the auto-generated opts->dhchap_ctrl_key unrevoked.
> 
Fixed with the next version.

>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>> index 1311f5e29b004..47caed2ce3978 100644
>> --- a/drivers/nvme/host/sysfs.c
>> +++ b/drivers/nvme/host/sysfs.c
>> @@ -828,13 +828,14 @@ static ssize_t dhchap_secret_show(struct device *dev,
>>   	down_read(&key->sem);
>>   	if (key_validate(key))
>>   		count = sysfs_emit(buf, "<invalidated>\n");
>> -	else {
>> +	else if (ctrl->host_key_generated) {
>>   		count = key->type->read(key, buf, PAGE_SIZE);
>>   		if (count > 0) {
>>   			buf[count] = '\n';
>>   			count++;
>>   		}
>> -	}
>> +	} else
>> +		count = sysfs_emit(buf, "%s\n", key->description);
>>   	up_read(&key->sem);
>>   	return count;
>>   }
> [ ... ]
>> @@ -869,19 +872,25 @@ static ssize_t dhchap_secret_store(struct device *dev,
>>   	up_read(&key->sem);
>>   	if (ret) {
>>   		dev_warn(ctrl->dev, "key %08x invalidated\n", key_serial(key));
>> -		dev_dbg(ctrl->dev, "revoke host key %08x\n", key_serial(key));
>> -		key_revoke(key);
>> +		if (generated) {
>> +			dev_dbg(ctrl->dev, "revoke host key %08x\n", key_serial(key));
>> +			key_revoke(key);
>> +			synchronize_rcu();
>> +		}
>>   		key_put(key);
>>   		kfree_sensitive(dhchap_secret);
>>   		return ret;
>>   	}
>>   	mutex_lock(&ctrl->dhchap_auth_mutex);
>>   	old_key = ctrl->host_key;
>> -	dev_dbg(ctrl->dev, "revoke host key %08x\n",
>> -		key_serial(old_key));
>> -	key_revoke(old_key);
>> -
>> +	if (ctrl->host_key_generated) {
>> +		dev_dbg(ctrl->dev, "revoke host key %08x\n",
>> +			key_serial(old_key));
>> +		key_revoke(old_key);
>> +		synchronize_rcu();
>> +	}
>>   	ctrl->host_key = key;
>> +	ctrl->host_key_generated = generated;
>>   	mutex_unlock(&ctrl->dhchap_auth_mutex);
>>   	key_put(old_key);
>>   	kfree_sensitive(dhchap_secret);
> 
> [Severity: Medium]
> Can dhchap_secret_show(), dhchap_ctrl_secret_show(), dhchap_key_show(), and
> dhchap_ctrl_key_show() race with concurrent stores and trigger a
> use-after-free or read a mismatched *_key_generated flag?
> 
> Unlike nvmet_host_dhchap_key_show() in drivers/nvme/target/configfs.c, the
> host sysfs show callbacks read ctrl->host_key / ctrl->ctrl_key and
> ctrl->host_key_generated / ctrl->ctrl_key_generated without holding
> ctrl->dhchap_auth_mutex or pinning the key with key_get():
> 
> CPU0                                  CPU1
> dhchap_secret_show()                  dhchap_secret_store()
>    key = ctrl->host_key;
>                                          mutex_lock(&ctrl->dhchap_auth_mutex);
>                                          old_key = ctrl->host_key;
>                                          ctrl->host_key = new_key;
>                                          ctrl->host_key_generated = true;
>                                          mutex_unlock(&ctrl->dhchap_auth_mutex);
>                                          key_put(old_key);
>    down_read(&key->sem);  <-- use-after-free
> 
> Even if old_key still has another reference (such as when old_key was a
> pre-populated user key in the keyring), CPU0 can pair old_key with the newly
> written ctrl->host_key_generated == true and dump the pre-populated key's
> raw secret via key->type->read() instead of its description.
> 
Fixed with the next version.

>> @@ -906,13 +915,14 @@ static ssize_t dhchap_ctrl_secret_show(struct device *dev,
>>   	down_read(&key->sem);
>>   	if (key_validate(key))
>>   		count = sysfs_emit(buf, "<invalidated>");
>> -	else {
>> +	else if (ctrl->ctrl_key_generated) {
>>   		count = key->type->read(key, buf, PAGE_SIZE);
>>   		if (count > 0) {
>>   			buf[count] = '\n';
>>   			count++;
>>   		}
>> -	}
>> +	} else
>> +		count = sysfs_emit(buf, "%s\n", key->description);
>>   	up_read(&key->sem);
>>   	return count;
>>   }
> 
> [Severity: Low]
> In dhchap_ctrl_secret_show(), count is declared as unsigned size_t (unlike
> ssize_t in dhchap_secret_show()), so a negative error return from
> key->type->read() would wrap to a large positive value, pass count > 0, and
> write out of bounds at buf[count] = '\n'.  Also,
> sysfs_emit(buf, "<invalidated>") is missing the trailing '\n' present in the
> other show callbacks.
> 
Fixed with the next version.

> [ ... ]
> 
>> @@ -1066,8 +1088,12 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
>>   #ifdef CONFIG_NVME_HOST_AUTH
>>   	if (a == &dev_attr_dhchap_secret.attr && !ctrl->opts)
>>   		return 0;
>> +	if (a == &dev_attr_dhchap_key.attr && ctrl->host_key_generated)
>> +		return 0;
>>   	if (a == &dev_attr_dhchap_ctrl_secret.attr && !ctrl->opts)
>>   		return 0;
>> +	if (a == &dev_attr_dhchap_ctrl_key.attr && ctrl->ctrl_key_generated)
>> +		return 0;
>>   #endif
>>   
>>   	return a->mode;
> 
> [Severity: Medium]
> Should the visibility checks for dev_attr_dhchap_key.attr and
> dev_attr_dhchap_ctrl_key.attr also check !ctrl->opts, and how is attribute
> visibility updated when keys change at runtime?
> 
> Without a !ctrl->opts check, dhchap_key and dhchap_ctrl_key are exposed in
> sysfs on non-Fabrics controllers (such as PCIe controllers, where
> ctrl->opts is NULL and the *_key_generated fields are false) even though
> dhchap_secret and dhchap_ctrl_secret are hidden.  In addition, because
> nvme_dev_attrs_are_visible() is only evaluated when the sysfs group is
> created and dhchap_secret_store() / dhchap_ctrl_secret_store() do not call
> sysfs_update_group(), switching a controller at runtime between an
> auto-generated secret and a pre-populated key description leaves dhchap_key
> and dhchap_ctrl_key stuck in their initial visibility state.
> 

Fixed with the new version.

>> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
>> index 880cf5151588a..319947aa0a40f 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
> [ ... ]
>> @@ -2305,13 +2306,14 @@ static ssize_t nvmet_host_dhchap_ctrl_key_show(struct config_item *item,
>>   		down_read(&key->sem);
>>   		if (key_validate(key))
>>   			ret = sprintf(page, "<invalidated>\n");
>> -		else {
>> +		else if (host->dhchap_ctrl_key_generated) {
>>   			ret = key->type->read(key, page, PAGE_SIZE);
>>   			if (ret > 0) {
>>   				page[ret] = '\n';
>>   				ret++;
>>   			}
>> -		}
>> +		} else
>> +			ret = sprintf(page, "%s\n", key->description);
>>   		up_read(&key->sem);
>>   		key_put(key);
>>   	}
> 
> [Severity: Medium]
> Does nvmet_host_dhchap_ctrl_key_store() just below this function leak
> keydata on every write?
> 
> drivers/nvme/target/configfs.c:nvmet_host_dhchap_ctrl_key_store() {
> 	...
> 	keydata = kstrndup(page, len, GFP_KERNEL);
> 	if (!keydata)
> 		return -ENOMEM;
> 
> 	ret = nvmet_auth_set_key(host, keydata, true);
> 	...
> 	return ret < 0 ? ret : count;
> }
> 
> Unlike nvmet_host_dhchap_key_store(), which calls kfree_sensitive(keydata)
> after nvmet_auth_set_key(), nvmet_host_dhchap_ctrl_key_store() returns
> without freeing keydata, leaking the buffer and leaving key material in slab
> memory.
> 
Already fixed with the update to a previous patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

