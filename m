Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEB7606A31E
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fjKZefaL;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lrUTxkr3;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IvEnOuT2;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lrUTxkr3;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IvEnOuT2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=UBqlN+jYii1FPW1nDcFyMzeOguDSwtc6pw41o2k2sHE=; b=fjKZefaLvhX8XB
	iPQtvYEyz9/hBwqqDimaqmhvi+k0KSXmKLJcI/v3v+j2NuJivjFsrkLnW066TTOg+NkkwPTp6KLwl
	6ZjsDPOI+7Sdjut1m8Vg0Tcr+XqkaMwFeZ/7bo9zWrWf5EwvlqcdtjudqODxrFY0DJapnoovJeFwT
	JtLV1nSxv31Xe85+fTVBUH/+ExvMEUczvKxzJz2H0AP4gTincG0XM4mGSDdMtdpaskPg7xW6Qi9RE
	tBgB+LbhTFSBy3JK+tZF+rRGDcbtbvFK17E410aEz8SQBh6aCnzh4oRqSFAotITXUiJDqR9DhpvU/
	giqdiDqeD9dzLFGfQUYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVUkW-00000003gnz-3cZG;
	Mon, 23 Nov 2026 14:10:28 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVUkR-00000003gna-4BcC
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 14:10:26 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 48C1B1F452;
	Mon, 23 Nov 2026 14:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795443022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UBqlN+jYii1FPW1nDcFyMzeOguDSwtc6pw41o2k2sHE=;
	b=lrUTxkr35l6iFvZo3bSAICf7+WysAw7q5kh5t2ksIukRX20LF0ZGNjFVoIs3TlftAf92am
	IOm9duPdQllzmCWrv1LrmamFakEYuZgzsHQGdPgE6v7MT1XJSZWNRvUJrzzrVgp62rTrPh
	LoC19ZRrvZKFh+JXWxABVVmCL4BR4iE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795443022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UBqlN+jYii1FPW1nDcFyMzeOguDSwtc6pw41o2k2sHE=;
	b=IvEnOuT2QPC7jioOkJyE7lhulo25QVZSSkFmFmrFxWqoSzEo6sM58VqPOJ4m7I/VuPQFSp
	v+D4A5OeXmT3XMBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lrUTxkr3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IvEnOuT2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795443022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UBqlN+jYii1FPW1nDcFyMzeOguDSwtc6pw41o2k2sHE=;
	b=lrUTxkr35l6iFvZo3bSAICf7+WysAw7q5kh5t2ksIukRX20LF0ZGNjFVoIs3TlftAf92am
	IOm9duPdQllzmCWrv1LrmamFakEYuZgzsHQGdPgE6v7MT1XJSZWNRvUJrzzrVgp62rTrPh
	LoC19ZRrvZKFh+JXWxABVVmCL4BR4iE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795443022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UBqlN+jYii1FPW1nDcFyMzeOguDSwtc6pw41o2k2sHE=;
	b=IvEnOuT2QPC7jioOkJyE7lhulo25QVZSSkFmFmrFxWqoSzEo6sM58VqPOJ4m7I/VuPQFSp
	v+D4A5OeXmT3XMBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22AF61352B;
	Mon, 23 Nov 2026 14:10:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AxpiO01JBGtcSAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Nov 2026 14:10:22 +0000
Message-ID: <28c4e3f3-a54c-421a-8ac3-6fd233812aac@suse.de>
Date: Mon, 23 Nov 2026 15:10:21 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] nvme: parse dhchap keys during option parsing
To: sashiko-reviews@lists.linux.dev, Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
 <20261123-dhchap-keyring-v4-v5-4-81eefb4c0724@kernel.org>
 <sashiko-outbox-229226@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sashiko-outbox-229226@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 48C1B1F452
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
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.50
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_061024_358370_2C0E65B5 
X-CRM114-Status: GOOD (  30.67  )
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

