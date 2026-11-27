Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC7C606A31E
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Nov 2026 10:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NUk7VwsB;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EFdnpaJH;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bLn/7QWS;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EFdnpaJH;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bLn/7QWS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=KowgHdxAv0VqgGY3kZnozXRx78oYlqyIyYJ2riEahb0=; b=NUk7VwsBgU+N/P
	BP1oCn3x7evbhIsxT+mlrLZSncvyb8hPT41Gl++hH/cZPH85k3y9/aMkpF4ILSGe3mt7rfHymKo5N
	rr97SKbuYhUitRl2wrYcF+QpsyHzzams2DtulmuEdZzS1ti/uHfvPoawlRly0vT4MLJ/aLl6f8uOP
	wIzPujwgmYE9pdnkzs31Xso81rYVvP2fTnuDwPYMhiGUNyhych730ANKW921jHrbpIQgyTD7OYEO5
	UTNXnXQZwCc56oZKR2nMAS/QCea9o1iXz50n2L+Wl0iBNrbgRx8KpZ+QR9CIOAxzSfa3JxUi5zONr
	TPAkD83SDphhEmXNJR9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWtVS-0000000FfDC-0YmY;
	Fri, 27 Nov 2026 10:48:42 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWtVP-0000000FfBo-2NbM
	for linux-nvme@lists.infradead.org;
	Fri, 27 Nov 2026 10:48:41 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 75A991FB78;
	Fri, 27 Nov 2026 10:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795776517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KowgHdxAv0VqgGY3kZnozXRx78oYlqyIyYJ2riEahb0=;
	b=EFdnpaJHns3RcOCCP39Hb3ZxoENu6F7wxfU3W53Y9Yi5pCyz5382Lsdt7NTNeMU+1GDYB2
	ejoFp+M4wGZSh09b49z7YEA6m0hZfNwvRoVshxJw+BynMZo0twVcj/LuilQvXyE9zkyJZP
	XT9EE1PJGARfKFw4m1SXLSzEVYoRg9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795776517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KowgHdxAv0VqgGY3kZnozXRx78oYlqyIyYJ2riEahb0=;
	b=bLn/7QWSRpc+xaOS3AdvmzG64aycNcdAUMIgbeeo7xb+JaCwzAGBNXG18ncKkA+ltzLh5K
	eW4wuJM1v1fZnrBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EFdnpaJH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="bLn/7QWS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795776517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KowgHdxAv0VqgGY3kZnozXRx78oYlqyIyYJ2riEahb0=;
	b=EFdnpaJHns3RcOCCP39Hb3ZxoENu6F7wxfU3W53Y9Yi5pCyz5382Lsdt7NTNeMU+1GDYB2
	ejoFp+M4wGZSh09b49z7YEA6m0hZfNwvRoVshxJw+BynMZo0twVcj/LuilQvXyE9zkyJZP
	XT9EE1PJGARfKFw4m1SXLSzEVYoRg9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795776517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KowgHdxAv0VqgGY3kZnozXRx78oYlqyIyYJ2riEahb0=;
	b=bLn/7QWSRpc+xaOS3AdvmzG64aycNcdAUMIgbeeo7xb+JaCwzAGBNXG18ncKkA+ltzLh5K
	eW4wuJM1v1fZnrBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E852134E8;
	Fri, 27 Nov 2026 10:48:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E9WKAAVgCWvLbgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 27 Nov 2026 10:48:37 +0000
Message-ID: <434003e5-9e0d-44dd-a81b-f23f93fa52cd@suse.de>
Date: Fri, 27 Nov 2026 11:48:36 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/14] nvme-auth: allow to update pre-provisioned keys
To: sashiko-reviews@lists.linux.dev, Hannes Reinecke <hare@kernel.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Eric Biggers <ebiggers@kernel.org>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, keyrings@vger.kernel.org,
 Martin Belanger <martin.nvme.dev@gmail.com>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-14-ee438ffea527@kernel.org>
 <sashiko-outbox-235712@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sashiko-outbox-235712@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-12.00 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -12.00
