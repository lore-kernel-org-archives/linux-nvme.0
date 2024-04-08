Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C504CD1292
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 22:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FThSj/lEvXD+TrD7yhH/zHtMElQLT185LsQ0CfCCW90=; b=QGiO+XESufZty0HZVmdh/43XF6
	crZrY/oElWzP3Hwka7F5Vc5gxkT5B+8Ig/fnDU9ZnesRYuQBTR/eUBtBZo/a+mFjGPh21JJhXBhps
	0vwWY5m7Jk0Jb33rduRaWLc9385+YtTmgw8YWuJvLOAz7SvFeCal6uNGfPUGwmKIcCuVQNad9xJVq
	k/o8zX9kZ22e8algXzsXICW8kxpC0Tb0mjr8Y4c8QB4TkOpVTbvqUy5AcnkBUcYxFHWS+yGW73g3o
	GlrNapBAFsvaZNYt/vrnCa4V0nvn+/jOdGizfF75CG+zFV2F4va+SYJvJekp5ogRuScdRkSpzvWTA
	+FP0EWsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtxAv-0000000Gywh-2zhk;
	Mon, 08 Apr 2024 22:09:13 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtxAc-0000000Gyt8-1nrJ
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 22:09:00 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0B82B22D83;
	Mon,  8 Apr 2024 22:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712614132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FThSj/lEvXD+TrD7yhH/zHtMElQLT185LsQ0CfCCW90=;
	b=QeyVVhwFm+rG6chVGTTrVhkCHcJCJIlSqBNnSK9Zyi8zQpR/3pf/pB34xyRtRoCCf1Olnj
	531meW8X27qeF7Ccn04cEpXmuqd+vK6B9jWG9qshr+DAbEihbr2l2h/0Hcnmi4nsHinB9y
	IW9ZOWTCwjTRvNZpiOzps3RufrCtxxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712614132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FThSj/lEvXD+TrD7yhH/zHtMElQLT185LsQ0CfCCW90=;
	b=gEeVUANo9FPkTTB9IEHwm+8xnH099leSMkZP1hZ9PTqi187jciTPUfBzfCpBFYe3iFSSPs
	tYkmUlOv2sqyOwAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712614131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FThSj/lEvXD+TrD7yhH/zHtMElQLT185LsQ0CfCCW90=;
	b=GKZvKDcM6hSgRljOW2KksHAUIfTuScVXU0zCxSKk/aviqsWQN+FuwJx936xWae2slYn6b0
	u2E0itakZ5x7IRIrJ2E/h0fErzzi/Zeo1gyt9BMsytlVqza12YI/ZOqffyzjHSjVsEyXOB
	WHUkqfsfjMZ4j8yOBpW4BRauKFEm8EI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712614131;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FThSj/lEvXD+TrD7yhH/zHtMElQLT185LsQ0CfCCW90=;
	b=H1xM3257CpOtzeKZXH0hRbAbbKKEp2r/WGvCSvuXhq32v9u4oG1FqJicpwvwnjuzzX2dhf
	6gfWMD3Rer/7QGBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0AE2137D4;
	Mon,  8 Apr 2024 22:08:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iQ03MPJqFGZ1PQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 08 Apr 2024 22:08:50 +0000
Message-ID: <c4e7d9bc-aebe-4efc-bcde-11a481f76a6f@suse.de>
Date: Tue, 9 Apr 2024 00:08:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] nvme-fabrics: reset connection for secure
 concatenation
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-13-hare@kernel.org>
 <31c2c699-bff1-455d-a6ca-337724324150@grimberg.me>
 <a1395ee5-fbff-47ef-9400-56b8f3a0d1f5@suse.de>
 <ad9eb876-061b-4f85-9c6f-add1719b72c8@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ad9eb876-061b-4f85-9c6f-add1719b72c8@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_150854_666709_0C25EBD1 
X-CRM114-Status: GOOD (  33.12  )
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

