Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC0CECAAD3
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Sep 2022 22:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XquxIa/C+HgJBcKhlLUpfjvYsfEojeNfxnY9rJ03XFY=; b=zpr3HbKetRrVImSzprwDXpq3X6
	x2ofL51XunQOfryYC9yfdFev6Q5qCiFEb8ol4bJDzaaqHwDQOiW5XYZUPb7pB5WUMxROA6DqZaiP7
	n03yzDhFLl8HYXR0FqlPHtLNIYA7DnrAMcOmWA5GpY7fEDc4aCg7++HuMI25Cpz0xDl53X8QyU6sK
	eQZMI6ExTLn6jyLskrwvtcfuIEjWa3TMlV+Yca5hLU4bH6M1FgbQW+5J/EsZ0r23HXWGDCBsnBD+j
	5f0hfG22D0kryxCGFShufXe+fkLgpUHL0oNwn/6FMeGR91ukHtxKPvcze05ARsH7dZa9RRrSw9tEx
	HrxfZ1TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWmD4-003PXL-C7; Fri, 09 Sep 2022 22:10:50 +0000
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWmAz-003NIA-VO
	for linux-nvme@lists.infradead.org; Fri, 09 Sep 2022 22:08:43 +0000
Received: by mail-yb1-xb2a.google.com with SMTP id t184so4647739yba.4
        for <linux-nvme@lists.infradead.org>; Fri, 09 Sep 2022 15:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=XquxIa/C+HgJBcKhlLUpfjvYsfEojeNfxnY9rJ03XFY=;
        b=vpmRpPKIfMVMzbaRJizRmqtjmxVYxU3q+GwrEEoPEeObK3aQjRxIejSVh+hMfMW/ws
         cG0OEvfpkMG8idb0frHUDE9pMvGYh2DFnScRZ+j3vFS5eSA30hFSFJL2uOdbTUxa9mfz
         MUvT0aLjxnOfx4XtyEVXfzHfxHUsfdJ7gTnCryyPNTCq3ACxAW2vSaK2gu/wjseMVB08
         AxqnqOi8ez1VhTQPCP5U64nMh4gdDgzW6z7mgy9bgAUsIAZ23iceAh5lnLhrwsM6XBRP
         RxE2Y5J92eDMUQtGnm80KWeV/UAG/hBQH/46Z10SW3yKLOPRp4ptip8Mr+eIPePdb1rb
         vI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=XquxIa/C+HgJBcKhlLUpfjvYsfEojeNfxnY9rJ03XFY=;
        b=X3r2oQmtRn+JEJYECbHzSFrpYTofS3WNpHAAYrePtXVJ6BKFGbbb6Ap9iSSoFWNDKC
         4bsjEKLsFpLU3/FeyBpDObW/Zv/YZ6dUeHTDDnTPVdFZ5J903QDIN/XBbTCdgDjaDial
         acqvZNyQr9rKsWYd6mEiA73ZEsmG4VRp/ZBchuv0WiP7TlWzHyMq7+TSSfq4C1gcb7ut
         2e6lUQLA6BUPX5p6M/AlIlzM8iMCjPlGvXE+8Yq+STeZAPZm8A1XdSH08PR3+0efz3KZ
         hsNS8Fmj+61oFM1fcoYI+kZqrHtLpRzZHFxHdL3SA1SEnKCu1eXt0T6KoMtzyu3rXVb/
         KNOg==
X-Gm-Message-State: ACgBeo1GDLw5BVzuOuEMZymhy13Wx/LJGvA+5aM4F0jgR/6yfm3oPd9b
	heFp+eLF0wSi6tcBLnDNtH0k73P5TjPV0IK6yLLs+4UsdhdRe5iz
