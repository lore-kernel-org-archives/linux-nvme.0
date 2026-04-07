Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8AEFB519C
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Apr 2026 06:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WzfSZ5caEEyxh5GcfOGS//JnTBWP90iZm4yk6GWvIK8=; b=ANuC4tMXUoOr3i6hPQNlN6cwE9
	Pnm1guq3Tamtqk7rJP7f1h9rdadFgKq+k6KFRVL4DhI1TMw6SSyL4DaSXDojbbgCmF9Y6skAmctOV
	o6hFKF3JWtoSeZRe371QKuZDJzF6nh+slS9wBtT94UQljn9w7KUfCuJ7vo/4FoIwR0lMPsQhIBCy9
	OPELP3vEYrdS7lyrSIzT6mbgdXXdhI/FIi7TuL0oBw+gIhg7J1NF0YdVYnFPSeWdIouOfbrxrtR3N
	HWu03nyOm5n79ODmcqDbivl5+kXr/BozEEXTEaJQ/4tEORmOaZj1nfzgm8mdwMSCyykZ6mjvjoHew
	7TQhX3NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9znU-00000005ygY-2uD7;
	Tue, 07 Apr 2026 06:20:24 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9znR-00000005yfR-3gBM
	for linux-nvme@lists.infradead.org;
	Tue, 07 Apr 2026 06:20:23 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 318775BDCF;
	Tue,  7 Apr 2026 06:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775542820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WzfSZ5caEEyxh5GcfOGS//JnTBWP90iZm4yk6GWvIK8=;
	b=zu3aJhJ8kUO89rvgio7QWdJgranqRywPTFR/GeGTTUhO4sJWXWU4flL2epSusnmC0Q1hKb
	urdgrc3jRG9DBmxv0eyC/W8gWY6VFgK8oCy9CuWp9P9gayAdsBfoQKvvoe9zCXjy8FL1gH
	mLtnwFs9vu5U2r/IP1SiWYjC6Td/4vA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775542820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WzfSZ5caEEyxh5GcfOGS//JnTBWP90iZm4yk6GWvIK8=;
	b=tbsjkZoDspMS/G/I+t0wRZ/KSBbDye4SmjsGYXDc0wzgXoEn9Okif5ggMMK5x9jfI0oi+u
	crz+/lXo/wRqkdBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775542820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WzfSZ5caEEyxh5GcfOGS//JnTBWP90iZm4yk6GWvIK8=;
	b=zu3aJhJ8kUO89rvgio7QWdJgranqRywPTFR/GeGTTUhO4sJWXWU4flL2epSusnmC0Q1hKb
	urdgrc3jRG9DBmxv0eyC/W8gWY6VFgK8oCy9CuWp9P9gayAdsBfoQKvvoe9zCXjy8FL1gH
	mLtnwFs9vu5U2r/IP1SiWYjC6Td/4vA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775542820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WzfSZ5caEEyxh5GcfOGS//JnTBWP90iZm4yk6GWvIK8=;
	b=tbsjkZoDspMS/G/I+t0wRZ/KSBbDye4SmjsGYXDc0wzgXoEn9Okif5ggMMK5x9jfI0oi+u
	crz+/lXo/wRqkdBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04E9C4A0B0;
	Tue,  7 Apr 2026 06:20:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0KIOOyOi1GldEAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 07 Apr 2026 06:20:19 +0000
Message-ID: <7e406bf1-604c-4dab-aeb8-519ada055162@suse.de>
Date: Tue, 7 Apr 2026 08:20:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] nvme-auth: switch to use 'struct key'
To: Chris Leech <cleech@redhat.com>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20260317130103.107360-1-hare@kernel.org>
 <20260317130103.107360-4-hare@kernel.org>
 <20260401-dd12748d3ce7d56bf6f24fa3@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260401-dd12748d3ce7d56bf6f24fa3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260406_232022_066012_96E99A33 
