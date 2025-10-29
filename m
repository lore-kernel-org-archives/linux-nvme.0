Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431DECCF9EB
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 21:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YgG4dN9EoCCaQ4L4J+hSiTOPtn4oW+9mN370kjQhTQc=; b=BGtpb5qUZYbXOaHc0PoidtVviy
	Tn7Gd4sZUXqP3VY2G0sKzi2DPW3/AjzGNvzmM1YtG32hJ6KY6jq3+MLh6y62pBqMBaf+gL2sPJN7U
	TTuewn/Xpxpsp/UWtSxKEYRJ4NYiX4kl7eFOuxqiNMbDD80uFNBVQ7PkgEHJ3MuAi9K95D88Ee+ee
	O+WHQoxkKgUigN9Rx4wJk0Zi9pMVqjq4jDE2JP+Y6oOQurKLjLb6VHSpArH5uHStcaSnH4j94LL9v
	4tLnMHfj/43WqsutGr3JNU0mTt5m/TDv0/Cn/8o6oAbz1LnUiTFB4xFyfDpAwxIZxRky5UicDdKtV
	9h80lBHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEDPt-00000002uPD-0VsI;
	Wed, 29 Oct 2025 21:09:13 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEDPq-00000002uOJ-1nrg
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 21:09:12 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-63c184bb78eso49397a12.1
        for <linux-nvme@lists.infradead.org>; Wed, 29 Oct 2025 14:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761772148; x=1762376948; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YgG4dN9EoCCaQ4L4J+hSiTOPtn4oW+9mN370kjQhTQc=;
        b=YFdCcJ5TtJH1Sheht7iXBt+//Uf8MnyKLOWDUicoLdq4GvM1PiTOF04JKioTCVEg6U
         cbPhHuwa7TKqwq0yMOrfbIjT0C1Z+PxKcU3w8kSQqsh6fwFDlh91eu1N91eTmOuuASgz
         uT569v/3F8DHdE9MVTFG07KLEmib32A47ExN98HTab8h3HiVDtylrrD/PI+MmdnelSiT
         eaBtoVtEs1/dpRkFb9VFEv71xZN3rrDJbdZwzCmA17h3r3jGSsayndXsWT9VkvVXAFkr
         ivy6ffChYSbTvGNq0w+YKhCjBtk4yBycXjSzsvKyemcsAqOnWDczkDQ0gfikv2o54TLC
         /N+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761772148; x=1762376948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YgG4dN9EoCCaQ4L4J+hSiTOPtn4oW+9mN370kjQhTQc=;
        b=srP8pKftcSXezyhmPlWyYsejBf2jcVE8bwc+ssW7KYIgArzK0QFpjWRbyWo3WiEBqL
         ILQr3Bh+frHQtNpyuS97osj+JGwyEcZZ2o23CkKp3nSfcW+8WwYHe7U8ZHvbWjcO9yP3
         pG3LS0cLC2AoSWvqRafLA4fyhjkQGKk2GJ9QzlkxZWWbqDFaL+Xk71uZS7bVUFk9dWcF
         iae3WAKS/vWXac+P+3ashfdkxw6PzlLBC4i2wcLdGDiuKDD885w74qS7SycHQmUvjoNW
         aGg8KyZY08GAOnlJyPqRhi+i5nFrK57FN36uvY9jtHpx3V13/FnD+gzA3fqFE/g/J0TM
         SEBA==
X-Gm-Message-State: AOJu0YwNwKF8L2knCBCLhUFxO2SaCpZWJwh1I/OnOT5yzjZ4b7ZuorOL
	LWbTEA+XVMI0edKzXQykD+hgyZrKF4or1PCK9NaQIktCOoWlLJ3ZA9VPmp6H1Pz+jmOznb4/cXd
	E/jRWBm8O/otqVeEWsKJVrmMJdBHK5+xX+ojMcp7mUcQFi4Pmc2q2+sWXe/GKkBz9JGaPW2OjCK
	BmJfDmjxNSqaIzXahBDjQLbOvkOPy1kH0tgV82XXWPuO4tFVufW0WbmQ==
