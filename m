Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7EEC6FA86
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Sep 2022 12:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7N+G5rim9rotLlrIKt8cZ4eDvaEFPItNOcXgIHEg3iI=; b=oS8KY+1JI+PYnJ+KIq89H5Aeau
	HAtP0VVTUKrd6aAugk4ndFROoNaophqM7o7SKwFaVz8LkvHaRHNyGHJ6tIPSwEVKtFlUtkwCiOTgq
	pCAHORlo/qtGJotZxrXXGVzxV790czrDU92NvDuU5EfpkwrvRhThalFtk6jOwt7WOEfZ0vzhaqtM3
	pJfiGl8EZ8PVRIxcDNy0cnx/PfOJksm0AEEc5CXwK8FPWuKNC5ind8HWyqLb5Vs30dW8WyFRHwXTF
	ZRNQuyaBkTX3vlhz+CWTvfp1sJ4V8e4wY8Dk6LNVh1KYlLOhM2m/6caTFapPVOmZ3B6xcASAZ/8FN
	QV7H6eQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXiaU-009les-EP; Mon, 12 Sep 2022 12:30:54 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXiaS-009lYy-TE
	for linux-nvme@bombadil.infradead.org; Mon, 12 Sep 2022 12:30:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=7N+G5rim9rotLlrIKt8cZ4eDvaEFPItNOcXgIHEg3iI=; b=Ugg8H4e/k6N5OHWtMFXaaZdLBT
	6z8u6rW7DWGWm9TAQou5PmhreqldmoVZwhQzHVxzHkPCCe/s+Q1KGWCHxxuFyYWsEkgFsB07lDhxU
	Q0D0xTBFvrga+uMpEE+5dBMzhxBC9AtHFPbgHXWNV6/TzRQwP3+imMmlarQ0Z53SKdqD13mznkyUf
	MBhLoQIQcXhQ/J+GEzc+TxGpVJZy5IXAz6ZusP5iCdwfUFU5YXfnwD/QHnOnrwp3hRoRcrtkM2gXk
	PREzWkxmURyaBJGFf5ECnZsodaFmHoxm9Ce4/n8M/+QcR4GqxLA4Sfb5q/rXRnVadFktd5fgODtnr
	iN4ZS2eQ==;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXi8S-00BnUo-VI
	for linux-nvme@lists.infradead.org; Mon, 12 Sep 2022 12:01:59 +0000
Received: by mail-wr1-f50.google.com with SMTP id bj14so14941623wrb.12
        for <linux-nvme@lists.infradead.org>; Mon, 12 Sep 2022 05:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7N+G5rim9rotLlrIKt8cZ4eDvaEFPItNOcXgIHEg3iI=;
        b=WwhSGuVSZ4tGlpT5bjHsJT8MrJvr2VhW6hcaQHabVzULKKOW6glVuiik0BSPxBNPGs
         sEp3I+Dxd2LVj7Ca1G8SmKAoYP4wbBukkoDvK8SR2C8OgbxptZkWFnf9NeF2rYEIA+1f
         XJfrLFcBhTzVpWwMlULmscsbwLgm+HPFOhWhk7FKzoTZjnKL6rOEENIBDy4LQGC09ZlG
         0d/E5kaJnfOy+YIuOhDHc9hPlcmYgDCKPElwtOSqPD6p52SxSQPWexWlRrwjU8lyiUzD
         KTQ1O7zBWku6JehSn8DmCp2jeKKLaJwDyuKnPe3qsjj1UKGuD9ncMTqVIyIFTF3k0K8s
         zP3A==
X-Gm-Message-State: ACgBeo2fHOOR6r5Mo1Dto9FE2XURMLHbeU7W/+bteG2cyx5JhBZW2d/k
	Nu6+EfwufVLKBS+zEd8owl2cjOwwD+Y=
X-Google-Smtp-Source: AA6agR6YwFN9C1V1eUyLDLNn0RdEEDgfxsH4WJPMRzWKuZkxp43fLT1R08sxNziXo08X2/4nXIagJw==
X-Received: by 2002:a5d:64aa:0:b0:226:de65:810c with SMTP id m10-20020a5d64aa000000b00226de65810cmr15555716wrp.536.1662984114601;
        Mon, 12 Sep 2022 05:01:54 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z13-20020a05600c0a0d00b003b31fd74b05sm9958054wmp.8.2022.09.12.05.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 05:01:53 -0700 (PDT)
Message-ID: <c7c90d39-2c4a-afea-ace4-bc3ae5f584d7@grimberg.me>
Date: Mon, 12 Sep 2022 15:01:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: nvme/tcp: infinite loop, livelock, and OOPS issues on disconnect
Content-Language: en-US
To: Jonathan Nicklin <jnicklin@blockbridge.com>,
 linux-nvme@lists.infradead.org
References: <CAHex0cqsATq98N3xevr0-vEcKBaRnTV1cm8einZ925CYyJNcsw@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHex0cqsATq98N3xevr0-vEcKBaRnTV1cm8einZ925CYyJNcsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220912_130157_174359_4B8668A8 
X-CRM114-Status: GOOD (  21.38  )
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


