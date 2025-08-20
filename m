Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2FDCA0EF8
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Aug 2025 09:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ur6UPwHXhkqU1fS0bJm+yP8QnyRvGGnkp6ULmb2T2Es=; b=VRqLl/WYdxxjSWONH7WavYhKOd
	xuSIBHPDpOETQJVFNEU+qeIC5KJZBUMRX1eluVBie/NRSIzNKCVEqsdbIRTFkAiZygYpuAGgNd65Q
	2Om8ES28olF0R3h9rZG6PStZhMwsRItgwhgU6XrqF/N/5RgmZTIlQ0+9kRVUD1qmjMqoTg6G/BDfO
	08zFS9P08RZZ306n915MuRXMDqmAzJVrr6v3DDJQvrhu1f7L57yh2a1RU4FMJ+PyJx54E79ZUx2o4
	PSbmUzxMU8onqsYTg10vx3JOd9RysZ2KFX/FT+9S6KZdxgLH9ZlU5bvIm/Ca1qFP84cxUE13HQroP
	SKyrLZSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoepv-0000000CrA4-0vIT;
	Wed, 20 Aug 2025 09:10:27 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoe58-0000000Cii1-0arN
	for linux-nvme@lists.infradead.org;
	Wed, 20 Aug 2025 08:22:07 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 920D71F391;
	Wed, 20 Aug 2025 08:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755678124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ur6UPwHXhkqU1fS0bJm+yP8QnyRvGGnkp6ULmb2T2Es=;
	b=Ajxh9r7rn4MCWfqWofB2ki5EQgB5DiOmRp2YnRvO7lsggB2cqmrAvfAq+9rft+0QN0mAou
	WFDTvjYaQCgBVAH9hnXzYGPLWxEdc/1pmvkjDN6WvXwHrVCXZs7HwJxAT9FTYkCV/UV4F8
	VPgnKFq9M5zqt2N3ojnn0posfjP7cCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755678124;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ur6UPwHXhkqU1fS0bJm+yP8QnyRvGGnkp6ULmb2T2Es=;
	b=8mdE7zXt81kQNv/vaR4Jhyj7fUXDQx28bCJ4q9f35aOZ/zBMLZn4NYVJRdg/AKSM++YMWu
	jwQLMEouKP1OdnBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755678124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ur6UPwHXhkqU1fS0bJm+yP8QnyRvGGnkp6ULmb2T2Es=;
	b=Ajxh9r7rn4MCWfqWofB2ki5EQgB5DiOmRp2YnRvO7lsggB2cqmrAvfAq+9rft+0QN0mAou
	WFDTvjYaQCgBVAH9hnXzYGPLWxEdc/1pmvkjDN6WvXwHrVCXZs7HwJxAT9FTYkCV/UV4F8
	VPgnKFq9M5zqt2N3ojnn0posfjP7cCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755678124;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ur6UPwHXhkqU1fS0bJm+yP8QnyRvGGnkp6ULmb2T2Es=;
	b=8mdE7zXt81kQNv/vaR4Jhyj7fUXDQx28bCJ4q9f35aOZ/zBMLZn4NYVJRdg/AKSM++YMWu
	jwQLMEouKP1OdnBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FFE71368B;
	Wed, 20 Aug 2025 08:22:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fCeOHqyFpWjQaAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 20 Aug 2025 08:22:04 +0000
Message-ID: <61da6ec7-500e-4e33-a51a-d2f6ec9e08b6@suse.de>
Date: Wed, 20 Aug 2025 10:22:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] libnvme: TLS PSK derivation fixes
To: Daniel Wagner <dwagner@suse.de>, Chris Leech <cleech@redhat.com>
Cc: linux-nvme@lists.infradead.org,
 Prashanth Nayak <prashanth.nayak@netapp.com>,
 John Meneghini <jmeneghi@redhat.com>
References: <20250721021718.1159879-1-cleech@redhat.com>
 <20250721021718.1159879-2-cleech@redhat.com>
 <d8f4ed91-3fcb-45b9-b4d6-900382eb4ae7@suse.de>
 <aH5dbhXOS8h9gxzX@cleech-thinkpadt14sgen2i.rmtusor.csb>
 <3c3c3194-7275-4a77-9397-4c159458f2c5@suse.de>
 <aIPINwQZNxk_7FZs@cleech-thinkpadt14sgen2i.rmtusor.csb>
 <df8bfa36-c1a9-4398-8246-5bc31991b8c9@suse.de>
 <aJrEAia9jVk17y-j@my-developer-toolbox-latest>
 <3fc1b734-263e-4580-83f8-6852e72f198d@flourine.local>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <3fc1b734-263e-4580-83f8-6852e72f198d@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_012206_329066_05AE224F 
X-CRM114-Status: GOOD (  12.06  )
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

On 8/20/25 10:10, Daniel Wagner wrote:
> On Mon, Aug 11, 2025 at 09:33:06PM -0700, Chris Leech wrote:
>> If we don't have a resolution by then, maybe this is something we can
>> resolve at ALPSS.
>>
>> [1] Side note; with nvme_fabrics_cfg _not_ being allocated through
>> libnvme, I don't see how the various additions there can be ABI safe. It
>> looks to me like this struct alone broke ABI in libnvme 1.4, 1.8, 1.9,
>> and 1.11.
> 
> I know and I was hopping it wouldn't cause troubles... nvme_fabrics_cfg
> is a bit of a problem. I was planing to address this for v2.

In a similar vein: shouldn't we have a session at ALPSS around
libnvme v2?
Or, if not a session, maybe a beer topic?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

