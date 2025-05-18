Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CB6C3ABD8
	for <linux-nvme@archiver.kernel.org>; Sun, 18 May 2025 11:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QVotmFrRw7S6uv+MCVusAFu5PtN9XD5eaJlI5bCEF+Q=; b=om9SnPeO0bLz/GAUZ1fxI6XPUn
	mks8V3ReM1DMh5pp+6wSMHnBmhvH2LUN8WAlCCJVDRJ3gm/0Ot5saBYEJNxK4Gx5WRqYqmJ7nl+53
	TBrsLAahetIac1i3grMjdDIAIL+hnhgX0qRSn3PW8LHbl7Lir/0yewadiaBnx34ppyrwgbXuWmylc
	YEHKJ+jc36fkld0kwb6Akdmm32O9v6g66p5t6fD+wJV/jAPSnSK3E2fKG6gRtT0KSGEo4wroO8rMP
	t/qSGZAsSglGq7fxieanR0UsL7ruc3mGnWyzu6wyaiWZtHlI1z7f93OG0g5BpDGYVQduG/kqTX8sS
	XPoeNb0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGc9R-000000074eJ-3EPd;
	Sun, 18 May 2025 11:25:53 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGc9P-000000074dS-0L32
	for linux-nvme@lists.infradead.org;
	Sun, 18 May 2025 11:25:52 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C71002212F;
	Sun, 18 May 2025 11:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747567547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVotmFrRw7S6uv+MCVusAFu5PtN9XD5eaJlI5bCEF+Q=;
	b=zGhTJZ/oyueY4umA1d7Lg84QKJ9sq3sCXhHXl2T76I8ASqnkMWv3s/j809+5Tag422YYBJ
	lc/ScZNLjmGnryIFJW5K3lthuxgJphvK/9K53WmZcbHY7nx5eLOO7TSOvnQ5LYF9wSPpc2
	XD8nIKeinGaBm+AUJU38/Ag6/1sKUhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747567547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVotmFrRw7S6uv+MCVusAFu5PtN9XD5eaJlI5bCEF+Q=;
	b=GLokBfVU5MnR7UPHT+dY/MQ7ttSZgP0qyNmk0ovDvMHXng/m20KIrPc9KQdtW6Bwxy5uLx
	4pV5medLV4XSbaCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747567546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVotmFrRw7S6uv+MCVusAFu5PtN9XD5eaJlI5bCEF+Q=;
	b=SguQP8cdLy2Tj8E7YvUptQbCdGhMmAISIH6NXZLDmoiCtqpvyjuhWVw5YgKjUt0rGgBktt
	o8UbLcDXXmB6pSncVCLO80EbIrlMVmbFtZP+xk3eINXKIp/cbOoeE1IxpGPk3nDnuazdMT
	sPcTcWc/D6DRmFwulsWCqDHamc0mfCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747567546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVotmFrRw7S6uv+MCVusAFu5PtN9XD5eaJlI5bCEF+Q=;
	b=27d7mBZQgOlghlYnJ1BMK1RefkP5zJ4A0p7TXBXEE35kbeykJLRkGHk/JQuQZ9sO5l8J9r
	ogdyB19Fb5lCWIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 828011334C;
	Sun, 18 May 2025 11:25:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mqspHbrDKWjOFwAAD6G6ig
	(envelope-from <hare@suse.de>); Sun, 18 May 2025 11:25:46 +0000
Message-ID: <635f3315-a77b-4e8b-8454-20cb7c9ae2e8@suse.de>
Date: Sun, 18 May 2025 13:25:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] nvme/063 failure (tcp transport)
To: Sagi Grimberg <sagi@grimberg.me>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <6mhxskdlbo6fk6hotsffvwriauurqky33dfb3s44mqtr5dsxmf@gywwmnyh3twm>
 <72a394aa-9ed1-45ec-8aaf-5f5ccf1c18ab@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <72a394aa-9ed1-45ec-8aaf-5f5ccf1c18ab@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250518_042551_280501_9DABA5E6 
X-CRM114-Status: GOOD (  12.44  )
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

On 5/18/25 12:01, Sagi Grimberg wrote:
> 
> 
> On 16/05/2025 15:31, Shinichiro Kawasaki wrote:
>> Hello all,
>>
>> Using the kernel v6.15-rc6 and the latest blktests (git hash 
>> 613b8377e4d3), I
>> observe the test case nvme/063 fails with tcp transport. Kernel 
>> reported WARN in
>> blk_mq_unquiesce_queue and KASAN sauf in blk_mq_queue_tag_busy_iter 
>> [1]. The
>> failure is recreated in stable manner on my test nodes.
>>
>> The test case script had a bug then this failure was not found until 
>> the bug get
>> fixed. I tried the kernel v6.15-rc1, and observed the same failure 
>> symptom. This
>> test case cannot be run with the kernel v6.14, since it does not have 
>> secure
>> concatenation feature.
>>
>> Actions for fix will be appreciated.
> 
> Hannes, did you encounter this?
> 
No; I would think it's an artifact due to multipath not being enabled.
Shin'ichiro, can you reproduce it with CONFIG_NVME_MULTIPATH on?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