> Hello,
> 
> We've seen system hangs and OOPS with nvme/tcp with host-initiated
> disconnects during fault testing. To help debug, I've developed a short repro
> scenario (~5 minutes runtime) that triggers the issue on 5.15.65.

Does this happen on upstream as well?

> To reproduce:
> 
> On the host:
>   - run connect and disconnect to a single subsystem in a loop
> On the target:
>   - inject random transport failures every 1-2 seconds

Is this a single controller in the subsystem? or more?

> There are a few observed results:
> 
> 1. The system either hangs completely (reboot required) or nvme management
> commands hang (i.e., nvme list and nvme connect)

Would it be possible to check with the following applied?
41d07df7de84 ("nvme-tcp: always fail a request when sending it failed")

Perhaps its possible that we don't fail the command, and we are unable
to get to the iterator that cancels all commands becuase
nvme_remove_namespaces() is also blocked?

> 2. If the system stays alive, "nvme nvme1: failed to send request -32" streams
> from the kernel in an infinite loop.

Hmm, this is strange... this stream is when the system is hang and
without forward progress? or if the test continues?

> 
> 3. nvme tracing shows a loop trying to read the same lba:
> 
> kworker/2:1H-6376    [002] .....  4314.468725: nvme_setup_cmd:
>    nvme1: disk=nvme1c1n1, qid=3, cmdid=61519, nsid=1, flags=0x0, meta=0x0
>    cmd=(nvme_cmd_read slba=8, len=7, ctrl=0x0, dsmgmt=0, reftag=0)
> kworker/2:1H-6376    [002] .N...  4314.473568: nvme_complete_rq:
>    nvme1: disk=nvme1c1n1, qid=3, cmdid=61519, res=0x0, retries=0, flags=0x0,
>    status=0x370
> 
> 4. Hung task warnings for kernel worker threads:
> 
> INFO: task kworker/u16:2:6524 blocked for more than 491 seconds.
>        Not tainted 5.15.65-f0.el7.x86_64 #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/u16:2   state:D stack:    0 pid: 6524 ppid:     2 flags:0x00004000
> Workqueue: nvme-wq nvme_scan_work [nvme_core]
> 
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
> RIP: 0033:0x7ff4b79c4ba0
> RSP: 002b:00007fff37cea528 EFLAGS: 00000246
>   ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00000000006532e0 RCX: 00007ff4b79c4ba0
> RDX: 0000000000000001 RSI: 000000000043b146 RDI: 0000000000000003
> RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000001962fe0
> R10: 00007fff37ce9f60 R11: 0000000000000246 R12: 0000000001963090
> R13: 00007fff37ceab20 R14: 0000000000000037 R15: 00000000006535c0
>   </TASK>
> 
> 5. And, an occasional OOPS (same test, possibly a different issue)

There were some fixes related to oops observed sporadically with
connect/disconnect/reset loops. It was fixed in:
0fa0f99fc84e ("nvme: fix a possible use-after-free in controller reset 
during load")

Is it applied on your system?

> 
> BUG: kernel NULL pointer dereference, address: 0000000000000008
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0
> P4D 0
> Oops: 0000 [#1] SMP NOPTI
> CPU: 4 PID: 2131 Comm: kworker/4:2H Not tainted 5.15.65-f0.el7.x86_64 #1
> Hardware name: Supermicro SYS-1019S-WR/X11SSW-F, BIOS 2.1a 03/07/2018
> Workqueue:  0x0
>   (events_highpri)
> RIP: 0010:process_one_work+0x34/0x380
> Code: 57 41 56 41 55 41 54 49 89 fc 53 48 89 f3 48 83 ec 10 48 8b 06
> 4c 8b 7f 48 49 89 c5 45 30 ed a8 04 b8 00 00 00 00 4c 0f 44 e8 <49> 8b
> 45 08 44 8b b0 00 01 00 00 41 83 e6 20 41 f6 47 10 04 75 0f
> RSP: 0018:ffffc90001527e90 EFLAGS: 00010046
> RAX: 0000000000000000 RBX: ffff8881459395d0 RCX: dead000000000122
> RDX: 00000001001d8113 RSI: ffff8881459395d0 RDI: ffff888124d85c00
> RBP: ffffc90001527ec8 R08: ffff888857b2cea8 R09: 0000000000000381
> R10: 00000000000001ce R11: 0000000000000000 R12: ffff888124d85c00
> R13: 0000000000000000 R14: ffff888857b2c120 R15: ffff888857b2c100
> FS:  0000000000000000(0000) GS:ffff888857b00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000008 CR3: 000000000260a006 CR4: 00000000003706e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   worker_thread+0x37/0x3b0
>   ? process_one_work+0x380/0x380
>   kthread+0x12d/0x150
>   ? set_kthread_struct+0x50/0x50
>   ret_from_fork+0x1f/0x30
>   </TASK>
> 
> If there is some way that I can assist, let me know.
> 
> Thanks,
> -Jonathan
> 

