Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8FAC6FA91
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Sep 2022 14:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=glD28qXwaEDc0KPhXjNRIE6b8ieiErzN6XOhOblcozQ=; b=hge1XamZpCEpwZhrMNN0BK+KD5
	0axNpx/EvAyzjjlC1oHsZ+wE0GDaKZNk6neRJivX2sJRxC4mYEGipTpLQ9NIgYTlxfRnB7ZJ0HK/X
	zTt8yqYprJHRfB46oldB/mVLfzsiCWWQ2eWI+5vh55MrUIGfdoUdMltFF25nC0WRsLryDBXVZrtMC
	Wkf9yXiNf+5wqriWWcBdOOCztz0EuJozbSojP6DBscl6wOPvDVkr/vu2EX+tzg6G/cXd243bu5545
	qomiEcJUxGyJLcHj8MFeQ6uYrlMcc+TK0kGS8Pe44/irJZ5vp40eJbhbOJnIpVk80LdYTAEYBttrb
	hHNX3+2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaHQB-00C0ZO-JE; Mon, 19 Sep 2022 14:06:52 +0000
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaHQ6-00C0WP-CK
	for linux-nvme@lists.infradead.org; Mon, 19 Sep 2022 14:06:48 +0000
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3487d84e477so340440687b3.6
        for <linux-nvme@lists.infradead.org>; Mon, 19 Sep 2022 07:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=glD28qXwaEDc0KPhXjNRIE6b8ieiErzN6XOhOblcozQ=;
        b=X4LhXsf0tZPIbptgV47R5qsmMSFmcnm0BEPOVmEFXd+JZqFYZPqhQoL3wmVOLmFKOG
         xJi23dcM6IA/mnlBYbBIJcYw4kO7kRdknXBt2GIPXlEtcGVNAPY4Dg69fpGm57ZaFfHM
         zyBhhlevR6F59ob3/vJiIexxBkn07yxAeMenEuUFf6glBK+xWYTr8QDT49StANHoHmdO
         AtDmirOr6buRZ/bAXpieK2T7wNkHzX9feq1Oyvlx8vqwtJuV26MzIQl0f2JT1aR41J4J
         RTWlpUMVhz9P65bAwlzIbQJ79W8MK+7ljLnS2j94D+LC0G+24eDOnq2IKYgphLln7utl
         k0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=glD28qXwaEDc0KPhXjNRIE6b8ieiErzN6XOhOblcozQ=;
        b=H4nHrQB8R2GnoU9OD6BCTXpGuUlR6+5vXtpTguEPswAbVC28goX4f/ayigxWfxrqzV
         XkHYiJjfSfuqdEarLmBenbvSpGceVNj1n/YuforD6YOr/zlR0Z5ACNyuOzfi869c22+2
         qukonk2CeoDHEa5A0QXcuXhbzP5mlzE5fYstZm4sYo2IueR3pwIeDJu8D3ibAx4VyNoz
         Etw7vAeXSjf6QDlmiZHF2YT3ZhP+BuB0PQRHoU08OqpghrU+5iZxjRGv+yDXxzXxseXS
         KSoDmml7pp8OxxLIJwBYXRhFvou81nhtc5LkIRmewNzFE/wmcx+EVg/FBxI5idr/wST3
         7buA==
X-Gm-Message-State: ACrzQf1ckqjxESRmAKMMGeQBdSvtvqiTM0FcVrw3y1JQVx/0AgObgjrz
	Z/WHWVJKMUq8kw9PjlEA1dxodXaSr4yZdmbeDnNVow==
X-Google-Smtp-Source: AMsMyM7SWlBwSm2kbgRXxQOzXs4kYR5YNyRio3YMjNrVDokwyoAlZvqeUzxbBRd7xiVUMtiwpzMN/AFTgGHpmrCf1JE=
X-Received: by 2002:a81:9210:0:b0:348:5d75:fca0 with SMTP id
 j16-20020a819210000000b003485d75fca0mr14727353ywg.478.1663596404221; Mon, 19
 Sep 2022 07:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHex0cqsATq98N3xevr0-vEcKBaRnTV1cm8einZ925CYyJNcsw@mail.gmail.com>
 <c7c90d39-2c4a-afea-ace4-bc3ae5f584d7@grimberg.me>
In-Reply-To: <c7c90d39-2c4a-afea-ace4-bc3ae5f584d7@grimberg.me>
From: Jonathan Nicklin <jnicklin@blockbridge.com>
Date: Mon, 19 Sep 2022 10:06:08 -0400
Message-ID: <CAHex0cqc0UNWz4CzzJzxRvji=89BZiVKQFG3TF=espy72Ga54Q@mail.gmail.com>
Subject: Re: nvme/tcp: infinite loop, livelock, and OOPS issues on disconnect
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220919_070646_552767_D8413859 
X-CRM114-Status: GOOD (  33.19  )
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

