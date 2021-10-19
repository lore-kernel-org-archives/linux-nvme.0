Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E04C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 12:40:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4AF61212
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 12:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DF4AF61212
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WwHRGT4p5Zvb29YBopTDdYVcpV9bX6FZcIV7IRcV4GU=; b=dsG2KpveqOpmY7YMB7Ta07cR7o
	gmszo2ZdxAPJpqms/JktfNARTE8VEWW3YqnsNkqpqttgpgenHl3zxXg1Z3tOB7NXuvXKzhB+7l8uS
	MJEhuR7fa4TB4h0CGVhcIsJoUE+v7QMGnxG7Gtj6JH+ewhHrYO5h/m4WHqELM7aLcULN3KzISbV5Z
	z7rmohGYP3bsRD6+MeWYhnHgMvkFxdytOTke4+0luQMMJ+a4H35B9L3YVLsH0Cn+p5pJzM5972Zlf
	Fgi2TpF8LlWNHpqLU7g0HyV8cKk4Zb0rENArgD+AbNjOlUv7tXvrKY3kuo9UGjFuyuV3kBDilRlGj
	Pvn4eMeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcoPf-001G2K-M4; Tue, 19 Oct 2021 12:40:15 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcoPb-001Fzq-95
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 12:40:13 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 67E591FD2A;
 Tue, 19 Oct 2021 12:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634647209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WwHRGT4p5Zvb29YBopTDdYVcpV9bX6FZcIV7IRcV4GU=;
 b=weuQriNtIRhykfrGkWLLizglpVm25Q5R0xbSLBfwFc/3BOL348hZDpne5aKnM23KHOGhtP
 WkJtqGu/M/owR46aG3EWDwFYC1ZpwV+A4rv7THKKdCC+1RzY3JbJahDogNDc/+xNM75tYN
 Y/5m1pRloO6POovP3ZUJ6t6vzAzPRX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634647209;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WwHRGT4p5Zvb29YBopTDdYVcpV9bX6FZcIV7IRcV4GU=;
 b=Op28wxAtdyR9GyF/JnYxPMoDPthexvuEVA0jxjkc4diKfEFH+6jZthg1Fxaz9jGFOpMA2D
 jRNT0MMzDt69uDCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33F8413E2D;
 Tue, 19 Oct 2021 12:40:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GYenCKm8bmGwFQAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 19 Oct 2021 12:40:09 +0000
Subject: Re: Deadlock on failure to read NVMe namespace
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>
References: <87df4b26-19e7-6cc5-e973-23b6e98f4e19@suse.de>
 <e13114d1-b204-b89a-12bc-53ae049dfaa7@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <ce39fdb3-d60f-4e62-f70d-c433145dc68f@suse.de>
Date: Tue, 19 Oct 2021 14:40:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <e13114d1-b204-b89a-12bc-53ae049dfaa7@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_054011_509468_A346FD48 
X-CRM114-Status: GOOD (  25.59  )
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