X-Google-Smtp-Source: AA6agR6oXxKrZmVcTyRDczpv9KfWbzP5RtwJt9EsJ5xVJLIIrRSui3N+2Fl4WQkPJIQEf5ZbWDJSX2t+bF27w7qTuIM=
X-Received: by 2002:a25:4d4:0:b0:6a9:4de5:35c1 with SMTP id
 203-20020a2504d4000000b006a94de535c1mr12984748ybe.43.1662761317607; Fri, 09
 Sep 2022 15:08:37 -0700 (PDT)
MIME-Version: 1.0
From: Jonathan Nicklin <jnicklin@blockbridge.com>
Date: Fri, 9 Sep 2022 18:08:01 -0400
Message-ID: <CAHex0cqsATq98N3xevr0-vEcKBaRnTV1cm8einZ925CYyJNcsw@mail.gmail.com>
Subject: nvme/tcp: infinite loop, livelock, and OOPS issues on disconnect
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220909_150842_075052_89BFD112 
X-CRM114-Status: UNSURE (   9.06  )
X-CRM114-Notice: Please train this message.
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

Hello,

We've seen system hangs and OOPS with nvme/tcp with host-initiated
disconnects during fault testing. To help debug, I've developed a short repro
scenario (~5 minutes runtime) that triggers the issue on 5.15.65.

To reproduce:

On the host:
 - run connect and disconnect to a single subsystem in a loop
On the target:
 - inject random transport failures every 1-2 seconds

There are a few observed results:

1. The system either hangs completely (reboot required) or nvme management
commands hang (i.e., nvme list and nvme connect)

2. If the system stays alive, "nvme nvme1: failed to send request -32" streams
from the kernel in an infinite loop.

3. nvme tracing shows a loop trying to read the same lba:

kworker/2:1H-6376    [002] .....  4314.468725: nvme_setup_cmd:
  nvme1: disk=nvme1c1n1, qid=3, cmdid=61519, nsid=1, flags=0x0, meta=0x0
  cmd=(nvme_cmd_read slba=8, len=7, ctrl=0x0, dsmgmt=0, reftag=0)
kworker/2:1H-6376    [002] .N...  4314.473568: nvme_complete_rq:
  nvme1: disk=nvme1c1n1, qid=3, cmdid=61519, res=0x0, retries=0, flags=0x0,
  status=0x370

4. Hung task warnings for kernel worker threads:

INFO: task kworker/u16:2:6524 blocked for more than 491 seconds.
      Not tainted 5.15.65-f0.el7.x86_64 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u16:2   state:D stack:    0 pid: 6524 ppid:     2 flags:0x00004000
Workqueue: nvme-wq nvme_scan_work [nvme_core]

Call Trace:
 <TASK>
 __schedule+0x390/0x910
 ? scan_shadow_nodes+0x40/0x40
 schedule+0x55/0xe0
 io_schedule+0x16/0x40
 do_read_cache_page+0x55d/0x850
 ? __page_cache_alloc+0x90/0x90
 read_cache_page+0x12/0x20
 read_part_sector+0x3f/0x110
 amiga_partition+0x3d/0x3e0
 ? osf_partition+0x33/0x220
 ? put_partition+0x90/0x90
 bdev_disk_changed+0x1fe/0x4d0
 blkdev_get_whole+0x7b/0x90
 blkdev_get_by_dev+0xda/0x2d0
 device_add_disk+0x356/0x3b0
 nvme_mpath_set_live+0x13c/0x1a0 [nvme_core]
 ? nvme_parse_ana_log+0xae/0x1a0 [nvme_core]
 nvme_update_ns_ana_state+0x3a/0x40 [nvme_core]
 nvme_mpath_add_disk+0x120/0x160 [nvme_core]
 nvme_alloc_ns+0x594/0xa00 [nvme_core]
 nvme_validate_or_alloc_ns+0xb9/0x1a0 [nvme_core]
 ? __nvme_submit_sync_cmd+0x1d2/0x210 [nvme_core]
 nvme_scan_work+0x281/0x410 [nvme_core]
 process_one_work+0x1be/0x380
 worker_thread+0x37/0x3b0
 ? process_one_work+0x380/0x380
 kthread+0x12d/0x150
 ? set_kthread_struct+0x50/0x50
 ret_from_fork+0x1f/0x30
 </TASK>