On Mon, Sep 12, 2022 at 8:01 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > Hello,
> >
> > We've seen system hangs and OOPS with nvme/tcp with host-initiated
> > disconnects during fault testing. To help debug, I've developed a short repro
> > scenario (~5 minutes runtime) that triggers the issue on 5.15.65.
>
> Does this happen on upstream as well?

I have moved my testing over to 5.19.8 and have reproduced the issue. However,
the cycle time is now much longer (~12 hours). This is due to some
change in behavior
likely from other fixes.

> > To reproduce:
> >
> > On the host:
> >   - run connect and disconnect to a single subsystem in a loop
> > On the target:
> >   - inject random transport failures every 1-2 seconds
>
> Is this a single controller in the subsystem? or more?

Single controller subsystem.

> > There are a few observed results:
> >
> > 1. The system either hangs completely (reboot required) or nvme management
> > commands hang (i.e., nvme list and nvme connect)
>
> Would it be possible to check with the following applied?
> 41d07df7de84 ("nvme-tcp: always fail a request when sending it failed")

This patch was not present in the original testing on 5.15.65. It is present in
the latest repro on 5.19.8.

> Perhaps its possible that we don't fail the command, and we are unable
> to get to the iterator that cancels all commands becuase
> nvme_remove_namespaces() is also blocked?
>
> > 2. If the system stays alive, "nvme nvme1: failed to send request -32" streams
> > from the kernel in an infinite loop.
>
> Hmm, this is strange... this stream is when the system is hang and
> without forward progress? or if the test continues?

On 5.15.65, this was streaming in the kernel log while the test was hung;
any command via nvme cli hung. On 5.19.18, I did not see the streaming
behavior.

> >
> > 3. nvme tracing shows a loop trying to read the same lba:
> >
> > kworker/2:1H-6376    [002] .....  4314.468725: nvme_setup_cmd:
> >    nvme1: disk=nvme1c1n1, qid=3, cmdid=61519, nsid=1, flags=0x0, meta=0x0
> >    cmd=(nvme_cmd_read slba=8, len=7, ctrl=0x0, dsmgmt=0, reftag=0)
> > kworker/2:1H-6376    [002] .N...  4314.473568: nvme_complete_rq:
> >    nvme1: disk=nvme1c1n1, qid=3, cmdid=61519, res=0x0, retries=0, flags=0x0,
> >    status=0x370
> >
> > 4. Hung task warnings for kernel worker threads:
> >
> > INFO: task kworker/u16:2:6524 blocked for more than 491 seconds.
> >        Not tainted 5.15.65-f0.el7.x86_64 #1
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > task:kworker/u16:2   state:D stack:    0 pid: 6524 ppid:     2 flags:0x00004000
> > Workqueue: nvme-wq nvme_scan_work [nvme_core]
> >
> > Call Trace:
> >   <TASK>
> >   __schedule+0x390/0x910
> >   ? scan_shadow_nodes+0x40/0x40
> >   schedule+0x55/0xe0
> >   io_schedule+0x16/0x40
> >   do_read_cache_page+0x55d/0x850
> >   ? __page_cache_alloc+0x90/0x90
> >   read_cache_page+0x12/0x20
> >   read_part_sector+0x3f/0x110
> >   amiga_partition+0x3d/0x3e0
> >   ? osf_partition+0x33/0x220
> >   ? put_partition+0x90/0x90
> >   bdev_disk_changed+0x1fe/0x4d0
> >   blkdev_get_whole+0x7b/0x90
> >   blkdev_get_by_dev+0xda/0x2d0
> >   device_add_disk+0x356/0x3b0
> >   nvme_mpath_set_live+0x13c/0x1a0 [nvme_core]
> >   ? nvme_parse_ana_log+0xae/0x1a0 [nvme_core]
> >   nvme_update_ns_ana_state+0x3a/0x40 [nvme_core]
> >   nvme_mpath_add_disk+0x120/0x160 [nvme_core]
> >   nvme_alloc_ns+0x594/0xa00 [nvme_core]
> >   nvme_validate_or_alloc_ns+0xb9/0x1a0 [nvme_core]
> >   ? __nvme_submit_sync_cmd+0x1d2/0x210 [nvme_core]
> >   nvme_scan_work+0x281/0x410 [nvme_core]
> >   process_one_work+0x1be/0x380
> >   worker_thread+0x37/0x3b0
> >   ? process_one_work+0x380/0x380
> >   kthread+0x12d/0x150
> >   ? set_kthread_struct+0x50/0x50
> >   ret_from_fork+0x1f/0x30
> >   </TASK>
> > INFO: task nvme:6725 blocked for more than 491 seconds.
> >        Not tainted 5.15.65-f0.el7.x86_64 #1
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > task:nvme            state:D
> >   stack:    0 pid: 6725 ppid:  1761 flags:0x00004000
> > Call Trace:
> >   <TASK>
> >   __schedule+0x390/0x910
> >   ? sched_clock+0x9/0x10
> >   schedule+0x55/0xe0
> >   schedule_timeout+0x24b/0x2e0
> >   ? try_to_wake_up+0x358/0x510
> >   ? finish_task_switch+0x88/0x2c0
> >   wait_for_completion+0xa5/0x110
> >   __flush_work+0x144/0x210
> >   ? worker_attach_to_pool+0xc0/0xc0
> >   flush_work+0x10/0x20
> >   nvme_remove_namespaces+0x41/0xf0 [nvme_core]
> >   nvme_do_delete_ctrl+0x47/0x66 [nvme_core]
> >   nvme_sysfs_delete.cold.96+0x8/0xd [nvme_core]
> >   dev_attr_store+0x14/0x30
> >   sysfs_kf_write+0x38/0x50
> >   kernfs_fop_write_iter+0x146/0x1d0
> >   new_sync_write+0x114/0x1b0
> >   ? intel_pmu_handle_irq+0xe0/0x420
> >   vfs_write+0x18d/0x270
> >   ksys_write+0x61/0xe0
> >   __x64_sys_write+0x1a/0x20
> >   do_syscall_64+0x37/0x90
> >   entry_SYSCALL_64_after_hwframe+0x61/0xcb
> > RIP: 0033:0x7ff4b79c4ba0
> > RSP: 002b:00007fff37cea528 EFLAGS: 00000246
> >   ORIG_RAX: 0000000000000001
> > RAX: ffffffffffffffda RBX: 00000000006532e0 RCX: 00007ff4b79c4ba0
> > RDX: 0000000000000001 RSI: 000000000043b146 RDI: 0000000000000003
> > RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000001962fe0
> > R10: 00007fff37ce9f60 R11: 0000000000000246 R12: 0000000001963090
> > R13: 00007fff37ceab20 R14: 0000000000000037 R15: 00000000006535c0
> >   </TASK>
> >
> > 5. And, an occasional OOPS (same test, possibly a different issue)

