Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DC1606A334
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HT3IrQaX;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jSBD0nnX;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=M3KXaogI;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jSBD0nnX;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=M3KXaogI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=hvBmdMP4OZLKWFqaN8fW4YRLoaGUySsZ/cOOrSOBR3s=; b=HT3IrQaXXrPaRV
	BL/tKwjkGQDRpiYEufm71339lZmWrf303lYlmRE97TU5JpQ9uv3gygHsKhiQtN6Bspz8V6xl4z9bj
	WnmlFR0ak59wEUagUXQeTviNsajqRME4j71tbMXl2+zOfsyPeq2FNkqiwDkm7pT280/1XczjLm7WR
	UC4A3+tK4uZ9WopFRmbkYwYXZizL7EonxNeEkN/mOB06d2bs5/aTkNAS+d0knhmNbZU9WpFiftada
	eKplrwAKkSSJpPaqsgaE/H3d5RhbVBnkdG6hyHl/qu8RZb498anW7WAIeU52HROceq54/cIfWjBo8
	yh08a8mIxJBa+bn77Wpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUPOV-0000000FE4g-15f7;
	Fri, 20 Nov 2026 14:15:15 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUPOR-0000000FE3k-3frE
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 14:15:13 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D14D41F7BD;
	Fri, 20 Nov 2026 14:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795184109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hvBmdMP4OZLKWFqaN8fW4YRLoaGUySsZ/cOOrSOBR3s=;
	b=jSBD0nnXKSsdC2Ipk/dfrHw/MQgozA8lKAkxcETTi1rVXWvO0P+hKJ/NSyANHyhkNj5iHh
	Jk3pRIxOj8lqcGZThE4M/KoUT6xVK1XZmAxgogmxWPLwtq/ba7QWmdnll16hH+HLHD209e
	Lyj1Uh+qSND4IbrBCfxsIxAGlAn6F2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795184109;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hvBmdMP4OZLKWFqaN8fW4YRLoaGUySsZ/cOOrSOBR3s=;
	b=M3KXaogIaBK9LWabtg/DtK4oPrBCmOfKzw6EYesKs19NBEZz8k8WDW5RYW/37NfnW/KbVb
	cG1qVHdcGT0CoKDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795184109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hvBmdMP4OZLKWFqaN8fW4YRLoaGUySsZ/cOOrSOBR3s=;
	b=jSBD0nnXKSsdC2Ipk/dfrHw/MQgozA8lKAkxcETTi1rVXWvO0P+hKJ/NSyANHyhkNj5iHh
	Jk3pRIxOj8lqcGZThE4M/KoUT6xVK1XZmAxgogmxWPLwtq/ba7QWmdnll16hH+HLHD209e
	Lyj1Uh+qSND4IbrBCfxsIxAGlAn6F2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795184109;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hvBmdMP4OZLKWFqaN8fW4YRLoaGUySsZ/cOOrSOBR3s=;
	b=M3KXaogIaBK9LWabtg/DtK4oPrBCmOfKzw6EYesKs19NBEZz8k8WDW5RYW/37NfnW/KbVb
	cG1qVHdcGT0CoKDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 973D413507;
	Fri, 20 Nov 2026 14:15:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OXoxHO1VAGsFHwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 20 Nov 2026 14:15:09 +0000
Message-ID: <f88cac4d-8059-44fd-ac38-6c80eafcea8d@suse.de>
Date: Fri, 20 Nov 2026 15:15:09 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] nvmet-auth: parse dhchap key from configfs
 attribute
To: sashiko-reviews@lists.linux.dev, Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
 <20261120-dhchap-keyring-v4-v4-5-5f8c7d9926ee@kernel.org>
 <sashiko-outbox-225043@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sashiko-outbox-225043@kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_061512_225989_221B1476 
X-CRM114-Status: GOOD (  29.48  )
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