INFO: task nvme:6725 blocked for more than 491 seconds.
      Not tainted 5.15.65-f0.el7.x86_64 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:nvme            state:D
 stack:    0 pid: 6725 ppid:  1761 flags:0x00004000
Call Trace:
 <TASK>
 __schedule+0x390/0x910
 ? sched_clock+0x9/0x10
 schedule+0x55/0xe0
 schedule_timeout+0x24b/0x2e0
 ? try_to_wake_up+0x358/0x510
 ? finish_task_switch+0x88/0x2c0
 wait_for_completion+0xa5/0x110
 __flush_work+0x144/0x210
 ? worker_attach_to_pool+0xc0/0xc0
 flush_work+0x10/0x20
 nvme_remove_namespaces+0x41/0xf0 [nvme_core]
 nvme_do_delete_ctrl+0x47/0x66 [nvme_core]
 nvme_sysfs_delete.cold.96+0x8/0xd [nvme_core]
 dev_attr_store+0x14/0x30
 sysfs_kf_write+0x38/0x50
 kernfs_fop_write_iter+0x146/0x1d0
 new_sync_write+0x114/0x1b0
 ? intel_pmu_handle_irq+0xe0/0x420
 vfs_write+0x18d/0x270
 ksys_write+0x61/0xe0
 __x64_sys_write+0x1a/0x20
 do_syscall_64+0x37/0x90
 entry_SYSCALL_64_after_hwframe+0x61/0xcb
RIP: 0033:0x7ff4b79c4ba0
RSP: 002b:00007fff37cea528 EFLAGS: 00000246
 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000006532e0 RCX: 00007ff4b79c4ba0
RDX: 0000000000000001 RSI: 000000000043b146 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000001962fe0
R10: 00007fff37ce9f60 R11: 0000000000000246 R12: 0000000001963090
R13: 00007fff37ceab20 R14: 0000000000000037 R15: 00000000006535c0
 </TASK>

5. And, an occasional OOPS (same test, possibly a different issue)

BUG: kernel NULL pointer dereference, address: 0000000000000008
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0
P4D 0
Oops: 0000 [#1] SMP NOPTI
CPU: 4 PID: 2131 Comm: kworker/4:2H Not tainted 5.15.65-f0.el7.x86_64 #1
Hardware name: Supermicro SYS-1019S-WR/X11SSW-F, BIOS 2.1a 03/07/2018
Workqueue:  0x0
 (events_highpri)
RIP: 0010:process_one_work+0x34/0x380
Code: 57 41 56 41 55 41 54 49 89 fc 53 48 89 f3 48 83 ec 10 48 8b 06
4c 8b 7f 48 49 89 c5 45 30 ed a8 04 b8 00 00 00 00 4c 0f 44 e8 <49> 8b
45 08 44 8b b0 00 01 00 00 41 83 e6 20 41 f6 47 10 04 75 0f
RSP: 0018:ffffc90001527e90 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8881459395d0 RCX: dead000000000122
RDX: 00000001001d8113 RSI: ffff8881459395d0 RDI: ffff888124d85c00
RBP: ffffc90001527ec8 R08: ffff888857b2cea8 R09: 0000000000000381
R10: 00000000000001ce R11: 0000000000000000 R12: ffff888124d85c00
R13: 0000000000000000 R14: ffff888857b2c120 R15: ffff888857b2c100
FS:  0000000000000000(0000) GS:ffff888857b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000008 CR3: 000000000260a006 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 worker_thread+0x37/0x3b0
 ? process_one_work+0x380/0x380
 kthread+0x12d/0x150
 ? set_kthread_struct+0x50/0x50
 ret_from_fork+0x1f/0x30
 </TASK>

If there is some way that I can assist, let me know.

Thanks,
-Jonathan

