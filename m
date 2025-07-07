Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523D4C83F0C
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jul 2025 15:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PyUW2jNQ1CDdGSRifykhkuvSJEfICwLp3bIC3AG654A=; b=mwypQkObyspUPxG5IlEURNr7y7
	j5mxHbg2xieN5Dnl8ac30AWidK375BeJRun5h3PwjNsvFpwDG7G10hA4rWf5B1YWqCoyKSyygkPq0
	/yQW6wasffNEagvPAq6KjrcIH6x4sXzaRoWDGM3Dj8YG+AJ63114WC9utZZm7wB5eGbq1ydOSlfvi
	0aEjAVEfxDILVM6cANuh5MP7Odd/7WGg2UoecxzJpi3U0nwZG23WOyJIUsTbucKu0+NGILTMWgvsN
	zviacXCiNxQKhpEfT45Uqm8OS8987gLX2p8jBQdYav3x/y/qX8AgU/b8uzTfZ434g0kHoGCdUIgS0
	WkRktbxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYnq4-00000002sF3-00kO;
	Mon, 07 Jul 2025 15:33:04 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYnkG-00000002rHB-1h6m
	for linux-nvme@lists.infradead.org;
	Mon, 07 Jul 2025 15:27:05 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 792D51F390;
	Mon,  7 Jul 2025 15:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751902021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PyUW2jNQ1CDdGSRifykhkuvSJEfICwLp3bIC3AG654A=;
	b=cVLOTojAsaEzE2ylJrc14lyBlCoujSmt871bNTemWjd44vFTUXrwnAN5rngNIzpAmS/04S
	lSyIm17lG15homkFtgiOIR3+q4bbOKpAOYQjMSokHbtbV/MzOvU9CY7F1B0no3m/nTw8KA
	Hi6cFVA20+fBD2orQM9tLs5ARVFgKqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751902021;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PyUW2jNQ1CDdGSRifykhkuvSJEfICwLp3bIC3AG654A=;
	b=u0LFMmYSXLyPaeTdNeTKJX/sfPeif70MwlpcQ0dCaDDU9zLoKyAbRM6/4o4JQO8HanQ54j
	WlwdU6sOWxkV1IBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751902021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PyUW2jNQ1CDdGSRifykhkuvSJEfICwLp3bIC3AG654A=;
	b=cVLOTojAsaEzE2ylJrc14lyBlCoujSmt871bNTemWjd44vFTUXrwnAN5rngNIzpAmS/04S
	lSyIm17lG15homkFtgiOIR3+q4bbOKpAOYQjMSokHbtbV/MzOvU9CY7F1B0no3m/nTw8KA
	Hi6cFVA20+fBD2orQM9tLs5ARVFgKqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751902021;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PyUW2jNQ1CDdGSRifykhkuvSJEfICwLp3bIC3AG654A=;
	b=u0LFMmYSXLyPaeTdNeTKJX/sfPeif70MwlpcQ0dCaDDU9zLoKyAbRM6/4o4JQO8HanQ54j
	WlwdU6sOWxkV1IBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 267A613A5E;
	Mon,  7 Jul 2025 15:27:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F4FrB0Xna2hHQwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 07 Jul 2025 15:27:01 +0000
Message-ID: <b2ff30b5-5f12-4276-876d-81a8b2f180c1@suse.de>
Date: Mon, 7 Jul 2025 17:26:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What should we do about the nvme atomics mess?
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Alan Adamson <alan.adamson@oracle.com>,
 John Garry <john.g.garry@oracle.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20250707141834.GA30198@lst.de> <aGvYnMciN_IZC65Z@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aGvYnMciN_IZC65Z@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250707_082704_593778_B2928C48 
X-CRM114-Status: GOOD (  15.52  )
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

On 7/7/25 16:24, Keith Busch wrote:
> On Mon, Jul 07, 2025 at 04:18:34PM +0200, Christoph Hellwig wrote:
>> We could:
>>
>>   I.	 revert the check and the subsequent fixup.  If you really want
>>           to use the nvme atomics you already better pray a lot anyway
>> 	 due to issue 1)
>>   II.	 limit the check to multi-controller subsystems
>>   III.	 don't allow atomics on controllers that only report AWUPF and
>>   	 limit support to controllers that support that more sanely
>> 	 defined NAWUPF
>>
>> I guess for 6.16 we are limited to I. to bring us back to the previous
>> state, but I have a really bad gut feeling about it given the really
>> bad spec language and a lot of low quality NVMe implementations we're
>> seeing these days.
> 
> I like option III. The controler scoped atomic size is broken for all
> the reasons you mentioned, so I vote we not bother trying to make sense
> of it.
> 
Agree. We might consider I. as a fixup for stable, but should continue
with III going forward.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