X-Spam-Level: 
X-Rspamd-Queue-Id: 75A991FB78
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261127_024839_760943_6681CACB 
X-CRM114-Status: GOOD (  22.19  )
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

On 11/26/26 3:31 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issues to consider:
> - [High] nvme-auth: uninitialized old_key dereference in
>    dhchap_*_secret_store()
> - [High] nvme-keyring: .update callback added to psk instead of dhchap
>    key_type
> - [Medium] nvme-auth: wrong pre-populated key check in
>    dhchap_*_secret_store()
> --
> 
> commit 3ccb1f2ff3d815bafe5e4d68e5e266a56f5a6f51
> Author: Hannes Reinecke <hare@kernel.org>
> 
> nvme-auth: allow to update pre-provisioned keys
> 
> This commit attempts to support rotating pre-provisioned DH-HMAC-CHAP keys
> via keyctl update by adding a key_type .update callback and disallowing
> sysfs key replacements for pre-populated controller keys.
> 
>> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
>> index bee64c592752a..ffabd37cd090d 100644
>> --- a/drivers/nvme/common/keyring.c
>> +++ b/drivers/nvme/common/keyring.c
>> @@ -100,6 +100,7 @@ static struct key_type nvme_tls_psk_key_type = {
>>   	.free_preparse  = user_free_preparse,
>>   	.match_preparse = nvme_tls_psk_match_preparse,
>>   	.instantiate    = generic_key_instantiate,
>> +	.update         = user_update,
>>   	.revoke         = user_revoke,
>>   	.destroy        = user_destroy,
>>   	.describe       = nvme_tls_psk_describe,
> 
> [Severity: High]
> Was .update added to nvme_tls_psk_key_type instead of
> nvme_dhchap_psk_key_type?  Because nvme_dhchap_psk_key_type still has no
> .update callback, calling keyctl update on a dhchap key fails with
> -EOPNOTSUPP.
> 
Fixed with the next version.

>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>> index 0ffea12fcfb6b..0eb68b3973a1e 100644
>> --- a/drivers/nvme/host/sysfs.c
>> +++ b/drivers/nvme/host/sysfs.c
>> @@ -887,9 +887,17 @@ static ssize_t dhchap_secret_store(struct device *dev,
>>   		kfree_sensitive(dhchap_secret);
>>   		return ret;
>>   	}
>> +	if (!generated &&
>> +	    key_serial(old_key) != key_serial(key)) {
> 
> [Severity: Medium]
> Should this check !ctrl->host_key_generated under ctrl->dhchap_auth_mutex
> instead of !generated (and similarly !ctrl->ctrl_key_generated in
> dhchap_ctrl_secret_store())?
> 
> nvme_auth_extract_key() sets generated based on whether the newly written
> sysfs input is a raw DHHC-1 secret or an existing key lookup, not whether
> the controller's current key was pre-populated.  Writing a raw DHHC-1
> secret sets generated = true, bypassing this check and overwriting a
> pre-populated ctrl->host_key with a newly generated key, while writing a
> pre-populated key identifier to a controller that currently uses a
> generated key is rejected with -EPERM.
> 
Fixed up in the next version.

>> +		dev_warn(ctrl->device, "cannot change pre-populated key %08x\n",
>> +			 key_serial(old_key));
>> +		key_put(key);
>> +		kfree_sensitive(dhchap_secret);
>> +		return -EPERM;
>> +	}
>>   	mutex_lock(&ctrl->dhchap_auth_mutex);
>>   	old_key = ctrl->host_key;
> 
> [Severity: High]
> Does key_serial(old_key) dereference an uninitialized old_key pointer in
> both dhchap_secret_store() and dhchap_ctrl_secret_store()?
> 
> old_key is declared on the stack without an initializer and is only
> assigned from ctrl->host_key (or ctrl->ctrl_key) after acquiring
> ctrl->dhchap_auth_mutex below.  When writing a pre-populated key to sysfs
> (generated == false), key_serial(old_key) reads old_key->serial from the
> uninitialized pointer, or returns 0 when CONFIG_INIT_STACK_ALL_ZERO=y and
> causes every re-authentication write to fail with -EPERM.
> 
Fixed with the next version.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

