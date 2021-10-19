Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32320C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 15:09:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE6456115A
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 15:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EE6456115A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uEBftk0oRKLTsPD4o29+UUhqfAipcIzYmD3XlqMyuNM=; b=yEVEOvPIQCkHg+ljbXFdq98/Tm
	wrvN4163S7Ova/n4bnNs1MQ98AZ5aB0wK/ZxPFMpgAwfwOO8i9oio4yXyzdUnLoMf2lBAUKWL+mpy
	QbNMgoH3zCw3PXywjyUBKiuRAIa+3EvVwrNK8ARHbl5bmY4O+SMHIj9V4S7/fAPm736nHJvNT8PcO
	KTvDVfYmLyBkn5/bRYMZn6J0s225zxZEBXKQl8zHOqBH8gTQGG+nf/N2DT7ydzaks4tRt7I8rb+Pm
	b7MTIIKy8O4rVFaElAajGxm+gmb0FGH61uec74DlIDSAXGm2SntDns+DfyEeaYMgNVzbz/kDo3I0k
	ANuNsJXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcqkP-001e3U-6j; Tue, 19 Oct 2021 15:09:49 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcqkL-001e1w-Tr
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 15:09:47 +0000
Received: by mail-wm1-f44.google.com with SMTP id g39so8155861wmp.3
 for <linux-nvme@lists.infradead.org>; Tue, 19 Oct 2021 08:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uEBftk0oRKLTsPD4o29+UUhqfAipcIzYmD3XlqMyuNM=;
 b=C7aRMDlpVxbNBPpZo2breIVYCpGPaOV5buSJ2TxS9idnTvZoGrIp9hbNIO2Pjk/SH3
 jj1jRPhAWx0+sUpvAMM3vfdLXUBHNEqs3uZKI5hY6XAiSmyams3lMzPoqjrcUR5XVt3g
 q/wH+kYBrfnyoQ4cJ/3BoGa7BPo0bZJkZoqPg6mBfMWAtek3rW745D6cQig/jO0o63db
 3EVHdSZCakfySXRNXxv9r0MCBqUX/OiPWI9AJcyn9+rG/k7Vw+GRpOdE1NPu2ySm2yQE
 Aa1jdVw2exnk99FnN7ZT8jn6vzbDfe61xeIuiKQ1vJhgCgsSTjifC3bUz7nM9bWPe8ro
 A0SA==
X-Gm-Message-State: AOAM5304uEnJALipfoN3X0I1ckbjdI8oKGWzWaPPYvqjS+KrdgBCSf2k
 6CggFa1ua3FQlAiQlqOhmds=
X-Google-Smtp-Source: ABdhPJyP5cSxQ7vg2g1RmP/GDtIaVJ/rpk4+nJP2grtUBBAE5J5eo6/Lww478qRtXgaN/mPXWqXFwA==
X-Received: by 2002:a5d:6892:: with SMTP id h18mr44179963wru.177.1634656183861; 
 Tue, 19 Oct 2021 08:09:43 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id c17sm15715004wrq.4.2021.10.19.08.09.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Oct 2021 08:09:43 -0700 (PDT)
Subject: Re: Deadlock on failure to read NVMe namespace
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>
References: <87df4b26-19e7-6cc5-e973-23b6e98f4e19@suse.de>
 <e13114d1-b204-b89a-12bc-53ae049dfaa7@grimberg.me>
 <ce39fdb3-d60f-4e62-f70d-c433145dc68f@suse.de>
 <f5a43c7e-608b-5191-dd73-11c6c8dc1953@grimberg.me>
 <ed1d5970-60a8-88bb-c0d7-0c3e8eafbf7c@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8ecb32d7-7388-3758-4067-e93e733436e9@grimberg.me>
Date: Tue, 19 Oct 2021 18:09:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ed1d5970-60a8-88bb-c0d7-0c3e8eafbf7c@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_080945_990518_5B401F31 
X-CRM114-Status: GOOD (  32.08  )
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



