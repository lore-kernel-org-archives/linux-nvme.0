Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BCC606A33E
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RhFDlVsD;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=1OhmEY/V;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=noZbqmLQ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=1OhmEY/V;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=noZbqmLQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=/n3fTy8ng6ZYYJpewKOX6yR/aTlEnLa2I6y45l6z/UA=; b=RhFDlVsDbCQ7UH
	yzlP/thvqDzXAydQHoXZ278qTlNltL4ZUXU/xRcZrK5eih/UGdIkBzGBXLlWNEvMVRySceb/47NK7
	aNs57p/8E+Wd61sxvuAEvamZu6KYKMNX1WQH2Y0jb3gC4jSxg1sWatP3YwkE5hMo8e6Idh12QhCSP
	/X/zRNMVykFYt5yRXd+HHfQ1uoIVOiRQWP5BatND8OZZfAqle8f3wyY3TER81YwpWb6Hcih05NZII
	0vz+X+BBoKFEST+cE+6uDW7RElCW2CI/iaF/U92IBp0Dqv1I9VgifRMLaB4y/KCUmFCGYVXhXD4yF
	1qW/8CYq31g2jRFpCsew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUP5D-0000000FBpD-0YUE;
	Fri, 20 Nov 2026 13:55:19 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUP55-0000000FBnf-25gB
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 13:55:14 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E6841F458;
	Fri, 20 Nov 2026 13:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795182909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/n3fTy8ng6ZYYJpewKOX6yR/aTlEnLa2I6y45l6z/UA=;
	b=1OhmEY/VCq8CkAfiWhxBgropxPFpmMC0vHiHCUyZ2sL/0UEpAcW428SpV0JaU8jyoN+6Tq
	1n2212OpEBqz0SNEPqfnlx6h7oz7PckX6rczBChdjOFqcmdoN9WbCoV3IIDi3wJvldjBX9
	3xx4Fg59YJ+54B2zUIZqgl6PyJv+QtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795182909;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/n3fTy8ng6ZYYJpewKOX6yR/aTlEnLa2I6y45l6z/UA=;
	b=noZbqmLQ5JiTpQpREI0+ez677JldCjJz0vyIFJculmKfR/390D6KmUNl3cljssT2bKyiyK
	N6hcHpl2Tkc0riAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="1OhmEY/V";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=noZbqmLQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795182909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/n3fTy8ng6ZYYJpewKOX6yR/aTlEnLa2I6y45l6z/UA=;
	b=1OhmEY/VCq8CkAfiWhxBgropxPFpmMC0vHiHCUyZ2sL/0UEpAcW428SpV0JaU8jyoN+6Tq
	1n2212OpEBqz0SNEPqfnlx6h7oz7PckX6rczBChdjOFqcmdoN9WbCoV3IIDi3wJvldjBX9
	3xx4Fg59YJ+54B2zUIZqgl6PyJv+QtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795182909;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/n3fTy8ng6ZYYJpewKOX6yR/aTlEnLa2I6y45l6z/UA=;
	b=noZbqmLQ5JiTpQpREI0+ez677JldCjJz0vyIFJculmKfR/390D6KmUNl3cljssT2bKyiyK
	N6hcHpl2Tkc0riAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 614831348F;
	Fri, 20 Nov 2026 13:55:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ht2MDj1RAGuDCgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 20 Nov 2026 13:55:09 +0000
Message-ID: <d6585844-1446-45f6-8960-9c2c37c13f7c@suse.de>
Date: Fri, 20 Nov 2026 14:55:09 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] nvme: parse dhchap keys during option parsing
To: sashiko-reviews@lists.linux.dev, Hannes Reinecke <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
 <20261120-dhchap-keyring-v4-v4-4-5f8c7d9926ee@kernel.org>
 <sashiko-outbox-225048@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sashiko-outbox-225048@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8E6841F458
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
X-CRM114-CacheID: sfid-20261120_055513_645982_B661D418 
X-CRM114-Status: GOOD (  29.01  )
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

