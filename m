Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D375460A382C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Nov 2026 10:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=F46yuswY;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=PT5Jq66V;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ExYum4nB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8RH8dXHS;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ExYum4nB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8RH8dXHS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=xijV4TT34H1HE2E7K9j73ByrP6P42ezlU93ERe98y0I=; b=F46yuswYxlDVbi
	8YEKiMDSBNYZT9PjJbG+PgXgW8XOK4orAiV6c2mU7gCsEGd3dX++f8HRzb9A7PQLzQHQv7XN1HLeh
	ZP7kVLjLfnrA87ZkkADA16pepwMFD0q4Uk0hKJfJK4LQha2rFambe0Y0QnobQhZq3N2q0gq4KUNU5
	1HeIzKfj5hv4MmHRwuVToFqZac5n1Ana8NlNMHWhsAcyU3E7wTNTfUlC2eVLaAwTwhqIXkoZq19HQ
	dEuy97F9OotRO2bmLKPQLnTDm2GYr/9i6xPllvBBaJ9wcLj3X1C8/Byz9/D7yoExsJf8YROBcIh5L
	AwoYeQtoB76JQ6/ZEQQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWsym-0000000FZqG-2HQe;
	Fri, 27 Nov 2026 10:14:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWsyl-0000000FZpJ-0gGc
	for linux-nvme@bombadil.infradead.org;
	Fri, 27 Nov 2026 10:14:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=xijV4TT34H1HE2E7K9j73ByrP6P42ezlU93ERe98y0I=; b=PT5Jq66VWM+c0tpIdV3Q6ansKG
	OLWMUPy6IG1LHHldTmeRnG7gnE1XQfVDtlgTVBDPjeZBkmkSp6/JvAjyJYFys70W4DjPKPGFgNg7A
	KMggWsCLF7Yq9jzxeKVm4FsC6BlmnqZSqO+qTnHhW/N2/cH6x+FLM8LDoNEwLiCIJokjuDo4+YEAF
	075gAFtswIL+ZsA3nQengXjMYU36pAWnnozh8CcK4cJIyEZu2eYko695okVK5deOY/6k5M0mrqjZA
	6jIgzkxjwIEgohR8xZl3W9Ue1SwrxCHzDvX0ysksLnrkXNTg/danMvwR5ccOrNbu/cGQ5kDBWkjak
	8IqIKp+w==;
Received: from smtp-out2.suse.de ([195.135.223.131])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWsyi-00000007ZY4-29CJ
	for linux-nvme@lists.infradead.org;
	Fri, 27 Nov 2026 10:14:54 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 33CF51F813;
	Fri, 27 Nov 2026 10:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795774491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xijV4TT34H1HE2E7K9j73ByrP6P42ezlU93ERe98y0I=;
	b=ExYum4nBCF2yhW9z+pRPSTxQ2qDUkoh1MaukTrHQ79PfTB60spE3nkBvc1DVKRH29sJEFo
	2IU/I2S6S+S+IwylgbZ4JRlfjocmvMRz9hfB0mu46FEWFW+TBZ7vukOUoFXiRtB+CV7676
	v088bGVtXuzk1CkLZNxy648roigV5dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795774491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xijV4TT34H1HE2E7K9j73ByrP6P42ezlU93ERe98y0I=;
	b=8RH8dXHSVVOWyJYEqGUXTahEWOFIlYxfxW+L4Wis6UvTz/JddZIaln4cT2Z/GzLw7ef7oK
	rE8UhG1vXVeum6BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ExYum4nB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8RH8dXHS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795774491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xijV4TT34H1HE2E7K9j73ByrP6P42ezlU93ERe98y0I=;
	b=ExYum4nBCF2yhW9z+pRPSTxQ2qDUkoh1MaukTrHQ79PfTB60spE3nkBvc1DVKRH29sJEFo
	2IU/I2S6S+S+IwylgbZ4JRlfjocmvMRz9hfB0mu46FEWFW+TBZ7vukOUoFXiRtB+CV7676
	v088bGVtXuzk1CkLZNxy648roigV5dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795774491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xijV4TT34H1HE2E7K9j73ByrP6P42ezlU93ERe98y0I=;
	b=8RH8dXHSVVOWyJYEqGUXTahEWOFIlYxfxW+L4Wis6UvTz/JddZIaln4cT2Z/GzLw7ef7oK
	rE8UhG1vXVeum6BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7836713432;
	Fri, 27 Nov 2026 10:14:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KAyoABpYCWtBSgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 27 Nov 2026 10:14:50 +0000
