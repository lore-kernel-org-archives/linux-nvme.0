Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEFFC67861
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 05:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fJsWqnh7FZwi0SShK3cqcu0XDyBl5t0Pq7sJvA54AEU=; b=dR+B4aHY79SX8llnpKYdk5h8LV
	zJfkV9GbbmMlLzFtWz3qXZjmlgU+1uUVarp09Ksv4di/Ny78tui6NDVCkcNtHd1ld/NXeJUXI2wt3
	FNJWxUYyTUr4fmTok6u9FfPJzIfJKeUQGNNpPmlJiJ8N/7T8qOgpsI/f3+9PJWEKfz/qlvxO6tAiM
	umy1q8yZUCAOMyv9GjM6mdC186Ec3CWR9rveclMUpyiDAebuzqlrZSNAfmABMVkGQ86ZV29EyIDol
	aRUeBBUwROQz7R3cScEQ3LELodaKGZTNhrHTSlMcW2OsgnJHIuElu6YZ6tYGejxWf+96K7/o+LvWD
	xRWuXcNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rthPF-0000000ENge-22DP;
	Mon, 08 Apr 2024 05:18:57 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rthP8-0000000ENfV-2ija
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 05:18:56 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ACB2521DA9;
	Mon,  8 Apr 2024 05:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712553525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJsWqnh7FZwi0SShK3cqcu0XDyBl5t0Pq7sJvA54AEU=;
	b=VksxRZAzPrwuG7xluNa+1MkUkNXFVrU8ZvrEM1Vvw4AGr7qiP27yKq8vh5ne5HkqVBgmvE
	CnsWW8SXvDLdtSAYDkDnZDJYiRedDGKO8SghWUe4lXW2S8SPj3gEpu4cIke2SQaAfUWU0h
	9VqpM8fiN2D1CHeI6gDfuSnq+jqfJkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712553525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJsWqnh7FZwi0SShK3cqcu0XDyBl5t0Pq7sJvA54AEU=;
	b=QQxCf0Q6QWThLMjX4vLRq/7EOO14jKDMEr1RDfsh1kOawhCtQCoIZTQfQUSLM8L1pAEK+o
	EciVuIdoZ7m4nIDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712553525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJsWqnh7FZwi0SShK3cqcu0XDyBl5t0Pq7sJvA54AEU=;
	b=VksxRZAzPrwuG7xluNa+1MkUkNXFVrU8ZvrEM1Vvw4AGr7qiP27yKq8vh5ne5HkqVBgmvE
	CnsWW8SXvDLdtSAYDkDnZDJYiRedDGKO8SghWUe4lXW2S8SPj3gEpu4cIke2SQaAfUWU0h
	9VqpM8fiN2D1CHeI6gDfuSnq+jqfJkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712553525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJsWqnh7FZwi0SShK3cqcu0XDyBl5t0Pq7sJvA54AEU=;
	b=QQxCf0Q6QWThLMjX4vLRq/7EOO14jKDMEr1RDfsh1kOawhCtQCoIZTQfQUSLM8L1pAEK+o
	EciVuIdoZ7m4nIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7539613675;
	Mon,  8 Apr 2024 05:18:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qbKqGjV+E2Y8OAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 08 Apr 2024 05:18:45 +0000
Message-ID: <f2377c04-3f8c-42d9-82f7-9b862b203779@suse.de>
Date: Mon, 8 Apr 2024 07:18:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] nvme-tcp: check for invalidated or revoked key
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-3-hare@kernel.org>
 <7de989ae-6088-438d-af71-50688f18cba6@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <7de989ae-6088-438d-af71-50688f18cba6@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_221850_866879_657A4AC5 
X-CRM114-Status: GOOD (  16.20  )
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

On 4/7/24 22:51, Sagi Grimberg wrote:
> 
> 
> On 18/03/2024 17:03, Hannes Reinecke wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> key_lookup() will always return a key, even if that key is revoked
>> or invalidated. So check for invalid keys before continuing.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/host/fabrics.c | 7 ++++++-
>>   drivers/nvme/host/sysfs.c   | 9 +++++++--
>>   drivers/nvme/host/tcp.c     | 8 +++++++-
>>   3 files changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index 0141c0a6942f..75aa69457353 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -639,7 +639,12 @@ static struct key *nvmf_parse_key(int key_id)
>>       key = key_lookup(key_id);
>>       if (IS_ERR(key))
>>           pr_err("key id %08x not found\n", key_id);
>> -    else
>> +    else if (test_bit(KEY_FLAG_REVOKED, &key->flags) ||
>> +         test_bit(KEY_FLAG_INVALIDATED, &key->flags)) {
>> +        pr_err("key id %08x invalid\n", key_id);
>> +        key_put(key);
>> +        key = ERR_PTR(-EKEYREVOKED);
>> +    } else
>>           pr_debug("Using key id %08x\n", key_id);
>>       return key;
> 
> Looks like it will be useful to have a nvme_key_lookup() that
> prints an error and returns a semantic error for revoked/invalidated key
> and would be used in the call-sites ?

Good idea. Will be updating the patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


