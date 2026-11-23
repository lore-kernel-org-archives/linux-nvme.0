Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3321E606A31A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jdjQOBTr;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fH46QH5r;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=awRaMbAb;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fH46QH5r;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=awRaMbAb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=hWXuhg1k5v1/+2crSlissWZVGes2Kay5kOGyTB28JTQ=; b=jdjQOBTr2FArJ3
	bxR3t50NgAbaqrCVc6FGNclAaXpe0ROD0Sh9NYrNIQTJ25plD8w4nc+afT7BdBN7bRK4C+E8Bw+RI
	wcIT+/0vvK/mzIxhROG3BFw5vUruZEcdbRyTQI1zL681hGrlX7sdk3T3PQ0ve4KFWRvDxUGceeshI
	TspM9o2wIMYhf2jxULNW0/iRA5OT8e3wZiuEsAKov4FrY0gJU4LHl7wwPfXBuEC/neth49pY56G6F
	VsTfMXAJ4pL02lN6Sp5kVGCjenLVkQA6nIVGJL/otPcxzAmWxJtj92nkXebu2+oVAwG3NbZbZihP9
	3trg3ktQ7xn9JbAmuV/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVVaA-00000003tR3-0qXB;
	Mon, 23 Nov 2026 15:03:50 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVVa6-00000003tQ1-2ADI
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 15:03:48 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 58BF021CEE;
	Mon, 23 Nov 2026 15:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795446224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWXuhg1k5v1/+2crSlissWZVGes2Kay5kOGyTB28JTQ=;
	b=fH46QH5rZxcbJ3HKOguymECK+ZXQPsZwXfHesxaEh4dLIyUrA2jMSXCLG/C/x9+nycixwD
	m6TgTrvnDldoPa9bGVByioXe4vbCqb30o70roD8P3B8aAStnjR19N50RcO6iITXCQFvXxo
	UBDJq2tVbQ6EMqrr14GwdNYpNSwONlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795446224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWXuhg1k5v1/+2crSlissWZVGes2Kay5kOGyTB28JTQ=;
	b=awRaMbAbvcAkb6JHQIOMKXSzu2QxfT5aXGsAploaaUte7Uc2sJ3C43YX48hmxOla+Vjhck
	H+X2ouT51Tz5BBDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fH46QH5r;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=awRaMbAb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795446224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWXuhg1k5v1/+2crSlissWZVGes2Kay5kOGyTB28JTQ=;
	b=fH46QH5rZxcbJ3HKOguymECK+ZXQPsZwXfHesxaEh4dLIyUrA2jMSXCLG/C/x9+nycixwD
	m6TgTrvnDldoPa9bGVByioXe4vbCqb30o70roD8P3B8aAStnjR19N50RcO6iITXCQFvXxo
	UBDJq2tVbQ6EMqrr14GwdNYpNSwONlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795446224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hWXuhg1k5v1/+2crSlissWZVGes2Kay5kOGyTB28JTQ=;
	b=awRaMbAbvcAkb6JHQIOMKXSzu2QxfT5aXGsAploaaUte7Uc2sJ3C43YX48hmxOla+Vjhck
	H+X2ouT51Tz5BBDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C50F13532;
	Mon, 23 Nov 2026 15:03:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fn+7Ms9VBGuyfwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Nov 2026 15:03:44 +0000
Message-ID: <ca3c9a36-6964-4cd3-8b13-71bae7ef28e4@suse.de>
Date: Mon, 23 Nov 2026 16:03:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] nvmet-auth: parse dhchap key from configfs
 attribute
To: sashiko-reviews@lists.linux.dev, Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
 <20261123-dhchap-keyring-v4-v5-5-81eefb4c0724@kernel.org>
 <sashiko-outbox-229218@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sashiko-outbox-229218@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 58BF021CEE
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.50
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_070346_869079_DD5E1F69 
X-CRM114-Status: GOOD (  32.69  )
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

