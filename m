Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6F7C6FA86
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Sep 2022 13:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q6Vc5JmokKiZtizdMs7+tpCAIdWKFWguAFDlfDoTmbY=; b=1abhENTljTlc1qmkhDYMRBTkbw
	CldSWuF2G/eqKADUT8iGXaHOegW7a5u4E/PXybamCc+8NZmss7zw/164WDkO7eNZdrSZ1sAJ9V0HJ
	bVdIycEM/4SEFhXSwjx5SBAdEh3S0y1mZbeIYNfOlWGVtaaZ4a7Hxr9u5E0vDW5vOzXoUh1Z5nHZl
	xORG9jrTwe9j1TVB4Lz3443hGVlmxo0XrHsu2KYerRS68hUnKd/QIOxSScVtWDr2+T/V2V3gldpSM
	VUnAdmbMzrakUwE+Ll6DOnQ2MMq1PX7y+VDzBxNfgmmQW/XH+m5H8KSs9QERqPD/IkdN7KAigfTCf
	qEcanl/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocoO3-0059cZ-Tz; Mon, 26 Sep 2022 13:43:07 +0000
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocoO1-0059Zr-3s
	for linux-nvme@lists.infradead.org; Mon, 26 Sep 2022 13:43:07 +0000
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3487d84e477so68788597b3.6
        for <linux-nvme@lists.infradead.org>; Mon, 26 Sep 2022 06:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Q6Vc5JmokKiZtizdMs7+tpCAIdWKFWguAFDlfDoTmbY=;
        b=0SGeTTPP4IBi/QAo521wrRhn459lP4rvg5w5a+AQwTzAyFYuZ3YoVnwwX6rk3nKeyY
         w48V7Yy/AzDd7z76qfDWn73fgIx2aleH+vAsTe42gEmBb1ytwME9MyUw3u3vd/t1ODzz
         h7OVOdz2ggKH8tebjhtc18SfO6mICwHJFmiv+OmU0wGa3XjxG49FZRWaBtg6b592QRSd
         eKRcm5e22Yy67mSTXa/t6vkQQbBGvD8YPNpnJuB53w6BjqEwq+q6MPZuefdzXRtjhV87
         Uiy5/7/ZE+P/gr1NSpFuN1EpDgb6vzkZE6uF1GCm0PsSv9h40ZtlfL5umMa0qq2Du5YU
         VQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Q6Vc5JmokKiZtizdMs7+tpCAIdWKFWguAFDlfDoTmbY=;
        b=mO1OKSEFpXANvOzzE/LUsWGLvMFBjDqXO02QhC6tLyyR57FIha4NWWmmlhrKpIFy7b
         jC9SWTFsQWn9AXZ1O5BWYdFz2f/ttRqbhTFm75nDnDdrmHZ9qewXW7+44gBWF2zK7JxB
         ro3sHziAi+sA9oKYO6lcIcyeBHqZQoDlPj2eOpwvlSxVLRAqXHpe7nKPVg0BCiJv0ZYa
         1BlYAbvtsEH6DCKEjsdUnZ46HIqf0QzgA7ywewqOWENNl34foIZMkAl2ZD+nJFI1NkwG
         Re0z1Wx//+1dyKv33zwGtbBIBespX37l00RpRozUrCuQXxM+Qll+5s99sTL34+xmFohr
         FVeQ==
X-Gm-Message-State: ACrzQf2eCPWy8UiEkE2R5DBD285akNAqAJiIae1ky1DEpaPtNwuVvnqG
	h4UzKoKBdbQLqtM8fKxFs7VPN126n6OuKptK2jrc6SKpVXORIA==
X-Google-Smtp-Source: AMsMyM565LrO74YbCaNO2jb8KpcrK2qSo71JGU/R9ue0JHZvPCBdnP0xX1hKauZKA6z1KCWp88c1lgVZVt53C/Kv+oQ=
X-Received: by 2002:a81:80c3:0:b0:349:8498:a05b with SMTP id
 q186-20020a8180c3000000b003498498a05bmr20718255ywf.403.1664199781402; Mon, 26
 Sep 2022 06:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHex0cqsATq98N3xevr0-vEcKBaRnTV1cm8einZ925CYyJNcsw@mail.gmail.com>
 <c7c90d39-2c4a-afea-ace4-bc3ae5f584d7@grimberg.me> <CAHex0cqc0UNWz4CzzJzxRvji=89BZiVKQFG3TF=espy72Ga54Q@mail.gmail.com>
 <dea45ad6-a5da-b9f6-a851-22fc4e5ef75e@grimberg.me>
