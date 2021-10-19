Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2775EC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 15:49:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD763610C7
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 15:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DD763610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sp9NZ8ku6YEKNz01nmiXMScWMofqHh29uv4SSddmymI=; b=Vk+esbC+WZadK7GluACzh9/nVH
	rEFzewMBsLB+pzSyPv1k6V5NYTqZupnRKNDcHLtwGrHiJGZJtHlLl4b0crE1SU/eoibAZKlgL/8fB
	YMNgcDjgW7lcQd+a6EPvjBXWYto0aetX5qDDSmX7r7Rs9yqbEh1O6CswGIQFGlaHA1m14qIDsVH1L
	eRf29qa6MZJp66Jpcu3yp1s/GV/CxSn20SM72pfGHuTDo9Ow3xy1cFpbIEqPhIDaYWWjb3c7yAAa9
	K4hZywzlLWp1QECqAyXf5xGXvvXoFzSkI3NRlk/9/21ueEo0ivB/z7v336DsJ7X51zj75bZNOIdLv
	STkJGBHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcrMj-001keQ-NY; Tue, 19 Oct 2021 15:49:25 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcrMg-001kdU-Ed
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 15:49:24 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DF63F21981;
 Tue, 19 Oct 2021 15:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634658560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sp9NZ8ku6YEKNz01nmiXMScWMofqHh29uv4SSddmymI=;
 b=ODLQv8lliG+dDBTjgBuLbTBEnneavPkF8s9fQzcN//OaJdPnuWp5eOjlyFuq9J+w+ND1jy
 A/OF7G8OgQCCd/T4u6MRnS6gW2/OKHi8o1CwiI+ujfdPdfjNeJsBbJhekls5mz3rUtNA1D
 XemErCNS/bwuoA/gjYSnp3qWVX9xU7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634658560;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sp9NZ8ku6YEKNz01nmiXMScWMofqHh29uv4SSddmymI=;
 b=jNxtaX2E11WQgccC+4aaFXxwUyDkwLoz8xOXj/wwJT19j6adBG96wOZPBgOSi/qu27E7fY
 D5pyspMfa53tJdBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C012C13D36;
 Tue, 19 Oct 2021 15:49:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mW1JLgDpbmHaewAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 19 Oct 2021 15:49:20 +0000
Subject: Re: Deadlock on failure to read NVMe namespace
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>
References: <87df4b26-19e7-6cc5-e973-23b6e98f4e19@suse.de>
 <e13114d1-b204-b89a-12bc-53ae049dfaa7@grimberg.me>
 <ce39fdb3-d60f-4e62-f70d-c433145dc68f@suse.de>
 <f5a43c7e-608b-5191-dd73-11c6c8dc1953@grimberg.me>
 <ed1d5970-60a8-88bb-c0d7-0c3e8eafbf7c@suse.de>
 <8ecb32d7-7388-3758-4067-e93e733436e9@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d04de15f-9560-db43-f70b-2cf0598f7d97@suse.de>
Date: Tue, 19 Oct 2021 17:49:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <8ecb32d7-7388-3758-4067-e93e733436e9@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_084922_676434_1ABF1EAB 
X-CRM114-Status: GOOD (  25.04  )
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

