Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD61606A31A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Knhije/U;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RyTbH/gW;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=N1d5K+Bj;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RyTbH/gW;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=N1d5K+Bj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=nQ5N9r1XrbqgshD8vJD1gD8ZhUwp58YdUZEAb30ngo4=; b=Knhije/UmC94Os
	ZRwQMMyFWN+idLbwixsv1qMqKvMRJzoPAxC6ZKIxah0MBmpF3Aq84EOfHW5ZZxc4LTWsQWHaNe/HN
	KWHlw8+exvo/Ja9vQPuPJd8Xp5orNknsIUn0s/C+qb23rdkSEr3IiIsT7qXiAX/8VVh1bfhRyCDMa
	7VlHO9amtOaOeYZ+9WApMq2m/j+77zqPDgDTGORw3ankkwILQRFP+M4N8TIqDczRfuSy0bnhE654b
	D0ftkxF3K7COcv9WPVRlrGcZEJbadGB+ird6JZ4yV98x8QkfQ2s7bUACIIU3sG2hr7Vw0DnA4/1oC
	1rGes6InWElceyOEU0KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVU8u-00000003a9W-3J9f;
	Mon, 23 Nov 2026 13:31:36 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVU8s-00000003a91-1VcG
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 13:31:36 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 55E8B2209F;
	Mon, 23 Nov 2026 13:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795440692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nQ5N9r1XrbqgshD8vJD1gD8ZhUwp58YdUZEAb30ngo4=;
	b=RyTbH/gW2MYO7jFeHxap2YrNvJdjxzZXqQAw2EjNm0/mcZ7nzIqJWT0TML9ooG0Rgtyehh
	wudbNYe/72rpHCZscMGcorc9pqL03xIk8YtpdUqfesSLbf92jwNt6T3V7pnpgeyfnGw8bg
	VrCm64k+svbaythcSRNqI11EvuGZD5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795440692;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nQ5N9r1XrbqgshD8vJD1gD8ZhUwp58YdUZEAb30ngo4=;
	b=N1d5K+BjQbjMEo7SXsfdLABm2YOOG2LXSE7lzMtj4Aj1kZMjbOb+xwVNsUNlBGx2lw7iSj
	BPu9ZQ+EjunrZBBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="RyTbH/gW";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=N1d5K+Bj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795440692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nQ5N9r1XrbqgshD8vJD1gD8ZhUwp58YdUZEAb30ngo4=;
	b=RyTbH/gW2MYO7jFeHxap2YrNvJdjxzZXqQAw2EjNm0/mcZ7nzIqJWT0TML9ooG0Rgtyehh
	wudbNYe/72rpHCZscMGcorc9pqL03xIk8YtpdUqfesSLbf92jwNt6T3V7pnpgeyfnGw8bg
	VrCm64k+svbaythcSRNqI11EvuGZD5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795440692;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nQ5N9r1XrbqgshD8vJD1gD8ZhUwp58YdUZEAb30ngo4=;
	b=N1d5K+BjQbjMEo7SXsfdLABm2YOOG2LXSE7lzMtj4Aj1kZMjbOb+xwVNsUNlBGx2lw7iSj
	BPu9ZQ+EjunrZBBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E01D1352B;
	Mon, 23 Nov 2026 13:31:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iUy/OTNABGv0HgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Nov 2026 13:31:32 +0000
Message-ID: <5a37932f-6833-4967-bb47-13916dfb80f0@suse.de>
Date: Mon, 23 Nov 2026 14:31:31 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] nvme-auth: switch to use 'struct key'
To: sashiko-reviews@lists.linux.dev, Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
 <20261123-dhchap-keyring-v4-v5-3-81eefb4c0724@kernel.org>
 <sashiko-outbox-229229@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sashiko-outbox-229229@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 55E8B2209F
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
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email]
X-Spam-Score: -13.50
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_053134_729822_A171BD2C 
X-CRM114-Status: GOOD (  35.86  )
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

