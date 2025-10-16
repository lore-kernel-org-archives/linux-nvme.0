Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232FFCCD183
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Oct 2025 06:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NU3oVNJxkPki0i427fugzyKAo6PCL/Yz/AI9uuhxWSU=; b=0vzH/Bu7U3y6tiUkq+OhG8qwrA
	u6wdVqQv9Y5Ze4R1DLRSLSM39x9eMuuJdlN4YqrAPDE8KqSVAUiqRI14Cc/v72zX/gmF+SZWqeZGd
	INYf+icptO5ZGcIHk4Kms+To/chnYtgsxKIvRq8FENGrGT8/1rQ10wNlPEL96J6N6iRzH7FrsEr1m
	Xc2YILLdmPB8thU4jE60adFTqx2NhdB0lveUxWC1fH2CNV5kwLmWq9tP5S48M9ywpFryyxrfxST9T
	5d6VdC1JgyVg5tWRP912r1fjVfHp9jobaNT2a9RPxmMrQ+H57sa4eiCl9FU0BYcw6hxJtYvUZG5Rc
	MeZ+hvmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9HFq-00000003bSU-3O7N;
	Thu, 16 Oct 2025 06:14:26 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9HFo-00000003bS5-2Q77
	for linux-nvme@lists.infradead.org;
	Thu, 16 Oct 2025 06:14:25 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 148AA21EA4;
	Thu, 16 Oct 2025 06:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760595261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NU3oVNJxkPki0i427fugzyKAo6PCL/Yz/AI9uuhxWSU=;
	b=KcM+dRe0Zy1a7NDD+xNbGfPvjOeasqQLylRx/OjgRes1I8i5j+hm77zXOdOW8Q5LRfTOBY
	3Ku1SBKfbF+NXt6DGC2GTIoZYqvYW5XI/Tlzx94JjnVSGgvsZnisrvIDM18tn7SyaDZd88
	sHqM1LIVfD2xKG3FtirQedFYSUlgkeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760595261;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NU3oVNJxkPki0i427fugzyKAo6PCL/Yz/AI9uuhxWSU=;
	b=/qraf3oHRBVEXTHRG+dPHa+Ll170/QC2ao+OBKs1iqGLrc1EPxVNzfnuyhzlWe7I5OVn79
	n1xXiSj3rB6O3xCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oQZmC6nK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KYtx24UX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760595260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NU3oVNJxkPki0i427fugzyKAo6PCL/Yz/AI9uuhxWSU=;
	b=oQZmC6nKy8nzH/zSenwtpORMfWYjvj2GQLIuxnWxwiGTYWOuzOeW3SFYZi2q5mOsSDEHZc
	dxGU054PM9Wz8lXpTYMKMdXnjzjM/TPhlmqGXjVbxk7404EaiWUVdeFVs1boNBpPfVK2gg
	6wCTnbs1U4UosVV9myyVTrdbgfu/e2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760595260;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NU3oVNJxkPki0i427fugzyKAo6PCL/Yz/AI9uuhxWSU=;
	b=KYtx24UXH2UjTp9I9Ka6+O8WgtVTzLRPCutbEhqGHhRvR8pUjDKM0rZPDwvFEudQmIJhGn
	BVEdyb0d8rG3zWAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCD051376E;
	Thu, 16 Oct 2025 06:14:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HLxaMDuN8GisFAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 16 Oct 2025 06:14:19 +0000
Message-ID: <d179666e-aed5-476e-a6b6-73b3a80ce925@suse.de>
Date: Thu, 16 Oct 2025 08:14:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv2 4/4] nvme-multipath: add debugfs attribute for
 adaptive I/O policy stat
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, axboe@kernel.dk, dwagner@suse.de,
 gjoyce@ibm.com
References: <20251009100608.1699550-1-nilay@linux.ibm.com>
 <20251009100608.1699550-5-nilay@linux.ibm.com>
 <359e3d8f-4db7-4430-8520-4fed9de4f48e@suse.de>
 <4faf672b-ad74-41dc-9518-bbb9af557544@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <4faf672b-ad74-41dc-9518-bbb9af557544@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 148AA21EA4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251015_231424_783674_3C9220E6 
X-CRM114-Status: GOOD (  11.96  )
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

On 10/15/25 08:19, Nilay Shroff wrote:
> 
> 
> On 10/13/25 12:03 PM, Hannes Reinecke wrote:
>> On 10/9/25 12:05, Nilay Shroff wrote:
>>> This commit introduces a new debugfs attribute, "adaptive_stat", under
>>> both per-path and head debugfs directories (defined under /sys/kernel/
>>> debug/block/). This attribute provides visibility into the internal
>>> state of the adaptive I/O policy to aid in debugging and performance
>>> analysis.
>>>
>>> For per-path entries, "adaptive_stat" reports the corresponding path
>>> statistics such as I/O weight, selection count, processed samples, and
>>> ignored samples.
>>>
>>> For head entries, it reports per-CPU statistics for each reachable path,
>>> including I/O weight, path score, smoothed (EWMA) latency, selection
>>> count, processed samples, and ignored samples.
>>>
>>> These additions enhance observability of the adaptive I/O path selection
>>> behavior and help diagnose imbalance or instability in multipath
>>> performance.
>>>
>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>>> ---
>>>    drivers/nvme/host/core.c      |   3 +
>>>    drivers/nvme/host/debugfs.c   | 117 ++++++++++++++++++++++++++++++++++
>>>    drivers/nvme/host/multipath.c |   2 +
>>>    3 files changed, 122 insertions(+)
>>>
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>>
>> Might be an idea to have support for queue-depth in here, too.
>>
> Currently queue_depth and numa_nodes attributes are created under
> sysfs, so do you meant to move those attributes from sysfs to
> debugfs?
> 
Yes. sysfs information can be perused by udev rules, and that assumes
the information in there will not change without a 'CHANGE' uevent.
So it's questionable whether volatile information like the queue depth
or the round-robin path selection should be presented there.
I'd rather have it moved into debugfs.

But that might be personal preference.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

