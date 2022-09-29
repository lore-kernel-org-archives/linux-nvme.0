Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3DBC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 18:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HzXMlZ9eopWsQ8S4nt0WWAqkk33r2MbfueG9F1sYHRA=; b=QsiNAzjZisrTKUdgV7OgZwk9DF
	/XdIdySczBZaMr3JM5XWgxU+smWvHkR780ueiwhALzcGfgWcgn7QRvNmtv3dfsviqtcJDv9omong6
	vLoqhMMtKnLgN/zzoXRT8HcIZOsQs6vubilBwMdoHAd+C8kVy6s7TTnPDB2dOMsi1GF294ThP/9Zx
	GIkNCjqXsi9b9ZizdlUEBygpLFUQjD0K7S5DsO1w16X+mpcaKYoD3QoSF0aUBYGq+KSmmFGIxri/k
	wS9nPUEIdQtxQ2QoAIlAhncezAFyDG7zfblib+kRLhYdU+iWUksAmhDrgcHB1uf0Osk7vGSfVbEDB
	vo+fwqQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odyWh-004zq7-Ch; Thu, 29 Sep 2022 18:44:51 +0000
Received: from mail-ej1-f42.google.com ([209.85.218.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odyVe-004z0h-HT
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 18:43:48 +0000
Received: by mail-ej1-f42.google.com with SMTP id r18so4590937eja.11
        for <linux-nvme@lists.infradead.org>; Thu, 29 Sep 2022 11:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HzXMlZ9eopWsQ8S4nt0WWAqkk33r2MbfueG9F1sYHRA=;
        b=mCYcsBECUavP6Wj8LEo9H5m3znplWFBJJGj4a86jfoZGTvj5bP4PSlrOsPVaIk8JoU
         i/7FBPfjRex5Yy36mJvLCokADDmUiSVn6kZFQlRQpwABsA9+zl+MyXb9j9VbVG5ozNy5
         8dIGNmHkYRAv4UYi2bOj8y88zNiiUrcL+TUTG6/aoYJ9fibBUuWsKmCUDJ/oaXMoVpOY
         ePX53nRLl1i5pCCm+2ifXXiZDRHP5kMlEgE2fwchUGf2GHa0S54LlqHMAFr6DgR516Vn
         CQIzAFH8ivSJFTitiZcRnSTf8Jhgu+w5Q32Efi6zTH4Rpsw07mfITsH63FejM/anz4Iq
         F4bA==
X-Gm-Message-State: ACrzQf1Uh9YpJElalo54vu0ZFBwg12GAbAsmbEjtGhdKC+SUCEn34Kzy
	LAeAQSuYKmyRGFe4l7wkaWHQQNXXGFs=
X-Google-Smtp-Source: AMsMyM79J7/NyZufHMRtEUNbkMAToDnK/l/fS+gVWKcWfnhpmEhWiXrP19KFZFrLB41cnvq33Sw8Sw==
X-Received: by 2002:a17:906:8455:b0:773:c45b:d970 with SMTP id e21-20020a170906845500b00773c45bd970mr3779854ejy.46.1664477020922;
        Thu, 29 Sep 2022 11:43:40 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id v2-20020a170906292200b0073c80d008d5sm4295942ejd.122.2022.09.29.11.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 11:43:40 -0700 (PDT)
Message-ID: <603d624d-de25-e856-58ea-7a76e3029dbb@grimberg.me>
Date: Thu, 29 Sep 2022 21:43:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] nvme-tcp: fix possible hang caused during ctrl
 deletion
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Jonathan Nicklin <jnicklin@blockbridge.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20220928062326.45119-1-sagi@grimberg.me>
In-Reply-To: <20220928062326.45119-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_114346_647182_85C16807 
X-CRM114-Status: GOOD (  17.59  )
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



On 9/28/22 09:23, Sagi Grimberg wrote:
> When we delete a controller, we execute the following:
> 1. nvme_stop_ctrl() - stop some work elements that may be
> 	inflight or scheduled (specifically also .stop_ctrl
> 	which cancels ctrl error recovery work)
> 2. nvme_remove_namespaces() - which first flushes scan_work
> 	to avoid competing ns addition/removal
> 3. continue to teardown the controller
> 
> However, if err_work was scheduled to run in (1), it is designed to
> cancel any inflight I/O, particularly I/O that is originating from ns
> scan_work in (2), but because it is cancelled in .stop_ctrl(), we can
> prevent forward progress of (2) as ns scanning is blocking on I/O
> (that will never be cancelled).
> 
> The race is:
> 1. transport layer error observed -> err_work is scheduled
> 2. scan_work executes, discovers ns, generate I/O to it
> 3. nvme_ctop_ctrl() -> .stop_ctrl() -> cancel_work_sync(err_work)
>     - err_work never executed
> 4. nvme_remove_namespaces() -> flush_work(scan_work)
> --> deadlock, because scan_work is blocked on I/O that was supposed
> to be cancelled by err_work, but was cancelled before executing (see
> stack trace [1]).
> 
> Fix this by flushing err_work instead of cancelling it, to force it
> to execute and cancel all inflight I/O.
> 
> [1]:
> --
> Call Trace:
>   <TASK>
>   __schedule+0x390/0x910
>   ? scan_shadow_nodes+0x40/0x40
>   schedule+0x55/0xe0
>   io_schedule+0x16/0x40
>   do_read_cache_page+0x55d/0x850
>   ? __page_cache_alloc+0x90/0x90
>   read_cache_page+0x12/0x20
>   read_part_sector+0x3f/0x110
>   amiga_partition+0x3d/0x3e0
>   ? osf_partition+0x33/0x220
>   ? put_partition+0x90/0x90
>   bdev_disk_changed+0x1fe/0x4d0
>   blkdev_get_whole+0x7b/0x90
>   blkdev_get_by_dev+0xda/0x2d0
>   device_add_disk+0x356/0x3b0
>   nvme_mpath_set_live+0x13c/0x1a0 [nvme_core]
>   ? nvme_parse_ana_log+0xae/0x1a0 [nvme_core]
>   nvme_update_ns_ana_state+0x3a/0x40 [nvme_core]
>   nvme_mpath_add_disk+0x120/0x160 [nvme_core]
>   nvme_alloc_ns+0x594/0xa00 [nvme_core]
>   nvme_validate_or_alloc_ns+0xb9/0x1a0 [nvme_core]
>   ? __nvme_submit_sync_cmd+0x1d2/0x210 [nvme_core]
>   nvme_scan_work+0x281/0x410 [nvme_core]
>   process_one_work+0x1be/0x380
>   worker_thread+0x37/0x3b0
>   ? process_one_work+0x380/0x380
>   kthread+0x12d/0x150
>   ? set_kthread_struct+0x50/0x50
>   ret_from_fork+0x1f/0x30
>   </TASK>
> INFO: task nvme:6725 blocked for more than 491 seconds.
>        Not tainted 5.15.65-f0.el7.x86_64 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:nvme            state:D
>   stack:    0 pid: 6725 ppid:  1761 flags:0x00004000
> Call Trace:
>   <TASK>
>   __schedule+0x390/0x910
>   ? sched_clock+0x9/0x10
>   schedule+0x55/0xe0
>   schedule_timeout+0x24b/0x2e0
>   ? try_to_wake_up+0x358/0x510
>   ? finish_task_switch+0x88/0x2c0
>   wait_for_completion+0xa5/0x110
>   __flush_work+0x144/0x210
>   ? worker_attach_to_pool+0xc0/0xc0
>   flush_work+0x10/0x20
>   nvme_remove_namespaces+0x41/0xf0 [nvme_core]
>   nvme_do_delete_ctrl+0x47/0x66 [nvme_core]
>   nvme_sysfs_delete.cold.96+0x8/0xd [nvme_core]
>   dev_attr_store+0x14/0x30
>   sysfs_kf_write+0x38/0x50
>   kernfs_fop_write_iter+0x146/0x1d0
>   new_sync_write+0x114/0x1b0
>   ? intel_pmu_handle_irq+0xe0/0x420
>   vfs_write+0x18d/0x270
>   ksys_write+0x61/0xe0
>   __x64_sys_write+0x1a/0x20
>   do_syscall_64+0x37/0x90
>   entry_SYSCALL_64_after_hwframe+0x61/0xcb
> --
> 
> Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
> Reported-by: Jonathan Nicklin <jnicklin@blockbridge.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Jonathan, can I get your Tested-by tag on this?

