Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00DCEED60A
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 14:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ACR6rrLUWphR7t1B63Yh3MfzSYDxZJ0oLg9pI0Q1pZY=; b=aZYxbrLaH6ibWEM6dme/8IcHX4
	M+Q4m89Y/myOReMiNGecXqNQWmMFqDu1HKCtzeySHDyD7aRRrQJn8k8YZqFFeDygzHo2joWlKWzYB
	TM1qhu0YezNS+cSXoi/nifyPBZ57auzqZgL7jxy/6TFtVMQq6CtH1Z1nOhq2hJumdj7TcDiUY6KPv
	8NpqQlVcNU4uu1Z35PmeClm6dkQoLpyxmwFp+/0ooEkWWqvefkAern/JcVW/DqZcb1MrL3rTODuTz
	Tk9xQ6kyUKFRCTKeKr0oSRwHqc4Q8W+2NXm153fR1qhpFrgsRJFyIE3wViYStYT9qbygM2Fghy4y/
	PVghAQXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soks9-0000000DMZ6-1Ehg;
	Thu, 12 Sep 2024 14:32:37 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sokpj-0000000DM36-2et6
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 14:30:10 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A5AC521B09;
	Thu, 12 Sep 2024 14:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726151403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACR6rrLUWphR7t1B63Yh3MfzSYDxZJ0oLg9pI0Q1pZY=;
	b=1mhtAXFsvaEj9g2jk7KJxSRrrwTfsmhv6q9IoQvQMyQDNdfM3hYWbTdVxQ/tHeBI/D/Zlb
	BIRaeVj6APB9+psBFWMtgjc3KkOvxYhuWFSWo2jJY0HsSECURPXSktEGU2/UBn6/nDUnzD
	pvCrt7men5B4HNesRilMufQWlSf4vSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726151403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACR6rrLUWphR7t1B63Yh3MfzSYDxZJ0oLg9pI0Q1pZY=;
	b=FmNVRJLT5hsVI0cRwm5iytHv6W/RnbqO1lXDc1UCdbfzcY6hEhHvLv/ZxHQ4rk264ZROue
	sbm+UiPtJP4j5TCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1mhtAXFs;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FmNVRJLT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726151403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACR6rrLUWphR7t1B63Yh3MfzSYDxZJ0oLg9pI0Q1pZY=;
	b=1mhtAXFsvaEj9g2jk7KJxSRrrwTfsmhv6q9IoQvQMyQDNdfM3hYWbTdVxQ/tHeBI/D/Zlb
	BIRaeVj6APB9+psBFWMtgjc3KkOvxYhuWFSWo2jJY0HsSECURPXSktEGU2/UBn6/nDUnzD
	pvCrt7men5B4HNesRilMufQWlSf4vSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726151403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACR6rrLUWphR7t1B63Yh3MfzSYDxZJ0oLg9pI0Q1pZY=;
	b=FmNVRJLT5hsVI0cRwm5iytHv6W/RnbqO1lXDc1UCdbfzcY6hEhHvLv/ZxHQ4rk264ZROue
	sbm+UiPtJP4j5TCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9330B13AD8;
	Thu, 12 Sep 2024 14:30:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id djFBI+v64mZmBQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 12 Sep 2024 14:30:03 +0000
Message-ID: <9ac5f07d-4b43-4a62-a117-a02392e92a19@suse.de>
Date: Thu, 12 Sep 2024 16:30:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-multipath: stuck partition scan on inaccessible
 paths
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240911124610.81615-1-hare@kernel.org>
 <20240911124610.81615-4-hare@kernel.org>
 <2193b894-2999-4450-a221-19045c2b3e53@grimberg.me>
 <0acc13ea-50d9-4975-8859-dded066527e3@suse.de>
 <40050af2-f056-4e4e-b1ea-d3bf6c7bc13a@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <40050af2-f056-4e4e-b1ea-d3bf6c7bc13a@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A5AC521B09
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_073007_858237_268E49F9 
X-CRM114-Status: GOOD (  26.85  )
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