On 10/19/21 2:31 PM, Sagi Grimberg wrote:
> 
>> Hi all,
>>
>> during testing my test target (https://github.com/hreinecke/nofuse) 
>> I've managed to run into a deadlock (with nvme-5.16):
>>
>> c481:~ # dmesg
>> [102885.483587] nvme nvme0: sqsize 128 > ctrl maxcmd 32, clamping down
>> [102885.483711] nvme nvme0: creating 2 I/O queues.
>> [102885.484130] nvme nvme0: mapped 2/0/0 default/read/poll queues.
>> [102885.485527] nvme nvme0: new ctrl: NQN 
>> "nqn.2014-08.org.nvmexpress:uuid:62f37f51-0cc7-46d5-9865-4de22e81bd9d", addr 
>> 127.0.0.1:8009
>> [102885.487351] nvme nvme0: request 0x0 genctr mismatch (got 0x0 
>> expected 0x1)
>> [102885.487354] nvme nvme0: got bad c2hdata.command_id 0x0 on queue 2
> 
> Nice! the genctr is catching bugs already...
> 
>> [102885.487356] nvme nvme0: receive failed:  -2
>> [102885.487357] nvme nvme0: starting error recovery
>> [102885.487444] block nvme0n1: no usable path - requeuing I/O
>> [102885.502051] nvme nvme0: Reconnecting in 10 seconds...
>> [102893.291877] nvme nvme0: Removing ctrl: NQN 
> 
> Did you trigger this removal? its 2 seconds before
> the reconnect attempt was supposed to run.
> 
>> "nqn.2014-08.org.nvmexpress:uuid:62f37f51-0cc7-46d5-9865-4de22e81bd9d"
>> [102895.535149] nvme nvme0: queue_size 128 > ctrl sqsize 32, clamping 
>> down
>> [102895.535214] nvme nvme0: creating 2 I/O queues.
>> [102895.535943] nvme nvme0: mapped 2/0/0 default/read/poll queues.
>> [102895.536187] nvme nvme0: Failed reconnect attempt 1
>> [103700.406060] INFO: task kworker/u4:0:14965 blocked for more than 
>> 491 seconds.
>> [103700.406068]       Tainted: G            E     
>> 5.15.0-rc3-54-default+ #862
>> [103700.406071] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
>> disables this message.
>> [103700.406073] task:kworker/u4:0    state:D stack:    0 pid:14965 
>> ppid:      2 flags:0x00004000
>> [103700.406117] Workqueue: nvme-wq nvme_scan_work [nvme_core]
>> [103700.406143] Call Trace:
>> [103700.406146]  __schedule+0x302/0x13a0
>> [103700.406157]  ? block_read_full_page+0x21e/0x3b0
>> [103700.406164]  ? blkdev_direct_IO+0x4a0/0x4a0
>> [103700.406172]  schedule+0x3a/0xa0
>> [103700.406177]  io_schedule+0x12/0x40
>> [103700.406182]  do_read_cache_page+0x49b/0x790
>>
>> 481:~ # cat /proc/15761/stack
>> [<0>] nvme_mpath_clear_ctrl_paths+0x25/0x80 [nvme_core]
>> [<0>] nvme_remove_namespaces+0x31/0xf0 [nvme_core]
>> [<0>] nvme_do_delete_ctrl+0x4b/0x80 [nvme_core]
>> [<0>] nvme_sysfs_delete+0x42/0x60 [nvme_core]
>> [<0>] kernfs_fop_write_iter+0x12f/0x1a0
>> [<0>] new_sync_write+0x122/0x1b0
>> [<0>] vfs_write+0x1eb/0x250
>> [<0>] ksys_write+0xa1/0xe0
>> [<0>] do_syscall_64+0x3a/0x80
>> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>> c481:~ # cat /proc/14965/stack
>> [<0>] do_read_cache_page+0x49b/0x790
>> [<0>] read_part_sector+0x39/0xe0
>> [<0>] read_lba+0xf9/0x1d0
>> [<0>] efi_partition+0xf1/0x7f0
>> [<0>] bdev_disk_changed+0x1ee/0x550
>> [<0>] blkdev_get_whole+0x81/0x90
>> [<0>] blkdev_get_by_dev+0x128/0x2e0
>> [<0>] device_add_disk+0x377/0x3c0
>> [<0>] nvme_mpath_set_live+0x130/0x1b0 [nvme_core]
>> [<0>] nvme_mpath_add_disk+0x150/0x160 [nvme_core]
>> [<0>] nvme_alloc_ns+0x417/0x950 [nvme_core]
>> [<0>] nvme_validate_or_alloc_ns+0xe9/0x1e0 [nvme_core]
>> [<0>] nvme_scan_work+0x168/0x310 [nvme_core]
>> [<0>] process_one_work+0x231/0x420
>> [<0>] worker_thread+0x2d/0x3f0
>> [<0>] kthread+0x11a/0x140
>> [<0>] ret_from_fork+0x22/0x30
>>
>> My theory here is that the partition scanning code just calls into the 
>> pagecache, which doesn't set a timeout for any I/O operation.
>> As this is done under the scan_mutex we cannot clear the active paths, 
>> and consequently we hang.
> 
> But the controller removal should have cancelled all inflight
> commands...
> 
> Maybe we're missing unfreeze? Hannes, can you try this one?
> -- 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index e29c47114739..783fde36d2ba 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1974,8 +1974,11 @@ static void nvme_tcp_teardown_io_queues(struct 
> nvme_ctrl *ctrl,
>          nvme_sync_io_queues(ctrl);
>          nvme_tcp_stop_io_queues(ctrl);
>          nvme_cancel_tagset(ctrl);
> -       if (remove)
> +       if (remove) {
>                  nvme_start_queues(ctrl);
> +               nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT);
> +               nvme_unfreeze(ctrl);
> +       }
>          nvme_tcp_destroy_io_queues(ctrl, remove);
>   }
> -- 
Nope. Same problem.

I managed to make the problem go away (for some definitions of 'go 
away') with this patch:

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index fb96e900dd3a..30d1154eb611 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -141,12 +141,12 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl 
*ctrl)
  {
         struct nvme_ns *ns;

-       mutex_lock(&ctrl->scan_lock);
         down_read(&ctrl->namespaces_rwsem);
         list_for_each_entry(ns, &ctrl->namespaces, list)
                 if (nvme_mpath_clear_current_path(ns))
                         kblockd_schedule_work(&ns->head->requeue_work);
         up_read(&ctrl->namespaces_rwsem);
+       mutex_lock(&ctrl->scan_lock);
         mutex_unlock(&ctrl->scan_lock);
  }

But I'd be the first to agree that this really is hackish.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