X-Gm-Gg: ASbGncsciGnuG/3EvEDvZ0WNoM3hni32mwR020wgXDTegF1ZxEim+FzGGttB8KECU6e
	ySojpCF0KfguunHkh/iUvG8UJscgbNrTKYKvtRMbd8TJ/TN6CXbr94M0jKLxZHlKxziQzZUeBgN
	tcFebxYDQK+hS7nu94K7qHm0XtkUIWbVZDP871M4i9/LJHdqXbbp+0Fr6qobrInCIdZJ+Dj3omv
	V9GU2Xn7CXM0goHv7miOWQmiyr070J3Dy+GCgd1ZMDo4nJsxFtY/EtLZRebiMCYwOZ0/MhtSPd1
	Ek40A/cmPdURw1dTJQ1RewBwb94QEY1c6BR4OjoBSZIYTjudQnd3tjhcwkAbdD2mk9CPu05xP+a
	w0G5BMiDDlYbv7K7SQXSvcykNRrCit2i1V05uajY3yeRHcSTeAuRNltYeYnj308Lj0Prj60fRYU
	qvhPXSdFY//Lhd88r9fA==
X-Google-Smtp-Source: AGHT+IGPH0dmxSLQbl+e6DinDDqslq27X+d73ttHr1biucCjdkTKsS6TTqxhVvndQYjXNHchGgDrPQ==
X-Received: by 2002:a05:6402:42d2:b0:63c:1d4a:afcb with SMTP id 4fb4d7f45d1cf-64043f2fa7fmr2059154a12.0.1761772147681;
        Wed, 29 Oct 2025 14:09:07 -0700 (PDT)
Received: from dev-cachen.dev.purestorage.com ([2620:125:9007:640:ffff::9190])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef82907sm12966917a12.12.2025.10.29.14.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 14:09:06 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Cc: yzhong@purestorage.com,
	sconnor@purestorage.com,
	axboe@kernel.dk,
	mkhalfella@purestorage.com,
	Casey Chen <cachen@purestorage.com>
Subject: [PATCH 0/1] cover letter
Date: Wed, 29 Oct 2025 15:08:52 -0600
Message-ID: <20251029210853.20768-1-cachen@purestorage.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_140910_866873_FC86DA31 
X-CRM114-Status: GOOD (  12.06  )
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

When a controller is deleted (e.g., via sysfs delete_controller), the
admin queue is freed while userspace may still have open fd to the
namespace block device. Userspace can issue IOCTLs on the open fd
that access the freed admin queue through the stale ns->ctrl->admin_q
pointer, causing a use-after-free.

Fix this by taking an additional reference on the admin queue during
namespace allocation and releasing it during namespace cleanup.

We can easily reproduce this issue by doing following experiment.

