Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A5DC3DA41
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jul 2024 14:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zx0PPpys2vustmk/TbiLUR7Ix3IXW6paxk8BCby9XX4=; b=syBoajZOzniOAaUZM0vPX1cCYC
	QFKdLIXwNvW0YRPgXBG8q4EzL+KxFP/eTakmDz/eKumea1sHXqZwndVSBySv9sRtvjdpfiiVR/gR1
	P3eVwqUoAdqgbMC/ni5etuzZsq9/sdjqJDDP2zV5kn/5c8NyMJSXiXKGo00E2p4rNDBJinmF1gFUb
	fN0hYy3/IJ/rwN4/67eoOLoozpr6Vobl/uwyWAcyG6G2p4USnbBeGbg/zxbeXDgwlWZtgzw5dwb76
	PJNAfUTRMzk2FOkna85sdRIkcTCQcVJnRK1edgFpG9aoEPySjMBuBYrqnydxcLHT65oHK/3ytPd6s
	ZnXuVinw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRXyD-0000000Albf-3CIC;
	Wed, 10 Jul 2024 14:06:57 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRXy5-0000000AlWk-1Xnc
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jul 2024 14:06:56 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 35ED021BD6;
	Wed, 10 Jul 2024 14:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720620405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zx0PPpys2vustmk/TbiLUR7Ix3IXW6paxk8BCby9XX4=;
	b=QjCNuQ0ezMtGXVmK/Ysa6e4bSUO/qkDLsywmv13tunEiRBYV5tqKqBY8Af32KacefKNzE7
	CVTgk8jTEkDwQ6UeWSyDQK8Jz2Xg+9Xqk6JmTIswvn3TM5Hs8MRGolVqHKP1shG1w2GHDA
	0WN8TkwRWDhoKywH6wy9rEKFTU8AsDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720620405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zx0PPpys2vustmk/TbiLUR7Ix3IXW6paxk8BCby9XX4=;
	b=p0triDeCE+0M0bsttlKctMBwdzzxvrdsVoAiKbTQ9x94b0oOVTxfjIpvl3HAybl9/vnIKd
	MwlF0exmEDnqKNCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720620405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zx0PPpys2vustmk/TbiLUR7Ix3IXW6paxk8BCby9XX4=;
	b=QjCNuQ0ezMtGXVmK/Ysa6e4bSUO/qkDLsywmv13tunEiRBYV5tqKqBY8Af32KacefKNzE7
	CVTgk8jTEkDwQ6UeWSyDQK8Jz2Xg+9Xqk6JmTIswvn3TM5Hs8MRGolVqHKP1shG1w2GHDA
	0WN8TkwRWDhoKywH6wy9rEKFTU8AsDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720620405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zx0PPpys2vustmk/TbiLUR7Ix3IXW6paxk8BCby9XX4=;
	b=p0triDeCE+0M0bsttlKctMBwdzzxvrdsVoAiKbTQ9x94b0oOVTxfjIpvl3HAybl9/vnIKd
	MwlF0exmEDnqKNCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 197F3137D2;
	Wed, 10 Jul 2024 14:06:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oj7IBXWVjmYfNQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 10 Jul 2024 14:06:45 +0000
Message-ID: <3dfdf2e8-800b-4e87-a65f-f32fdb5018b0@suse.de>
Date: Wed, 10 Jul 2024 16:06:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 0/3] nvme-tcp: improve scalability
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240708071013.69984-1-hare@kernel.org>
 <33f72b7d-d1da-4c5d-8aa1-1df2559b9588@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <33f72b7d-d1da-4c5d-8aa1-1df2559b9588@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240710_070649_654324_7A2EA37B 
X-CRM114-Status: GOOD (  12.64  )
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

On 7/10/24 13:56, Sagi Grimberg wrote:
> 
> 
> On 08/07/2024 10:10, Hannes Reinecke wrote:
>> Hi all,
>>
>> for workloads with a lot of controllers we run into workqueue contention,
>> where the single workqueue is not able to service requests fast enough,
>> leading to spurious I/O errors and connect resets during high load.
>> This patchset improves the situation by improve the fairness between
>> rx and tx scheduling, introducing per-controller workqueues,
>> and distribute the load accoring to the blk-mq cpu mapping.
>> With this we reduce the spurious I/O errors and improve the overall
>> performance for highly contended workloads.
>>
>> All performance number are derived from the 'tiobench-example.fio'
> 
> Did you keep the fio file unmodified? I'd suggest to run it for longer
> say 60 seconds each workload. 512 MB is a very short benchmark...

Not for 32 queues :-)
But yeah, I can keep it running for slightly longer.

Not making much progress, mind; your 'softirq' patch definitely speeds 
up receiving, but seem to messing up the write side such that I'm 
basically guaranteed to hit I/O timeouts on WRITE :-(

Keep on debugging ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