Message-ID: <4fa5e563-463c-4a45-bccc-00d2b2c947ce@suse.de>
Date: Fri, 27 Nov 2026 11:14:49 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/14] nvme-fabrics: allow to pass in keyring by name
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
 <20261126-dhchap-keyring-v4-v7-12-ee438ffea527@kernel.org>
 <sashiko-outbox-235711@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sashiko-outbox-235711@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 33CF51F813
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
	RCPT_COUNT_TWELVE(0.00)[17];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
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
X-CRM114-CacheID: sfid-20261127_101452_571281_10815DF8 
X-CRM114-Status: GOOD (  30.55  )
X-Spam-Score: -2.5 (--)
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

On 11/26/26 3:31 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 8 potential
> issues to consider:
> - [High] nvme-fabrics: NULL dereference and key leak in
>    nvmf_parse_options()
> - [High] nvme-fabrics: missing keyring link and key leak in
>    tls_keyring_store()
> - [High] nvme-fabrics: vmlinux link failure when CONFIG_NVME_KEYRING=m
> - [High] nvme-keyring: broken header stubs when CONFIG_NVME_KEYRING=n
> - [Medium] nvme-fabrics: unstripped newline in tls_keyring_store()
>    breaks lookup
> - [Medium] nvme-fabrics: missing key type and state checks in keyring ID
>    fallback
> - [Medium] nvme-fabrics: unsynchronized opts->keyring access in
>    tls_keyring_store()
> - [Low] nvme-fabrics: unreachable !keyring path in
>    nvme_tls_attrs_are_visible()
> --
> 
> commit cea520ca62b4a11b68d9d8f8ca9eeea627f871dd
> Author: Hannes Reinecke <hare@kernel.org>
> 
> nvme-fabrics: allow to pass in keyring by name
> 
> This commit allows specifying the fabrics keyring option by name in
> addition to serial number, enables the keyring option for all fabrics
> transports, and makes the tls_keyring sysfs attribute writable.
> 
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index bba6a4848f227..12a30ed16f9ef 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -663,8 +663,8 @@ static struct key *nvmf_parse_key(int key_id)
>>   {
>>   	struct key *key;
>>   
>> -	if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
>> -		pr_err("TLS is not supported\n");
>> +	if (!IS_ENABLED(CONFIG_NVME_KEYRING)) {
>> +		pr_err("nvme keyring is not supported\n");
>>   		return ERR_PTR(-EINVAL);
>>   	}
> 
> [Severity: High]
> Can this fail to link vmlinux when CONFIG_NVME_KEYRING=m?
> 
> IS_ENABLED(CONFIG_NVME_KEYRING) is true when NVME_KEYRING is a module,
> while NVME_FABRICS in drivers/nvme/host/Kconfig only selects NVME_KEYRING
> if NVME_TCP_TLS is enabled.  If CONFIG_NVME_FABRICS=y (with
> CONFIG_NVME_TCP_TLS=n and CONFIG_NVME_HOST_AUTH=n) and
> CONFIG_NVME_KEYRING=m (for example via CONFIG_NVME_TARGET=m), built-in
> fabrics.o references nvme_tls_key_lookup() and nvme_keyring_link() in
> nvme-keyring.ko.  Similarly, when CONFIG_NVME_CORE=y, CONFIG_NVME_TCP=m,
> and CONFIG_NVME_TCP_TLS=y, NVME_FABRICS=m selects CONFIG_NVME_KEYRING=m,
> so built-in drivers/nvme/host/sysfs.o fails to link against
> nvme_keyring_name() and nvme_keyring_unlink().
> 
Modified Kconfig selection to include NVME_AUTH when selecting NVME_KEYRING

> [ ... ]
> 
>> @@ -993,14 +995,24 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>>   			opts->tos = token;
>>   			break;
>>   		case NVMF_OPT_KEYRING:
>> -			if (match_int(args, &key_id) || key_id <= 0) {
>> -				ret = -EINVAL;
>> +#if IS_ENABLED(CONFIG_NVME_KEYRING)
>> +			p = match_strdup(args);
>> +			if (!p) {
>> +				ret = -ENOMEM;
>>   				goto out;
>>   			}
>> -			key = nvmf_parse_key(key_id);
>> +			key = request_key(&key_type_keyring, p, NULL);
>> +			kfree(p);
>>   			if (IS_ERR(key)) {
>> -				ret = PTR_ERR(key);
>> -				goto out;
>> +				if (match_int(args, &key_id) || key_id <= 0) {
>> +					ret = -EINVAL;
>> +					goto out;
>> +				}
>> +				key = nvmf_parse_key(key_id);
>> +				if (IS_ERR(key)) {
>> +					ret = PTR_ERR(key);
>> +					goto out;
>> +				}
>>   			}
>>   			ret = nvme_keyring_link(opts->keyring);
>>   			if (ret) {
>> @@ -1008,6 +1020,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>>   				goto out;
>>   			}
>>   			opts->keyring = key;
>> +#endif
>>   			break;
> 
> [Severity: High]
> Does nvme_keyring_link(opts->keyring) pass NULL instead of the newly
> looked-up key?
> 
> On the first keyring= option, opts->keyring is NULL, so
> nvme_keyring_link(NULL) calls key_link(nvme_keyring, NULL) ->
> __key_link_lock(), triggering a NULL pointer dereference on
> index_key->type with nvme_keyring->sem held write-locked.  If keyring= is
> specified more than once in the option string, the previous opts->keyring
> is also overwritten without being unlinked or released with key_put().
> 
Fixed with the next version.

> [Severity: High]
> Does guarding this block with #if IS_ENABLED(CONFIG_NVME_KEYRING) expose
> broken stubs in include/linux/nvme-keyring.h when CONFIG_NVME_KEYRING=n?
> 
Fixed by modifying Kconfig selection in the next patch.

> include/linux/nvme-keyring.h {
>      ...
> static const char *nvme_keyring_name(void)
> {
> 	return NULL;
> }
> static int nvme_keyring_link(struct key *keyring)
> {
> 	return 0;
> }
> int nvme_keyring_unlink(struct key *keyring)
> {
> 	return 0;
> }
>      ...
> }
> 
> When CONFIG_NVME_KEYRING is disabled, nvme_keyring_unlink() is defined as
> a non-static function in the header, causing multiple-definition linker
> errors across fabrics.o, sysfs.o, and tcp.o, while the non-inline static
> nvme_keyring_link() stub becomes unused in fabrics.c and triggers
> -Wunused-function.
> 
Fixed with the next version.

>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>> index 4ebc03a8ddcae..0ffea12fcfb6b 100644
>> --- a/drivers/nvme/host/sysfs.c
>> +++ b/drivers/nvme/host/sysfs.c
>> @@ -1212,7 +1212,38 @@ static ssize_t tls_keyring_show(struct device *dev,
>>   		return sysfs_emit(buf, "%s\n", nvme_keyring_name());
>>   	return sysfs_emit(buf, "%s\n", keyring->description);
>>   }
>> -static DEVICE_ATTR_RO(tls_keyring);
>> +
>> +static ssize_t tls_keyring_store(struct device *dev,
>> +		struct device_attribute *attr, const char *buf, size_t count)
>> +{
>> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>> +	struct key *keyring = ctrl->opts->keyring;
>> +	int ret;
>> +
>> +	keyring = request_key(&key_type_keyring, buf, NULL);
> 
> [Severity: Medium]
> Does passing buf directly to request_key() without stripping a trailing
> newline break keyring lookup by name from sysfs?
> 
> Writes such as "echo my_keyring > tls_keyring" pass "my_keyring\n" to
> request_key(), which fails with -ENOKEY and falls through to kstrtoul(),
> returning -EINVAL.  Other sysfs handlers in this file (such as
> dhchap_secret_store()) strip the trailing newline with strcspn(buf, "\n").
> 
Dropped this hunk from the next version, so all reviews to this function
no longer apply.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

