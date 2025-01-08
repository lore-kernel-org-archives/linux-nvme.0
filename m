Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DC6E77199
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2025 15:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l3/3NDyv6ec1+8F9ViBWlIUgPVkv9qvxHNFluLi7xS0=; b=2rL0ntE4LB5DiqnofBWnyDYhiD
	15R8ZgnwSfF3vnBDWl3TBPZ+N0Y9kWyAoE5ha+LyPhhLAGPBc336OJHEtPDhatCww4rpoYPfePkw3
	/2rslOPSBtMWTPxewUoGH4SI6VKBxTGu01M45WLrgNsNSNKN9GjdsofjdYItIMeRuCVNAii87Whej
	u+GZotniyzkeejuceACAi+iTLiyTeRQgm9GeB3Uax5PV6/FhxjaZP/Qe1QlueVGsCi3CsXETC8Nzf
	apm2TOhQPc1wSNyTPz24wz48iUcou9zWaVMpZa/unu5fY3rJaBcLvuBWBWfEfFs25rIl1RZWcuQ6M
	S3KI2cbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVYFt-000000091UW-19LK;
	Wed, 08 Jan 2025 15:46:01 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVYFq-000000091T5-1i6R
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jan 2025 15:45:59 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D8AA21F385;
	Wed,  8 Jan 2025 15:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736351154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3/3NDyv6ec1+8F9ViBWlIUgPVkv9qvxHNFluLi7xS0=;
	b=Y3owQHgeRig3t4LZDwpJshU5dOXI8YZChWNZxsieVFP0V3Ts/6GcqvKCFytOF0z95lJGlc
	1aTLZo5vls3P+5VyOfsDbS+eznQNlGvim/1w8LuD4BZ4qxBIorIpP5CS4pNwz7dCag1Tn6
	lmAoNS2O+zoUgYvr37XaIUeTd4hwofM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736351154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3/3NDyv6ec1+8F9ViBWlIUgPVkv9qvxHNFluLi7xS0=;
	b=c1cXjrZLjPmnKqYKrOU51wpnqAjWNX4TqfCIMTluMaL6BOyAjhMOlBro9dqu0NLCDCIaTI
	L4+IIEmNXx4Xh+Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736351154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3/3NDyv6ec1+8F9ViBWlIUgPVkv9qvxHNFluLi7xS0=;
	b=Y3owQHgeRig3t4LZDwpJshU5dOXI8YZChWNZxsieVFP0V3Ts/6GcqvKCFytOF0z95lJGlc
	1aTLZo5vls3P+5VyOfsDbS+eznQNlGvim/1w8LuD4BZ4qxBIorIpP5CS4pNwz7dCag1Tn6
	lmAoNS2O+zoUgYvr37XaIUeTd4hwofM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736351154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3/3NDyv6ec1+8F9ViBWlIUgPVkv9qvxHNFluLi7xS0=;
	b=c1cXjrZLjPmnKqYKrOU51wpnqAjWNX4TqfCIMTluMaL6BOyAjhMOlBro9dqu0NLCDCIaTI
	L4+IIEmNXx4Xh+Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7655137DA;
	Wed,  8 Jan 2025 15:45:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SEHsL7KdfmfzYwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 08 Jan 2025 15:45:54 +0000
Message-ID: <e3c2d261-c360-4ec4-9423-e5c9ffbd9758@suse.de>
Date: Wed, 8 Jan 2025 16:45:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Remove namespace when nvme_identify_ns_descs()
 failed
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20241129140608.115282-1-hare@kernel.org>
 <f6229339-5b1f-47d5-8eb1-d11ed2fc2281@grimberg.me>
 <bb69b9b9-ad56-4c83-a848-a4b171896097@suse.de>
 <9cdb72d6-291f-46a1-8c80-45ceb75e2b8b@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <9cdb72d6-291f-46a1-8c80-45ceb75e2b8b@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_074558_622506_60DC1E0C 
X-CRM114-Status: GOOD (  14.50  )
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

On 1/8/25 11:49, Sagi Grimberg wrote:
> 
> 
> 
> On 07/01/2025 10:11, Hannes Reinecke wrote:
>> On 12/25/24 10:58, Sagi Grimberg wrote:
>>>
>>>
>>>
>>> On 29/11/2024 16:06, Hannes Reinecke wrote:
>>>> When a namespace gets unmapped on the target during scanning
>>>> nvme_identify_ns_descs() returns with a non-retryable error.
>>>> With the currrent code we will ignore that error on the grounds
>>>> that we failed to get information, and hence cannot make any
>>>> decisions whether to keep or remove that namespace.
>>>> But a non-retryable error implies that the namespace is _not_
>>>> present as we cannot retry that command and will never get
>>>> information about that namespace.
>>>> And we need to remove the namespace during scanning, as otherwise
>>>> the AEN informing us about a namespace change will find the NSID
>>>> present, but nvme_validate_ns() will fail, and the namespace
>>>> will never be updated with the correct information.
>>>
>>> Isn't that a bit harsh?
>>> I would expect to see a specific status line NVME_SC_INVALID_NS or 
>>> equivalent for a full removal of the namespace?
>>
>> Does it matter? If we get a DNR status back from 
>> nvme_identify_ns_descs() we _cannot_ resend that command.
>> Meaning we cannot get the namespace descriptors. As we
>> rely on these descriptors to properly map the namespace
>> we cannot correctly work with it, and we're better off
>> to pretend the namespace is gone and wait for an AEN
>> indicating that the namespace (or controller) state has changed.
> 
> I think it does matter. I don't think we should be removing the NS without
> the controller telling us that it is actually removed.

But what would be the recovery action here?
If the 'identify ns descs' command cannot be retried, how are
we going to map the namespace to an ns_head?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