In-Reply-To: <dea45ad6-a5da-b9f6-a851-22fc4e5ef75e@grimberg.me>
From: Jonathan Nicklin <jnicklin@blockbridge.com>
Date: Mon, 26 Sep 2022 09:42:25 -0400
Message-ID: <CAHex0cqz1yvN6qnrb-UcqciB6K6ZwjY_vQi06RyqKA3tUsxqRQ@mail.gmail.com>
Subject: Re: nvme/tcp: infinite loop, livelock, and OOPS issues on disconnect
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220926_064305_202940_85E779E0 
X-CRM114-Status: GOOD (  52.03  )
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

On Mon, Sep 19, 2022 at 11:27 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >>> Hello,
> >>>
> >>> We've seen system hangs and OOPS with nvme/tcp with host-initiated
> >>> disconnects during fault testing. To help debug, I've developed a short repro
> >>> scenario (~5 minutes runtime) that triggers the issue on 5.15.65.
> >>
> >> Does this happen on upstream as well?
> >
> > I have moved my testing over to 5.19.8 and have reproduced the issue. However,
> > the cycle time is now much longer (~12 hours). This is due to some
> > change in behavior
> > likely from other fixes.
>
> probably...
>
> >>> To reproduce:
> >>>
> >>> On the host:
> >>>    - run connect and disconnect to a single subsystem in a loop
> >>> On the target:
> >>>    - inject random transport failures every 1-2 seconds
> >>
> >> Is this a single controller in the subsystem? or more?
> >
> > Single controller subsystem.
> >
> >>> There are a few observed results:
> >>>
> >>> 1. The system either hangs completely (reboot required) or nvme management
> >>> commands hang (i.e., nvme list and nvme connect)
> >>
> >> Would it be possible to check with the following applied?
> >> 41d07df7de84 ("nvme-tcp: always fail a request when sending it failed")
> >
> > This patch was not present in the original testing on 5.15.65. It is present in
> > the latest repro on 5.19.8.
>
> OK.
>
> >> Perhaps its possible that we don't fail the command, and we are unable
> >> to get to the iterator that cancels all commands becuase
> >> nvme_remove_namespaces() is also blocked?
> >>
> >>> 2. If the system stays alive, "nvme nvme1: failed to send request -32" streams
> >>> from the kernel in an infinite loop.
> >>
> >> Hmm, this is strange... this stream is when the system is hang and
> >> without forward progress? or if the test continues?
> >
> > On 5.15.65, this was streaming in the kernel log while the test was hung;
> > any command via nvme cli hung. On 5.19.18, I did not see the streaming
> > behavior.
>
> OK.
>
> >>>
> >>> 3. nvme tracing shows a loop trying to read the same lba:
> >>>
> >>> kworker/2:1H-6376    [002] .....  4314.468725: nvme_setup_cmd:
> >>>     nvme1: disk=nvme1c1n1, qid=3, cmdid=61519, nsid=1, flags=0x0, meta=0x0
> >>>     cmd=(nvme_cmd_read slba=8, len=7, ctrl=0x0, dsmgmt=0, reftag=0)
> >>> kworker/2:1H-6376    [002] .N...  4314.473568: nvme_complete_rq:
> >>>     nvme1: disk=nvme1c1n1, qid=3, cmdid=61519, res=0x0, retries=0, flags=0x0,
> >>>     status=0x370
> >>>
> >>> 4. Hung task warnings for kernel worker threads:
> >>>
> >>> INFO: task kworker/u16:2:6524 blocked for more than 491 seconds.
> >>>         Not tainted 5.15.65-f0.el7.x86_64 #1
> >>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >>> task:kworker/u16:2   state:D stack:    0 pid: 6524 ppid:     2 flags:0x00004000
> >>> Workqueue: nvme-wq nvme_scan_work [nvme_core]
> >>>
> >>> Call Trace:
> >>>    <TASK>
> >>>    __schedule+0x390/0x910
> >>>    ? scan_shadow_nodes+0x40/0x40
> >>>    schedule+0x55/0xe0
> >>>    io_schedule+0x16/0x40
> >>>    do_read_cache_page+0x55d/0x850
> >>>    ? __page_cache_alloc+0x90/0x90
> >>>    read_cache_page+0x12/0x20
> >>>    read_part_sector+0x3f/0x110
> >>>    amiga_partition+0x3d/0x3e0
> >>>    ? osf_partition+0x33/0x220
> >>>    ? put_partition+0x90/0x90
> >>>    bdev_disk_changed+0x1fe/0x4d0
> >>>    blkdev_get_whole+0x7b/0x90
> >>>    blkdev_get_by_dev+0xda/0x2d0
> >>>    device_add_disk+0x356/0x3b0
> >>>    nvme_mpath_set_live+0x13c/0x1a0 [nvme_core]
> >>>    ? nvme_parse_ana_log+0xae/0x1a0 [nvme_core]
> >>>    nvme_update_ns_ana_state+0x3a/0x40 [nvme_core]
> >>>    nvme_mpath_add_disk+0x120/0x160 [nvme_core]
> >>>    nvme_alloc_ns+0x594/0xa00 [nvme_core]
> >>>    nvme_validate_or_alloc_ns+0xb9/0x1a0 [nvme_core]
> >>>    ? __nvme_submit_sync_cmd+0x1d2/0x210 [nvme_core]
> >>>    nvme_scan_work+0x281/0x410 [nvme_core]
> >>>    process_one_work+0x1be/0x380
> >>>    worker_thread+0x37/0x3b0
> >>>    ? process_one_work+0x380/0x380
> >>>    kthread+0x12d/0x150
> >>>    ? set_kthread_struct+0x50/0x50
> >>>    ret_from_fork+0x1f/0x30
> >>>    </TASK>
> >>> INFO: task nvme:6725 blocked for more than 491 seconds.
> >>>         Not tainted 5.15.65-f0.el7.x86_64 #1
> >>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >>> task:nvme            state:D
> >>>    stack:    0 pid: 6725 ppid:  1761 flags:0x00004000
> >>> Call Trace:
> >>>    <TASK>
> >>>    __schedule+0x390/0x910
> >>>    ? sched_clock+0x9/0x10
> >>>    schedule+0x55/0xe0
> >>>    schedule_timeout+0x24b/0x2e0
> >>>    ? try_to_wake_up+0x358/0x510
> >>>    ? finish_task_switch+0x88/0x2c0
> >>>    wait_for_completion+0xa5/0x110
> >>>    __flush_work+0x144/0x210
> >>>    ? worker_attach_to_pool+0xc0/0xc0
> >>>    flush_work+0x10/0x20
> >>>    nvme_remove_namespaces+0x41/0xf0 [nvme_core]
> >>>    nvme_do_delete_ctrl+0x47/0x66 [nvme_core]
> >>>    nvme_sysfs_delete.cold.96+0x8/0xd [nvme_core]
> >>>    dev_attr_store+0x14/0x30
> >>>    sysfs_kf_write+0x38/0x50
> >>>    kernfs_fop_write_iter+0x146/0x1d0
> >>>    new_sync_write+0x114/0x1b0
> >>>    ? intel_pmu_handle_irq+0xe0/0x420
> >>>    vfs_write+0x18d/0x270
> >>>    ksys_write+0x61/0xe0
> >>>    __x64_sys_write+0x1a/0x20
> >>>    do_syscall_64+0x37/0x90
> >>>    entry_SYSCALL_64_after_hwframe+0x61/0xcb
> >>> RIP: 0033:0x7ff4b79c4ba0
> >>> RSP: 002b:00007fff37cea528 EFLAGS: 00000246
> >>>    ORIG_RAX: 0000000000000001
> >>> RAX: ffffffffffffffda RBX: 00000000006532e0 RCX: 00007ff4b79c4ba0
> >>> RDX: 0000000000000001 RSI: 000000000043b146 RDI: 0000000000000003
> >>> RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000001962fe0
> >>> R10: 00007fff37ce9f60 R11: 0000000000000246 R12: 0000000001963090
> >>> R13: 00007fff37ceab20 R14: 0000000000000037 R15: 00000000006535c0
> >>>    </TASK>
> >>>
> >>> 5. And, an occasional OOPS (same test, possibly a different issue)
> >
> >> There were some fixes related to oops observed sporadically with
> >> connect/disconnect/reset loops. It was fixed in:
> >> 0fa0f99fc84e ("nvme: fix a possible use-after-free in controller reset
> >> during load")
> >>
> >> Is it applied on your system?
> >
> > This patch was not present in the original testing on 5.15.65. It is present in
> > the latest repro on 5.19.8.
>
> Thanks.
>
> >
> >>>
> >>> BUG: kernel NULL pointer dereference, address: 0000000000000008
> >>> #PF: supervisor read access in kernel mode
> >>> #PF: error_code(0x0000) - not-present page
> >>> PGD 0
> >>> P4D 0
> >>> Oops: 0000 [#1] SMP NOPTI
> >>> CPU: 4 PID: 2131 Comm: kworker/4:2H Not tainted 5.15.65-f0.el7.x86_64 #1
> >>> Hardware name: Supermicro SYS-1019S-WR/X11SSW-F, BIOS 2.1a 03/07/2018
> >>> Workqueue:  0x0
> >>>    (events_highpri)
> >>> RIP: 0010:process_one_work+0x34/0x380
> >>> Code: 57 41 56 41 55 41 54 49 89 fc 53 48 89 f3 48 83 ec 10 48 8b 06
> >>> 4c 8b 7f 48 49 89 c5 45 30 ed a8 04 b8 00 00 00 00 4c 0f 44 e8 <49> 8b
> >>> 45 08 44 8b b0 00 01 00 00 41 83 e6 20 41 f6 47 10 04 75 0f
> >>> RSP: 0018:ffffc90001527e90 EFLAGS: 00010046
> >>> RAX: 0000000000000000 RBX: ffff8881459395d0 RCX: dead000000000122
> >>> RDX: 00000001001d8113 RSI: ffff8881459395d0 RDI: ffff888124d85c00
> >>> RBP: ffffc90001527ec8 R08: ffff888857b2cea8 R09: 0000000000000381
> >>> R10: 00000000000001ce R11: 0000000000000000 R12: ffff888124d85c00
> >>> R13: 0000000000000000 R14: ffff888857b2c120 R15: ffff888857b2c100
> >>> FS:  0000000000000000(0000) GS:ffff888857b00000(0000) knlGS:0000000000000000
> >>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>> CR2: 0000000000000008 CR3: 000000000260a006 CR4: 00000000003706e0
> >>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >>> Call Trace:
> >>>    <TASK>
> >>>    worker_thread+0x37/0x3b0
> >>>    ? process_one_work+0x380/0x380
> >>>    kthread+0x12d/0x150
> >>>    ? set_kthread_struct+0x50/0x50
> >>>    ret_from_fork+0x1f/0x30
> >>>    </TASK>
> >>>
> >>> If there is some way that I can assist, let me know.
>
> Thanks for moving to a recent kernel.
>
> Based on the stack trace, the reason for the hang is that
> disconnect is attempting to remove all the namespaces before
> starting to teardown the controller, before that it flushes
> any ns scanning to not compete with it running concurrently.
>
> but NS scanning is stuck when discovering a namespace because
> adding it as a disk triggers some I/O most likely for stuff
> like partition scanning etc.
>
> The ns scan is stuck only because its inflight I/O never completes,
> which is likely related to the errors you are inserting from the
> controller side every now and then...
>
> I do see a possible race here. that right when a transport error is
> observed, error recovery is scheduled (err_work) but before it is
> executing, delete_ctrl is starting to teardown the controller,
> particularly calling nvme_stop_ctrl() -> nvme_tcp_stop_ctrl()
> which cancels the err_work.
>
> If the error recovery is not running, nothing will fail inflight
> commands if they are not failed by the controller explicitly.
>
> What would be helpful, is to know that once the issue reproduced,
> if the ctrl->err_work, was canceled without executing.
>
> So if the theory is correct, this fix is warranted:
> --
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index d5871fd6f769..2524b5304bfb 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2237,7 +2237,7 @@ static void nvme_reset_ctrl_work(struct
> work_struct *work)
>
>   static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
>   {
> -       cancel_work_sync(&to_tcp_ctrl(ctrl)->err_work);
> +       flush_work(&to_tcp_ctrl(ctrl)->err_work);
>          cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
>   }
> --
>
> This will make err_work to run, and then it is guaranteed that all
> inflight requests are completed/cancelled.

Good news. I ran with the fix proposed continuously for three days
without reproducing the issue. Is there any specific instrumentation
you want me to run to get direct confirmation of the bug/fix? If not,
I think we're all set.