On 11/20/26 12:28 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issues to consider:
> - [High] nvmet-auth: missing error abort and invalid status in
>    nvmet_setup_auth()
> - [High] nvmet-auth: missing initialization of ctrl->shash_id in
>    nvmet_setup_auth()
> - [High] nvmet-auth: missing length checks in nvme_dhchap_psk_preparse()
> - [Medium] nvmet-auth: memory leak of keydata in
>    nvmet_host_dhchap_ctrl_key_store()
> - [Medium] nvmet-auth: empty writes rejected in configfs key store
>    callbacks
> --
> 
> commit 4bc851b3a915dfe8fe3d7c3db8fe8c3fa58c01ca
> Author: Hannes Reinecke <hare@kernel.org>
> 
> nvmet-auth: parse dhchap key from configfs attribute
> 
> This commit converts the nvmet configfs DH-HMAC-CHAP key handling to store
> host and controller keys as struct key pointers rather than raw secret
> strings.
> 
>> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
>> index 26457ce4acc2a..33b45b4b202d4 100644
>> --- a/drivers/nvme/target/auth.c
>> +++ b/drivers/nvme/target/auth.c
>> @@ -19,52 +19,63 @@
> 
> [ ... ]
> 
>>   int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
>>   		       bool set_ctrl)
>>   {
>> -	unsigned char key_hash;
>> -	char *dhchap_secret;
>> -	int offset = 0;
>> +	struct key *key;
>> +	size_t len;
>>   
>>   	if (!strlen(secret)) {
>>   		down_write(&nvmet_config_sem);
>> -		if (set_ctrl) {
>> -			kfree(host->dhchap_ctrl_secret);
>> -			host->dhchap_ctrl_secret = NULL;
>> -			host->dhchap_ctrl_key_hash = 0;
>> -			host->dhchap_ctrl_key_offset = 0;
>> -		} else {
>> -			kfree(host->dhchap_secret);
>> -			host->dhchap_secret = NULL;
>> -			host->dhchap_key_hash = 0;
>> -			host->dhchap_key_offset = 0;
>> -		}
>> +		nvmet_auth_revoke_key(host, set_ctrl);
>>   		up_write(&nvmet_config_sem);
>>   		return 0;
>>   	}
>> -	if (sscanf(secret, "DHHC-1:%hhd:%n", &key_hash, &offset) != 1 ||
>> -	    !offset)
>> -		return -EINVAL;
>> -	if (key_hash > 3) {
>> -		pr_warn("Invalid DH-HMAC-CHAP hash id %d\n",
>> -			 key_hash);
>> -		return -EINVAL;
>> -	}
>> -	dhchap_secret = kstrdup(secret, GFP_KERNEL);
>> -	if (!dhchap_secret)
>> -		return -ENOMEM;
>> +	len = strcspn(secret, "\n");
>> +	key = nvme_auth_extract_key(NULL, secret, len);
>> +	if (IS_ERR(key)) {
>> +		pr_debug("%s: invalid key specification\n", __func__);
>> +		return PTR_ERR(key);
>> +	}
> 
> [Severity: High]
> Can passing unvalidated configfs strings into nvme_auth_extract_key()
> underflow datalen and ret in nvme_dhchap_psk_preparse()?
> 
> nvme_auth_extract_key() calls nvme_dhchap_psk_create() -> key_create() ->
> nvme_dhchap_psk_preparse():
> 
> drivers/nvme/common/keyring.c:nvme_dhchap_psk_preparse() {
> 	...
> 	if (sscanf(prep->data, "DHHC-%01hhu:%02hhu:%*s",
> 		   &version, &hmac) != 2) {
> 		...
> 		return -EINVAL;
> 	}
> 
> 	/* skip header and final ':' character */
> 	datalen -= 11;
> 	...
> 	ret = base64_decode(prep->data + 10, datalen, upayload->data,
> 			    true, BASE64_STD);
> 	if (ret < 0) {
> 		...
> 		return ret;
> 	}
> 	ret -= 4;
> 	crc = ~crc32(~0, upayload->data, ret);
> 	...
> }
> 
> Because %02hhu matches 1 or 2 digits and %*s is not counted in sscanf()'s
> return value, a short string such as "DHHC-1:1:" (9 bytes) returns 2 with
> datalen < 11, so datalen -= 11 underflows size_t datalen and passes a huge
> length to base64_decode().  Similarly, a short payload that decodes to 0..3
> bytes (such as "DHHC-1:01:AA==:") makes ret -= 4 negative, which is then
> converted to size_t in crc32() and reads past upayload->data.
> 
The parsing routines have been fixed up with updates to earlier patches.

> [ ... ]
> 
>> @@ -186,44 +195,74 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
>>   		goto out_unlock;
>>   	}
>>   
>> -	if (!host->dhchap_secret) {
>> +	if (!host->dhchap_key) {
>>   		pr_debug("No authentication provided\n");
>>   		goto out_unlock;
>>   	}
>>   
>> -	host_key = nvme_auth_extract_key(NULL, host->dhchap_secret,
>> -					 strlen(host->dhchap_secret));
>> -	if (IS_ERR(host_key)) {
>> -		ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
>> +	key = key_get(host->dhchap_key);
>> +	if (!key) {
>> +		pr_warn("%s: host key %08x not found\n",
>> +			__func__, key_serial(host->dhchap_key));
>>   		goto out_unlock;
>>   	}
>> -	if (host->dhchap_ctrl_secret) {
>> -		ctrl_key = nvme_auth_extract_key(NULL, host->dhchap_ctrl_secret,
>> -						 strlen(host->dhchap_ctrl_secret));
>> -		if (IS_ERR(ctrl_key)) {
>> -			key_put(host_key);
>> -			ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
>> -			goto out_unlock;
>> +	down_read(&key->sem);
>> +	ret = key_validate(key);
>> +	if (!ret) {
>> +		if (ctrl->host_key) {
>> +			pr_debug("%s: drop host key %08x\n",
>> +				 __func__, key_serial(ctrl->host_key));
>> +			key_put(ctrl->host_key);
>>   		}
>> +		ctrl->host_key = key;
>> +	}
>> +	key_id = key_serial(key);
>> +	up_read(&key->sem);
>> +	if (ret) {
>> +		pr_warn("host key %08x invalidated\n", key_id);
>> +		key_put(key);
>> +		key = ERR_PTR(-EKEYREVOKED);
>>   	}
> 
> [Severity: High]
> When key_validate(key) fails on host->dhchap_key, doesn't execution fall
> through instead of setting ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE and
> jumping to out_unlock?
> 
> If host->dhchap_ctrl_key is present and valid, the second key_validate()
> overwrites ret with 0, so nvmet_setup_auth() returns 0 while leaving
> ctrl->host_key NULL on initial connect, bypassing authentication because
> nvmet_has_auth() and nvmet_check_auth_status() treat a NULL ctrl->host_key
> as no authentication required.  If host->dhchap_ctrl_key is absent or also
> invalid, nvmet_setup_auth() returns the negative errno from key_validate()
> truncated to u8 instead of NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE, and if
> key_get() returns NULL it jumps to out_unlock with ret == 0.
> 
Correct. Fixed up with the next version.

>> -	key_put(ctrl->host_key);
>> -	ctrl->host_key = host_key;
>> -	key_put(ctrl->ctrl_key);
>> -	ctrl->ctrl_key = ctrl_key;
>> -	ctrl->shash_id = host->dhchap_hash_id;
>>   #ifdef CONFIG_NVME_TARGET_AUTH_DEBUG
>> -	host_hash = nvme_dhchap_psk_hash(ctrl->host_key);
>> -	pr_debug("%s: using hash %s key %u\n", __func__,
>> -		 ctrl_hash > 0 ?
>> -		 nvme_auth_hmac_name(ctrl_hash) : "none",
>> -		 key_serial(ctrl->host_key));
>> -	if (ctrl->ctrl_key) {
>> -		ctrl_hash = nvme_dhchap_psk_hash(ctrl->ctrl_key);
>> -		pr_debug("%s: using ctrl hash %s key %u\n", __func__,
>> -			 ctrl_hash > 0 ?
>> -			 nvme_auth_hmac_name(ctrl_hash) : "none",
>> -			 key_serial(ctrl->ctrl_key));
>> +	pr_debug("%s: using dhchap hash %s key %08x\n", __func__,
>> +		 nvme_auth_hmac_name(ctrl->shash_id), key_id);
>> +#endif
> 
> [Severity: High]
> Does dropping ctrl->shash_id = host->dhchap_hash_id leave ctrl->shash_id at
> 0?
> 
> nvmet_auth_negotiate() matches the host's proposed HMAC IDs against
> ctrl->shash_id, so leaving it at 0 ignores the host's configured dhchap_hash
> attribute and always falls back to fallback_hash_id (and passes 0 to
> nvme_auth_hmac_name() in the debug prints here).
> 
Of course. Reverted with the next version.

>> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
>> index 27c50fa533e70..880cf5151588a 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
> 
> [ ... ]
> 
>> @@ -2251,9 +2266,19 @@ static ssize_t nvmet_host_dhchap_key_store(struct config_item *item,
>>   		const char *page, size_t count)
>>   {
>>   	struct nvmet_host *host = to_host(item);
>> +	u8 *keydata;
>> +	size_t len;
>>   	int ret;
>>   
>> -	ret = nvmet_auth_set_key(host, page, false);
>> +	len = strcspn(page, "\n");
>> +	if (!len)
>> +		return -EINVAL;
>> +	keydata = kstrndup(page, len, GFP_KERNEL);
>> +	if (!keydata)
>> +		return -ENOMEM;
>> +
>> +	ret = nvmet_auth_set_key(host, keydata, false);
>> +	kfree_sensitive(keydata);
> 
> [Severity: Medium]
> Does returning -EINVAL when !len in nvmet_host_dhchap_key_store() and
> nvmet_host_dhchap_ctrl_key_store() prevent clearing a configured key via
> configfs?  An empty or newline-only write is rejected before reaching the
> !strlen(secret) revocation branch in nvmet_auth_set_key().
> 
Fixed up with the next version.

> [ ... ]
> 
>> @@ -2284,9 +2323,18 @@ static ssize_t nvmet_host_dhchap_ctrl_key_store(struct config_item *item,
>>   		const char *page, size_t count)
>>   {
>>   	struct nvmet_host *host = to_host(item);
>> +	u8 *keydata;
>> +	size_t len;
>>   	int ret;
>>   
>> -	ret = nvmet_auth_set_key(host, page, true);
>> +	len = strcspn(page, "\n");
>> +	if (!len)
>> +		return -EINVAL;
>> +	keydata = kstrndup(page, len, GFP_KERNEL);
>> +	if (!keydata)
>> +		return -ENOMEM;
>> +
>> +	ret = nvmet_auth_set_key(host, keydata, true);
>>   	/*
>>   	 * Re-authentication is a soft state, so keep the
>>   	 * current authentication valid until the host
> 
> [Severity: Medium]
> Does nvmet_host_dhchap_ctrl_key_store() leak keydata?  Unlike
> nvmet_host_dhchap_key_store(), it does not call kfree_sensitive(keydata)
> after nvmet_auth_set_key().
> 

Fixed up with the next version.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

