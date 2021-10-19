Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599B3C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 20:13:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19948611CB
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 20:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 19948611CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wadq51VmHxbv2fHge7K1uQq7+HSySvo2GfsE92qzAuU=; b=CfKmXJVvz/b218NdsSOEsquzaR
	TAuUehS9FUXN2nOwcrq6pOMRWABL2EmQKj/dG+hdrd7A933NdT9eVgXOeqZWVw4PNUKrtZTr9aJC5
	98K3R0fVzCUouKqqIxDTO2lzKB8R1BSXqX/1MfqRhn8laGcdp/iFt4+2DAL2/U0pGkxDcqiSPtBYL
	v2hnkyBHiSIDwp+bpYEf+HDo9V9qb3ZnOmw5zyFhbwzZRmhgZec6EOkViCKl5jIt2hzMImt/kkdwm
	BWxcnKvGSs4pJEGgiLsLQZzPg2+khHK53Xx70OFxKBEhtxgir4EYn6GpFSFCtg57wnHd9FTiYkWR6
	2qPtjY0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcvU7-002Ysw-MW; Tue, 19 Oct 2021 20:13:19 +0000
Received: from mail-ed1-f43.google.com ([209.85.208.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcvTy-002Ysc-V5
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 20:13:12 +0000
Received: by mail-ed1-f43.google.com with SMTP id t16so17432745eds.9
 for <linux-nvme@lists.infradead.org>; Tue, 19 Oct 2021 13:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wadq51VmHxbv2fHge7K1uQq7+HSySvo2GfsE92qzAuU=;
 b=FyByJbmdRDLB7L087A5mK69FZwaWYzNe/HIZx3zQtFX28WdHOkyNXyemQY+w3VjtQT
 KjDr54XBQRH8g0L7LUksdxsPeXCSKM0CfoOiZeiLMHA40Y4HgtXAafjfiYybkdNBAd3U
 qPqS3+lKRrvG8zIHtYPLBLN4rtWupNwkOVleMQuJPa6e/qNFc0v/6TZeNvhhYD7NCXaT
 X3FrFS1qQkNsDAtVeBuHDHNayAElS3V5yYNhmfk+qjaJDW5Rlz+Hb3QtcXa0kzSCqC9j
 cxaD96tvJdv9UaDHAAw88ltpbxqQx7HcyGUu0H/8FtZ7NYSXi16UmNsyZBP7gwwJoake
 93Gg==
X-Gm-Message-State: AOAM531jt46/nMqBEAm2in4H9MOBu9HisjpmS1J0eTJ/vIC/QzQ07OwQ
 jcy+FaNYXcKTqBz2FSkJ4qM=
X-Google-Smtp-Source: ABdhPJzF38fqRMTOQ6gF0gFExCJcB6321ryshl6G2IFrGHajTIhxIutLxjnOZ9I4eKOdWreb/9u5eg==
X-Received: by 2002:a50:d841:: with SMTP id v1mr55085210edj.221.1634674389143; 
 Tue, 19 Oct 2021 13:13:09 -0700 (PDT)
Received: from [10.100.102.14] (109-186-251-144.bb.netvision.net.il.
 [109.186.251.144])
 by smtp.gmail.com with ESMTPSA id b26sm8118595ejl.82.2021.10.19.13.13.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Oct 2021 13:13:08 -0700 (PDT)
Subject: Re: Deadlock on failure to read NVMe namespace
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>
References: <87df4b26-19e7-6cc5-e973-23b6e98f4e19@suse.de>
 <e13114d1-b204-b89a-12bc-53ae049dfaa7@grimberg.me>
 <ce39fdb3-d60f-4e62-f70d-c433145dc68f@suse.de>
 <f5a43c7e-608b-5191-dd73-11c6c8dc1953@grimberg.me>
 <8ff377bd-4d04-9fc7-66af-a48c7cdd7399@grimberg.me>
 <0ea3d998-5f8c-347f-c64e-86575135a6f2@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a53f1ce7-40f7-0f91-6cac-96f1b2093abc@grimberg.me>
Date: Tue, 19 Oct 2021 23:13:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <0ea3d998-5f8c-347f-c64e-86575135a6f2@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_131311_046869_70654906 
X-CRM114-Status: GOOD (  18.41  )
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
>>
>> ...
>>
>>> I think this sequence is familiar and was addressed by a fix from Anton
>>> (CC'd) which still has some pending review comments.
>>>
>>> Can you lookup and try:
>>> [PATCH] nvme/mpath: fix hang when disk goes live over reconnect
>>
>> Actually, I see the trace is going from nvme_alloc_ns, no the ANA
>> update path, so that is unlikely to address the issue.
>>
>> Looking at nvme_mpath_clear_ctrl_paths, I don't think it should
>> take the scan_lock anymore. IIRC the reason why it needed the
>> scan_lock in the first place was the fact that ctrl->namespaces
>> was added and then sorted in scan_work (taking the namespaces_rwsem
>> twice).
>>
>> But now that ctrl->namespaces is always sorted, and accessed with
>> namespaces_rwsem, I think that scan_lock is no longer needed
>> here and namespaces_rwsem is sufficient.
>>
> ... which was precisely what my initial patch did.
> While it worked in the sense the 'nvme disconnect' completed, we did not 
> terminate the outstanding I/O as no current path is set and hence this:
> 
>      down_read(&ctrl->namespaces_rwsem);
>      list_for_each_entry(ns, &ctrl->namespaces, list)
>          if (nvme_mpath_clear_current_path(ns))
>              kblockd_schedule_work(&ns->head->requeue_work);
>      up_read(&ctrl->namespaces_rwsem);
> 
> doesn't do anything, in particular does _not_ flush the requeue work.

So you get I/O hung? Why does it need to flush it?

