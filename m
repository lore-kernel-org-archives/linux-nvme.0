Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8C1C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 14:27:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A85261029
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 14:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7A85261029
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EiEOLauSUhJz8JH3bNlkArNu3L0Doct5Tnh79ep2Bnc=; b=qXfslurPPEQarnKhqYXXw1wkTf
	f4eJRGQgn2vStkuF891ITxEFU3lbK9NjlaOzDGCkvS/NILydxdkR7+fkjCi3PmyK/UvyTCAnmvHOR
	mhH1Mv6zODqjBugFGwYpTiqPqdGVoIarZjv5tnN3bJ+qc7PnuBNZbfCxM9GIOcneoxTHKHtNGnEUe
	ckzsvFbFhZ4ZBXyv5CVFsA1WZ/4Dfs9YoCke4YYOaiw0AsR03gawfYAcY/IN8kT7hPAV3tzr5fonw
	39dc5utqRE+5JeXP9YkuzkhsffuoMcXR4zqM0elm0VuADC4ChRKPgFpTNMz40BEr+ZL2PDNtrqgHi
	iiTdAHZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcq55-001X7R-Uk; Tue, 19 Oct 2021 14:27:07 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcq53-001X6m-Q4
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 14:27:07 +0000
Received: by mail-wr1-f51.google.com with SMTP id y3so48270101wrl.1
 for <linux-nvme@lists.infradead.org>; Tue, 19 Oct 2021 07:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EiEOLauSUhJz8JH3bNlkArNu3L0Doct5Tnh79ep2Bnc=;
 b=qA/OKKbDslZk3A/2hzqT+x53as+GtvE16smqOrXccgIdyTbnvrK430vlnKQWZUejc4
 lwonwEUt2Aae+49r6CAJmICZET5ebmSF02zzPGohRhN6hPytKUsnWvd3YQsvXQETveon
 QoWNxaZbriA6ZuSXQh/58GjFWzi4URJx0DkjrG36NSSHlSpnyxQvQyKNNtHlStOImokQ
 o3oRbrSpaEh7pgtgdfbd52cuUKXudnE4ihbKewws9w7noKQ4QM6thKyt3pgJ1L/VRP4i
 7WKQl+PwciIivU0K5Gtc8XVUP2iLdLUQnEsjt8uC6WlJNkdqUiDSTfh6dMemRRv1iUvR
 kmzQ==
X-Gm-Message-State: AOAM531iwxeSY1El+IRy64BJ40J0fRbT26iDcrTrPQ1nprJOJKB+uRg+
 GQtzSNmZ4A/GbKQ4rO+Nj8vCidQQXec=
X-Google-Smtp-Source: ABdhPJx48y0EHg2/ThSjqbyldVt1mn6byLaKsOdjAA8dqsmkJm8JsOJcqoqRmlFVrX6e3QVs56f4cw==
X-Received: by 2002:adf:9b97:: with SMTP id d23mr43068081wrc.53.1634653623798; 
 Tue, 19 Oct 2021 07:27:03 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id g19sm2199952wmg.1.2021.10.19.07.27.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Oct 2021 07:27:03 -0700 (PDT)
Subject: Re: Deadlock on failure to read NVMe namespace
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>
References: <87df4b26-19e7-6cc5-e973-23b6e98f4e19@suse.de>
 <e13114d1-b204-b89a-12bc-53ae049dfaa7@grimberg.me>
 <ce39fdb3-d60f-4e62-f70d-c433145dc68f@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f5a43c7e-608b-5191-dd73-11c6c8dc1953@grimberg.me>
Date: Tue, 19 Oct 2021 17:27:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ce39fdb3-d60f-4e62-f70d-c433145dc68f@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_072705_870685_2664E9F3 
X-CRM114-Status: GOOD (  23.70  )
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