On 11/23/26 1:29 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issues to consider:
> - [High] nvmet-auth: NULL pointer dereference in nvmet_auth_set_key()
>    when clearing key
> - [High] nvmet-auth: invalid DH-CHAP status and partial key update in
>    nvmet_setup_auth()
> - [High] nvmet-auth: shared key revocation in nvmet_auth_revoke_key()
>    breaks active ctrls
> - [High] nvmet-auth: uninitialized offset and OOB read in
>    nvme_dhchap_psk_preparse()
> - [Medium] nvmet-auth: missing DH-CHAP version and hash ID check in
>    nvmet_auth_set_key()
> --
> 
> commit 46da02dd0755f9ec506cfdb7b2885930c4ee4ffd
> Author: Hannes Reinecke <hare@kernel.org>
> 
> nvmet-auth: parse dhchap key from configfs attribute
> 
> This commit converts the nvmet configfs DH-HMAC-CHAP key interface to
> store keys as struct key pointers on struct nvmet_host rather than raw
> secret strings.
> 
>> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
>> index 26457ce4acc2a..8b77164512c9c 100644
>> --- a/drivers/nvme/target/auth.c
>> +++ b/drivers/nvme/target/auth.c
>> @@ -19,52 +19,63 @@
>>   
>>   #include "nvmet.h"
>>   
>> +void nvmet_auth_revoke_key(struct nvmet_host *host, bool set_ctrl)
>> +{
>> +	struct key *key = NULL;
>> +
>> +	if (set_ctrl) {
>> +		if (host->dhchap_ctrl_key) {
>> +			key = host->dhchap_ctrl_key;
>> +			host->dhchap_ctrl_key = NULL;
>> +		}
>> +	} else {
>> +		if (host->dhchap_key) {
>> +			key = host->dhchap_key;
>> +			host->dhchap_key = NULL;
>> +		}
>> +	}
>> +	if (key) {
>> +		pr_debug("%s: revoke %s key %08x\n",
>> +			 __func__, set_ctrl ? "ctrl" : "host",
>> +			 key_serial(key));
>> +		key_revoke(key);
>> +		key_put(key);
>> +	}
>> +}
> 
> [Severity: High]
> Does revoking the key here break active controllers that still hold a
> reference to it?
> 
> nvmet_setup_auth() shares host->dhchap_key and host->dhchap_ctrl_key with
> connected controllers via key_get().  When a key is updated or cleared in
> configfs, calling key_revoke() here marks that shared key revoked and
> clears its payload, even though nvmet_host_dhchap_key_store() notes that
> existing authentication must stay valid until the host requests
> re-authentication.  Because nvmet_execute_auth_send() only re-runs
> nvmet_setup_auth() on the admin queue, in-flight authentication or later
> I/O queue authentication on an existing controller continues using
> ctrl->host_key and fails in key_validate() with -EKEYREVOKED.
> 
> In addition, when host->dhchap_key is cleared to NULL, nvmet_setup_auth()
> returns early without dropping ctrl->host_key or ctrl->ctrl_key, leaving
> the controller pointing to the revoked key on re-authentication.
> 
This is okay. Once a queue is authenticated we cannot 'unset' the key
(and move the queue to unauthenticated) as this would break security
policies set during queue establishment.
The only way to clear a key for an authenticated queue is to disconnect
the queue (and controller) and do a full nvme connect without 
authentication.
Similarly, a revoked key will need to be used for re-authentication 
until the admin provides a valid key; we cannot disable or remove that
key as this would disable authentication.

