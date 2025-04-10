Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EC2C3601E
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 06:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3zZmZhxThfVs0/7/o58shtBCOpPJMyrS0Y56JOrkl3w=; b=QECVrWoLD0CiOTmKvHaQKrWWRd
	NLAt3TNHEPpuN0ghFRgG8p4NH8mRwghqHBBzmPkXFkvLMTVoFRZpXuP5lqHjvHOuLyj0eUEBognUS
	mHn+fmaiM5W2hfjV998CNH+sE/QyBg9tuwyU58cEtxa7xa8zX+uzyENwbIyW0J99ksxErlAMconcW
	WkomA7PF9PXE1vQ5dsb9EtYWiOYQw7oV1tID0WTetiM/whDefRV8z9fM+1489C/2rFIdJVDU8/4Rr
	5iIOvPNgxi5co6LhcWcxERxxXsCytQOSuJ6OE6Oq6FRTrFH+pOhEXdTdiZ8lCQd9SCwR6shceggD8
	YyQ7t6kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2l7r-00000009KuW-15hW;
	Thu, 10 Apr 2025 06:10:59 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2l7m-00000009Ksw-2hCW
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 06:10:58 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6731C2116D;
	Thu, 10 Apr 2025 06:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744265451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3zZmZhxThfVs0/7/o58shtBCOpPJMyrS0Y56JOrkl3w=;
	b=sacG+DukQMZm4/vYoe0XU7lzUyUJEeaFJwk029OR1Ysva/wPO28wHtKUqhDA/FJVdpP0+M
	Oc3F8/CTBIScLWW3kx47bIu572mOE/0NqrOLqSJrp0Vv4Ocm7Cyd5SPsRXBf5X3sG6OwLC
	ln4u58sHwG309GsYxOT+tmBLA1Wh+IY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744265451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3zZmZhxThfVs0/7/o58shtBCOpPJMyrS0Y56JOrkl3w=;
	b=py43ckEvsbMjeu/Q9votX2V/x1N2j/5ic+sE1y+RGYGVuql0nXAqlXCCT9bhJwPPLLkk00
	A130J7X22UQqQfAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sacG+Duk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=py43ckEv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744265451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3zZmZhxThfVs0/7/o58shtBCOpPJMyrS0Y56JOrkl3w=;
	b=sacG+DukQMZm4/vYoe0XU7lzUyUJEeaFJwk029OR1Ysva/wPO28wHtKUqhDA/FJVdpP0+M
	Oc3F8/CTBIScLWW3kx47bIu572mOE/0NqrOLqSJrp0Vv4Ocm7Cyd5SPsRXBf5X3sG6OwLC
	ln4u58sHwG309GsYxOT+tmBLA1Wh+IY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744265451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3zZmZhxThfVs0/7/o58shtBCOpPJMyrS0Y56JOrkl3w=;
	b=py43ckEvsbMjeu/Q9votX2V/x1N2j/5ic+sE1y+RGYGVuql0nXAqlXCCT9bhJwPPLLkk00
	A130J7X22UQqQfAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E532132D8;
	Thu, 10 Apr 2025 06:10:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A8yqAetg92cpZQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 10 Apr 2025 06:10:51 +0000
Message-ID: <823c825c-a777-4c84-a833-39c7d4a6be54@suse.de>
Date: Thu, 10 Apr 2025 08:10:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvmetcli restore fails in add_subsystem
To: Anton Gavriliuk <antosha20xx@gmail.com>, Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Daniel Wagner <wagi@kernel.org>,
 linux-nvme@lists.infradead.org
References: <CAAiJnjpzCfDViPDsixbyOe3V3w5EMDa-ScEt0jod9b-YJjJw7Q@mail.gmail.com>
 <Z_Y3AYFzE3L2ujBW@infradead.org>
 <527963f3-1b89-4604-bc76-b3a18bb330a6@flourine.local>
 <CAAiJnjoft3gSsg-TYgyiBVpWiTjWztF=3E-aJpuaeZLCNrT-hg@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAAiJnjoft3gSsg-TYgyiBVpWiTjWztF=3E-aJpuaeZLCNrT-hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6731C2116D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com,suse.de];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email,suse.com:url]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_231054_852248_25C6E399 
X-CRM114-Status: GOOD (  15.78  )
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

On 4/9/25 13:58, Anton Gavriliuk wrote:
> Hhmmm.....
> 
> The link - https://documentation.suse.com/sles/15-SP6/html/SLES-all/cha-nvmeof.html
> 
> is quite confused me,
> 
> 17.4.3 Marvell
> 
> FC-NVMe is supported on QLE269x and QLE27xx adapters. FC-NVMe support
> is enabled by default in the Marvell® QLogic® QLA2xxx Fibre Channel
> driver.
> 
> So if "the qla2xxx driver or/and the HBA firmware do not support the
> target mode anymore.", it is not clear, will NVMe/FC target work with
> QLE269x and QLE27xx adapters or not.
> 
It does not. The HBA model is irrelevant as the code to run nvme target
mode on QLogic HBAs is not present.

>> Though he was able to get the target mode running with a Emulex HBA (lpfc driver).
> 
> Long live Emulex!
> 
Kudos to James Smart; he was the main driver behind the NVMe-FC effort.

> P.S., I don't like FC, but I want to do some NVMe/FC vs TCP
> performance tests, so I must set up NVMe/FC for the tests.
> 
I am not sure how far you get with that. There is a differential
in transport speeds (10/25/50/100 for Ethernet, 16/32/64 for FC),
and the best you can hope is to reach line speed.
In my tests we reach line speed out of the box for 10GigE and
16G FC. I did some tests with 32G FC, but that was inconclusive
as it _heavily_ depended on the hardware setup (How many CPUs?
How many queues are exposed? Which backend did one use?).
And I do expect the picture is even worse for 100GigE.

But it'll be on my agenda to do some benchmarking here, too.

 From a practical side, FC is far more robust than Ethernet.
Thing is, traffic on FC is well managed, and one can expect
reliable performance characteristics throughout the lifetime
of the connection.
Ethernet, OTOH, is prone to outside influence as typically the
switches are used for all traffic (not just I/O), and hence packet
drops and performance drops are for more likely.

Which in the end will be far more important than raw speed.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