On 11/23/26 1:34 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential
> issues to consider:
> - [High] nvme: build failure in sysfs.c when CONFIG_NVME_KEYRING is
>    disabled
> - [Low] nvme-auth: log of unassigned keys and NULL device in
>    nvme_auth_init_ctrl()
> - [Low] nvme-fabrics: dead !CONFIG_NVME_HOST_AUTH branches in
>    nvmf_parse_options()
> - [Low] nvme: missing trailing newline in dhchap_ctrl_secret_show() on
>    invalid key
> - [Low] nvme: wrong device pointer logged in dhchap_secret_store() and
>    ctrl store
> - [Low] nvme: undocumented dhchap_key sysfs attrs and inaccurate
>    changelog
> --
> 
> commit 8a46b5c132a1f37ed808c2b1576c3ace8af7cf7f
> Author: Hannes Reinecke <hare@kernel.org>
> 
> nvme: parse dhchap keys during option parsing
> 
> This commit extracts DH-HMAC-CHAP secrets into key objects during fabrics
> option parsing and exposes the active keys and their serial numbers via
> controller sysfs attributes.
> 
>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>> index 0ddf3834f4ea2..535cc433dd35d 100644
>> --- a/drivers/nvme/host/auth.c
>> +++ b/drivers/nvme/host/auth.c
> [ ... ]
>> @@ -1029,40 +1024,106 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
> [ ... ]
>> +	dev_dbg(ctrl->device,
>> +		"%s: using dhchap host key %08x\n",
>> +		__func__, key_serial(ctrl->host_key));
>> +	if (ctrl->host_key)
>> +		nvme_auth_clear_host_key(ctrl);
>> +	ctrl->host_key = host_key;
>> +
>> +	if (ctrl->ctrl_key)
>> +		nvme_auth_clear_ctrl_key(ctrl);
>> +	if (ctrl_key) {
>> +		dev_dbg(ctrl->device,
>> +			"%s: using dhchap ctrl key %08x\n",
>> +			__func__, key_serial(ctrl->ctrl_key));
>> +		ctrl->ctrl_key = ctrl_key;
>> +	}
> 
> [Severity: Low]
> Do these two dev_dbg() calls pass ctrl->host_key and ctrl->ctrl_key to
> key_serial() before assigning host_key and ctrl_key, always logging key
> serial 00000000?
> 
> Also, nvme_init_ctrl() calls nvme_auth_init_ctrl() before setting
> ctrl->device = &ctrl->ctrl_device, so ctrl->device is NULL for all
> dev_warn() and dev_dbg() calls in nvme_auth_init_ctrl().
> 
Fixed with the next version.

>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index 5ed91557f0706..0c09888be31f7 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
> [ ... ]
>> @@ -1086,6 +1078,53 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>>   			pr_warn("failfast tmo (%d) larger than controller loss tmo (%d)\n",
>>   				opts->fast_io_fail_tmo, ctrl_loss_tmo);
>>   	}
>> +
>> +	opts->host = nvmf_host_add(hostnqn, &hostid);
>> +	if (IS_ERR(opts->host)) {
>> +		ret = PTR_ERR(opts->host);
>> +		opts->host = NULL;
>> +		goto out;
>> +	}
>> +
>> +	if (host_secret) {
>> +#ifdef CONFIG_NVME_HOST_AUTH
>> +		pr_debug("lookup host identity '%s'\n", host_secret);
>> +		key = nvme_auth_extract_key(opts->keyring, host_secret,
>> +					    strlen(host_secret));
>> +		if (IS_ERR(key)) {
>> +			ret = PTR_ERR(key);
>> +			goto out;
>> +		}
>> +		pr_debug("using dhchap host key %08x\n", key_serial(key));
>> +		opts->dhchap_key = key;
>> +#else
>> +		pr_warn("nvme authentication is disabled\n");
>> +		ret = -EINVAL;
>> +		goto out;
>> +#endif
>> +	}
>> +	if (ctrl_secret) {
>> +#ifdef CONFIG_NVME_HOST_AUTH
>> +		if (!opts->dhchap_key) {
>> +			ret = -EINVAL;
>> +			goto out;
>> +		}
>> +		pr_debug("lookup ctrl identity '%s'\n", ctrl_secret);
>> +		key = nvme_auth_extract_key(opts->keyring, ctrl_secret,
>> +					    strlen(ctrl_secret));
>> +		if (IS_ERR(key)) {
>> +			ret = PTR_ERR(key);
>> +			goto out;
>> +		}
>> +		pr_debug("using dhchap ctrl key %08x\n", key_serial(key));
>> +		opts->dhchap_ctrl_key = key;
>> +#else
>> +		pr_warn("nvme authentication is disabled\n");
>> +		ret = -EINVAL;
>> +		goto out;
>> +#endif
>> +	}
> 
> [Severity: Low]
> Can the !CONFIG_NVME_HOST_AUTH branches under if (host_secret) and
> if (ctrl_secret) ever be reached?
> 
> NVMF_OPT_DHCHAP_SECRET and NVMF_OPT_DHCHAP_CTRL_SECRET in opt_tokens are
> guarded by #ifdef CONFIG_NVME_HOST_AUTH, so when CONFIG_NVME_HOST_AUTH is
> disabled, match_token() rejects dhchap_secret and dhchap_ctrl_secret as
> unknown parameters and jumps to out while host_secret and ctrl_secret are
> still NULL.
> 
Removed the '#else' branches for the next version.