On 11/20/26 12:32 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 7 potential
> issues to consider:
> - [High] nvme-fabrics: wrong key revoked in nvmf_free_options() for
>    dhchap_ctrl_key
> - [High] nvme: build failure in nvmf_parse_options() and sysfs.c without
>    auth/keyring
> - [High] nvme: removing secret length checks exposes underflows in key
>    preparsing
> - [Medium] nvme: out-of-bounds write on read error in
>    dhchap_ctrl_secret_show()
> - [Medium] nvme-auth: host_key ref leak and inverted check in
>    nvme_auth_init_ctrl()
> - [Medium] nvme: unlocked host_key and ctrl_key access in dhchap sysfs
>    show callbacks
> - [Low] nvme: check !ctrl->opts for dhchap_key attrs in
>    nvme_dev_attrs_are_visible()
> --
> 
> commit ddf0d4926edd9ec44ea25839b02c0ba20380f64e
> Author: Hannes Reinecke <hare@kernel.org>
> 
> nvme: parse dhchap keys during option parsing
> 
> This commit parses DH-HMAC-CHAP secrets into struct key pointers during
> fabric option parsing instead of storing raw secret strings in
> nvmf_ctrl_options, and adds sysfs attributes to expose the host and
> controller key serials.
> 
>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>> index 0ddf3834f4ea2..c189096f825ea 100644
>> --- a/drivers/nvme/host/auth.c
>> +++ b/drivers/nvme/host/auth.c
> [ ... ]
>> @@ -1038,31 +1056,68 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
>>   	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
>>   	if (!ctrl->opts)
>>   		return 0;
>> -	ctrl->host_key = nvme_auth_extract_key(ctrl->opts->keyring,
>> -				ctrl->opts->dhchap_secret,
>> -				strlen(ctrl->opts->dhchap_secret));
>> -	if (IS_ERR(ctrl->host_key)) {
>> -		ret = PTR_ERR(ctrl->host_key);
>> -		ctrl->host_key = NULL;
>> -		return ret;
>> +	if (!ctrl->opts->dhchap_key) {
>> +		nvme_auth_clear_host_key(ctrl);
>> +		nvme_auth_clear_ctrl_key(ctrl);
>> +		return 0;
>>   	}
>> +	if (!ctrl->host_key)
>> +		nvme_auth_clear_host_key(ctrl);
>>
>> -	ctrl->ctrl_key = nvme_auth_extract_key(ctrl->opts->keyring,
>> -				ctrl->opts->dhchap_ctrl_secret,
>> -				strlen(ctrl->opts->dhchap_ctrl_secret));
>> -	if (IS_ERR(ctrl->ctrl_key)) {
>> -		ret = PTR_ERR(ctrl->ctrl_key);
>> -		ctrl->ctrl_key = NULL;
>> -		goto err_free_dhchap_secret;
>> +	ctrl->host_key = key_get(ctrl->opts->dhchap_key);
>> +	if (!ctrl->host_key) {
>> +		dev_warn(ctrl->device,
>> +			 "dhchap host key %08x not present\n",
>> +			 key_serial(ctrl->opts->dhchap_key));
>> +		return -ENOKEY;
>>   	}
>> +	down_read(&ctrl->host_key->sem);
>> +	ret = key_validate(ctrl->host_key);
>> +	up_read(&ctrl->host_key->sem);
>> +	if (ret) {
>> +		dev_warn(ctrl->device,
>> +			 "dhchap host key %08x invalidated\n",
>> +			 key_serial(ctrl->host_key));
>> +		key_put(ctrl->host_key);
>> +		ctrl->host_key = NULL;
>> +		return -ENOKEY;
>> +	}
>> +	dev_dbg(ctrl->device,
>> +		"%s: using dhchap host key %08x\n",
>> +		__func__, key_serial(ctrl->host_key));
>>
>> -	if (!ctrl->opts->dhchap_secret && !ctrl->opts->dhchap_ctrl_secret)
>> -		return 0;
>> +	if (ctrl->ctrl_key)
>> +		nvme_auth_clear_ctrl_key(ctrl);
>> +
>> +	if (ctrl->opts->dhchap_ctrl_key) {
>> +		ctrl->ctrl_key = key_get(ctrl->opts->dhchap_ctrl_key);
>> +		if (!ctrl->ctrl_key) {
>> +			dev_warn(ctrl->device,
>> +				 "dhchap ctrl key %08x not present\n",
>> +				 key_serial(ctrl->opts->dhchap_ctrl_key));
>> +			return -ENOKEY;
>> +		}
>> +		down_read(&ctrl->ctrl_key->sem);
>> +		ret = key_validate(ctrl->ctrl_key);
>> +		up_read(&ctrl->ctrl_key->sem);
>> +		if (ret) {
>> +			dev_warn(ctrl->device,
>> +				 "dhchap ctrl key %08x invalidated\n",
>> +				 key_serial(ctrl->ctrl_key));
>> +			key_put(ctrl->ctrl_key);
>> +			ctrl->ctrl_key = NULL;
>> +			return -EKEYREVOKED;
>> +		}
> 
> [Severity: Medium]
> Do the error returns in the ctrl->opts->dhchap_ctrl_key block leak the
> ctrl->host_key reference taken earlier in nvme_auth_init_ctrl()?
> 
> When nvme_auth_init_ctrl() fails, nvme_init_ctrl() jumps to
> out_release_instance before initializing ctrl->ctrl_device, so
> nvme_auth_free() is never called on that error path.
> 
> Also, the check before nvme_auth_clear_host_key(ctrl) is inverted
> (!ctrl->host_key instead of ctrl->host_key), and nvme_init_ctrl() calls
> nvme_auth_init_ctrl() before assigning ctrl->device = &ctrl->ctrl_device,
> so the dev_warn() and dev_dbg() calls here pass a NULL ctrl->device.
> 
Restructured the function to only update the ->host_key and ->ctrl_key
values once the keys are validated.

>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index 5ed91557f0706..7ed8618257ca9 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
> [ ... ]
>> @@ -1020,14 +1024,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>>   				ret = -ENOMEM;
>>   				goto out;
>>   			}
>> -			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
>> -				pr_err("Invalid DH-CHAP secret %s\n", p);
>> -				kfree_sensitive(p);
>> -				ret = -EINVAL;
>> -				goto out;
>> -			}
>> -			kfree_sensitive(opts->dhchap_secret);
>> -			opts->dhchap_secret = p;
>> +			kfree_sensitive(host_secret);
>> +			host_secret = p;
>>   			break;
>>   		case NVMF_OPT_DHCHAP_CTRL_SECRET:
>>   			p = match_strdup(args);
>> @@ -1035,14 +1033,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>>   				ret = -ENOMEM;
>>   				goto out;
>>   			}
>> -			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
>> -				pr_err("Invalid DH-CHAP secret %s\n", p);
>> -				kfree_sensitive(p);
>> -				ret = -EINVAL;
>> -				goto out;
>> -			}
>> -			kfree_sensitive(opts->dhchap_ctrl_secret);
>> -			opts->dhchap_ctrl_secret = p;
>> +			kfree_sensitive(ctrl_secret);
>> +			ctrl_secret = p;
>>   			break;
> 
> [Severity: High]
> Does removing the minimum length checks here and in dhchap_secret_store() /
> dhchap_ctrl_secret_store() allow short secret strings to underflow datalen
> and ret in nvme_dhchap_psk_preparse()?
> 
> drivers/nvme/common/keyring.c:nvme_dhchap_psk_preparse() {
>      ...
> 	if (sscanf(prep->data, "DHHC-%01hhu:%02hhu:%*s",
> 		   &version, &hmac) != 2) {
>      ...
> 	}
> 
> 	/* skip header and final ':' character */
> 	datalen -= 11;
> }
> 
> Because %*s is assignment-suppressed and %02hhu matches one or two digits,
> sscanf() returns 2 for 8- to 10-byte strings such as "DHHC-1:0:a", causing
> unsigned datalen -= 11 to wrap around and wrap the kzalloc() size
> calculation sizeof(*upayload) + datalen.  For 11- to 15-byte inputs such as
> "DHHC-1:00:a" where base64_decode() returns 0..3, ret -= 4 in
> nvme_dhchap_psk_preparse() becomes negative and is passed as an unsigned
> length to crc32(~0, upayload->data, ret), reading out-of-bounds across
> kernel memory.
> 
The parsing routines have been fixed with reworks of the previous patches.

