Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14888C2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 15:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=auMhl49kUJlkPmViL/fEdxszcdmZ+F+p81bEEt63B/8=; b=zfDqrBks3VViZYc2+Ef08wAJ6T
	hLo1mVJTYEvFAmlGb1z7vGHj3UViIO4/uPHTEnnTSmc9PPzCaWOOGO7KIIdXve6LGtAdCSfGEhvys
	mmB8P6NZDfFG09BCiDCcp/vsSLXoyE5MxJhY8aB4UappdmvwNLTiZvr2g85owrU3go6EEsD3rwwnr
	6688CTL06SReSHyzUuN11Yyf5lt2KIKukRGw/HGJ/N8Ta0s8xCcLS3WD5FFtYi/Ygc4MIuiHadbO8
	Mt5sllt9aWO6nq9kraAVmDtDGQvxs0ktRIEHp6njtpvh+xWgHZHOmXDemHI8uvFgyFHb0BL8yZqdM
	QyrNxgRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP2Fw-0000000AkZZ-3z0w;
	Wed, 03 Jul 2024 15:50:52 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP2Fr-0000000AkYk-2zbw
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 15:50:51 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 05F2521BCA;
	Wed,  3 Jul 2024 15:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720021846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=auMhl49kUJlkPmViL/fEdxszcdmZ+F+p81bEEt63B/8=;
	b=lZHoz9efQAweiCC+Bu517as/UNNVYUYf0S1aq60QjRo4qHTAPFbYlUptjZZNdvWfBwGoRo
	oK5o0EfOjuOYdGDbsZxmgkKW9FsqFOiBLZPDpAdRkl3D5jye+7U4s34yv5KIwxmGofvydu
	XIFbx41kecE2ch0XN55yxmubG6whsZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720021846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=auMhl49kUJlkPmViL/fEdxszcdmZ+F+p81bEEt63B/8=;
	b=wJkA9FXtlID8JAdtNI2PEkELcR4eqwO0DZNUsKAB2pWmoSF2OAhtZvUkIOoASQQq4Q2WBO
	/ixMN2lWtHZJe2Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720021846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=auMhl49kUJlkPmViL/fEdxszcdmZ+F+p81bEEt63B/8=;
	b=lZHoz9efQAweiCC+Bu517as/UNNVYUYf0S1aq60QjRo4qHTAPFbYlUptjZZNdvWfBwGoRo
	oK5o0EfOjuOYdGDbsZxmgkKW9FsqFOiBLZPDpAdRkl3D5jye+7U4s34yv5KIwxmGofvydu
	XIFbx41kecE2ch0XN55yxmubG6whsZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720021846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=auMhl49kUJlkPmViL/fEdxszcdmZ+F+p81bEEt63B/8=;
	b=wJkA9FXtlID8JAdtNI2PEkELcR4eqwO0DZNUsKAB2pWmoSF2OAhtZvUkIOoASQQq4Q2WBO
	/ixMN2lWtHZJe2Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C267913974;
	Wed,  3 Jul 2024 15:50:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E4C0LVVzhWZEWAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 03 Jul 2024 15:50:45 +0000
Message-ID: <56ebc95e-8c9c-43cb-a849-a1bbdd4a98e6@suse.de>
Date: Wed, 3 Jul 2024 17:50:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] nvme-tcp: switch to 'cpu' affinity scope for unbound
 workqueues
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240703135021.34143-1-hare@kernel.org>
 <20240703135021.34143-5-hare@kernel.org>
 <1259766c-234e-4958-a16f-9de753a4a0b5@grimberg.me>
 <792eeb90-90ba-4750-ab22-622023967eeb@suse.de>
 <2b0dbd25-bfa5-4a0c-842b-50c27b0843a7@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <2b0dbd25-bfa5-4a0c-842b-50c27b0843a7@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_085048_082625_AF33294A 
X-CRM114-Status: GOOD (  24.55  )
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

