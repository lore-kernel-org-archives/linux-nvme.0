Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF23606A31C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Nov 2026 07:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vzI2Awy3;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZTYuFEyp;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UL4k7IZT;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZTYuFEyp;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UL4k7IZT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=n96sOU/5/jnhCO42S+4rsCREmChCaTIsZkg6ljCCD2I=; b=vzI2Awy3iq9Fss
	CF/N/cKuwrTJjApz4EC5UyUyJoO7I0XgwY5xyP26whInpyBnclpJlXRtc+tq1FqDppGgSrPmInskU
	2+5u0e368WamE8t9PXP1TgKw0K6GDj0wtVLDE72sKRNQCcrQXT6E6d9ZsST6xsLivBRlZO0/8oxHk
	b32nerBWGnW3dITyW/G3djl6A9h/QpPvFlmrFQPh1AMn0UgFUKzATAjuZp0hP32C0f0UVUT95KL2h
	EiFF4JWorGJTMiXxAoo4gU1SIIZcSM6zzWhaorWZMlbxkS5MxYmlzqVbIFxGzk3MvwC2elqnBUDJT
	aOyFC9ceOajfRtUY1cTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWqU2-0000000F8bF-23CY;
	Fri, 27 Nov 2026 07:35:02 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWqTz-0000000F8Zu-0wnI
	for linux-nvme@lists.infradead.org;
	Fri, 27 Nov 2026 07:35:00 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8724422847;
	Fri, 27 Nov 2026 07:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795764897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n96sOU/5/jnhCO42S+4rsCREmChCaTIsZkg6ljCCD2I=;
	b=ZTYuFEyp0O6eFBgB/uufgy9Hde4Cuq2M6nFh22BRBoac89MK/Ggn/3f1YXQi9BB21xSw7g
	myZ5gJR96Ei6d1O1AZQJ+P9G4qzHNnwJqEA9sknfJl0DcSIN6NWaBnsAJ7jwe30byGE2DS
	aHl3kVCvUZEcY9liXuOhJyCy5K7cFoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795764897;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n96sOU/5/jnhCO42S+4rsCREmChCaTIsZkg6ljCCD2I=;
	b=UL4k7IZTozHVaUV85Gta+JabDHiwk5FwpfCbUOER0vDlU9eI+UKmxibIocQGEVb7zWvef8
	FxomVih/Ul5WgWAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795764897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n96sOU/5/jnhCO42S+4rsCREmChCaTIsZkg6ljCCD2I=;
	b=ZTYuFEyp0O6eFBgB/uufgy9Hde4Cuq2M6nFh22BRBoac89MK/Ggn/3f1YXQi9BB21xSw7g
	myZ5gJR96Ei6d1O1AZQJ+P9G4qzHNnwJqEA9sknfJl0DcSIN6NWaBnsAJ7jwe30byGE2DS
	aHl3kVCvUZEcY9liXuOhJyCy5K7cFoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795764897;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n96sOU/5/jnhCO42S+4rsCREmChCaTIsZkg6ljCCD2I=;
	b=UL4k7IZTozHVaUV85Gta+JabDHiwk5FwpfCbUOER0vDlU9eI+UKmxibIocQGEVb7zWvef8
	FxomVih/Ul5WgWAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E117913432;
	Fri, 27 Nov 2026 07:34:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y7UfKKAyCWsgKAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 27 Nov 2026 07:34:56 +0000
Message-ID: <14ae3e78-ac9b-4bb8-99f1-a29a28d5984d@suse.de>
Date: Fri, 27 Nov 2026 08:34:56 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/14] nvmet-auth: parse dhchap key from configfs
 attribute
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
 <20261126-dhchap-keyring-v4-v7-8-ee438ffea527@kernel.org>
 <sashiko-outbox-235707@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sashiko-outbox-235707@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261126_233459_419663_AD79884E 
X-CRM114-Status: GOOD (  19.38  )
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

