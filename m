Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168F2C67861
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 05:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ib77SABWp9gcvOTKhbgYnyJbV6rLTQni1GW0x9wQ2hE=; b=w+bEWdOBnSBexpuzKfF6Wn+H5y
	nvnL75OrBXiUdLm7hMXNCRpQ9vFoXVC57OHtFVb06qMaO682aHjBUYj1X5guUpj92fKNCSZiRG44/
	j5kHA77WuWCECyPlejSNU9NqDGTbKZCmcRwA2y4c402FFFTREW66LUh6L32gpy7nqEHpIMDQ6xgxL
	0b4q4c8Kld2sCxO5O5zBOIWyt8xKdelwy+JnZMJP/bS3nkGarbHxwXHEiejNbMSMmF/5S0PmOk+8g
	xPJmuePzMpUoPeYN4ikKg8VV8tyWoZTSDXdDKQyPaLL6ph1N1V64oteQqxzECrwRs/Q6ZIygqsEnV
	LkN1zLyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rthQj-0000000ENps-1Qj6;
	Mon, 08 Apr 2024 05:20:29 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rthQa-0000000ENo2-353X
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 05:20:27 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BFD5022005;
	Mon,  8 Apr 2024 05:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712553619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ib77SABWp9gcvOTKhbgYnyJbV6rLTQni1GW0x9wQ2hE=;
	b=pM0zXG2k/DQgii547LrAqPYbIQseJ9IprcoVYEB2l5DAObXZgtB7tp+obPDlLMm2Ah2azc
	z0Asi0R0bV/+fquHRjbaJFHoENawYs/tJdRF4OFuWYUYwkSC3fvhAP5uiCZXn69/MozgKp
	gnWQayAfkVY0Vj05SCjmuFuWPLv2TRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712553619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ib77SABWp9gcvOTKhbgYnyJbV6rLTQni1GW0x9wQ2hE=;
	b=m61RGyNBsow9D4JBZHK114X/CS6KGxPAkAt1N+4dMt1aFGDKZ0p0ucxfBTcvi7Wg/axbyw
	NxVvCpOzJHOelLAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DeIImdoX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LWTMs7pL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712553618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ib77SABWp9gcvOTKhbgYnyJbV6rLTQni1GW0x9wQ2hE=;
	b=DeIImdoXRcQBceCiZ4SvBmnb8ogfSOlvk+2/lmBmzUlhjm0Shf4nWYu0bPA/vssM6FzdPn
	Mlu9x1/KOatiNrTo7Hn7X5zUJjE8frS4mC9l1pjXb74I1S6dNGr7ImoEXLSmeg1tpgbLht
	q1FQwxzER8pNylp0N1krKWzzhYVwpJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712553618;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ib77SABWp9gcvOTKhbgYnyJbV6rLTQni1GW0x9wQ2hE=;
	b=LWTMs7pLzNag/0iAKLsSLjXtB67dB4q3lss4DRMUATZP6qMKB0OTQJjUBZ6Mm3wnoyYb71
	hxED83wjUiMF+DAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67FE113675;
	Mon,  8 Apr 2024 05:20:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SBT0DpJ+E2Y8OAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 08 Apr 2024 05:20:18 +0000
Message-ID: <4e879022-05a0-4e1f-8bd8-e7954871adf3@suse.de>
Date: Mon, 8 Apr 2024 07:20:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] nvme: add nvme_auth_generate_psk()
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-5-hare@kernel.org>
 <b786734b-c182-4cff-b4ba-3428d500de26@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <b786734b-c182-4cff-b4ba-3428d500de26@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BFD5022005
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_222021_047861_C0138BD6 
X-CRM114-Status: GOOD (  12.94  )
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

On 4/7/24 22:59, Sagi Grimberg wrote:
> 
> 
> On 18/03/2024 17:03, Hannes Reinecke wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> Add a function to generate a NVMe PSK from the shared credentials
>> negotiated by DH-HMAC-CHAP.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   drivers/nvme/common/auth.c | 76 ++++++++++++++++++++++++++++++++++++++
>>   include/linux/nvme-auth.h  |  2 +
>>   2 files changed, 78 insertions(+)
>>
>> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
>> index a3455f1d67fa..7a4b6589351d 100644
>> --- a/drivers/nvme/common/auth.c
>> +++ b/drivers/nvme/common/auth.c
>> @@ -11,6 +11,7 @@
>>   #include <asm/unaligned.h>
>>   #include <crypto/hash.h>
>>   #include <crypto/dh.h>
>> +#include <crypto/hkdf.h>
>>   #include <linux/nvme.h>
>>   #include <linux/nvme-auth.h>
>> @@ -471,5 +472,80 @@ int nvme_auth_generate_key(u8 *secret, struct 
>> nvme_dhchap_key **ret_key)
>>   }
>>   EXPORT_SYMBOL_GPL(nvme_auth_generate_key);
>> +u8 *nvme_auth_generate_psk(u8 hmac_id, u8 *skey, size_t skey_len,
>> +               u8 *c1, u8 *c2, size_t hash_len, size_t *ret_len)
> 
> It seems it would be simpler to have this psk and psk_len as out params and
> return a normal status instead?
> 
Tried to shorten the number of arguments; it's long enough already.
But sure, can do.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