>> +
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
> 
> [Severity: High]
> Does removing the offset check here expose an uninitialized read and an
> out-of-bounds read in nvme_dhchap_psk_preparse()?
> 
> Commit 62dae895f986 ("nvmet-auth: store the DH-CHAP key offset instead of
> hardcoding it") initialized offset = 0 and used the parsed %n offset.
> Delegating parsing to nvme_auth_extract_key() -> nvme_dhchap_psk_preparse()
> loses both fixes:
> 

Fixed with the next version.

> [Severity: Medium]
> Does switching to nvme_auth_extract_key() drop the DH-CHAP version and
> hash ID validation?
> 
> Previously, nvmet_auth_set_key() required the "DHHC-1:" prefix and
> rejected key_hash > 3 with -EINVAL.  nvme_dhchap_psk_preparse() parses
> "DHHC-%01hhu:%02hhu:%n" into version and hmac without checking that
> version == 1 or hmac <= 3, allowing keys with unsupported versions or
> hash IDs to be stored via configfs and deferring failure until
> authentication time.
> 

Fixed with the next version.

> [ ... ]
> 
>> @@ -186,44 +195,76 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
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
>>   	}
>> -	key_put(ctrl->host_key);
>> -	ctrl->host_key = host_key;
>> -	key_put(ctrl->ctrl_key);
>> -	ctrl->ctrl_key = ctrl_key;
>> +	key_id = key_serial(key);
>> +	up_read(&key->sem);
>> +	if (ret) {
>> +		pr_warn("host key %08x invalidated\n", key_id);
>> +		key_put(key);
>> +		key = ERR_PTR(-EKEYREVOKED);
>> +		goto out_unlock;
>> +	}
>>   	ctrl->shash_id = host->dhchap_hash_id;
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
>> +	if (!host->dhchap_ctrl_key) {
>> +		if (ctrl->ctrl_key) {
>> +			pr_debug("%s: drop ctrl key %08x\n",
>> +				 __func__, key_serial(ctrl->ctrl_key));
>> +			key_put(ctrl->ctrl_key);
>> +			ctrl->ctrl_key = NULL;
>> +		}
>> +		goto out_unlock;
>>   	}
>> +
>> +	key = key_get(host->dhchap_ctrl_key);
>> +	if (!key) {
>> +		pr_warn("%s: ctrl key %08x not found\n",
>> +			__func__, key_serial(host->dhchap_ctrl_key));
>> +		goto out_unlock;
>> +	}
>> +	down_read(&key->sem);
>> +	ret = key_validate(key);
>> +	if (!ret) {
>> +		if (ctrl->ctrl_key) {
>> +			pr_debug("%s: drop ctrl key %08x\n",
>> +				 __func__, key_serial(ctrl->ctrl_key));
>> +			key_put(ctrl->ctrl_key);
>> +		}
>> +		ctrl->ctrl_key = key;
>> +	}
>> +	key_id = key_serial(key);
>> +	up_read(&key->sem);
>> +	if (ret) {
>> +		pr_warn("ctrl key %08x invalidated\n", key_id);
>> +		key_put(key);
>> +		goto out_unlock;
>> +	}
> 
> [Severity: High]
> Does nvmet_setup_auth() return a negative errno instead of a DH-HMAC-CHAP
> status code when key_validate() fails, and overwrite ctrl->host_key before
> host->dhchap_ctrl_key is validated?
> 
> nvmet_execute_auth_send() stores the u8 return value of nvmet_setup_auth()
> directly in req->sq->dhchap_status to send in the DH-HMAC-CHAP_Failure1
> message.  When key_validate() fails for either key, ret holds a negative
> errno (such as -EKEYREVOKED) instead of NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE,
> so (u8)ret is sent on the wire as the failure reason code.  Conversely, if
> key_get() returns NULL, ret is still 0 and nvmet_setup_auth() reports
> success without installing the key.
> 
> Also, ctrl->host_key and ctrl->shash_id are replaced before
> host->dhchap_ctrl_key is validated, undoing commit 41ad4af45ac9
> ("nvmet-auth: keep the old keys if the new ones fail") and leaving the
> controller with a mismatched host/controller key pair if controller key
> validation fails during re-authentication.
> 

Fixed for the next version.

> [ ... ]
> 
>> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
>> index ff3a8d74de599..12c093f4c8363 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
> 
> [ ... ]
> 
>> @@ -2251,9 +2266,19 @@ static ssize_t nvmet_host_dhchap_key_store(struct config_item *item,
>>   		const char *page, size_t count)
>>   {
>>   	struct nvmet_host *host = to_host(item);
>> +	u8 *keydata = NULL;
>> +	size_t len;
>>   	int ret;
>>   
>> -	ret = nvmet_auth_set_key(host, page, false);
>> +	len = strcspn(page, "\n");
>> +	if (len) {
>> +		keydata = kstrndup(page, len, GFP_KERNEL);
>> +		if (!keydata)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	ret = nvmet_auth_set_key(host, keydata, false);
>> +	kfree_sensitive(keydata);
> 
> [Severity: High]
> Does clearing dhchap_key or dhchap_ctrl_key via configfs trigger a NULL
> pointer dereference in nvmet_auth_set_key()?
> 
> When an empty string or a newline is written to nvmet_host_dhchap_key_store()
> or nvmet_host_dhchap_ctrl_key_store() to clear a key, len is 0 and keydata
> remains NULL.  nvmet_auth_set_key() then evaluates if (!strlen(secret))
> without checking if secret is NULL first.
> 
Fixed with the next version.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