On 11/26/26 3:30 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] nvmet-auth: ERR_PTR dereference in key_lookup() callers
> --
> 
> commit b41d5ff16da6a60366fa816c551dfd75334950eb
> Author: Hannes Reinecke <hare@kernel.org>
> 
> nvmet-auth: parse dhchap key from configfs attribute
> 
> This commit converts the nvmet DH-HMAC-CHAP configfs attributes to store
> key serial numbers in struct nvmet_host and look up the keys via
> key_lookup() when needed.
> 
>> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
>> index e1d92f5455219..ff0e8569d7067 100644
>> --- a/drivers/nvme/target/auth.c
>> +++ b/drivers/nvme/target/auth.c
> 
> [ ... ]
> 
>> @@ -186,22 +212,45 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
>>   		goto out_unlock;
>>   	}
>>   
>> -	if (!host->dhchap_secret) {
>> +	if (!host->dhchap_key) {
>>   		pr_debug("No authentication provided\n");
>>   		goto out_unlock;
>>   	}
>>   
>> -	host_key = nvme_auth_extract_key(host->dhchap_secret,
>> -					 strlen(host->dhchap_secret));
>> -	if (IS_ERR(host_key)) {
>> +	host_key = key_lookup(host->dhchap_key);
>> +	if (!host_key) {
>> +		pr_warn("%s: host key %08x not found\n",
>> +			__func__, host->dhchap_key);
>>   		ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
>>   		goto out_unlock;
>>   	}
>> -	if (host->dhchap_ctrl_secret) {
>> -		ctrl_key = nvme_auth_extract_key(host->dhchap_ctrl_secret,
>> -						 strlen(host->dhchap_ctrl_secret));
>> -		if (IS_ERR(ctrl_key)) {
>> +	down_read(&host_key->sem);
>> +	ret = key_validate(host_key);
>> +	up_read(&host_key->sem);
>> +	if (ret) {
>> +		pr_warn("host key %08x invalidated\n",
>> +			host->dhchap_key);
>> +		key_put(host_key);
>> +		ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
>> +		goto out_unlock;
>> +	}
>> +	if (host->dhchap_ctrl_key) {
>> +		ctrl_key = key_lookup(host->dhchap_ctrl_key);
>> +		if (!ctrl_key) {
>> +			pr_warn("%s: ctrl key %08x not found\n",
>> +				__func__, host->dhchap_ctrl_key);
>> +			key_put(host_key);
>> +			ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
>> +			goto out_unlock;
>> +		}
>> +		down_read(&ctrl_key->sem);
>>   
>> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
>> index ff3a8d74de599..f6bfda757f076 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
> 
> [ ... ]
> 
>> @@ -2234,15 +2235,29 @@ static struct config_group nvmet_ports_group;
>>   static ssize_t nvmet_host_dhchap_key_show(struct config_item *item,
>>   		char *page)
>>   {
>> -	char *dhchap_secret;
>> +	struct nvmet_host *host = to_host(item);
>> +	struct key *key;
>>   	ssize_t ret;
>>   
>>   	down_read(&nvmet_config_sem);
>> -	dhchap_secret = to_host(item)->dhchap_secret;
>> -	if (!dhchap_secret)
>> -		ret = sprintf(page, "\n");
>> -	else
>> -		ret = sprintf(page, "%s\n", dhchap_secret);
>> +	key = key_lookup(host->dhchap_key);
>> +	if (!key) {
>> +		page[0] = '\0';
>> +		ret = 0;
>> +	} else {
>> +		down_read(&key->sem);
> 
> [ ... ]
> 
>> @@ -2267,15 +2292,29 @@ CONFIGFS_ATTR(nvmet_host_, dhchap_key);
>>   static ssize_t nvmet_host_dhchap_ctrl_key_show(struct config_item *item,
>>   		char *page)
>>   {
>> -	char *dhchap_secret = to_host(item)->dhchap_ctrl_secret;
>> +	struct nvmet_host *host = to_host(item);
>> +	struct key *key;
>>   	ssize_t ret;
>>   
>>   	down_read(&nvmet_config_sem);
>> -	dhchap_secret = to_host(item)->dhchap_ctrl_secret;
>> -	if (!dhchap_secret)
>> -		ret = sprintf(page, "\n");
>> -	else
>> -		ret = sprintf(page, "%s\n", dhchap_secret);
>> +	key = key_lookup(host->dhchap_ctrl_key);
>> +	if (!key) {
>> +		page[0] = '\0';
>> +		ret = 0;
>> +	} else {
>> +		down_read(&key->sem);
> 
> [Severity: High]
> Should the key_lookup() checks in nvmet_setup_auth(),
> nvmet_host_dhchap_key_show(), and nvmet_host_dhchap_ctrl_key_show() use
> IS_ERR() instead of testing for NULL?
> 
> key_lookup() returns ERR_PTR(-ENOKEY) when a key serial is not found
> (including when dhchap_key or dhchap_ctrl_key is 0 because no key is
> configured).  Checking !key lets ERR_PTR(-ENOKEY) through and crashes at
> down_read(&key->sem) when reading the configfs attributes on a host
> without a key configured or when a key is not found during
> authentication setup.
> 

Fixed with the next version.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