1. Adding 10s delay in nvme_submit_user_cmd before it allocates request.
@@ -175,6 +176,10 @@ static int nvme_submit_user_cmd(struct request_queue *q,
        u32 effects;
        int ret;

+       pr_info("About to sleep for 10 seconds\n");
+       msleep(10000);
+       pr_info("Done sleeping for 10 seconds\n");
+
        req = nvme_alloc_user_request(q, cmd, 0, 0);
        if (IS_ERR(req))
                return PTR_ERR(req);

2. Run nvme command to send admin cmd through block device
$ strace -vf nvme read --start-block=0 --data-size=4096 /dev/nvme12n1

3. Right after issuing the nvme command, remove nvme device from sysfs
$ echo 1 > /sys/bus/pci/devices/0000\:ce\:00.0/remove

Output from strace:

openat(AT_FDCWD, "/dev/nvme12n1", O_RDONLY) = 3
fstat(3, {st_dev=makedev(0, 0x6), st_ino=711, st_mode=S_IFBLK|0660, st_nlink=1, st_uid=0, st_gid=6, st_blksize=4096, st_blocks=0, st_rdev=makedev(0x103, 0xa4), st_atime=1761700579 /* 2025-10-29T01:16:19.769373519+0000 */, st_atime_nsec=769373519, st_mtime=1761700579 /* 2025-10-29T01:16:19.769373519+0000 */, st_mtime_nsec=769373519, st_ctime=1761700579 /* 2025-10-29T01:16:19.769373519+0000 */, st_ctime_nsec=769373519}) = 0
ioctl(3, NVME_IOCTL_ID, 0)              = 3
ioctl(3, NVME_IOCTL_ADMIN_CMD, "\x06\x00\x00\x00\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x60\x54\x00\x00\x00\x00\x00"... => "\x06\x00\x00\x00\x03\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x60\x54\x00\x00\x00\x00\x00"...) = -1 ENODEV (No such device)
write(2, "identify namespace: No such devi"..., 34identify namespace: No such device) = 34
write(2, "\n", 1
)                       = 1
close(3)                                = 0
exit_group(1)                           = ?
+++ exited with 1 +++

strace shows it stuck at identify namespace admin command.

Output from KASAN:

[  360.958500] ==================================================================
[  360.959310] BUG: KASAN: slab-use-after-free in blk_queue_enter+0x41c/0x4a0
[  360.960213] Read of size 8 at addr ffff88c0a53819f8 by task nvme/3287

[  360.962096] CPU: 67 UID: 0 PID: 3287 Comm: nvme Tainted: G            E       6.13.2-ga1582f1a031e #15
[  360.962103] Tainted: [E]=UNSIGNED_MODULE
[  360.962105] Hardware name: Jabil /EGS 2S MB1, BIOS 1.00 06/18/2025
[  360.962107] Call Trace:
[  360.962110]  <TASK>
[  360.962112]  dump_stack_lvl+0x4f/0x60
[  360.962120]  print_report+0xc4/0x620
[  360.962128]  ? _raw_spin_lock_irqsave+0x70/0xb0
[  360.962135]  ? _raw_read_unlock_irqrestore+0x30/0x30
[  360.962139]  ? blk_queue_enter+0x41c/0x4a0
[  360.962143]  kasan_report+0xab/0xe0
[  360.962147]  ? blk_queue_enter+0x41c/0x4a0
[  360.962151]  blk_queue_enter+0x41c/0x4a0
[  360.962155]  ? __irq_work_queue_local+0x75/0x1d0
[  360.962162]  ? blk_queue_start_drain+0x70/0x70
[  360.962166]  ? irq_work_queue+0x18/0x20
[  360.962170]  ? vprintk_emit.part.0+0x1cc/0x350
[  360.962176]  ? wake_up_klogd_work_func+0x60/0x60
[  360.962180]  blk_mq_alloc_request+0x2b7/0x6b0
[  360.962186]  ? __blk_mq_alloc_requests+0x1060/0x1060
[  360.962190]  ? __switch_to+0x5b7/0x1060
[  360.962198]  nvme_submit_user_cmd+0xa9/0x330
[  360.962204]  nvme_user_cmd.isra.0+0x240/0x3f0
[  360.962208]  ? force_sigsegv+0xe0/0xe0
[  360.962215]  ? nvme_user_cmd64+0x400/0x400
[  360.962218]  ? vfs_fileattr_set+0x9b0/0x9b0
[  360.962224]  ? cgroup_update_frozen_flag+0x24/0x1c0
[  360.962231]  ? cgroup_leave_frozen+0x204/0x330
[  360.962236]  ? nvme_ioctl+0x7c/0x2c0
[  360.962238]  blkdev_ioctl+0x1a8/0x4d0
[  360.962242]  ? blkdev_common_ioctl+0x1930/0x1930
[  360.962244]  ? fdget+0x54/0x380
[  360.962251]  __x64_sys_ioctl+0x129/0x190
[  360.962255]  do_syscall_64+0x5b/0x160
[  360.962260]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  360.962267] RIP: 0033:0x7f765f703b0b
[  360.962271] Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d dd 52 0f 00 f7 d8 64 89 01 48
[  360.962275] RSP: 002b:00007ffe2cefe808 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
[  360.962280] RAX: ffffffffffffffda RBX: 00007ffe2cefe860 RCX: 00007f765f703b0b
[  360.962283] RDX: 00007ffe2cefe860 RSI: 00000000c0484e41 RDI: 0000000000000003
[  360.962285] RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
[  360.962287] R10: 00007f765f611d50 R11: 0000000000000202 R12: 0000000000000003
[  360.962289] R13: 00000000c0484e41 R14: 0000000000000001 R15: 00007ffe2cefea60
[  360.962293]  </TASK>

[  361.046089] Allocated by task 970:
[  361.048182]  kasan_save_stack+0x1c/0x40
[  361.050278]  kasan_save_track+0x10/0x30
[  361.052339]  __kasan_slab_alloc+0x7d/0x80
[  361.054396]  kmem_cache_alloc_node_noprof+0xe5/0x3a0
[  361.056485]  blk_alloc_queue+0x31/0x700
[  361.058573]  blk_mq_alloc_queue+0x13e/0x210
[  361.060660]  nvme_alloc_admin_tag_set+0x32e/0x620
[  361.062760]  nvme_probe+0x951/0x1810
[  361.064836]  local_pci_probe+0xc6/0x170
[  361.066909]  work_for_cpu_fn+0x4e/0xa0
[  361.068968]  process_one_work+0x5a4/0xe00
[  361.071035]  worker_thread+0x8a2/0x1560
[  361.073103]  kthread+0x284/0x350
[  361.075159]  ret_from_fork+0x2d/0x70
[  361.077217]  ret_from_fork_asm+0x11/0x20

