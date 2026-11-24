Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062DD606A698
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 08:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=E17StuCH;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=PibrNznz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IQeR2Sx5;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GQQ1iU+y;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=D/TWgHuv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9RUFyHnJytmJI25l4Tvhp7lRDYmqeQuEdE+y0dNHV6g=; b=E17StuCHefTe5n
	vjTvhgxrDX/0S+WQVxGA9U92oATp5i49JcyBGVjW9QxYb8YXb1Bo7t/6lN/WttLm6ZmdEMkHH/9qz
	8unJ2JzQ24nWJDpVIYkhv8zdisq+MCgZjcwO63FROKG+RlJi3mxbcvSo51DNRECpHRAtbOC8bSIKA
	r3U+nhBOrGPD2An61aRd19g8vfGEOgLB4fvuqtNq1RswbVKu40JGKdv/w2kUTFTwL6AgbvGVtAwE+
	094dMWBq3/mOtrJ0FBj5Rihqu3L9nzIBA1VEkpghsTUeFtdMwQAzMfbTJ19jOB4CitHU0ORaRMxEJ
	pxg6ZXEZTeudZ/HKdLPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVlvt-00000005uCo-1BM2;
	Tue, 24 Nov 2026 08:31:21 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVlvq-00000005uBP-0eVt
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 08:31:19 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E7B22222FA;
	Tue, 24 Nov 2026 08:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795509073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9RUFyHnJytmJI25l4Tvhp7lRDYmqeQuEdE+y0dNHV6g=;
	b=PibrNznz1p46mzolvxz+76qiAibImF42ScedMIz6ETPfNpkooM1GG9WXF+cHyvAh2DpQkx
	ihx4R2uWtq8EZ4dDq7Jzr2KrZCCOq7LEVbut+lVXFxD1mwzgX8nTYxGfBB7WB5it6gjHcX
	dqSCcReHrHMDm4/AnrGfGGNBg5whvqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795509073;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9RUFyHnJytmJI25l4Tvhp7lRDYmqeQuEdE+y0dNHV6g=;
	b=IQeR2Sx57POwWGEsSfLwVAc/9bkX+Unu6Be8SdonFkjl8YdCIk4EMHWfi+fSLObP/U307Z
	NZ2Sh86AJlt5XpAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795509072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9RUFyHnJytmJI25l4Tvhp7lRDYmqeQuEdE+y0dNHV6g=;
	b=GQQ1iU+yQuQtPEe53iMxPfDrpWW4/rjQaL1DSsHscd5rCtWz9O7MM+6/AZxEclmcWRhywS
	TrYnKgQrWDKF6p0owHjNEzdyvUK7gxNFi3AXWZ4zoj2OJ2b/rCcXYoOSUcju3G/+eThRIr
	Nh0CbG9dLlpkBeAa4KB4K3xBKA49oqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795509072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9RUFyHnJytmJI25l4Tvhp7lRDYmqeQuEdE+y0dNHV6g=;
	b=D/TWgHuvrDgCcQ1TAizgtcp1n7D/+7CsR2pqwwK2iunzrRBfPzZhaKzfagvL8ceRE+Nr9o
	kGeg7R4g54/enQAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3D511339F;
	Tue, 24 Nov 2026 08:31:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BaeAHFBLBWsWDwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 24 Nov 2026 08:31:12 +0000
Message-ID: <b5d600fd-12cd-4c0b-974c-0d4c9a8e53ae@suse.de>
Date: Tue, 24 Nov 2026 09:31:12 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/9] nvme: allow to pass in key description as dhchap
 secret
To: sashiko-reviews@lists.linux.dev, Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
 <20261123-dhchap-keyring-v4-v6-6-5082a49715ab@kernel.org>
 <sashiko-outbox-229755@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sashiko-outbox-229755@kernel.org>
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
X-CRM114-CacheID: sfid-20261124_003118_499830_A90F46A4 
X-CRM114-Status: GOOD (  37.40  )
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

