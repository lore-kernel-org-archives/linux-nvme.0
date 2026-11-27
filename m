Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ABE606A31C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Nov 2026 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3OPm73Vg;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=TFzAV5Eh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=p6Chr0Vc;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=TFzAV5Eh;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=p6Chr0Vc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=WtPONeQNptK60dRnXsQtk+TpjO0s1q6dHnTkgRxZNCo=; b=3OPm73VgbARM1b
	m2aEl5ZEE+y3qCvNO5Uck5EO4c14pW8sguWJxwwQdVrYYL7+FPF2yxiXyJMbZ6HjvWQmigOfiF1wD
	ifSaZw4vz3hz+rlfiX3A5Y+IrHwVY5lLcMiYrIXB4aJxfbaUx/+5FgYzVKjsqtIHhhPWlpsL6pgUG
	FAWWIIi77FRJibOfqYdDHAP0YTHGAqy0t8stw9PD/jz2wQdJJ5gcA5dnUifNzagJmaDe724kycdHZ
	vd6b8VAVKpEMVyOSXXrQ20IYthhlbb5qn9dVUo5Os3WQcYrx0lUz5PU/Dt9u+ijJtdTCQtn3HsiAh
	uisEGXGrALIWv0Au8BJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWs1T-0000000FOSe-3Wql;
	Fri, 27 Nov 2026 09:13:39 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWs1Q-0000000FOSI-2Vx8
	for linux-nvme@lists.infradead.org;
	Fri, 27 Nov 2026 09:13:38 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A46A21F452;
	Fri, 27 Nov 2026 09:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795770814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WtPONeQNptK60dRnXsQtk+TpjO0s1q6dHnTkgRxZNCo=;
	b=TFzAV5EhYlo+BguMgyKKWB2vqEBPAZ9dX4SMrW8Jfu2mWnt0VWe3gbk7jmuG+r6WAD5H+6
	tlJrLTLg6yVHGigMOquKPqrIiMwWTOg9t4Z7fHjIqBmBYPAhXK6ROQ4PAmGMsvAcHXQ3ma
	V1OBic/6b+ocD2nIu5e+xYl1VFj/u0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795770814;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WtPONeQNptK60dRnXsQtk+TpjO0s1q6dHnTkgRxZNCo=;
	b=p6Chr0VcFq3LdaDoNUZR3gBQPdDADJmQx6KRYqebsVAInOGOreb1NgGDdw0HpABjlq7OhY
	ldAbMlfYRCRtDgAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TFzAV5Eh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=p6Chr0Vc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795770814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WtPONeQNptK60dRnXsQtk+TpjO0s1q6dHnTkgRxZNCo=;
	b=TFzAV5EhYlo+BguMgyKKWB2vqEBPAZ9dX4SMrW8Jfu2mWnt0VWe3gbk7jmuG+r6WAD5H+6
	tlJrLTLg6yVHGigMOquKPqrIiMwWTOg9t4Z7fHjIqBmBYPAhXK6ROQ4PAmGMsvAcHXQ3ma
	V1OBic/6b+ocD2nIu5e+xYl1VFj/u0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795770814;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WtPONeQNptK60dRnXsQtk+TpjO0s1q6dHnTkgRxZNCo=;
	b=p6Chr0VcFq3LdaDoNUZR3gBQPdDADJmQx6KRYqebsVAInOGOreb1NgGDdw0HpABjlq7OhY
	ldAbMlfYRCRtDgAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52BD0134E8;
	Fri, 27 Nov 2026 09:13:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lICEC75JCWuwCwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 27 Nov 2026 09:13:34 +0000
Message-ID: <51911e62-8e69-4408-b37c-d9d57a8ba7b0@suse.de>
Date: Fri, 27 Nov 2026 10:13:33 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/14] nvme-auth: allow to specify the key by key
 serial
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
 <20261126-dhchap-keyring-v4-v7-10-ee438ffea527@kernel.org>
 <sashiko-outbox-235696@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <sashiko-outbox-235696@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: A46A21F452
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261127_011336_956667_2CAEA2FC 
X-CRM114-Status: GOOD (  23.24  )
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

On 11/26/26 3:26 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] nvme-auth: missing key type validation in
>    nvme_auth_extract_key()
> - [Low] nvme-auth: key_serial truncation to key_serial_t in
>    nvme_auth_extract_key()
> --
> 
> commit 7d31006b6164c1d407e94a069e4daf6dec180cf1
> Author: Hannes Reinecke <hare@kernel.org>
> 
> nvme-auth: allow to specify the key by key serial
> 
> This commit updates nvme_auth_extract_key() to parse a numeric key serial
> and look up the key via key_lookup() before falling back to key description
> lookup or key generation.
> 
>> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
>> index 15e72fe8868af..e336c698437dc 100644
>> --- a/drivers/nvme/common/auth.c
>> +++ b/drivers/nvme/common/auth.c
>> @@ -148,7 +148,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_hmac_hash_len);
>>    * @generated: indicate whether a key has been generated
>>    *
>>    * Extracts or generates a key from @input.
>> - * @input can either be a key description or raw key data; in
>> + * @input can be a key serial, a key description or raw key data; in
>>    * the latter case a key is generated from @input and
>>    * @generated is set to 'true'.
>>    *
>> @@ -158,7 +158,18 @@ struct key *nvme_auth_extract_key(const char *input, size_t input_len,
>>   				  bool *generated)
>>   {
>>   	struct key *key;
>> -
>> +	unsigned long key_serial;
>> +	int err;
>> +
>> +	/* Check if @input is a key serial */
>> +	err = kstrtoul(input, 0, &key_serial);
>> +	if (!err) {
>> +		key = key_lookup(key_serial);
> 
> [Severity: Low]
> Can kstrtoul() silently truncate 64-bit values when key_serial is passed to
> key_lookup()?  key_serial_t is int32_t and valid serials are positive, so a
> numeric string larger than INT_MAX on 64-bit platforms is narrowed to its
> lower 32 bits instead of being rejected.  Parsing with kstrtos32() and
> checking key_serial > 0 would avoid this.
> 
Fixed with the next version.

>> +		if (!IS_ERR(key)) {
>> +			*generated = false;
>> +			return key;
>> +		}
>> +	}
> 
> [Severity: High]
> Can key_lookup() return a key that is not a positively instantiated
> nvme_dhchap_psk_key_type key?
> 
> Unlike nvme_dhchap_psk_lookup(), key_lookup() searches the global serial
> tree without checking key->type or instantiation state.  When
> nvme_auth_transform_key() later runs, it unconditionally calls user_read()
> and nvme_dhchap_psk_hash(), which read key->payload.rcu_data0 as a struct
> user_key_payload and access 6 bytes past upayload->datalen:
> 
> drivers/nvme/common/keyring.c:nvme_dhchap_psk_hash() {
> 	...
> 	upayload = user_key_payload_locked(key);
> 	hmac = upayload->data[upayload->datalen + 5];
> 	return hmac;
> }
> 
> Passing the serial of an uninstantiated key, a keyring, or another key type
> (such as user, logon, or NVMe TLS PSK, where user_preparse() only allocates
> upayload->datalen bytes) causes a NULL pointer dereference, type confusion,
> or a 6-byte slab out-of-bounds read.
> 
Fixed with the next version.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