On 10/19/21 5:09 PM, Sagi Grimberg wrote:
> 
> 
> On 10/19/21 6:04 PM, Hannes Reinecke wrote:
>> On 10/19/21 4:27 PM, Sagi Grimberg wrote:
>>>
>>>>>> 481:~ # cat /proc/15761/stack
>>>>>> [<0>] nvme_mpath_clear_ctrl_paths+0x25/0x80 [nvme_core]
>>>>>> [<0>] nvme_remove_namespaces+0x31/0xf0 [nvme_core]
>>>>>> [<0>] nvme_do_delete_ctrl+0x4b/0x80 [nvme_core]
>>>>>> [<0>] nvme_sysfs_delete+0x42/0x60 [nvme_core]
>>>>>> [<0>] kernfs_fop_write_iter+0x12f/0x1a0
>>>>>> [<0>] new_sync_write+0x122/0x1b0
>>>>>> [<0>] vfs_write+0x1eb/0x250
>>>>>> [<0>] ksys_write+0xa1/0xe0
>>>>>> [<0>] do_syscall_64+0x3a/0x80
>>>>>> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>>>> c481:~ # cat /proc/14965/stack
>>>>>> [<0>] do_read_cache_page+0x49b/0x790
>>>>>> [<0>] read_part_sector+0x39/0xe0
>>>>>> [<0>] read_lba+0xf9/0x1d0
>>>>>> [<0>] efi_partition+0xf1/0x7f0
>>>>>> [<0>] bdev_disk_changed+0x1ee/0x550
>>>>>> [<0>] blkdev_get_whole+0x81/0x90
>>>>>> [<0>] blkdev_get_by_dev+0x128/0x2e0
>>>>>> [<0>] device_add_disk+0x377/0x3c0
>>>>>> [<0>] nvme_mpath_set_live+0x130/0x1b0 [nvme_core]
>>>>>> [<0>] nvme_mpath_add_disk+0x150/0x160 [nvme_core]
>>>>>> [<0>] nvme_alloc_ns+0x417/0x950 [nvme_core]
>>>>>> [<0>] nvme_validate_or_alloc_ns+0xe9/0x1e0 [nvme_core]
>>>>>> [<0>] nvme_scan_work+0x168/0x310 [nvme_core]
>>>>>> [<0>] process_one_work+0x231/0x420
>>>>>> [<0>] worker_thread+0x2d/0x3f0
>>>>>> [<0>] kthread+0x11a/0x140
>>>>>> [<0>] ret_from_fork+0x22/0x30
>>>>>>
>>>>>> My theory here is that the partition scanning code just calls into 
>>>>>> the pagecache, which doesn't set a timeout for any I/O operation.
>>>>>> As this is done under the scan_mutex we cannot clear the active 
>>>>>> paths, and consequently we hang.
>>>>>
>>>>> But the controller removal should have cancelled all inflight
>>>>> commands...
>>>>>
>>>>> Maybe we're missing unfreeze? Hannes, can you try this one?
>>>>> -- 
>>>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>>>> index e29c47114739..783fde36d2ba 100644
>>>>> --- a/drivers/nvme/host/tcp.c
>>>>> +++ b/drivers/nvme/host/tcp.c
>>>>> @@ -1974,8 +1974,11 @@ static void 
>>>>> nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
>>>>>          nvme_sync_io_queues(ctrl);
>>>>>          nvme_tcp_stop_io_queues(ctrl);
>>>>>          nvme_cancel_tagset(ctrl);
>>>>> -       if (remove)
>>>>> +       if (remove) {
>>>>>                  nvme_start_queues(ctrl);
>>>>> +               nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT);
>>>>> +               nvme_unfreeze(ctrl);
>>>>> +       }
>>>>>          nvme_tcp_destroy_io_queues(ctrl, remove);
>>>>>   }
>>>>> -- 
>>>> Nope. Same problem.
>>>>
>>>> I managed to make the problem go away (for some definitions of 'go 
>>>> away') with this patch:
>>>>
>>>> diff --git a/drivers/nvme/host/multipath.c 
>>>> b/drivers/nvme/host/multipath.c
>>>> index fb96e900dd3a..30d1154eb611 100644
>>>> --- a/drivers/nvme/host/multipath.c
>>>> +++ b/drivers/nvme/host/multipath.c
>>>> @@ -141,12 +141,12 @@ void nvme_mpath_clear_ctrl_paths(struct 
>>>> nvme_ctrl *ctrl)
>>>>   {
>>>>          struct nvme_ns *ns;
>>>>
>>>> -       mutex_lock(&ctrl->scan_lock);
>>>>          down_read(&ctrl->namespaces_rwsem);
>>>>          list_for_each_entry(ns, &ctrl->namespaces, list)
>>>>                  if (nvme_mpath_clear_current_path(ns))
>>>>                          
>>>> kblockd_schedule_work(&ns->head->requeue_work);
>>>>          up_read(&ctrl->namespaces_rwsem);
>>>> +       mutex_lock(&ctrl->scan_lock);
>>>>          mutex_unlock(&ctrl->scan_lock);
>>>>   }
>>>>
>>>> But I'd be the first to agree that this really is hackish.
>>>
>>> Yea, that doesn't solve anything.
>>>
>>> I think this sequence is familiar and was addressed by a fix from Anton
>>> (CC'd) which still has some pending review comments.
>>>
>>> Can you lookup and try:
>>> [PATCH] nvme/mpath: fix hang when disk goes live over reconnect
>>
>> I actually had looked at it, but then decided it's (trying) to address 
>> a different issue.
>>
>> Thing is, I'll see it being stuck even _before_ disconnect happens; 
>> we're stuck with the _initial_ scan:
>>
>> [ 3920.880552]  device_add_disk+0x377/0x3c0
>> [ 3920.880558]  nvme_mpath_set_live+0x130/0x1b0 [nvme_core]
>> [ 3920.880574]  nvme_mpath_add_disk+0x150/0x160 [nvme_core]
>> [ 3920.880588]  ? device_add_disk+0x27d/0x3c0
>> [ 3920.880593]  nvme_alloc_ns+0x417/0x950 [nvme_core]
>> [ 3920.880606]  nvme_validate_or_alloc_ns+0xe9/0x1e0 [nvme_core]
>> [ 3920.880618]  ? __nvme_submit_sync_cmd+0x19b/0x210 [nvme_core]
>> [ 3920.880631]  nvme_scan_work+0x168/0x310 [nvme_core]
>>
>> and can't make progress as the I/O is _NOT_ failed, but rather causing 
>> a reconnect:
>> [ 1364.442390] nvme nvme0: request 0x0 genctr mismatch (got 0x0 
>> expected 0x2)
>> [ 1364.442408] nvme nvme0: got bad c2hdata.command_id 0x0 on queue 2
>> [ 1364.442411] nvme nvme0: receive failed:  -2
>> [ 1364.442414] nvme nvme0: starting error recovery
>> [ 1364.442502] block nvme0n1: no usable path - requeuing I/O
>>
>> so we don't have an usable path, and will requeue I/O.
>> But upon reconnect we will retry _the same_ I/O, and get into the same 
>> state.
>>
>> So the I/O will be stuck until disconnect happens.
>> But disconnect does a
>> nvme_do_dele te_ctrl()
>> -> nvme_remove_namespaces()
>>     -> nvme_mpath_clear_ctrl_paths()
>>        -> mutex_lock(&scan_mutex)
>>
>> and hangs.
>>
>> Everything would be solved if we had _aborted_ the invalid I/O instead 
>> of forcing a reconnect;
> 
> But you don't know which I/O to abort, you got a bad command_id.
> 

Yeah, you are right. I stand  corrected.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