On 11/23/26 1:35 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issues to consider:
> - [High] nvme-keyring: build failure in !CONFIG_NVME_KEYRING header
>    stubs
> - [High] nvme-auth: broken offset, payload leak, and -ENOKEY in key
>    extraction
> - [Low] nvme-auth: missing memzero_explicit() on error in
>    nvme_auth_transform_key()
> --
> 
> commit 784e3a15ff15feda9e4de8c374a9d16d4c147b86
> Author: Hannes Reinecke <hare@kernel.org>
> 
> nvme-auth: switch to use 'struct key'
> 
> This commit switches NVMe in-band authentication to store DH-HMAC-CHAP keys
> in struct key using the dhchap key type and removes struct nvme_dhchap_key.
> 
>> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
>> index 308af3d7c7383..ee26fb416ee62 100644
>> --- a/drivers/nvme/common/auth.c
>> +++ b/drivers/nvme/common/auth.c
> [ ... ]
>> @@ -317,11 +261,13 @@ static int nvme_auth_hash(u8 hmac_id, const u8 *data, size_t data_len, u8 *out)
>>   	return -EINVAL;
>>   }
>>   
>> -int nvme_auth_transform_key(const struct nvme_dhchap_key *key, const char *nqn,
>> +int nvme_auth_transform_key(struct key *key, const char *nqn,
>>   			    u8 **transformed_secret)
>>   {
>>   	struct nvme_auth_hmac_ctx hmac;
>> -	u8 *key_data;
>> +	long key_len = 0;
>> +	u8 *transformed_data;
>> +	u8 *key_data, key_hash;
>>   	size_t transformed_len;
>>   	int ret;
>>   
>> @@ -329,28 +275,64 @@ int nvme_auth_transform_key(const struct nvme_dhchap_key *key, const char *nqn,
>>   		pr_warn("No key specified\n");
>>   		return -ENOKEY;
>>   	}
>> -	if (key->hash == 0) {
>> -		key_data = kzalloc(key->len, GFP_KERNEL);
>> -		if (!key_data)
>> -			return -ENOMEM;
>> -		memcpy(key_data, key->key, key->len);
>> -		*transformed_secret = key_data;
>> -		return key->len;
>> -	}
>> -	ret = nvme_auth_hmac_init(&hmac, key->hash, key->key, key->len);
>> -	if (ret)
>> +	down_read(&key->sem);
>> +	ret = key_validate(key);
>> +	if (ret) {
>> +		pr_warn("%s: key %08x invalidated\n",
>> +			__func__, key_serial(key));
>> +		up_read(&key->sem);
>>   		return ret;
>> -	transformed_len = nvme_auth_hmac_hash_len(key->hash);
>> -	key_data = kzalloc(transformed_len, GFP_KERNEL);
>> +	}
>> +	key_len = user_read(key, NULL, 0);
>> +	if (key_len <= 0) {
>> +		pr_warn("failed to get length from key %08x: error %ld\n",
>> +			key_serial(key), key_len);
>> +		up_read(&key->sem);
>> +		return key_len < 0 ? key_len : -ENOKEY;
>> +	}
>> +
>> +	key_data = kzalloc(key_len, GFP_KERNEL);
>>   	if (!key_data) {
>> -		memzero_explicit(&hmac, sizeof(hmac));
>> +		up_read(&key->sem);
>>   		return -ENOMEM;
>>   	}
>> +	ret = user_read(key, (char *)key_data, key_len);
>> +	key_hash = nvme_dhchap_psk_hash(key);
>> +	up_read(&key->sem);
>> +	if (ret != key_len) {
>> +		if (ret < 0) {
>> +			pr_warn("failed to read from key %08x: error %d\n",
>> +				key_serial(key), ret);
>> +		} else {
>> +			pr_warn("only read %d of %ld bytes from key %08x\n",
>> +				ret, key_len, key_serial(key));
>> +			ret = -ENOKEY;
>> +		}
>> +		goto out_free_data;
>> +	}
>> +	if (key_hash == 0) {
>> +		*transformed_secret = key_data;
>> +		return key_len;
>> +	}
>> +
>> +	ret = nvme_auth_hmac_init(&hmac, key_hash, key_data, key_len);
>> +	if (ret)
>> +		goto out_free_data;
>> +	transformed_len = nvme_auth_hmac_hash_len(key_hash);
>> +	transformed_data = kzalloc(transformed_len, GFP_KERNEL);
>> +	if (!transformed_data) {
>> +		ret = -ENOMEM;
>> +		goto out_free_data;
>> +	}
> 
> [Severity: Low]
> Does the !transformed_data error path leave key-derived state in hmac on
> the stack?  Before this patch, failing to allocate the output buffer after
> nvme_auth_hmac_init() called memzero_explicit(&hmac, sizeof(hmac)) because
> nvme_auth_hmac_final() is not reached to zeroize the context.
> 
Moved kzalloc() before calling nvme_auth_hmac_init().

>> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
>> index d0c36d153afdb..08e2a8e39faac 100644
>> --- a/drivers/nvme/common/keyring.c
>> +++ b/drivers/nvme/common/keyring.c
>> @@ -481,6 +481,104 @@ static struct key_type nvme_dhchap_psk_key_type = {
>>   	.read           = nvme_dhchap_psk_read,
>>   };
>>   
>> +/**
>> + * nvme_dhchap_psk_create - Create DH-HMAC-CHAP key
>> + * @keyring: keyring for the new key or NULL for the default keyring
>> + * @data: Key data
>> + * @data_len: Length of @data
>> + *
>> + * Creates a new DH-HMAC-CHAP key with a random UUID as the key identity.
>> + * Returns the new key or an error pointer on failure.
>> + */
>> +struct key *nvme_dhchap_psk_create(struct key *keyring,
>> +		const char *data, size_t data_len)
>> +{
>> +	key_perm_t keyperm =
>> +		KEY_POS_SEARCH | KEY_POS_VIEW | KEY_POS_READ |
>> +		KEY_POS_WRITE | KEY_POS_LINK | KEY_POS_SETATTR |
>> +		KEY_USR_SEARCH | KEY_USR_VIEW | KEY_USR_READ;
>> +	char *identity;
>> +	key_ref_t keyref;
>> +	key_serial_t keyring_id;
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
>> +	if (!keyring)
>> +		keyring = nvme_keyring;
>> +	keyring_id = key_serial(keyring);
>> +
>> +	pr_debug("keyring %x generate dhchap psk '%s'\n",
>> +		 keyring_id, identity);
>> +	keyref = key_create(make_key_ref(keyring, true),
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
> [Severity: High]
> Routing nvme_auth_extract_key() through nvme_dhchap_psk_create() and
> nvme_dhchap_psk_preparse() introduces several regressions when parsing or
> rejecting DH-HMAC-CHAP secrets:
> 
> drivers/nvme/common/keyring.c:nvme_dhchap_psk_preparse() {
> 	...
> 	if (sscanf(prep->data, "DHHC-%01hhu:%02hhu:%n",
> 		   &version, &hmac, &offset) != 2 || !offset) {
> 	...
> 	/* skip header and final ':' character */
> 	datalen = strlen(prep->data + offset);
> 	p = strrchr(prep->data + offset, ':');
> 	if (p)
> 		datalen--;
> 	...
> 	prep->payload.data[0] = upayload;
> 	ret = base64_decode(prep->data + 10, datalen, upayload->data,
> 			    true, BASE64_STD);
> 	if (ret < 0) {
> 		pr_debug("%s: Failed to decode key %s\n",
> 			 __func__, (char *)prep->data + 10);
> 		prep->payload.data[0] = NULL;
> 		return ret;
> 	}
> 	if (ret != 36 && ret != 52 && ret != 68) {
> 		pr_debug("%s: invalid decoded key size '%d'\n",
> 			 __func__, ret);
> 		prep->payload.data[0] = NULL;
> 		return -EINVAL;
> 	}
> 	ret -= 4;
> 	crc = ~crc32(~0, upayload->data, ret);
> 	if (get_unaligned_le32(upayload->data + ret) != crc) {
> 		pr_debug("%s: CRC mismatch for key\n", __func__);
> 		/* CRC mismatch */
> 		prep->payload.data[0] = NULL;
> 		return -EKEYREJECTED;
> 	}
> 	...
> }
> 
> Does base64_decode() fail on secrets with a single-digit hash ID (such as
> "DHHC-1:0:...") and leak upayload on error?
> 
key parsing has been fixed with an updated version to the previous patch.

> With a 1-digit hash ID, offset is 9, so hardcoding prep->data + 10 skips
> the first base64 character and reads one byte past the end of the payload.
> When base64_decode(), the decoded length check, or the CRC check fails,
> setting prep->payload.data[0] = NULL before returning prevents
> user_free_preparse() from freeing upayload, leaking it on every rejected
> key.
> 
> In addition, prep->data is passed to sscanf(), strlen(), and strrchr()
> without bounding to prep->datalen (and with offset uninitialized if the
> colon after the hash ID is omitted), "if (p) datalen--" only subtracts 1
> instead of truncating at p when a trailing newline follows ':', and
> nvme_dhchap_psk_create() overwrites the error from key_create() with
> -ENOKEY.
> 
>> diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
>> index ab8971afa9734..a2ba7588e2d73 100644
>> --- a/include/linux/nvme-keyring.h
>> +++ b/include/linux/nvme-keyring.h
>> @@ -18,12 +18,18 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
>>   
>>   key_serial_t nvme_keyring_id(void);
>>   struct key *nvme_tls_key_lookup(key_serial_t key_id);
>> +
>> +struct key *nvme_dhchap_psk_create(struct key *keyring,
>> +		const char *data, size_t data_len);
>> +struct key *nvme_dhchap_psk_lookup(struct key *keyring, const char *identity);
>> +u8 nvme_dhchap_psk_hash(struct key *key);
>> +
>>   #else
>>   static inline struct key *nvme_tls_psk_refresh(struct key *keyring,
>> -		const char *hostnqn, char *subnqn, u8 hmac_id,
>> +		const char *hostnqn, const char *subnqn, *data, u8 hmac_id,
>>   		u8 *data, size_t data_len, const char *digest)
>>   {
>> -	return ERR_PTR(-ENOTSUPP);
>> +	return ERR_PTR(-EOPNOTSUPP);
>>   }
>>   static inline key_serial_t nvme_tls_psk_default(struct key *keyring,
>>   		const char *hostnqn, const char *subnqn)
>> @@ -36,7 +42,21 @@ static inline key_serial_t nvme_keyring_id(void)
>>   }
>>   static inline struct key *nvme_tls_key_lookup(key_serial_t key_id)
>>   {
>> -	return ERR_PTR(-ENOTSUPP);
>> +	return ERR_PTR(-EOPNOTSUPP);
>> +}
>> +static inline struct key *nvme_dhchap_psk_create(struct key *keyring,
>> +		const char *data, size_t data_len)
>> +{
>> +	return ERR_PTR(-EOPNOTSUPP);
>> +}
>> +static inline struct key *nvme_dhchap_psk_lookup(struct key *keyring,
>> +		const char *identity)
>> +{
>> +	return ERR_PTR(-EOPNOTSUPP);
>> +}
>> +u8 nvme_dhchap_psk_hash(struct key *key)
>> +{
>> +	return 0;
>>   }
>>   #endif /* !CONFIG_NVME_KEYRING */
>>   #endif /* _NVME_KEYRING_H */
> 
> [Severity: High]
> As reported by kernel test robot on v4 [1], does this break the build when
> CONFIG_NVME_KEYRING is disabled?  The !CONFIG_NVME_KEYRING stub for
> nvme_tls_psk_refresh() has a stray untyped *data parameter before hmac_id,
> and nvme_dhchap_psk_hash() is defined in the header without static inline,
> causing multiple-definition linker errors across translation units that
> include linux/nvme-keyring.h.
> 
> [1] https://lore.kernel.org/r/202611210318.EedT1DJk-lkp@intel.com
> 
Fixed with the next version.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

