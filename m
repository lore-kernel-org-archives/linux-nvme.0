Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD69BC2BD09
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jul 2024 06:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3yEV5Mth4GbtX1rg5f10INAr+H52NO/l+mmP1MPeBIE=; b=40TP30lDf1xERnBmts441o8l5j
	DQ+5sifOgL5R3GgfUNrdXcEUShsuif98Ypp7xRAqPNXJB6aOh3fkRnE5E+5EfdzKp9k949PXavJ0E
	mbVVbVWKOHwLGpB/ghNwDXaqWEQpp38bB41yLqrJNZC0snOUK59bk6aYvsd+xqNYfT1TcLNw5KPQA
	EkK6cEnJADR7GG3SNKNEUm2K5u85RtHwfectvfSQHeoBRh3sVLKzsIiOwkT39/+wnxAxAlFAthgqO
	T/Wn/rBzuywYJ+YVoF9YUkKfl3VsMkyicetTco26qZgdy7nvFb5Tyf5aMhu65aTIQAWjy3OHnAjHR
	L4lrOxuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR4ho-000000069ER-2fPf;
	Tue, 09 Jul 2024 06:52:04 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR4hk-000000069Cb-0J4N
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jul 2024 06:52:03 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE04421B8B;
	Tue,  9 Jul 2024 06:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720507917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3yEV5Mth4GbtX1rg5f10INAr+H52NO/l+mmP1MPeBIE=;
	b=Kud8DhROLrPCKB4f7jT6DEzGLahcMo7kcNctdNf4rTM2Oi9dAmBHwpdFdYsSTySLklqUmh
	3EtydosoRkkb8RfdyBMbCfIbPJdhSKsICOd4QsyhByjOtP51sSTHHxqaWwob1W3S6cLtUP
	cfUZPK/nDqAlpmHZIsApz4rGV8Jik78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720507917;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3yEV5Mth4GbtX1rg5f10INAr+H52NO/l+mmP1MPeBIE=;
	b=8jaH1cq0g+bWULPVLdWKEIBpfGhwrSt445rk+qzUyJXSDLjxwfazWyLlek70tnxGJwdMMM
	Y5hUiDA1MA568PAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720507916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3yEV5Mth4GbtX1rg5f10INAr+H52NO/l+mmP1MPeBIE=;
	b=CVFQs96LGcUSEJtzdFLtFo+TvkJK3tdzb15Fgt7/imlJSKWPo/jS8MDDTbCewlYevkZaNv
	ze54H+DDX8iCkySaIRlk4PVjD9wr3XkIxQb/rPGebIhwIV7iwFkP3nyUOzqQo2Homuhayl
	TIcZ70pU6Z4Q/3txbI5Pc0Vs54Znmpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720507916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3yEV5Mth4GbtX1rg5f10INAr+H52NO/l+mmP1MPeBIE=;
	b=uCOFHfYpRAj7OAG+4iM67VVjmwGhQU3XNL0iUEA3wpg6tsY2Zijj1U7BL2p7IymzXCjOet
	uOuU3ogt1/i2b4AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEA071396E;
	Tue,  9 Jul 2024 06:51:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Pl7BLAzejGY4CgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 09 Jul 2024 06:51:56 +0000
Message-ID: <7b5006e7-9df3-4ee3-a2e9-0ce091c21434@suse.de>
Date: Tue, 9 Jul 2024 08:51:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvme-tcp: improve rx/tx fairness
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240708071013.69984-1-hare@kernel.org>
 <20240708071013.69984-2-hare@kernel.org>
 <96bb4107-abc0-4fd3-8e2b-35eafa6a5d4f@grimberg.me>
 <a54ac72e-f04f-4bb7-a9de-5a3d3d71d9c6@suse.de>
 <5334b2dd-23ab-4637-a762-e871f884db54@grimberg.me>
 <7d52a56b-2311-4f64-a0f4-383c5521e91c@suse.de>
 <8013f402-4831-46c3-b207-c08821c15760@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <8013f402-4831-46c3-b207-c08821c15760@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_235200_293711_86DBE12D 
X-CRM114-Status: GOOD (  14.04  )
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

On 7/8/24 21:31, Sagi Grimberg wrote:
> 
> 
> On 08/07/2024 18:50, Hannes Reinecke wrote:
[ .. ]
>>
>> Weellll ... if 'SOCK_NOSPACE' is for blocking sockets, why do we even 
>> get the 'write_space()' callback?
>> It gets triggered quite often, and checking for the SOCK_NOSPACE bit 
>> before sending drops the number of invocations quite significantly.
> 
> I need to check, but where have you testing it? in the inline path?
> Thinking further, I do agree that because the io_work is shared, we may
> sendmsg immediately as space is becomes available instead of some 
> minimum space.
>  > Can you please quantify this with your testing?
> How many times we get write_space() callback? how many times we get 
> EAGAIN, and what
> is the perf... Also interesting if this is more apparent in specific 
> workloads. I'm assuming its
> more apparent with large write workloads.

Stats for my testing
(second row is controller 1, third row controller 2):

write_space:
0: 0 0
1: 489 2
10: 325 20
11: 28 1
12: 14 1
13: 252 1
14: 100 12
15: 310 1
16: 454 2
2: 31 11
3: 50 1
4: 299 42
5: 1 19
6: 12 0
7: 737 16
8: 636 1
9: 19 1

queue_busy:
0: 0 0
1: 396 2
10: 66 18
11: 91 8
12: 56 14
13: 464 7
14: 24 15
15: 574 8
16: 516 9
2: 22 29
3: 56 5
4: 153 99
5: 2 40
6: 18 0
7: 632 5
8: 590 13
9: 129 2

The send latency is actually pretty good, and around 150 us on 
controller 1 (with two notable exceptions of 480 us on queue 5 and 646 
us on queue 6) and around 100 us on controller 2 (again with exceptions 
of 444 us on queue 5 and 643 us on queue 6). Each queue processing 
around 150k requests.

Receive latency is far more consistent; each queue has around 150 us on 
controller 1 and 140 us on controller 2.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


