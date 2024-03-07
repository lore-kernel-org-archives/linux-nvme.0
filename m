Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA13C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 14:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B4ZTqC6WD3Q3AwEZtThtNYvg53FvryjST/5G6eVjvtE=; b=WfR7+Z/His6KefuZPRenzRkPR1
	GINcIKJlL3FTxCYlPqZhseGeRuJMEiSWGDPYJPtvJT4EEMg2fXAorgEThwZ78MB3dpgl93p6B0tEW
	uXdyUW6D4lqAPd/khfnxuDZBRFphOrXXnAWgtO7mZlUo68tcluY+3fUeQRXOmkTcQpPnysOR6Ino4
	tfW4BbbfF1KBzBcVWyqjGAS/l38TkbrfoufpPq2W3De5r7BtqgD+UfKhcpPQCMH+UPc3m6mKE3rWb
	7zmDpkfn3mNZO9bgbAJPDNqupxLsXXQifVZCNPafzujdhKNP0XrgQRfCk2vY8zjEDWFuoLrFh9tcM
	39mRyboQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riETe-00000004z20-2KzS;
	Thu, 07 Mar 2024 14:12:06 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riETY-00000004yyC-2iKx
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 14:12:05 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0949B37854;
	Thu,  7 Mar 2024 12:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709813631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B4ZTqC6WD3Q3AwEZtThtNYvg53FvryjST/5G6eVjvtE=;
	b=LpWjY+loZcby/iAeVgTWWZB7uCoqrZ/D8fdRZXiX3esX7QrPIM1jWxw04tqOePOczml8bk
	0VCp9JedLUM9rDSs+BUzTni1zo8I9LfNqLycqTAmrqh3kVAVH5XcRefhlQoq7qsSDZFby3
	aJVOPH+N46/0oJqKYsFggPBHZpKm/Wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709813631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B4ZTqC6WD3Q3AwEZtThtNYvg53FvryjST/5G6eVjvtE=;
	b=BwHIE/Q/9ZXMHe5f4CHsx20fd6PqoQ+XX0FSU9/2LsnWXNfntugwOE9WYzLbtbO2baj8kY
	uoqjFXCXYvkUlTDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709813631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B4ZTqC6WD3Q3AwEZtThtNYvg53FvryjST/5G6eVjvtE=;
	b=LpWjY+loZcby/iAeVgTWWZB7uCoqrZ/D8fdRZXiX3esX7QrPIM1jWxw04tqOePOczml8bk
	0VCp9JedLUM9rDSs+BUzTni1zo8I9LfNqLycqTAmrqh3kVAVH5XcRefhlQoq7qsSDZFby3
	aJVOPH+N46/0oJqKYsFggPBHZpKm/Wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709813631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B4ZTqC6WD3Q3AwEZtThtNYvg53FvryjST/5G6eVjvtE=;
	b=BwHIE/Q/9ZXMHe5f4CHsx20fd6PqoQ+XX0FSU9/2LsnWXNfntugwOE9WYzLbtbO2baj8kY
	uoqjFXCXYvkUlTDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D868B12FC5;
	Thu,  7 Mar 2024 12:13:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uKa9M36v6WVEQwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 07 Mar 2024 12:13:50 +0000
Message-ID: <3fffc9c8-0b40-4da0-b424-d18affdbcba8@suse.de>
Date: Thu, 7 Mar 2024 13:13:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] nvme-keyring: restrict match length for version '1'
 identifiers
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, hare@kernel.org,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240127093058.15699-1-hare@kernel.org>
 <20240127093058.15699-7-hare@kernel.org>
 <f43dc8c9-3377-40c2-a384-906fe893c80c@grimberg.me>
 <9a5c9df9-162f-4941-82e7-a82979e338ef@suse.de>
 <6273f295-9857-495e-bcde-b76627da8d35@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <6273f295-9857-495e-bcde-b76627da8d35@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LpWjY+lo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="BwHIE/Q/"
X-Spamd-Result: default: False [-5.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 0949B37854
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_061201_012795_E287D86F 
X-CRM114-Status: GOOD (  14.14  )
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

On 3/7/24 13:08, Sagi Grimberg wrote:
> 
> 
> On 07/03/2024 13:35, Hannes Reinecke wrote:
>> On 3/7/24 11:49, Sagi Grimberg wrote:
>>>
>>>
>>> On 27/01/2024 11:30, hare@kernel.org wrote:
>>>> From: Hannes Reinecke <hare@suse.de>
>>>>
>>>> TP8018 changed the TLS PSK identifiers to append a PSK hash value,
>>>> so to lookup any version '1' identifiers we need to restrict the
>>>> match length to exclude the PSK hash value (which we don't have
>>>> when looking up keys).
>>>>
>>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>>> ---
>>>>   drivers/nvme/common/keyring.c | 21 +++++++++++++++++++++
>>>>   1 file changed, 21 insertions(+)
>>>>
>>>> diff --git a/drivers/nvme/common/keyring.c 
>>>> b/drivers/nvme/common/keyring.c
>>>> index c16f9496643f..51b99b34e100 100644
>>>> --- a/drivers/nvme/common/keyring.c
>>>> +++ b/drivers/nvme/common/keyring.c
>>>> @@ -44,6 +44,27 @@ static bool nvme_tls_psk_match(const struct key 
>>>> *key,
>>>>           return false;
>>>>       }
>>>>       match_id = match_data->raw_data;
>>>> +    if (memcmp(match_id, "NVMe1", 5)) {
>>>> +        char *e = (char *)match_id;
>>>> +        size_t offset = 0;
>>>> +        int n = 0;
>>>> +
>>>> +        while (*e != ' ' && offset < match_len) {
>>>> +            if (*e == ' ') {
>>>> +                n++;
>>>> +                if (n == 3)
>>>> +                    break;
>>>> +            }
>>>> +            e++;
>>>> +            offset++;
>>>> +        }
>>>> +        if (n != 3) {
>>>> +            pr_debug("%s: error parsing '%s'\n",
>>>> +                 __func__, match_id);
>>>> +            return false;
>>>> +        }
>>>> +        match_len = offset;
>>>> +    }
>>>
>>> My eyes hurt... I am failing to understand what this even does...
>>>
>>> You have a concrete example?
>>
>> Yeah, it's ugly. What I'm trying to do here is to lookup TLS PSK 
>> identities which are either in the original format:
>>
>> NVMe0[RG]0[12] <hostnqn> <subsysnqn>
>>
>> _or_ the TP8018 TLS PSK format:
>>
>> NVMe1[RG]0[12] <hostnqn> <subsysnqn> <digest>
>>
>> given that I only have <hostnqn> and <subsysnqn> as lookup keys.
>> So for the memcmp() I'll have to exclude the ' <digest>' bit, which
>> happens to the after the third blank space in the identity.
>> I'll have a slightly better version queued, but parsing remains ugly.
> 
> Shouldn't strtok/strsep simplify what you are trying to do here?

Yeah. I'll be reworking that.

Cheers,

Hannes


