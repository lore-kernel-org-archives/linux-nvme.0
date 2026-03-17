Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FA0FD7099
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 14:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I+ToyIrRYm9Ra4OccFrrdQoIdvwyTPAJBW+slO8Cgcw=; b=N7/d/0ZUb92vtd0vZv33I2M5n+
	mXXfDoNoy84c9uFQooByw8AwYIIl6nHxNzQ8e20BKW5YTByCB1N60tXh3eSbU77aS7+0tE5spnBzo
	oE9q8Q14Z9meu4B2A+8esFUFOs2EQvWaYhNQ5AkVDMM7cI+85iNsqW4n6cwvTtCV8JNYvNYp1CEKq
	aVMkzk4enmPOlDylvdBpFltI2TR359ubqSLKA/WT7dLvLXh74j73t+qIMK21gNzlC1UTvAX7ina0o
	pg/hAXZ2TOdi4jYTCpBqsD0RcBQ1xaCC/nzzqoCOqcwJFbWz26d7IAWJ2u1cNdSRss26h/kUlcXJK
	0D+DTIdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2VpE-00000006fJd-3OEC;
	Tue, 17 Mar 2026 14:55:16 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2VpC-00000006fJF-0zl0
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 14:55:15 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F12884D35B;
	Tue, 17 Mar 2026 14:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773759312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+ToyIrRYm9Ra4OccFrrdQoIdvwyTPAJBW+slO8Cgcw=;
	b=uRN1p+KBsXaxIz4t8iM6Dtlkl8nPeh7YUON4jspMN5186iLJIMa6BViYm8Lgvpe0Uney1a
	psO5VP7oId1e9oGxdUvMOzCbbnZxq3BQWipNB/nd3aXStDBH8gfBUPIeljmWoTjwLi56lf
	jyfusMRxLUGjP3MSzddYjONmsIW6e0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773759312;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+ToyIrRYm9Ra4OccFrrdQoIdvwyTPAJBW+slO8Cgcw=;
	b=qakrOC9rAqKTK0HHDj3ojklya5YmitZoCD14JXFKrvOCvwu7RIvj/HMbS2a31RpnZPrOCD
	lag2nQOwUfXiScBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IrwfKqkJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sS42rrum
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773759311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+ToyIrRYm9Ra4OccFrrdQoIdvwyTPAJBW+slO8Cgcw=;
	b=IrwfKqkJ6wPY96jflcB9+mdFaLZWQnJIXhrnQBPqvJ5r7HQn67SpKdWnIKWad7wlZM20jX
	sq+JC+Kt/PjzQ7WFx0SRvQDEWd1IGYrXcHHWbOUAR70LGR0nqP7lwsy3Q8VQaKONaNwF6n
	tfC9KP0S7QbLROlkw/So+fV90N47qus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773759311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+ToyIrRYm9Ra4OccFrrdQoIdvwyTPAJBW+slO8Cgcw=;
	b=sS42rrumozJZkgRv0LLI0EySgEue42jRbmqYhxsMvT/uCnFSOivI4vtV5g4chfC27+LJ5X
	/iyYoPCug9OTzqDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC0434273B;
	Tue, 17 Mar 2026 14:55:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EHXfME9ruWnRHAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 17 Mar 2026 14:55:11 +0000
Message-ID: <da9b9b09-072e-408c-a00d-70d411da9064@suse.de>
Date: Tue, 17 Mar 2026 15:55:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] nvme-auth: modify nvme_auth_transform_key() to return
 status
To: Maurizio Lombardi <mlombard@arkamax.eu>, Hannes Reinecke
 <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20260317130103.107360-1-hare@kernel.org>
 <20260317130103.107360-2-hare@kernel.org>
 <DH52XYOOWNYQ.1S8KINS05UU0L@arkamax.eu>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <DH52XYOOWNYQ.1S8KINS05UU0L@arkamax.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ASN(0.00)[asn:32098, ipnet:2800::/6, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: F12884D35B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_075514_477073_BFD8C8E1 
X-CRM114-Status: GOOD (  15.69  )
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

On 3/17/26 14:09, Maurizio Lombardi wrote:
> On Tue Mar 17, 2026 at 2:00 PM CET, Hannes Reinecke wrote:
>> In preparation for converting the DH-HMAC-CHAP code to use the
>> kernel keyring modify nvme_auth_transform_key() to return a status
>> and provide the transformed data as argument on the command line as
>> raw data.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> ---
>>   drivers/nvme/common/auth.c | 38 ++++++++++++++++----------------
>>   drivers/nvme/host/auth.c   | 44 ++++++++++++++++++++------------------
>>   drivers/nvme/target/auth.c | 37 ++++++++++++++++++--------------
>>   include/linux/nvme-auth.h  |  4 ++--
>>   4 files changed, 65 insertions(+), 58 deletions(-)
>>
>> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
>> index 2d325fb93083..772af9b6dccd 100644
>> --- a/drivers/nvme/common/auth.c
>> +++ b/drivers/nvme/common/auth.c
>> @@ -317,37 +317,37 @@ static int nvme_auth_hash(u8 hmac_id, const u8 *data, size_t data_len, u8 *out)
>>   	return -EINVAL;
>>   }
>>   
>> -struct nvme_dhchap_key *nvme_auth_transform_key(
>> -		const struct nvme_dhchap_key *key, const char *nqn)
>> +int nvme_auth_transform_key(const struct nvme_dhchap_key *key, const char *nqn,
>> +			    u8 **transformed_secret)
>>   {
>>   	struct nvme_auth_hmac_ctx hmac;
>> -	struct nvme_dhchap_key *transformed_key;
>> -	int ret, key_len;
>> +	u8 *transformed_data;
>> +	u8 *key_data;
>> +	size_t transformed_len;
>> +	int ret;
>>   
>>   	if (!key) {
>>   		pr_warn("No key specified\n");
>> -		return ERR_PTR(-ENOKEY);
>> +		return -ENOKEY;
>>   	}
>>   	if (key->hash == 0) {
>> -		key_len = nvme_auth_key_struct_size(key->len);
>> -		transformed_key = kmemdup(key, key_len, GFP_KERNEL);
>> -		if (!transformed_key)
>> -			return ERR_PTR(-ENOMEM);
>> -		return transformed_key;
>> +		key_data = kzalloc(key->len, GFP_KERNEL);
>> +		memcpy(key_data, key->key, key->len);
> 
> Nit: unchecked kzalloc() return value
> 
Will be removed in patch 3 anyway. No point trying to fix it up.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