On 4/8/24 23:21, Sagi Grimberg wrote:
> 
> 
> On 08/04/2024 9:21, Hannes Reinecke wrote:
>> On 4/7/24 23:46, Sagi Grimberg wrote:
>>>
>>>
>>> On 18/03/2024 17:03, Hannes Reinecke wrote:
>>>> When secure concatenation is requested the connection needs to be
>>>> reset to enable TLS encryption on the new cnnection.
>>>> That implies that the original connection used for the DH-CHAP
>>>> negotiation really shouldn't be used, and we should reset as soon
>>>> as the DH-CHAP negotiation has succeeded on the admin queue.
>>>> The current implementation does not allow to easily skip
>>>> connection attempts on the I/O queues, so we connect I/O
>>>> queues, but disable namespace scanning on these queues.
>>>> With that no I/O can be issued on these queues, so we
>>>> can tear them down quickly without having to wait for
>>>> quiescing etc.
>>>
>>> We shouldn't have to connect io queues here. The scan prevention
>>> is just a hack...
>>>
>> Oh, believe me, I tried. What _should_ be possible is to create a
>> controller with just admin queues, and skip the io queue setup part.
>> But once you do that it's impossible to create io queues after reset
>> (which is what you'd need here).
>> I tried to fix this, but that ended up with a massive rewrite/reordering
>> of the init path. Which sure has its merits, but I deemed out of scope
>> for this patchset.
>>
>> So I decided for this 'hack', and shelved the init path reorg for a
>> later patchset.
> 
> Interesting that it requires a full rewrite. Can you share some info
> what particularly breaks when you change the nr_io_queues between
> resets? nr_io_queues can be changed across resets from the controller side
> as well.
> 
Just look at the 'new' parameter to nvme_tcp_configure_io_queues(),
and try to modify the code to _not_ required the parameter.
Key observation here is that the _size_ of the I/O tagset is actually
defined by the parameters for the connect command; we cannot grow
beyond that. Which means that we should be allocate the I/O tagset
right at the start, and only modify the number of queue which we _use_
based on the information we get back from the controller.
Currently the io tagset allocation is tied to the number of queues
for the controller, and trying to modify that is an even worse hack
than suppressing the namespace scan.

Anyway,it's quite a different patchset which is basically unrelated
to the secure concatenation work.

I do have a preliminary patchset for this if there's interest.

>>
>>>> Once that is done we can reset the controller directly
>>>> after the ->create_ctrl() callback.
>>>
>>> Why not set opts->nr_io_queues = 0 for secure concatenation and
>>> setting it to the original value before resetting?
>>
>> See above. The io tagset is allocated in the init path _only_.
> 
> ok. So? What is the issue here? is this because ns scanning is checking
> the existence of a ctrl->tagset? I predicted that this check will be 
> problematic to assume the ctrl state in the future.
> 
> We can add a controller flag for this.
> 
Problem is that namespace scanning will create block devices, which will
create uevent, which will cause udev to start scan for signatures etc.
At the same time we're resetting the queue, causing all sorts of race 
conditions and timing issues for the outstanding I/Os.
And all of that for namespaces which have a questionable existence
as they are only valid for _encrypted_ connections.

>> And creating of the io tagset is tied with connecting the io queues.
> 
> Where exactly?
> 
Check the 'new' parameter for nvme_configure_io_queues().
That is being called _only_ when we have more than 1 queue.
And is doing both, allocating the io tagset _and_ issue a 'connect' call
on each queue. We'd need to split that into allocating the io tagset
(which should happen always) and the 'connect' call (which should be
done for non-concat connection or concat connections with TLS enabled).

Cheers,

Hannes

>>
>> The reset code requires the tagset to be present; it just reconnects
>> the io queues.
> 
> it connects io_queues if ctrl->queue_count > 1
> 
and allocates the io tagset ...

>> So either you do some trickery here like skipping connecting io queues
>> (or, indeed, skipping namespace scanning),
>> or you end up with a massive reshuffling of the init code path trying
>> to separate tagset creation from io queue connections.
> 
> Hmm, I'm not exactly sure what separation exactly is required here.

The tagset will always need to be allocated, but the 'connect' command 
should be skipped for non-TLS enabled secure concat connections.

Cheers,

Hannes


