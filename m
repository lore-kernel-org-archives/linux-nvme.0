Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B4BC4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Apr 2024 11:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fb0pioxCxmV+uJNv+LJTcMUzH8FhmUpvLxhRAAeHBls=; b=HZChDhz+m5OdnaPNbTAYOy7TYb
	YQTSVTOGDJMSicET+v7Tkd3P+vYVInhbEDWUBNWiOLY5wMiq4LwO5NDvaBwAMAt5eaVIuobtmyLA0
	kWjMvu85TpmfGORfGr86HjR+adUGkDnFm8e/oTf0Jfr1L7APZzZCI0ZTwlmcWGDe9SiCj5G1xmTmr
	y6SsWAPIrzJxbkdgGJQYx8wgcDsjSlPxgFSC0nVzG4/pJ1JFm5o4c0jIcWVcesOx4wpvubgoS5Z+u
	1XPSY3ENsxLj6tArKHzhTGXqBrdMLl7o3PU39sWaMKYMhecCwZIXWtfnIzaKNwpONvyNK7OCOi1W8
	f2tgSTxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxPVW-00000001ui0-18dL;
	Thu, 18 Apr 2024 11:00:46 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxPVQ-00000001ug0-2XPA
	for linux-nvme@lists.infradead.org;
	Thu, 18 Apr 2024 11:00:44 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C667C5C8F6;
	Thu, 18 Apr 2024 11:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713438037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fb0pioxCxmV+uJNv+LJTcMUzH8FhmUpvLxhRAAeHBls=;
	b=z3C9FV3GiqCwaoKIACY9fYMnrXKSaoU1BtRUa/K5kybbIV7vUlrtZlNb7MbCQkMLY9IWbQ
	yq3p0T9C+ixnh5hm+BcwA6gUsiJEjwErDACfFA01r/mZj2W+Dny2moA2soGI00HMAb4DAs
	q1QFUMcavZg1SMszQCRposZFsBxvy+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713438037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fb0pioxCxmV+uJNv+LJTcMUzH8FhmUpvLxhRAAeHBls=;
	b=+5Q5Bb4nDG+i6XeZco4bHtULs4scdaLFohnmvptYsZ/niDZ0dY/Dm4hVLkGEcm8SRFGG2H
	eBV8U/mYEjWSIxAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=z3C9FV3G;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+5Q5Bb4n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713438037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fb0pioxCxmV+uJNv+LJTcMUzH8FhmUpvLxhRAAeHBls=;
	b=z3C9FV3GiqCwaoKIACY9fYMnrXKSaoU1BtRUa/K5kybbIV7vUlrtZlNb7MbCQkMLY9IWbQ
	yq3p0T9C+ixnh5hm+BcwA6gUsiJEjwErDACfFA01r/mZj2W+Dny2moA2soGI00HMAb4DAs
	q1QFUMcavZg1SMszQCRposZFsBxvy+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713438037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fb0pioxCxmV+uJNv+LJTcMUzH8FhmUpvLxhRAAeHBls=;
	b=+5Q5Bb4nDG+i6XeZco4bHtULs4scdaLFohnmvptYsZ/niDZ0dY/Dm4hVLkGEcm8SRFGG2H
	eBV8U/mYEjWSIxAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B217B1384C;
	Thu, 18 Apr 2024 11:00:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8NPCKlX9IGbNWQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 18 Apr 2024 11:00:37 +0000
Message-ID: <ddc51b8a-0ea7-4c95-b6c1-911d1039d0ad@suse.de>
Date: Thu, 18 Apr 2024 13:00:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/17] nvme: add nvme_auth_derive_tls_psk()
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-7-hare@kernel.org>
 <c0c4beac-2680-411f-bd1d-45db6d1c3792@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <c0c4beac-2680-411f-bd1d-45db6d1c3792@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C667C5C8F6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240418_040040_924721_B7D29463 
X-CRM114-Status: GOOD (  15.62  )
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

On 4/7/24 23:04, Sagi Grimberg wrote:
> 
> 
> On 18/03/2024 17:03, Hannes Reinecke wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> Add a function to derive the TLS PSK as specified TP8018.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/common/auth.c | 71 ++++++++++++++++++++++++++++++++++++++
>>   include/linux/nvme-auth.h  |  1 +
>>   2 files changed, 72 insertions(+)
>>
>> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
>> index f56f08a4461e..90d525afc240 100644
>> --- a/drivers/nvme/common/auth.c
>> +++ b/drivers/nvme/common/auth.c
>> @@ -652,5 +652,76 @@ u8 *nvme_auth_generate_digest(u8 hmac_id, u8 
>> *psk, size_t psk_len,
>>   }
>>   EXPORT_SYMBOL_GPL(nvme_auth_generate_digest);
>> +u8 *nvme_auth_derive_tls_psk(int hmac_id, u8 *psk, size_t psk_len, u8 
>> *psk_digest)
>> +{
> 
> Same comment here.
> Can you please add a description of the derivation process in a function 
> comment?
> It is not trivial for me to follow.
> 
Sure, will do.

>> +    struct crypto_shash *hmac_tfm;
>> +    const char *hmac_name;
>> +    const char *psk_prefix = "tls13 nvme-tls-psk";
>> +    size_t info_len, prk_len;
>> +    char *info;
>> +    unsigned char *prk, *tls_key;
>> +    int ret;
>> +
>> +    hmac_name = nvme_auth_hmac_name(hmac_id);
>> +    if (!hmac_name) {
>> +        pr_warn("%s: invalid hash algoritm %d\n",
>> +            __func__, hmac_id);
>> +        return ERR_PTR(-EINVAL);
>> +    }
>> +    if (hmac_id == NVME_AUTH_HASH_SHA512) {
>> +        pr_warn("%s: unsupported hash algorithm %s\n",
>> +            __func__, hmac_name);
>> +        return ERR_PTR(-EINVAL);
>> +    }
>> +
>> +    hmac_tfm = crypto_alloc_shash(hmac_name, 0, 0);
>> +    if (IS_ERR(hmac_tfm))
>> +        return (u8 *)hmac_tfm;
>> +
>> +    prk_len = crypto_shash_digestsize(hmac_tfm);
>> +    prk = kzalloc(prk_len, GFP_KERNEL);
> 
> What does prk stand for?
> 
That's from the spec. It'll be referred to in the function
description.

Cheers,

Hannes