X-CRM114-Status: GOOD (  19.53  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/1/26 20:36, Chris Leech wrote:
> On Tue, Mar 17, 2026 at 02:00:58PM +0100, Hannes Reinecke wrote:
>> Use the new key type 'dhchap' to store the DH-HMAC-CHAP keys and modify
>> handling function to use 'struct key'. With that we can drop the now
>> unused 'struct nvme_dhchap_key' definitions.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/common/Kconfig   |   1 +
>>   drivers/nvme/common/auth.c    | 191 +++++++++++++---------------------
>>   drivers/nvme/common/keyring.c |  98 +++++++++++++++++
>>   drivers/nvme/host/Kconfig     |   1 -
>>   drivers/nvme/host/auth.c      |  28 +++--
>>   drivers/nvme/host/nvme.h      |   4 +-
>>   drivers/nvme/host/sysfs.c     |  26 +++--
>>   drivers/nvme/target/Kconfig   |   1 -
>>   drivers/nvme/target/auth.c    |  40 +++----
>>   drivers/nvme/target/nvmet.h   |   4 +-
>>   include/linux/nvme-auth.h     |  17 +--
>>   include/linux/nvme-keyring.h  |  22 +++-
>>   12 files changed, 256 insertions(+), 177 deletions(-)
> ...
>> @@ -180,42 +181,43 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
>>   		ctrl->shash_id = host->dhchap_hash_id;
>>   	}
>>   
>> -	/* Skip the 'DHHC-1:XX:' prefix */
>> -	nvme_auth_free_key(ctrl->host_key);
>> -	ctrl->host_key = nvme_auth_extract_key(host->dhchap_secret + 10,
>> -					       host->dhchap_key_hash);
>> +	key_put(ctrl->host_key);
>> +	ctrl->host_key = nvme_auth_extract_key(NULL, host->dhchap_secret,
>> +					       strlen(host->dhchap_secret));
>>   	if (IS_ERR(ctrl->host_key)) {
>>   		ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
>>   		ctrl->host_key = NULL;
>>   		goto out_free_hash;
>>   	}
>> -	pr_debug("%s: using hash %s key %*ph\n", __func__,
>> -		 ctrl->host_key->hash > 0 ?
>> -		 nvme_auth_hmac_name(ctrl->host_key->hash) : "none",
>> -		 (int)ctrl->host_key->len, ctrl->host_key->key);
>> +	host_hash = nvme_dhchap_psk_hash(ctrl->host_key);
>> +	pr_debug("%s: using hash %s key %u\n", __func__,
>> +		 ctrl_hash > 0 ?
>> +		 nvme_auth_hmac_name(ctrl_hash) : "none",
> 
> Use of uninitialized ctrl_hash, should this be host_hash?
> 
Ok, will fix it up.

>> --- a/include/linux/nvme-keyring.h
>> +++ b/include/linux/nvme-keyring.h
>> @@ -18,9 +18,14 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
>>   
>>   key_serial_t nvme_keyring_id(void);
>>   struct key *nvme_tls_key_lookup(key_serial_t key_id);
>> +
>> +struct key *nvme_dhchap_psk_create(struct key *keyring,
>> +		const u8 *data, size_t data_len);
>> +struct key *nvme_dhchap_psk_lookup(struct key *keyring, const char *identity);
>> +u8 nvme_dhchap_psk_hash(struct key *key);
>> +
>>   #else
>>   static inline struct key *nvme_tls_psk_refresh(struct key *keyring,
>> -		const char *hostnqn, char *subnqn, u8 hmac_id,
>>   		u8 *data, size_t data_len, const char *digest)
> 
> This looks like a mistake, it changes the signature of the stub but
> there is no change to the actual implemenataion.
> 
>>   {
>>   	return ERR_PTR(-ENOTSUPP);
>> @@ -38,5 +43,20 @@ static inline struct key *nvme_tls_key_lookup(key_serial_t key_id)
>>   {
>>   	return ERR_PTR(-ENOTSUPP);
>>   }
>> +static inline struct key *nvme_dhchap_psk_refresh(struct key *keyring,
>> +		const char *hostnqn, const char *subnqn,
>> +		u8 *data, size_t data_len)
> 
> This looks like a stub for something that doesn't exist, it's unused code.
> 
>> +{
>> +	return ERR_PTR(-ENOTSUPP);
>> +}
>> +static inline struct key *nvme_dhchap_psk_lookup(struct key *keyring,
>> +		const char *hostnqn, const char *subnqn, u8 hmac);
> 
> This stub function signature does not match the real one.
> 
I'll check (and potentially remove) pointless stubs for the next round.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