>>> 481:~ # cat /proc/15761/stack
>>> [<0>] nvme_mpath_clear_ctrl_paths+0x25/0x80 [nvme_core]
>>> [<0>] nvme_remove_namespaces+0x31/0xf0 [nvme_core]
>>> [<0>] nvme_do_delete_ctrl+0x4b/0x80 [nvme_core]
>>> [<0>] nvme_sysfs_delete+0x42/0x60 [nvme_core]
>>> [<0>] kernfs_fop_write_iter+0x12f/0x1a0
>>> [<0>] new_sync_write+0x122/0x1b0
>>> [<0>] vfs_write+0x1eb/0x250
>>> [<0>] ksys_write+0xa1/0xe0
>>> [<0>] do_syscall_64+0x3a/0x80
>>> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>>> c481:~ # cat /proc/14965/stack
>>> [<0>] do_read_cache_page+0x49b/0x790
>>> [<0>] read_part_sector+0x39/0xe0
>>> [<0>] read_lba+0xf9/0x1d0
>>> [<0>] efi_partition+0xf1/0x7f0
>>> [<0>] bdev_disk_changed+0x1ee/0x550
>>> [<0>] blkdev_get_whole+0x81/0x90
>>> [<0>] blkdev_get_by_dev+0x128/0x2e0
>>> [<0>] device_add_disk+0x377/0x3c0
>>> [<0>] nvme_mpath_set_live+0x130/0x1b0 [nvme_core]
>>> [<0>] nvme_mpath_add_disk+0x150/0x160 [nvme_core]
>>> [<0>] nvme_alloc_ns+0x417/0x950 [nvme_core]
>>> [<0>] nvme_validate_or_alloc_ns+0xe9/0x1e0 [nvme_core]
>>> [<0>] nvme_scan_work+0x168/0x310 [nvme_core]
>>> [<0>] process_one_work+0x231/0x420
>>> [<0>] worker_thread+0x2d/0x3f0
>>> [<0>] kthread+0x11a/0x140
>>> [<0>] ret_from_fork+0x22/0x30
>>>
>>> My theory here is that the partition scanning code just calls into 
>>> the pagecache, which doesn't set a timeout for any I/O operation.
>>> As this is done under the scan_mutex we cannot clear the active 
>>> paths, and consequently we hang.
>>
>> But the controller removal should have cancelled all inflight
>> commands...
>>
>> Maybe we're missing unfreeze? Hannes, can you try this one?
>> -- 
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index e29c47114739..783fde36d2ba 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -1974,8 +1974,11 @@ static void nvme_tcp_teardown_io_queues(struct 
>> nvme_ctrl *ctrl,
>>          nvme_sync_io_queues(ctrl);
>>          nvme_tcp_stop_io_queues(ctrl);
>>          nvme_cancel_tagset(ctrl);
>> -       if (remove)
>> +       if (remove) {
>>                  nvme_start_queues(ctrl);
>> +               nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT);
>> +               nvme_unfreeze(ctrl);
>> +       }
>>          nvme_tcp_destroy_io_queues(ctrl, remove);
>>   }
>> -- 
> Nope. Same problem.
> 
> I managed to make the problem go away (for some definitions of 'go 
> away') with this patch:
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index fb96e900dd3a..30d1154eb611 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -141,12 +141,12 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl 
> *ctrl)
>   {
>          struct nvme_ns *ns;
> 
> -       mutex_lock(&ctrl->scan_lock);
>          down_read(&ctrl->namespaces_rwsem);
>          list_for_each_entry(ns, &ctrl->namespaces, list)
>                  if (nvme_mpath_clear_current_path(ns))
>                          kblockd_schedule_work(&ns->head->requeue_work);
>          up_read(&ctrl->namespaces_rwsem);
> +       mutex_lock(&ctrl->scan_lock);
>          mutex_unlock(&ctrl->scan_lock);
>   }
> 
> But I'd be the first to agree that this really is hackish.

Yea, that doesn't solve anything.

I think this sequence is familiar and was addressed by a fix from Anton
(CC'd) which still has some pending review comments.

Can you lookup and try:
[PATCH] nvme/mpath: fix hang when disk goes live over reconnect