On 11/23/26 6:32 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential
> issues to consider:
> - [Medium] nvmet-auth: self-revocation of active generated key in
>    nvmet_auth_set_key()
> - [Medium] nvmet-auth: host_key reference leak on ctrl_key error in
>    nvmet_setup_auth()
> - [Medium] nvme-auth: dhchap_secret_store() returns -EBUSY instead of
>    re-authenticating
> - [Low] nvme-auth: key_serial(ctrl->host_key) logged before assignment
>    in nvme_auth_init_ctrl()
> - [Low] nvme: wrong device pointer ctrl->dev used for logging in sysfs
>    store helpers
> - [Low] nvme-auth: mismatched key serial comments in
>    nvme_auth_extract_key()
> --
> 
> commit bea90f054bc2ef7a55e7fb9326ffa4aa13dd0817
> Author: Hannes Reinecke <hare@kernel.org>
> 
> nvme: allow to pass in key description as dhchap secret
> 
> This commit updates nvme_auth_extract_key() to look up a pre-populated key
> in the keyring before falling back to generating a new key from raw secret
> data, and tracks whether the key was auto-generated so only generated keys
> are revoked on cleanup.
> 
>> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
>> index 158c9cb886c15..8c84595018258 100644
>> --- a/drivers/nvme/common/auth.c
>> +++ b/drivers/nvme/common/auth.c
>> @@ -144,20 +144,32 @@ EXPORT_SYMBOL_GPL(nvme_auth_hmac_hash_len);
>>    * nvme_auth_extract_key - extract the DH-HMAC-CHAP key
>>    *
>>    * @keyring: keyring to be used for the resulting key
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
>>   {
>>   	struct key *key;
>>   
>> -	key = nvme_dhchap_psk_create(keyring, secret, secret_len);
>> +	/* Check if @input is a key serial number */
>> +	key = nvme_dhchap_psk_lookup(keyring, input);
> 
> [Severity: Low]
> This isn't a bug, but the comments here and the commit message body say
> that @input can be a key serial number, whereas nvme_dhchap_psk_lookup()
> searches the keyring by key description (matching the commit subject and
> the sysfs/configfs show callbacks).
> 
Fixed with the next version.

> [ ... ]
> 
>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>> index 26e8f321650e7..2c73da4cd3c61 100644
>> --- a/drivers/nvme/host/auth.c
>> +++ b/drivers/nvme/host/auth.c
> 
> [ ... ]
> 
>> @@ -1104,6 +1117,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
>>   	if (ctrl->host_key)
>>   		nvme_auth_clear_host_key(ctrl);
>>   	ctrl->host_key = host_key;
>> +	ctrl->host_key_generated = host_key_generated;
> 
> [Severity: Low]
> Just above this hunk, pr_debug() logs key_serial(ctrl->host_key) before
> ctrl->host_key is assigned host_key:
> 
Already fixed with the next version of the previous patch.

> drivers/nvme/host/auth.c:nvme_auth_init_ctrl() {
>      ...
> 	pr_debug("%s: using dhchap host key %08x\n",
> 	       __func__, key_serial(ctrl->host_key));
> 	if (ctrl->host_key)
> 		nvme_auth_clear_host_key(ctrl);
> 	ctrl->host_key = host_key;
>      ...
> }
> 
> Should that log key_serial(host_key) instead, like the ctrl_key message a
> few lines below?  Otherwise it logs 00000000 on initial controller setup
> and the old key serial on re-initialization.
> 
Already fixed with the next version of the previous patch.

> [ ... ]
> 
>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>> index 6fab0d217e749..c94abb901a73c 100644
>> --- a/drivers/nvme/host/sysfs.c
>> +++ b/drivers/nvme/host/sysfs.c
> 
> [ ... ]
> 
>> @@ -874,22 +877,34 @@ static ssize_t dhchap_secret_store(struct device *dev,
>>   	ret = key_validate(key);
>>   	up_read(&key->sem);
>>   	if (ret) {
>> -		dev_warn(ctrl->device, "key %08x invalidated\n",
>> +		dev_warn(ctrl->dev, "key %08x invalidated\n",
>>   			 key_serial(key));
>> -		dev_dbg(ctrl->device, "revoke host key %08x\n",
>> -			key_serial(key));
>> -		key_revoke(key);
>> +		if (generated) {
>> +			dev_dbg(ctrl->dev, "revoke host key %08x\n",
>> +				key_serial(key));
>> +			key_revoke(key);
>> +		}
>>   		key_put(key);
>>   		kfree_sensitive(dhchap_secret);
>>   		return ret;
>>   	}
>>   	mutex_lock(&ctrl->dhchap_auth_mutex);
>>   	old_key = ctrl->host_key;
>> -	dev_dbg(ctrl->device, "revoke host key %08x\n",
>> -		key_serial(old_key));
>> -	key_revoke(old_key);
>> -
>> +	if (old_key && key_serial(old_key) == key_serial(key)) {
>> +		dev_warn(ctrl->device, "key %08x already present\n",
>> +			 key_serial(key));
>> +		mutex_unlock(&ctrl->dhchap_auth_mutex);
>> +		key_put(key);
>> +		kfree_sensitive(dhchap_secret);
>> +		return -EBUSY;
>> +	}
>> +	if (ctrl->host_key_generated) {
>> +		dev_dbg(ctrl->dev, "revoke host key %08x\n",
>> +			key_serial(old_key));
>> +		key_revoke(old_key);
>> +	}
> 
> [Severity: Low]
> Should these dev_warn() and dev_dbg() calls (and the one in
> dhchap_ctrl_secret_store() below) keep using ctrl->device instead of
> ctrl->dev?  ctrl->device is the nvmeX controller class device, whereas
> ctrl->dev is the parent device (such as the shared /dev/nvme-fabrics misc
> device), so switching to ctrl->dev loses the controller name in the logs.
> 
Fixed with the next version.

>>   	ctrl->host_key = key;
>> +	ctrl->host_key_generated = generated;
>>   	mutex_unlock(&ctrl->dhchap_auth_mutex);
>>   	key_put(old_key);
>>   	kfree_sensitive(dhchap_secret);
> 
> [ ... ]
> 
>> @@ -960,20 +979,32 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
>>   	if (ret) {
>>   		dev_warn(ctrl->device, "key %08x invalidated\n",
>>   			 key_serial(key));
>> -		dev_dbg(ctrl->device, "revoke ctrl key %08x\n",
>> -			key_serial(key));
>> -		key_revoke(key);
>> +		if (generated) {
>> +			dev_dbg(ctrl->device, "revoke ctrl key %08x\n",
>> +				key_serial(key));
>> +			key_revoke(key);
>> +		}
>>   		key_put(key);
>>   		kfree_sensitive(dhchap_secret);
>>   		return ret;
>>   	}
>>   	mutex_lock(&ctrl->dhchap_auth_mutex);
>>   	old_key = ctrl->ctrl_key;
>> -	dev_dbg(ctrl->device, "revoke ctrl key %08x\n",
>> -		key_serial(old_key));
>> -	key_revoke(old_key);
>> -
>> +	if (old_key && key_serial(old_key) == key_serial(key)) {
>> +		dev_warn(ctrl->device, "ctrl key %08x already present\n",
>> +			 key_serial(key));
>> +		mutex_unlock(&ctrl->dhchap_auth_mutex);
>> +		key_put(key);
>> +		kfree_sensitive(dhchap_secret);
>> +		return -EBUSY;
>> +	}
>> +	if (ctrl->ctrl_key_generated) {
>> +		dev_dbg(ctrl->dev, "revoke ctrl key %08x\n",
>> +			key_serial(old_key));
>> +		key_revoke(old_key);
>> +	}
>>   	ctrl->ctrl_key = key;
>> +	ctrl->ctrl_key_generated = generated;
>>   	mutex_unlock(&ctrl->dhchap_auth_mutex);
>>   	key_put(old_key);
>>   	kfree_sensitive(dhchap_secret);
> 
> [Severity: Medium]
> Does returning -EBUSY when key_serial(old_key) == key_serial(key) in
> dhchap_secret_store() and dhchap_ctrl_secret_store() break triggering
> re-authentication via sysfs when using pre-populated keys?
> 
> Writing the currently active secret to dhchap_secret or dhchap_ctrl_secret
> is the documented interface for triggering controller re-authentication.
> When a raw secret is written, nvme_dhchap_psk_create() allocates a new key
> with a new serial number and queues ctrl->dhchap_auth_work, but when the
> active pre-populated key description is written, nvme_dhchap_psk_lookup()
> returns the existing key, so these functions stop any pending auth work
> via nvme_auth_stop(ctrl) and fail with -EBUSY instead of queueing
> ctrl->dhchap_auth_work.
> 
Fixed with the next version.

> [ ... ]
> 
>> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
>> index 6348c810bd168..c3fa4ab78fb94 100644
>> --- a/drivers/nvme/target/auth.c
>> +++ b/drivers/nvme/target/auth.c
> 
> [ ... ]
> 
>> @@ -56,7 +67,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
>>   		return 0;
>>   	}
>>   	len = strcspn(secret, "\n");
>> -	key = nvme_auth_extract_key(NULL, secret, len);
>> +	key = nvme_auth_extract_key(NULL, secret, len, &generated);
>>   	if (IS_ERR(key)) {
>>   		pr_debug("%s: invalid key specification\n", __func__);
>>   		return PTR_ERR(key);
>> @@ -72,10 +83,13 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
>>   	up_read(&key->sem);
>>   	down_write(&nvmet_config_sem);
>>   	nvmet_auth_revoke_key(host, set_ctrl);
>> -	if (set_ctrl)
>> +	if (set_ctrl) {
>>   		host->dhchap_ctrl_key = key;
>> -	else
>> +		host->dhchap_ctrl_key_generated = generated;
>> +	} else {
>>   		host->dhchap_key = key;
>> +		host->dhchap_key_generated = generated;
>> +	}
>>   	up_write(&nvmet_config_sem);
>>   	return 0;
>>   }
> 
> [Severity: Medium]
> Can nvmet_auth_set_key() revoke the newly looked-up key in place if the
> host currently has an auto-generated key and its description (UUID) is
> written back to configfs?
> 
> nvme_auth_extract_key() finds the active key in the keyring via
> nvme_dhchap_psk_lookup() and returns it with generated = false, and then
> nvmet_auth_revoke_key() sees the old generated flag set and calls
> key_revoke() on that same struct key before it is reinstalled on host,
> leaving the host with a permanently revoked key that fails all subsequent
> authentications.  Also, if key_validate(key) fails when generated is true,
> nvmet_auth_set_key() calls key_put(key) without key_revoke(key), leaving
> the generated key linked in the keyring.
> 
Fixed with the next version.

> [Severity: Medium]
> Later in drivers/nvme/target/auth.c, does nvmet_setup_auth() leak the
> host_key reference when acquiring or validating ctrl_key fails?
> 
> drivers/nvme/target/auth.c:nvmet_setup_auth() {
>      ...
> 	host_key = key_get(host->dhchap_key);
>      ...
> 	if (host->dhchap_ctrl_key) {
> 		ctrl_key = key_get(host->dhchap_ctrl_key);
> 		if (!ctrl_key) {
> 			pr_warn("%s: ctrl key %08x not found\n",
> 				__func__, key_serial(host->dhchap_ctrl_key));
> 			ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
> 			goto out_unlock;
> 		}
> 		down_read(&ctrl_key->sem);
> 		ret = key_validate(ctrl_key);
> 		key_id = key_serial(ctrl_key);
> 		up_read(&ctrl_key->sem);
> 		if (ret) {
> 			pr_warn("ctrl key %08x invalidated\n", key_id);
> 			key_put(ctrl_key);
> 			ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
> 			goto out_unlock;
> 		}
> 	}
>      ...
> out_unlock:
> 	up_read(&nvmet_config_sem);
> 
> 	return ret;
> }
> 
> When a pre-populated ctrl_key in the keyring is revoked or expired,
> key_validate(ctrl_key) fails and jumps to out_unlock without calling
> key_put(host_key), leaking a reference on host_key on every authentication
> attempt.
> 
Fixed with the next version.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