> [ ... ]
> 
>> @@ -1086,6 +1078,41 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
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
>> +		pr_debug("lookup host identity '%s'\n", host_secret);
>> +		key = nvme_auth_extract_key(opts->keyring, host_secret,
>> +					    strlen(host_secret));
>> +		if (IS_ERR(key)) {
>> +			ret = PTR_ERR(key);
>> +			goto out;
>> +		}
>> +		pr_debug("using dhchap host key %08x\n", key_serial(key));
>> +		opts->dhchap_key = key;
>> +	}
>> +	if (ctrl_secret) {
>> +		if (!opts->dhchap_key) {
>> +			ret = -EINVAL;
>> +			goto out;
>> +		}
>> +		pr_debug("lookup ctrl identity '%s'\n", ctrl_secret);
>> +		key = nvme_auth_extract_key(opts->keyring, ctrl_secret,
>> +					    strlen(ctrl_secret));
> 
> [Severity: High]
> Does calling nvme_auth_extract_key() unconditionally here break the build
> when CONFIG_NVME_FABRICS is enabled without CONFIG_NVME_AUTH (or when
> CONFIG_NVME_FABRICS=y and CONFIG_NVME_AUTH=m)?
> 
> include/linux/nvme-auth.h declares nvme_auth_extract_key() without a
> !CONFIG_NVME_AUTH stub, and match_token() is an external call so the
> compiler cannot dead-code-eliminate the host_secret and ctrl_secret
> branches when CONFIG_NVME_HOST_AUTH is disabled.
> 
> In addition, drivers/nvme/host/sysfs.c now includes <linux/nvme-keyring.h>
> unconditionally, which fails to compile when CONFIG_NVME_KEYRING is
> disabled due to a stray semicolon and a non-inline function definition in
> the fallback block:
> 
> include/linux/nvme-keyring.h:
> static inline struct key *nvme_dhchap_psk_lookup(struct key *keyring,
> 		const char *hostnqn, const char *subnqn, u8 hmac);
> {
> 	return ERR_PTR(-EOPNOTSUPP);
> }
> u8 nvme_dhchap_psk_hash(struct key *key)
> {
> 	return 0;
> }
> 
Fixed up with the next version.

> [ ... ]
> 
>> @@ -1304,8 +1326,18 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
>>   	kfree(opts->subsysnqn);
>>   	kfree(opts->host_traddr);
>>   	kfree(opts->host_iface);
>> -	kfree_sensitive(opts->dhchap_secret);
>> -	kfree_sensitive(opts->dhchap_ctrl_secret);
>> +	if (opts->dhchap_key) {
>> +		pr_debug("revoke dhchap host key %08x\n",
>> +			 key_serial(opts->dhchap_key));
>> +		key_revoke(opts->dhchap_key);
>> +		key_put(opts->dhchap_key);
>> +	}
>> +	if (opts->dhchap_ctrl_key) {
>> +		pr_debug("revoke dhchap ctrl key %08x\n",
>> +			 key_serial(opts->dhchap_ctrl_key));
>> +		key_revoke(opts->dhchap_key);
>> +		key_put(opts->dhchap_ctrl_key);
>> +	}
> 
> [Severity: High]
> In the opts->dhchap_ctrl_key block, should key_revoke() be passed
> opts->dhchap_ctrl_key instead of opts->dhchap_key?  Passing
> opts->dhchap_key dereferences the host key after key_put(opts->dhchap_key)
> has already dropped its reference, and leaves opts->dhchap_ctrl_key
> unrevoked.
> 
Of course. Fixed up with the next version.

>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>> index a5c1511e49ac2..1311f5e29b004 100644
>> --- a/drivers/nvme/host/sysfs.c
>> +++ b/drivers/nvme/host/sysfs.c
> [ ... ]
>> @@ -818,11 +820,23 @@ static ssize_t dhchap_secret_show(struct device *dev,
>>   		struct device_attribute *attr, char *buf)
>>   {
>>   	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>> -	struct nvmf_ctrl_options *opts = ctrl->opts;
>> +	struct key *key = ctrl->host_key;
>> +	ssize_t count;
>>
>> -	if (!opts->dhchap_secret)
>> +	if (!key)
>>   		return sysfs_emit(buf, "none\n");
>> -	return sysfs_emit(buf, "%s\n", opts->dhchap_secret);
>> +	down_read(&key->sem);
>> +	if (key_validate(key))
>> +		count = sysfs_emit(buf, "<invalidated>\n");
>> +	else {
>> +		count = key->type->read(key, buf, PAGE_SIZE);
>> +		if (count > 0) {
>> +			buf[count] = '\n';
>> +			count++;
>> +		}
>> +	}
>> +	up_read(&key->sem);
>> +	return count;
>>   }
> [ ... ]
>> @@ -830,36 +844,47 @@ static ssize_t dhchap_secret_store(struct device *dev,
> [ ... ]
>> +	mutex_lock(&ctrl->dhchap_auth_mutex);
>> +	old_key = ctrl->host_key;
>> +	dev_dbg(ctrl->dev, "revoke host key %08x\n",
>> +		key_serial(old_key));
>> +	key_revoke(old_key);
>> +
>> +	ctrl->host_key = key;
>> +	mutex_unlock(&ctrl->dhchap_auth_mutex);
>> +	key_put(old_key);
> 
> [Severity: Medium]
> Can a concurrent read of dhchap_secret (or dhchap_ctrl_secret, dhchap_key,
> or dhchap_ctrl_key) race with dhchap_secret_store() or
> dhchap_ctrl_secret_store() and trigger a use-after-free on the old key?
> 
> CPU0                              CPU1
> dhchap_secret_show()
>    key = ctrl->host_key;
>                                    dhchap_secret_store()
>                                      mutex_lock(&ctrl->dhchap_auth_mutex);
>                                      old_key = ctrl->host_key;
>                                      key_revoke(old_key);
>                                      ctrl->host_key = key;
>                                      mutex_unlock(&ctrl->dhchap_auth_mutex);
>                                      key_put(old_key);  <-- frees old_key
>    down_read(&key->sem);  <-- use-after-free
> 
> None of dhchap_secret_show(), dhchap_ctrl_secret_show(), dhchap_key_show(),
> or dhchap_ctrl_key_show() hold ctrl->dhchap_auth_mutex or take a key_get()
> reference before dereferencing ctrl->host_key or ctrl->ctrl_key.  Once a
> key has been replaced via sysfs store (so opts->dhchap_key no longer holds
> a reference), ctrl->host_key holds the only reference, and key_put(old_key)
> frees it while a concurrent show callback is using it.
> 
Updated the _show functions to take the dhchap_auth_mutex.

>> @@ -873,11 +898,23 @@ static ssize_t dhchap_ctrl_secret_show(struct device *dev,
>>   		struct device_attribute *attr, char *buf)
>>   {
>>   	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>> -	struct nvmf_ctrl_options *opts = ctrl->opts;
>> +	struct key *key = ctrl->ctrl_key;
>> +	size_t count;
>>
>> -	if (!opts->dhchap_ctrl_secret)
>> +	if (!key)
>>   		return sysfs_emit(buf, "none\n");
>> -	return sysfs_emit(buf, "%s\n", opts->dhchap_ctrl_secret);
>> +	down_read(&key->sem);
>> +	if (key_validate(key))
>> +		count = sysfs_emit(buf, "<invalidated>");
>> +	else {
>> +		count = key->type->read(key, buf, PAGE_SIZE);
>> +		if (count > 0) {
>> +			buf[count] = '\n';
>> +			count++;
>> +		}
>> +	}
>> +	up_read(&key->sem);
>> +	return count;
>>   }
> 
> [Severity: Medium]
> Can a negative error return from key->type->read() cause an out-of-bounds
> write before buf in dhchap_ctrl_secret_show() and dhchap_key_show()?
> 
> Unlike dhchap_secret_show(), which declares ssize_t count, both
> dhchap_ctrl_secret_show() and dhchap_key_show() declare count as unsigned
> size_t.  If key->type->read() returns a negative error code (such as
> -EINVAL), count wraps to a large positive value, passes count > 0, and
> writes '\n' to buf[count] out-of-bounds.  Commit "nvme: allow to pass in
> key description as dhchap secret" later in this series replaces
> key->type->read() in dhchap_key_show(), but dhchap_ctrl_secret_show()
> retains the unsigned size_t count and also omits the trailing newline on
> "<invalidated>".
> 
Used 'ssize_t' here, too.

> [ ... ]
> 
>> @@ -925,6 +970,41 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
>>   }
>>
>>   static DEVICE_ATTR_ADMIN_RW(dhchap_ctrl_secret);
>> +
>> +static ssize_t dhchap_key_show(struct device *dev,
>> +		struct device_attribute *attr, char *buf)
>> +{
>> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>> +	struct key *key = ctrl->host_key;
>> +	size_t count;
>> +
>> +	if (!key)
>> +		return 0;
>> +	down_read(&key->sem);
>> +	if (key_validate(key))
>> +		count = sysfs_emit(buf, "<invalidated>\n");
>> +	else {
>> +		count = key->type->read(key, buf, PAGE_SIZE);
>> +		if (count > 0) {
>> +			buf[count] = '\n';
>> +			count++;
>> +		}
>> +	}
>> +	up_read(&key->sem);
>> +	return count;
>> +}
>> +static DEVICE_ATTR_ADMIN_RO(dhchap_key);
>> +
>> +static ssize_t dhchap_ctrl_key_show(struct device *dev,
>> +		struct device_attribute *attr, char *buf)
>> +{
>> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>> +
>> +	if (!ctrl->ctrl_key)
>> +		return 0;
>> +	return sysfs_emit(buf, "%08x\n", key_serial(ctrl->ctrl_key));
>> +}
>> +static DEVICE_ATTR_ADMIN_RO(dhchap_ctrl_key);
>>   #endif
>>
>>   static struct attribute *nvme_dev_attrs[] = {
>> @@ -956,6 +1036,8 @@ static struct attribute *nvme_dev_attrs[] = {
>>   #ifdef CONFIG_NVME_HOST_AUTH
>>   	&dev_attr_dhchap_secret.attr,
>>   	&dev_attr_dhchap_ctrl_secret.attr,
>> +	&dev_attr_dhchap_key.attr,
>> +	&dev_attr_dhchap_ctrl_key.attr,
>>   #endif
> 
> [Severity: Low]
> Should nvme_dev_attrs_are_visible() hide dev_attr_dhchap_key.attr and
> dev_attr_dhchap_ctrl_key.attr when !ctrl->opts, the same way it hides
> dev_attr_dhchap_secret.attr and dev_attr_dhchap_ctrl_secret.attr?  Without
> that check, both attributes appear on non-Fabrics controllers (such as PCIe
> controllers) when CONFIG_NVME_HOST_AUTH is enabled.
> 
Yes, it should. Updated for the next version.

> Also, in this patch dhchap_key_show() outputs the key payload via
> key->type->read() instead of key_serial(key) as dhchap_ctrl_key_show() does
> (though commit "nvme: allow to pass in key description as dhchap secret"
> later in the series updates dhchap_key_show() to emit key_serial()).
> 
Fixed up with the next version.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