[  361.081256] Freed by task 0:
[  361.083263]  kasan_save_stack+0x1c/0x40
[  361.085300]  kasan_save_track+0x10/0x30
[  361.087299]  kasan_save_free_info+0x37/0x50
[  361.089287]  __kasan_slab_free+0x4b/0x60
[  361.091277]  kmem_cache_free+0x11a/0x5c0
[  361.093266]  rcu_core+0x6da/0xe50
[  361.095232]  handle_softirqs+0x196/0x570
[  361.097193]  __irq_exit_rcu+0xb6/0xf0
[  361.099097]  sysvec_apic_timer_interrupt+0x6e/0x90
[  361.100943]  asm_sysvec_apic_timer_interrupt+0x16/0x20

[  361.104458] Last potentially related work creation:
[  361.106185]  kasan_save_stack+0x1c/0x40
[  361.107893]  __kasan_record_aux_stack+0xba/0xd0
[  361.109628]  __call_rcu_common.constprop.0+0x70/0x790
[  361.111393]  nvme_remove_admin_tag_set+0x94/0x1b0
[  361.113166]  nvme_remove+0xce/0x350
[  361.114879]  pci_device_remove+0x65/0x110
[  361.116620]  device_release_driver_internal+0x34d/0x670
[  361.118410]  pci_stop_bus_device+0x106/0x150
[  361.120209]  pci_stop_and_remove_bus_device_locked+0x16/0x30
[  361.122072]  remove_store+0xab/0xc0
[  361.123929]  kernfs_fop_write_iter+0x2f2/0x550
[  361.125792]  vfs_write+0x54b/0xbd0
[  361.127631]  ksys_write+0xe0/0x190
[  361.129459]  do_syscall_64+0x5b/0x160
[  361.131274]  entry_SYSCALL_64_after_hwframe+0x4b/0x53

[  361.134937] Second to last potentially related work creation:
[  361.136852]  kasan_save_stack+0x1c/0x40
[  361.138760]  __kasan_record_aux_stack+0xba/0xd0
[  361.140685]  insert_work+0x2b/0x1f0
[  361.142612]  __queue_work.part.0+0x516/0xb20
[  361.144564]  queue_work_on+0x5a/0x70
[  361.146526]  call_timer_fn+0x25/0x190
[  361.148475]  __run_timers+0x522/0x850
[  361.150433]  run_timer_softirq+0x117/0x270
[  361.152402]  handle_softirqs+0x196/0x570
[  361.154398]  __irq_exit_rcu+0xb6/0xf0
[  361.156402]  sysvec_apic_timer_interrupt+0x6e/0x90
[  361.158439]  asm_sysvec_apic_timer_interrupt+0x16/0x20

[  361.162525] The buggy address belongs to the object at ffff88c0a53819b0
[  361.162525]  which belongs to the cache request_queue of size 968
[  361.166831] The buggy address is located 72 bytes inside of
[  361.166831]  freed 968-byte region [ffff88c0a53819b0, ffff88c0a5381d78)

[  361.173361] The buggy address belongs to the physical page:
[  361.175584] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x40a5380
[  361.177895] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  361.180251] flags: 0x15ffff0000000040(head|node=1|zone=2|lastcpupid=0x1ffff)
[  361.182652] page_type: f5(slab)
[  361.185024] raw: 15ffff0000000040 ffff88810b26e800 dead000000000122 0000000000000000
[  361.187525] raw: 0000000000000000 00000000801d001d 00000001f5000000 0000000000000000
[  361.190033] head: 15ffff0000000040 ffff88810b26e800 dead000000000122 0000000000000000
[  361.192551] head: 0000000000000000 00000000801d001d 00000001f5000000 0000000000000000
[  361.195057] head: 15ffff0000000003 ffffea010294e001 ffffffffffffffff 0000000000000000
[  361.197564] head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
[  361.200047] page dumped because: kasan: bad access detected

[  361.205007] Memory state around the buggy address:
[  361.207539]  ffff88c0a5381880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  361.210162]  ffff88c0a5381900: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
[  361.212762] >ffff88c0a5381980: fc fc fc fc fc fc fa fb fb fb fb fb fb fb fb fb
[  361.215346]                                                                 ^
[  361.217944]  ffff88c0a5381a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  361.220542]  ffff88c0a5381a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  361.223104] ==================================================================
[  361.225739] Disabling lock debugging due to kernel taint


Yuanyuan Zhong (1):
  nvme: fix use-after-free of admin queue via stale pointer

 drivers/nvme/host/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.49.0