>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>> index a5c1511e49ac2..e73c3ad89adc0 100644
>> --- a/drivers/nvme/host/sysfs.c
>> +++ b/drivers/nvme/host/sysfs.c
>> @@ -6,6 +6,8 @@
>>    */
>>   
>>   #include <linux/nvme-auth.h>
>> +#include <linux/nvme-keyring.h>
>> +#include <linux/key-type.h>
>>   #include <linux/blkdev.h>
> 
> [Severity: High]
> Does including linux/nvme-keyring.h unconditionally in sysfs.c break the
> build when CONFIG_NVME_CORE is enabled and CONFIG_NVME_KEYRING is
> disabled?
> 
> In the !IS_ENABLED(CONFIG_NVME_KEYRING) block of
> include/linux/nvme-keyring.h (updated earlier in commit "nvme-auth: switch
> to use 'struct key'"), nvme_tls_psk_refresh() has a malformed parameter
> list and nvme_dhchap_psk_hash() is defined without static inline:
> 
> include/linux/nvme-keyring.h:
>      static inline struct key *nvme_tls_psk_refresh(struct key *keyring,
> 		const char *hostnqn, const char *subnqn, *data, u8 hmac_id,
> 		u8 *data, size_t data_len, const char *digest)
>      ...
>      u8 nvme_dhchap_psk_hash(struct key *key)
>      {
> 	return 0;
>      }
> 
> Since sysfs.c is built for any CONFIG_NVME_CORE configuration and does not
> use any symbols from linux/nvme-keyring.h, compiling with
> CONFIG_NVME_KEYRING=n fails with syntax and multiple-definition errors.
> 
Fixed wit the next version.

>> @@ -830,36 +850,47 @@ static ssize_t dhchap_secret_store(struct device *dev,
> [ ... ]
>> +	down_read(&key->sem);
>> +	ret = key_validate(key);
>> +	up_read(&key->sem);
>> +	if (ret) {
>> +		dev_warn(ctrl->dev, "key %08x invalidated\n", key_serial(key));
>> +		dev_dbg(ctrl->dev, "revoke host key %08x\n", key_serial(key));
>> +		key_revoke(key);
>> +		key_put(key);
>> +		kfree_sensitive(dhchap_secret);
>> +		return ret;
>> +	}
>> +	mutex_lock(&ctrl->dhchap_auth_mutex);
>> +	old_key = ctrl->host_key;
>> +	dev_dbg(ctrl->dev, "revoke host key %08x\n",
>> +		key_serial(old_key));
>> +	key_revoke(old_key);
> 
> [Severity: Low]
> Should these dev_warn() and dev_dbg() calls in dhchap_secret_store() and
> dhchap_ctrl_secret_store() use ctrl->device instead of ctrl->dev?
> 
> ctrl->dev is the parent transport device (such as the shared
> /sys/class/nvme-fabrics/ctl device), whereas ctrl->device is the nvmeX
> controller device used by the rest of the function.
> 
Fixed with the next version.

>> @@ -873,11 +904,28 @@ static ssize_t dhchap_ctrl_secret_show(struct device *dev,
>>   		struct device_attribute *attr, char *buf)
>>   {
>>   	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>> -	struct nvmf_ctrl_options *opts = ctrl->opts;
>> +	struct key *key;
>> +	ssize_t count;
>>   
>> -	if (!opts->dhchap_ctrl_secret)
>> +	mutex_lock(&ctrl->dhchap_auth_mutex);
>> +	key = ctrl->ctrl_key;
>> +	if (!key) {
>> +		mutex_unlock(&ctrl->dhchap_auth_mutex);
>>   		return sysfs_emit(buf, "none\n");
>> -	return sysfs_emit(buf, "%s\n", opts->dhchap_ctrl_secret);
>> +	}
>> +	down_read(&key->sem);
>> +	if (key_validate(key))
>> +		count = sysfs_emit(buf, "<invalidated>");
> 
> [Severity: Low]
> Is a trailing newline missing from "<invalidated>" in
> dhchap_ctrl_secret_show()?  dhchap_secret_show(), dhchap_key_show(), and
> dhchap_ctrl_key_show() all emit "<invalidated>\n".
> 
Fixed with the next version.

> [ ... ]
> 
>> @@ -925,6 +981,52 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
>>   }
>>   
>>   static DEVICE_ATTR_ADMIN_RW(dhchap_ctrl_secret);
>> +
>> +static ssize_t dhchap_key_show(struct device *dev,
>> +		struct device_attribute *attr, char *buf)
>> +{
> [ ... ]
>> +}
>> +static DEVICE_ATTR_ADMIN_RO(dhchap_key);
>> +
>> +static ssize_t dhchap_ctrl_key_show(struct device *dev,
>> +		struct device_attribute *attr, char *buf)
>> +{
> [ ... ]
>> +}
>> +static DEVICE_ATTR_ADMIN_RO(dhchap_ctrl_key);
> 
> [Severity: Low]
> This isn't a bug, but the new dhchap_key and dhchap_ctrl_key sysfs
> attributes are not mentioned in the commit message or documented in
> Documentation/ABI/stable/sysfs-nvme.  Also, the commit message says the
> key serial is stored in struct nvmf_ctrl_options, whereas opts stores
> struct key pointers (dhchap_key and dhchap_ctrl_key).
> 
Updated for the next version.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