On 7/3/24 17:09, Sagi Grimberg wrote:
> 
> 
> On 03/07/2024 18:01, Hannes Reinecke wrote:
>> On 7/3/24 16:22, Sagi Grimberg wrote:
>>>
>>>
>>> On 03/07/2024 16:50, Hannes Reinecke wrote:
>>>> We should switch to the 'cpu' affinity scope when using the 
>>>> 'wq_unbound'
>>>> parameter as this allows us to keep I/O locality and improve 
>>>> performance.
>>>
>>> Can you please describe more why this is better? locality between what?
>>>
>> Well; the default unbound scope is 'cache', which groups the cpu 
>> according to the cache hierarchy. I want the cpu locality of the 
>> workqueue items to be preserved as much as possible, so I switched
>> to 'cpu' here.
>>
>> I'll get some performance numbers.
>>
>>> While you mention in your cover letter "comments and reviews are 
>>> welcome"
>>> The change logs in your patches are not designed to assist your 
>>> reviewer.
>>
>> I spent the last few weeks trying to come up with a solution based on my
>> original submission, but in the end I gave up as I hadn't been able to
>> fix the original issue.
> 
> Well, the last submission was a discombobulated set of mostly unrelated 
> patches...
> What was it that did not work?
> 
>> This here is a different approach by massaging the 'wq_unbound' 
>> mechanism, which is not only easier but also has the big advantage that
>> it actually works :-)
>> So I did not include a changlog to the previous patchset as this is a 
>> pretty different approach.
>> Sorry if this is confusing.
> 
> It's just difficult to try and understand what each patch contributes, 
> and most of the time the patches
> are under-documented. I want to see the improvements added, but I also 
> want them to be properly reviewed.

Sure. So here are some performance number:
(One subsystem, two paths, 96 queues)
default:
4k seq read: bw=365MiB/s (383MB/s), 11.4MiB/s-20.5MiB/s 
(11.0MB/s-21.5MB/s), io=16.0GiB (17.2GB), run=24950-44907msec
4k rand read: bw=307MiB/s (322MB/s), 9830KiB/s-13.8MiB/s 
(10.1MB/s-14.5MB/s), io=16.0GiB (17.2GB), run=37081-53333msec
4k seq write: bw=550MiB/s (577MB/s), 17.2MiB/s-28.7MiB/s 
(18.0MB/s-30.1MB/s), io=16.0GiB (17.2GB), run=17859-29786msec
4k rand write: bw=453MiB/s (475MB/s), 14.2MiB/s-21.3MiB/s 
(14.8MB/s-22.3MB/s), io=16.0GiB (17.2GB), run=24066-36161msec

unbound:
4k seq read: bw=232MiB/s (243MB/s), 6145KiB/s-9249KiB/s 
(6293kB/s-9471kB/s), io=13.6GiB (14.6GB), run=56685-60074msec
4k rand read: bw=249MiB/s (261MB/s), 6335KiB/s-9713KiB/s 
(6487kB/s-9946kB/s), io=14.6GiB (15.7GB), run=53976-60019msec
4k seq write: bw=358MiB/s (375MB/s), 11.2MiB/s-13.5MiB/s 
(11.7MB/s-14.2MB/s), io=16.0GiB (17.2GB), run=37918-45779msec
4k rand write: bw=335MiB/s (351MB/s), 10.5MiB/s-14.7MiB/s 
(10.0MB/s-15.4MB/s), io=16.0GiB (17.2GB), run=34929-48971msec

unbound + 'cpu' affinity:
4k seq read: bw=249MiB/s (261MB/s), 6003KiB/s-13.6MiB/s 
(6147kB/s-14.3MB/s), io=14.6GiB (15.7GB), run=37636-60065msec
4k rand read: bw=305MiB/s (320MB/s), 9773KiB/s-13.9MiB/s 
(10.0MB/s-14.6MB/s), io=16.0GiB (17.2GB), run=36791-53644msec
4k seq write: bw=499MiB/s (523MB/s), 15.6MiB/s-18.0MiB/s 
(16.3MB/s-19.9MB/s), io=16.0GiB (17.2GB), run=27018-32860msec
4k rand write: bw=536MiB/s (562MB/s), 16.7MiB/s-21.1MiB/s 
(17.6MB/s-22.1MB/s), io=16.0GiB (17.2GB), run=24305-30588msec

As you can see, with unbound and 'cpu' affinity we are basically on par
with the default implementations (all tests are run with per-controller
workqueues, mind).
Running the same workload with 4 subsystems and 8 paths will run into
I/O timeouts for the default implementation, but perfectly succeed with
unbound and 'cpu' affinity.
So definitely an improvement there.

I'll see to dig out performance numbers for the current implementations.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


