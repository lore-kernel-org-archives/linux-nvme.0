Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974F1EFD206
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 08:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cv61eXul4+Id0Xk3dMKov6St1E/xGPF7i7RC/RbLP28=; b=PKQLM6nA9BudXKc2kcgJumUjOA
	nyvvPZM6grYznhaHkdGthelJrk/twMcg402rJ0acyn5SnLFWIB1rm89BvTgeAkUlbmDDkVQT9VIEi
	xiGkPEUrsfpQNTwojoD1XcfqzzwhzHWHNEJghp88HeG8CIfSdGC1hvqHcMChH8YnyC3OZy78qvSBY
	0g/rpEwWGkKtoDjTyrln4gCKhDIi+8KebtZea2SNjqR7+iA1OUUvtxjlo4PXzoMc/bGIEbvubx7X7
	ey3aPp4iwPzZONMvwzUNNws31T7nYajjVJdI1CxmqxWzjgRG9o2lfJ0VTsnAzBaRbNOoWFMvAMXRM
	G7nqv+aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv9zE-00000003TW5-0DJY;
	Wed, 25 Feb 2026 08:11:12 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv9zC-00000003TV6-0rfZ
	for linux-nvme@lists.infradead.org;
	Wed, 25 Feb 2026 08:11:11 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 83F553F6D2;
	Wed, 25 Feb 2026 08:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772007066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cv61eXul4+Id0Xk3dMKov6St1E/xGPF7i7RC/RbLP28=;
	b=mMtgbQ339ta6FU0XTED0h+40xDyL5aM/deQNd1mnahKJxGQFnLyRxYyMVQa4Z36pMhRMwH
	lsv+ALst/r7Da2jOFMS9q82RHCgB4MhrzEC9NT7/FepFA9ZkcgULwzlXOT3J3Scgt1VYXZ
	+AHLdLMgDkxn8WIN/zkcQa+uPH3Y1PY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772007066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cv61eXul4+Id0Xk3dMKov6St1E/xGPF7i7RC/RbLP28=;
	b=D7Fgbhv8hbdx99qzzkFVJTNx12tSQ4AW8N352bDH7ZwGNqfn4H+b8xVqDorJxf03NXkGnp
	1IqgF8U7MBHTZ+BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772007066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cv61eXul4+Id0Xk3dMKov6St1E/xGPF7i7RC/RbLP28=;
	b=mMtgbQ339ta6FU0XTED0h+40xDyL5aM/deQNd1mnahKJxGQFnLyRxYyMVQa4Z36pMhRMwH
	lsv+ALst/r7Da2jOFMS9q82RHCgB4MhrzEC9NT7/FepFA9ZkcgULwzlXOT3J3Scgt1VYXZ
	+AHLdLMgDkxn8WIN/zkcQa+uPH3Y1PY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772007066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cv61eXul4+Id0Xk3dMKov6St1E/xGPF7i7RC/RbLP28=;
	b=D7Fgbhv8hbdx99qzzkFVJTNx12tSQ4AW8N352bDH7ZwGNqfn4H+b8xVqDorJxf03NXkGnp
	1IqgF8U7MBHTZ+BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 240DB3EA65;
	Wed, 25 Feb 2026 08:11:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /ip0BpqunmmRRgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 25 Feb 2026 08:11:06 +0000
Message-ID: <0a6ec8d3-7623-4809-b275-3eccb94419d4@suse.de>
Date: Wed, 25 Feb 2026 09:11:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Native SCSI multipath support
To: Benjamin Marzinski <bmarzins@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, lsf-pc@lists.linux-foundation.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, dm-devel@lists.linux.dev
References: <69349b51-72c2-47f9-948f-f89843af62e4@oracle.com>
 <aZnuSC0qYfw0hiwM@kernel.org> <aZ5GbVxDT3gcS6WE@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aZ5GbVxDT3gcS6WE@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_001110_392586_8108AE20 
X-CRM114-Status: GOOD (  22.94  )
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

On 2/25/26 01:46, Benjamin Marzinski wrote:
> On Sat, Feb 21, 2026 at 12:41:28PM -0500, Mike Snitzer wrote:
>> On Fri, Feb 13, 2026 at 02:19:11PM +0000, John Garry wrote:
>>> At ALPSS 25 I presented a proposal for Native SCSI multipath support. Let's
>>> discuss this topic at LSFMM.
>>>
>>> The idea for this is that SCSI could natively support multipath, like how
>>> NVMe host driver does today. It is intended as an alternative to
>>> dm-multipath support.
>>>
>>> I have been working on the implementation and I plan to post patches in the
>>> next cycle. I am looking at a 3-stage approach:
>>> a. create a driver-agnostic multipath library, very heavily based on NVMe
>>> host multipath support.
>>> The library would support features such as path management, path
>>> selection/iopolicy, failover recovery, PR, delayed removal, gendisk
>>> management etc.
>>> b. switch NVMe over to use this library
>>
>> I can appreciate that the kernel to userspace interface of DM
>> multipath is clearly unwanted (hence NVMe multipath and now SCSI
>> multipath).
>>
>> But you should really be switching DM-multipath over to using it too;
>> or at least detailing _why_ the core of DM multipath
>> (drivers/md/dm-mpath.c) cannot be updated to use this common backend
>> library.
>>
>> This line of work makes little sense to me if it just ignores
>> dm-multipath.
>>
>> Mike
> 
> Thinking about this work from a DM multipath perspective, I'm more
> interested in how much it plans to handle the more annoying niche cases
> of dealing with SCSI devices, like paths that confidently report that
> they are able to accept IO, only to fail all IO sent to them. Also, I
> wonder how/if this is planning on handling Persistent Reservations. The
> arrays, I assume, are still going to see this as a collection of I_T
> Nexuses (some of which may be down and unable to accept commands at any
> given time, and to which new ones my be added) instead of a single one.
> 
> I also think this would be useful to talk about at LSF.
> 
And that even makes me wonder whether we should have a discussion about
persistent reservations at LSF, too.
I seem to be involved in discussions about PRs from various angles now
(live migration seems to want to join the fray), so maybe we could get
together to discuss things.

And I _still_ want to have a blktests for persistent reservations ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