On 9/12/24 12:29, Sagi Grimberg wrote:
> 
> 
> 
> On 11/09/2024 19:10, Hannes Reinecke wrote:
>> On 9/11/24 17:20, Sagi Grimberg wrote:
>>>
>>>
>>>
>>> On 11/09/2024 15:46, Hannes Reinecke wrote:
>>>> When a path is switched to 'inaccessible' during partition scan
>>>> triggered via device_add_disk() and we only have one path the
>>>> system will be stuck as nvme_available_path() will always return
>>>> 'true'. So I/O will never be completed and the system is stuck
>>>> in device_add_disk():
>>>>
>>>>      [<0>] folio_wait_bit_common+0x12a/0x310
>>>>      [<0>] filemap_read_folio+0x97/0xd0
>>>>      [<0>] do_read_cache_folio+0x108/0x390
>>>>      [<0>] read_part_sector+0x31/0xa0
>>>>      [<0>] read_lba+0xc5/0x160
>>>>      [<0>] efi_partition+0xd9/0x8f0
>>>>      [<0>] bdev_disk_changed+0x23d/0x6d0
>>>>      [<0>] blkdev_get_whole+0x78/0xc0
>>>>      [<0>] bdev_open+0x2c6/0x3b0
>>>>      [<0>] bdev_file_open_by_dev+0xcb/0x120
>>>>      [<0>] disk_scan_partitions+0x5d/0x100
>>>>      [<0>] device_add_disk+0x402/0x420
>>>>      [<0>] nvme_mpath_set_live+0x4f/0x1f0 [nvme_core]
>>>>      [<0>] nvme_mpath_add_disk+0x107/0x120 [nvme_core]
>>>>      [<0>] nvme_alloc_ns+0xac6/0xe60 [nvme_core]
>>>>      [<0>] nvme_scan_ns+0x2dd/0x3e0 [nvme_core]
>>>>      [<0>] nvme_scan_work+0x1a3/0x490 [nvme_core]
>>>>
>>>> This patch introduces a flag NVME_NSHEAD_FAIL_ON_LAST_PATH to
>>>> cause nvme_available_path() to always return NULL, and with
>>>> that I/O to be failed if the last path is unavailable. But
>>>> we also need to requeue all pending I/Os whenever we have
>>>> changed the ANA state as now even inaccessible ANA states
>>>> influence I/O behaviour.
>>>>
>>>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>>>> ---
>>>>   drivers/nvme/host/multipath.c | 15 +++++++++++++++
>>>>   drivers/nvme/host/nvme.h      |  1 +
>>>>   2 files changed, 16 insertions(+)
>>>>
>>>> diff --git a/drivers/nvme/host/multipath.c 
>>>> b/drivers/nvme/host/multipath.c
>>>> index f72c5a6a2d8e..0373b4043eea 100644
>>>> --- a/drivers/nvme/host/multipath.c
>>>> +++ b/drivers/nvme/host/multipath.c
>>>> @@ -422,6 +422,10 @@ static bool nvme_available_path(struct 
>>>> nvme_ns_head *head)
>>>>       struct nvme_ns *ns;
>>>>       if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
>>>> +        return NULL;
>>>> +
>>>> +    if (test_bit(NVME_NSHEAD_FAIL_ON_LAST_PATH, &head->flags) &&
>>>> +        list_is_singular(&head->list))
>>>>           return NULL;
>>>
>>> This is wrong too Hannes.
>>>
>>> If you added a live path, and when partition scan triggers your path 
>>> becomes
>>> inaccessible, but then after anatt it becomes optimized again. You 
>>> just ended up without discovering partitions...
>>
>> But we will be getting an ANA state change AEN in that case, seeing 
>> that we have enabled ANA state change events and the spec states that 
>> we should be getting them (NVMe 1.3, section 8.21.4 Host ANA 
>> Transition Operation explicitly has an 'or' between point a) and b) ...).
> 
> That is too late, you already failed the IO...
> 
Which wouldn't matter if we were able to properly rescan the namespace
once we get an ANA event. But device_add_disk() completely ignores I/O
errors, so no chance there ...

>> Which is what we rely upon anyway, otherwise we would have had to 
>> check for INACCESSIBLE in nvme_update_ana_state, and not just for 
>> CHANGE as we do now.
> 
> I am referring to the fact that you fail the io and not simply queueing 
> it for future requeue.
> 
Yes.

>> Plus the situation will be exactly the same if one uses 'persistent 
>> loss' instead of 'inaccessible'...
> 
> That is a side point, that needs to be addressed separately.
> 
Not sure if I agree, but anyway...

>>
>> And incidentally, the same issue happens when you disable the 
>> namespace in nvmet just after the namespace got scanned, but before 
>> device_add_disk() is called. So really it's not about ANA, but rather 
>> about any path-related error here.
> 
> Right, which is transient semantically. You are making a decision here 
> to FAIL the IO, and it needs a strong justification. We can
> just sporadically fail IO...
> 
> The way that I see it, for as long as there is a possibility for an IO 
> to be executed in the future (i.e. a path exists) we queue up
> the IO. IMO if you want to fail it before, fast_io_fail_tmo is designed 
> to address it.

So we'd need a timer (or modifying to ANATT timer) to terminate all 
pending I/O on inaccessible paths, and requeue/keep it until then.
Okay, let's see how this pans out.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