On 10/19/21 6:04 PM, Hannes Reinecke wrote:
> On 10/19/21 4:27 PM, Sagi Grimberg wrote:
>>
>>>>> 481:~ # cat /proc/15761/stack
>>>>> [<0>] nvme_mpath_clear_ctrl_paths+0x25/0x80 [nvme_core]
>>>>> [<0>] nvme_remove_namespaces+0x31/0xf0 [nvme_core]
>>>>> [<0>] nvme_do_delete_ctrl+0x4b/0x80 [nvme_core]
>>>>> [<0>] nvme_sysfs_delete+0x42/0x60 [nvme_core]
>>>>> [<0>] kernfs_fop_write_iter+0x12f/0x1a0
>>>>> [<0>] new_sync_write+0x122/0x1b0
>>>>> [<0>] vfs_write+0x1eb/0x250
>>>>> [<0>] ksys_write+0xa1/0xe0
>>>>> [<0>] do_syscall_64+0x3a/0x80
>>>>> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>>> c481:~ # cat /proc/14965/stack
>>>>> [<0>] do_read_cache_page+0x49b/0x790
>>>>> [<0>] read_part_sector+0x39/0xe0
>>>>> [<0>] read_lba+0xf9/0x1d0
>>>>> [<0>] efi_partition+0xf1/0x7f0
>>>>> [<0>] bdev_disk_changed+0x1ee/0x550
>>>>> [<0>] blkdev_get_whole+0x81/0x90
>>>>> [<0>] blkdev_get_by_dev+0x128/0x2e0
>>>>> [<0>] device_add_disk+0x377/0x3c0
>>>>> [<0>] nvme_mpath_set_live+0x130/0x1b0 [nvme_core]
>>>>> [<0>] nvme_mpath_add_disk+0x150/0x160 [nvme_core]
>>>>> [<0>] nvme_alloc_ns+0x417/0x950 [nvme_core]
>>>>> [<0>] nvme_validate_or_alloc_ns+0xe9/0x1e0 [nvme_core]
>>>>> [<0>] nvme_scan_work+0x168/0x310 [nvme_core]
>>>>> [<0>] process_one_work+0x231/0x420
>>>>> [<0>] worker_thread+0x2d/0x3f0
>>>>> [<0>] kthread+0x11a/0x140
>>>>> [<0>] ret_from_fork+0x22/0x30
>>>>>
>>>>> My theory here is that the partition scanning code just calls into 
>>>>> the pagecache, which doesn't set a timeout for any I/O operation.
>>>>> As this is done under the scan_mutex we cannot clear the active 
>>>>> paths, and consequently we hang.
>>>>
>>>> But the controller removal should have cancelled all inflight
>>>> commands...
>>>>
>>>> Maybe we're missing unfreeze? Hannes, can you try this one?
>>>> -- 
>>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>>> index e29c47114739..783fde36d2ba 100644
>>>> --- a/drivers/nvme/host/tcp.c
>>>> +++ b/drivers/nvme/host/tcp.c
>>>> @@ -1974,8 +1974,11 @@ static void 
>>>> nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
>>>>          nvme_sync_io_queues(ctrl);
>>>>          nvme_tcp_stop_io_queues(ctrl);
>>>>          nvme_cancel_tagset(ctrl);
>>>> -       if (remove)
>>>> +       if (remove) {
>>>>                  nvme_start_queues(ctrl);
>>>> +               nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT);
>>>> +               nvme_unfreeze(ctrl);
>>>> +       }
>>>>          nvme_tcp_destroy_io_queues(ctrl, remove);
>>>>   }
>>>> -- 
>>> Nope. Same problem.
>>>
>>> I managed to make the problem go away (for some definitions of 'go 
>>> away') with this patch:
>>>
>>> diff --git a/drivers/nvme/host/multipath.c 
>>> b/drivers/nvme/host/multipath.c
>>> index fb96e900dd3a..30d1154eb611 100644
>>> --- a/drivers/nvme/host/multipath.c
>>> +++ b/drivers/nvme/host/multipath.c
>>> @@ -141,12 +141,12 @@ void nvme_mpath_clear_ctrl_paths(struct 
>>> nvme_ctrl *ctrl)
>>>   {
>>>          struct nvme_ns *ns;
>>>
>>> -       mutex_lock(&ctrl->scan_lock);
>>>          down_read(&ctrl->namespaces_rwsem);
>>>          list_for_each_entry(ns, &ctrl->namespaces, list)
>>>                  if (nvme_mpath_clear_current_path(ns))
>>>                          kblockd_schedule_work(&ns->head->requeue_work);
>>>          up_read(&ctrl->namespaces_rwsem);
>>> +       mutex_lock(&ctrl->scan_lock);
>>>          mutex_unlock(&ctrl->scan_lock);
>>>   }
>>>
>>> But I'd be the first to agree that this really is hackish.
>>
>> Yea, that doesn't solve anything.
>>
>> I think this sequence is familiar and was addressed by a fix from Anton
>> (CC'd) which still has some pending review comments.
>>
>> Can you lookup and try:
>> [PATCH] nvme/mpath: fix hang when disk goes live over reconnect
> 
> I actually had looked at it, but then decided it's (trying) to address a 
> different issue.
> 
> Thing is, I'll see it being stuck even _before_ disconnect happens; 
> we're stuck with the _initial_ scan:
> 
> [ 3920.880552]  device_add_disk+0x377/0x3c0
> [ 3920.880558]  nvme_mpath_set_live+0x130/0x1b0 [nvme_core]
> [ 3920.880574]  nvme_mpath_add_disk+0x150/0x160 [nvme_core]
> [ 3920.880588]  ? device_add_disk+0x27d/0x3c0
> [ 3920.880593]  nvme_alloc_ns+0x417/0x950 [nvme_core]
> [ 3920.880606]  nvme_validate_or_alloc_ns+0xe9/0x1e0 [nvme_core]
> [ 3920.880618]  ? __nvme_submit_sync_cmd+0x19b/0x210 [nvme_core]
> [ 3920.880631]  nvme_scan_work+0x168/0x310 [nvme_core]
> 
> and can't make progress as the I/O is _NOT_ failed, but rather causing a 
> reconnect:
> [ 1364.442390] nvme nvme0: request 0x0 genctr mismatch (got 0x0 expected 
> 0x2)
> [ 1364.442408] nvme nvme0: got bad c2hdata.command_id 0x0 on queue 2
> [ 1364.442411] nvme nvme0: receive failed:  -2
> [ 1364.442414] nvme nvme0: starting error recovery
> [ 1364.442502] block nvme0n1: no usable path - requeuing I/O
> 
> so we don't have an usable path, and will requeue I/O.
> But upon reconnect we will retry _the same_ I/O, and get into the same 
> state.
> 
> So the I/O will be stuck until disconnect happens.
> But disconnect does a
> nvme_do_dele te_ctrl()
> -> nvme_remove_namespaces()
>     -> nvme_mpath_clear_ctrl_paths()
>        -> mutex_lock(&scan_mutex)
> 
> and hangs.
> 
> Everything would be solved if we had _aborted_ the invalid I/O instead 
> of forcing a reconnect;

But you don't know which I/O to abort, you got a bad command_id.

  which, incidentally, is a far better way to
> handle TCP PDU sequence errors than the current way of dropping the 
> connection.

This is not a transport error, a digest error would be a transport
error, this is a controller logic error.

> Which would only help if it were a transport artifact, but 
> I've yet to see a fabric which eats individual bits of a frame;
> a programming error far more likely, in which case an I/O error would be 
> a far better response.

Again, which I/O?