> There were some fixes related to oops observed sporadically with
> connect/disconnect/reset loops. It was fixed in:
> 0fa0f99fc84e ("nvme: fix a possible use-after-free in controller reset
> during load")
>
> Is it applied on your system?

This patch was not present in the original testing on 5.15.65. It is present in
the latest repro on 5.19.8.

> >
> > BUG: kernel NULL pointer dereference, address: 0000000000000008
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > PGD 0
> > P4D 0
> > Oops: 0000 [#1] SMP NOPTI
> > CPU: 4 PID: 2131 Comm: kworker/4:2H Not tainted 5.15.65-f0.el7.x86_64 #1
> > Hardware name: Supermicro SYS-1019S-WR/X11SSW-F, BIOS 2.1a 03/07/2018
> > Workqueue:  0x0
> >   (events_highpri)
> > RIP: 0010:process_one_work+0x34/0x380
> > Code: 57 41 56 41 55 41 54 49 89 fc 53 48 89 f3 48 83 ec 10 48 8b 06
> > 4c 8b 7f 48 49 89 c5 45 30 ed a8 04 b8 00 00 00 00 4c 0f 44 e8 <49> 8b
> > 45 08 44 8b b0 00 01 00 00 41 83 e6 20 41 f6 47 10 04 75 0f
> > RSP: 0018:ffffc90001527e90 EFLAGS: 00010046
> > RAX: 0000000000000000 RBX: ffff8881459395d0 RCX: dead000000000122
> > RDX: 00000001001d8113 RSI: ffff8881459395d0 RDI: ffff888124d85c00
> > RBP: ffffc90001527ec8 R08: ffff888857b2cea8 R09: 0000000000000381
> > R10: 00000000000001ce R11: 0000000000000000 R12: ffff888124d85c00
> > R13: 0000000000000000 R14: ffff888857b2c120 R15: ffff888857b2c100
> > FS:  0000000000000000(0000) GS:ffff888857b00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000008 CR3: 000000000260a006 CR4: 00000000003706e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >   <TASK>
> >   worker_thread+0x37/0x3b0
> >   ? process_one_work+0x380/0x380
> >   kthread+0x12d/0x150
> >   ? set_kthread_struct+0x50/0x50
> >   ret_from_fork+0x1f/0x30
> >   </TASK>
> >
> > If there is some way that I can assist, let me know.
> >
> > Thanks,
> > -Jonathan
> >

