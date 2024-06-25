Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54100C2BBCA
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jun 2024 06:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7oyM2OL3tPiEejcSLTM9P/Kg1MevNn1NW7/UKmBX1rY=; b=KZMOk6v/O/I3PEvbHrgH8xq0g6
	CgA8SpNFr41Q60RBa6YPMPJibNvlG6ZqfcaiWgkBQqRJ5cDKE5EjbFCp1Ux4ir3uLUobila/TS7lc
	y+PVsVY8HnWWG+hzH0pm/Ek+f/18s7XpNPFwBusNoEkjrh84IpHbqxqfPCbqbfSsZcLe1odzkdU/0
	NPKoA+DsHo8aXETbkpsFt++oRARW/YxJE39Bfp+/icvZV2pzSMmmV18o381fydkA3Fc7aQfoiQDA4
	cBw6IgOS2w17ce74ZWZtPCYOB2a+N5oMyrmWPeSLIDsksvy2KyWXWkp9WXAezTXIGfnXSG0LAJHf4
	F0xQD9jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLzIz-00000001kyM-1AlL;
	Tue, 25 Jun 2024 06:05:25 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLzIt-00000001kwu-3ZeJ
	for linux-nvme@lists.infradead.org;
	Tue, 25 Jun 2024 06:05:23 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 68C71219BB;
	Tue, 25 Jun 2024 06:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719295516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7oyM2OL3tPiEejcSLTM9P/Kg1MevNn1NW7/UKmBX1rY=;
	b=DMWFOiu8NOw3drSLLFju4ljKaSLyZNPNBCLTbqCeaTcC1O9qPNroZcp8u7qBJOLWMU3qXe
	y5ble/GpN/i2xEnNoBCX8Wd4OQbSu1DZXraKUrrRThKMW5I5W9ASJ5ziEfmJap27D37vCQ
	d1yf8YsX/6kKDDwQ+L9S5/Gs8Hm8c+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719295516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7oyM2OL3tPiEejcSLTM9P/Kg1MevNn1NW7/UKmBX1rY=;
	b=HczRoWEQdkcGPVaJx5LfIPY8O1f6l/PnTokSl/SmpNl7nfLdMazNjN9IxAvOMQBPiBxqBo
	ZNjck9HvBC776EBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719295516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7oyM2OL3tPiEejcSLTM9P/Kg1MevNn1NW7/UKmBX1rY=;
	b=DMWFOiu8NOw3drSLLFju4ljKaSLyZNPNBCLTbqCeaTcC1O9qPNroZcp8u7qBJOLWMU3qXe
	y5ble/GpN/i2xEnNoBCX8Wd4OQbSu1DZXraKUrrRThKMW5I5W9ASJ5ziEfmJap27D37vCQ
	d1yf8YsX/6kKDDwQ+L9S5/Gs8Hm8c+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719295516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7oyM2OL3tPiEejcSLTM9P/Kg1MevNn1NW7/UKmBX1rY=;
	b=HczRoWEQdkcGPVaJx5LfIPY8O1f6l/PnTokSl/SmpNl7nfLdMazNjN9IxAvOMQBPiBxqBo
	ZNjck9HvBC776EBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20A6D13A9A;
	Tue, 25 Jun 2024 06:05:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7wpIBRxeemYGBwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 25 Jun 2024 06:05:16 +0000
Message-ID: <bf241d6c-3123-4047-b393-32eb46f692fe@suse.de>
Date: Tue, 25 Jun 2024 08:05:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-tcp: align I/O cpu with blk-mq mapping
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240619145553.89736-1-hare@kernel.org>
 <20240619145958.GA2254@lst.de> <d5c87821-54a7-4fb4-9222-501174d6058b@suse.de>
 <f1348234-1dcb-4ac2-a0d4-305c39643a48@grimberg.me>
 <eb0023bc-3a3b-4f31-955b-c6aad4cad4a3@suse.de>
 <b4dc2a6a-1663-4144-a607-edb6beef48c0@grimberg.me>
 <f67d4572-f625-48eb-a8e3-3e7a5527d9c6@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <f67d4572-f625-48eb-a8e3-3e7a5527d9c6@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_230520_075649_E37F8AE9 
X-CRM114-Status: GOOD (  12.20  )
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

On 6/24/24 12:02, Sagi Grimberg wrote:
> 
> 
> On 19/06/2024 18:58, Sagi Grimberg wrote:
>>
>>
>>>> I see how you address multiple controllers falling into the same 
>>>> mappings case in your patch.
>>>> You could have selected a different mq_map entry for each controller 
>>>> (out of the entries that map to the qid).
>>>>
>>> Looked at it, but hadn't any idea how to figure out the load.
>>> The load is actually per-cpu, but we only have per controller 
>>> structures.
>>> So we would need to introduce a per-cpu counter, detailing out the
>>> number of queues scheduled on that CPU.
>>> But that won't help with the CPU oversubscription issue; we still 
>>> might have substantially higher number of overall queues than we have 
>>> CPUs...
>>
>> I think that it would still be better than what you have right now:
>>
>> IIUC Right now you will have for all controllers (based on your example):
>> queue 1: using cpu 6
>> queue 2: using cpu 9
>> queue 3: using cpu 18
>>
>> But selecting a different mq_map entry can give:
>> ctrl1:
>> queue 1: using cpu 6
>> queue 2: using cpu 9
>> queue 3: using cpu 18
>>
>> ctrl2:
>> queue 1: using cpu 7
>> queue 2: using cpu 10
>> queue 3: using cpu 19
>>
>> ctrl3:
>> queue 1: using cpu 8
>> queue 2: using cpu 11
>> queue 3: using cpu 20
>>
>> ctrl4:
>> queue 1: using cpu 54
>> queue 2: using cpu 57
>> queue 3: using cpu 66
>>
>> and so on...
> 
> Hey Hannes,
> 
> Did you make progress with this one?

Yeah, just trying to get some performance numbers.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


