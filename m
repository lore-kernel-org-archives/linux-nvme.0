Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB30C30653
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jul 2024 08:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dIGflQywJ8dMNdlKWrZr5XV9go3j7auton/EPKSlbOY=; b=QCRlDV9IuYDa1fcdoeYiD35yGU
	QCuMt0Qxy0eo2QTtSjl1WZGI/T/aaGkRNYwyiDSNUIiVCm3QIyNjBqh9fL6TJv4lIm1ojMwRt9nV1
	w+up3qjnh4FjjRbhpR32e4c9xRLG4Kp5A2U8DCpDpIHF5NTmQ535jHuI96mwql72Bxm8DZkUV+E8C
	443e5plupbhaQL16Nq042nMCs9ooEqlPfxkxsodrhlw+jObVwd1s2rJogA1lVSEwg7SAo/2JzV4Pf
	RmFt1FddZDlY3B4OFFqLoEcqi2BirorJkGroRXUNyuhKnje5PissSFBdJa4gCqzGJh5kOmE4AeeIl
	vg5TrKRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOCd7-00000002HOz-1pAk;
	Mon, 01 Jul 2024 08:43:21 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOCd2-00000002HMi-2YNw
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jul 2024 08:43:20 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B10D221AB2;
	Mon,  1 Jul 2024 08:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719823394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIGflQywJ8dMNdlKWrZr5XV9go3j7auton/EPKSlbOY=;
	b=cKUI307rRb/HXjE2LY3/FdpZ+60oCL5DdFYtsOSUJh3imAPs1DMSM8hlrwlKI9rBeZff47
	UOHTlB1YkZBO7cJsBCBrNpzXTtwMXRkkSTjHTY+1bYh4c9BScxhovb9lB1iI6l8O+xXbht
	xRBF0Afm3Djlz6qZy7LXL2wXcjl+OhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719823394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIGflQywJ8dMNdlKWrZr5XV9go3j7auton/EPKSlbOY=;
	b=tEKfHSheR0o5BNtMV3BsolCPze4YAKmPupn+SeMGYwRh0MhJFP5hH5Qp6WUHoUrsBGZby7
	wQccriqBj0pX/iDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cKUI307r;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tEKfHShe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719823394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIGflQywJ8dMNdlKWrZr5XV9go3j7auton/EPKSlbOY=;
	b=cKUI307rRb/HXjE2LY3/FdpZ+60oCL5DdFYtsOSUJh3imAPs1DMSM8hlrwlKI9rBeZff47
	UOHTlB1YkZBO7cJsBCBrNpzXTtwMXRkkSTjHTY+1bYh4c9BScxhovb9lB1iI6l8O+xXbht
	xRBF0Afm3Djlz6qZy7LXL2wXcjl+OhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719823394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIGflQywJ8dMNdlKWrZr5XV9go3j7auton/EPKSlbOY=;
	b=tEKfHSheR0o5BNtMV3BsolCPze4YAKmPupn+SeMGYwRh0MhJFP5hH5Qp6WUHoUrsBGZby7
	wQccriqBj0pX/iDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A3C313800;
	Mon,  1 Jul 2024 08:43:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FdU9HSJsgmZnBwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 01 Jul 2024 08:43:14 +0000
Message-ID: <0d8a5256-9719-45c5-b098-237b5a82fd36@suse.de>
Date: Mon, 1 Jul 2024 10:43:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] lib/group_cpus.c: honor housekeeping config when
 grouping CPUs
To: Ming Lei <ming.lei@redhat.com>, Daniel Wagner <dwagner@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>, Frederic Weisbecker <fweisbecker@suse.com>,
 Mel Gorman <mgorman@suse.de>,
 Sridhar Balaraman <sbalaraman@parallelwireless.com>,
 "brookxu.cn" <brookxu.cn@gmail.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
 <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
 <ZoFgLxGXrk4VCR03@fedora>
 <b2ncik6c7xicsnzihhwfjjqood2yys52tzotohjnxj6o2mapg5@m364yzsjbvs2>
 <ZoJY6a1CHCENAZZ8@fedora>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZoJY6a1CHCENAZZ8@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.dk,kernel.org,grimberg.me,linutronix.de,lst.de,suse.com,suse.de,parallelwireless.com,gmail.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B10D221AB2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_014317_152914_7F0FACCC 
X-CRM114-Status: GOOD (  20.08  )
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

On 7/1/24 09:21, Ming Lei wrote:
> On Mon, Jul 01, 2024 at 09:08:32AM +0200, Daniel Wagner wrote:
>> On Sun, Jun 30, 2024 at 09:39:59PM GMT, Ming Lei wrote:
>>>> Make group_cpus_evenly aware of isolcpus configuration and use the
>>>> housekeeping CPU mask as base for distributing the available CPUs into
>>>> groups.
>>>>
>>>> Fixes: 11ea68f553e2 ("genirq, sched/isolation: Isolate from handling managed interrupts")
>>>
>>> isolated CPUs are actually handled when figuring out irq effective mask,
>>> so not sure how commit 11ea68f553e2 is wrong, and what is fixed in this
>>> patch from user viewpoint?
>>
>> IO queues are allocated/spread on the isolated CPUs and if there is an
>> thread submitting IOs from an isolated CPU it will cause noise on the
>> isolated CPUs. The question is this a use case you need/want to support?
> 
> I have talked RH Openshift team weeks ago and they have such usage.
> 
> userspace is free to run any application from isolated CPUs via 'taskset
> -c' even though 'isolcpus=' is passed from command line.
> 
> Kernel can not add such new constraint on userspace.
> 
>> We have customers who are complaining that even with isolcpus provided
>> they still see IO noise on the isolated CPUs.
> 
> That is another issue, which has been fixed by the following patch:
> 
> a46c27026da1 blk-mq: don't schedule block kworker on isolated CPUs
> 
Hmm. Just when I thought I understood the issue ...

How is this supposed to work, then, given that I/O can be initiated
from the isolated CPUs?
I would have accepted that we have two scheduling domains, blk-mq is
spread across all cpus, and the blk-mq cpusets are arranged according
to the isolcpu settings.
Then we can initiate I/O from the isolated cpus, and the scheduler
would 'magically' ensure that everything is only run on isolated cpus.

But that patch would completely counteract such a setup, as during
I/O we more often than not will invoke kblockd, which then would cause
cross-talk on non-isolated cpus.

What is the idea here?

Confused,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


