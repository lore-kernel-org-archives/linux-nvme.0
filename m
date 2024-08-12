Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE021C52D7C
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Aug 2024 06:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KHVn3EFWOqsEeSrH5sPn/wIAL/chehAMidqiSzpMfNw=; b=apM3tAP6uTa7CTo5xUJwZofqby
	3RmOxnTQWOuEwei4gD7vicsfXrkTE3lgrTBSTIJ2rRO1uyOR/gmCRM4LMbioucKdou4O3lMCTirN8
	27e+7Vs2aA1Clg0AFXpNu4s0RHyOK5znJgnPBS2KVB+CsjE7T+MtxWKBBB10Dv5ostdMru7OkqFKi
	FgZXBOJYp9u1//6UA10miyeFBvc0nQg127D9IkEjbiNyqY7A7Cwo8yrT+eiTUh9o6gcklY1EEd6x8
	NhjDGrSsC/KddTe8UfhknojwCkjzbXEDsoSUE5IU4YOGiExPDhtEM6lWhRnfwG5NJxH3vbrYqQGIH
	Y78TkSug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdOUn-0000000H05S-2ZAh;
	Mon, 12 Aug 2024 06:25:33 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdOUi-0000000H04T-2Ix3
	for linux-nvme@lists.infradead.org;
	Mon, 12 Aug 2024 06:25:31 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2CFCA224A9;
	Mon, 12 Aug 2024 06:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723443925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHVn3EFWOqsEeSrH5sPn/wIAL/chehAMidqiSzpMfNw=;
	b=oT5PwCnAgQ0XkH+rAyRlQpJSB9SBXV7ir9oBVpJLEQKoMYdfJ+pbXqC9TPXkYUP1vz+cyE
	poUCRCp2hkYOxga0m14U3cvFram2jBesXubp9CnRGTkKwXjIOicAhzmTYTqJ0Omo+36erQ
	5LhAbM3DuMfJ8KA09GN+tEOKE4fK1HY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723443925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHVn3EFWOqsEeSrH5sPn/wIAL/chehAMidqiSzpMfNw=;
	b=S9XrDGdSpZfIJKn/hjMWd/7FsGgEidqFIy3WqgvhZXbFudBtBcfVypEHROHkL1sN0I9esO
	49tY5IIeNiYHPsAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oT5PwCnA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=S9XrDGdS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723443925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHVn3EFWOqsEeSrH5sPn/wIAL/chehAMidqiSzpMfNw=;
	b=oT5PwCnAgQ0XkH+rAyRlQpJSB9SBXV7ir9oBVpJLEQKoMYdfJ+pbXqC9TPXkYUP1vz+cyE
	poUCRCp2hkYOxga0m14U3cvFram2jBesXubp9CnRGTkKwXjIOicAhzmTYTqJ0Omo+36erQ
	5LhAbM3DuMfJ8KA09GN+tEOKE4fK1HY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723443925;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHVn3EFWOqsEeSrH5sPn/wIAL/chehAMidqiSzpMfNw=;
	b=S9XrDGdSpZfIJKn/hjMWd/7FsGgEidqFIy3WqgvhZXbFudBtBcfVypEHROHkL1sN0I9esO
	49tY5IIeNiYHPsAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB4AF13A23;
	Mon, 12 Aug 2024 06:25:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ybeJN9SquWbheAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 12 Aug 2024 06:25:24 +0000
Message-ID: <659e9317-9f68-4264-b976-f8f13184c4da@suse.de>
Date: Mon, 12 Aug 2024 08:25:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] nvme-tcp: check for invalidated or revoked key
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20240722120226.88737-1-hare@kernel.org>
 <20240722120226.88737-4-hare@kernel.org> <ZqeqqK3XBk_eoyZb@kbusch-mbp>
 <9192ada0-0be6-4fad-8d2d-a26bebe934be@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <9192ada0-0be6-4fad-8d2d-a26bebe934be@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.50 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2CFCA224A9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240811_232528_760983_A5BA777F 
X-CRM114-Status: GOOD (  11.48  )
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

On 7/31/24 11:45, Sagi Grimberg wrote:
> 
>>>   static void nvme_tls_psk_describe(const struct key *key, struct 
>>> seq_file *m)
>>>   {
>>>       seq_puts(m, key->description);
>>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>>> index f5f545fa0103..432efcbf9e2f 100644
>>> --- a/drivers/nvme/host/fabrics.c
>>> +++ b/drivers/nvme/host/fabrics.c
>>> @@ -665,7 +665,7 @@ static struct key *nvmf_parse_key(int key_id)
>>>           return ERR_PTR(-EINVAL);
>>>       }
>>> -    key = key_lookup(key_id);
>>> +    key = nvme_tls_key_lookup(key_id);
>> We've had some fallout before with nvme modules vs built-in, so I test
>> for this now. Here's the relevant parts of my config:
>>
>> CONFIG_NVME_KEYRING=m
>> ...
>> CONFIG_NVME_FABRICS=y
>> ...
>> CONFIG_NVME_TCP=m
>>
>> And that gets this error:
>>
>> vmlinux.o: in function `nvmf_parse_key':
>> /home/kbusch/src/linux/drivers/nvme/host/fabrics.c:668: undefined 
>> reference to `nvme_tls_key_lookup'
> 
> Hannes, can you take look.
> 
Just back from vacation, but yeah, I'll take a look.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


