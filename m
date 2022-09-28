Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77C3C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 06:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+lL0YYPIt6RG5pPpD8xP+x0mMww4TKcJM4kvnAiy0z4=; b=og+4a3F7n3toYc0NwC8/Nd62Ha
	aHstgExzL90hC1yqwzde0YJdMH9SyF/pNB/bU6L5e1o0VEAyb+xmsXmRcS03xi/7UuQzI8Tf9URLW
	+ShpfBjpQA2PJyhCii3mdZYoRv1PWOSW2k7ZksrCMRIp/W6DGDxiwD0spLUMMIoWi3KyjiI+Ljj0W
	mm2HtUzthMu8Sl8ZjUxPTgYhbnBieGfKslz2r8lCTFLlixYsCALUiyuKNxMKWkQlqYZnhSWzInd2g
	DafGkCQGwZadQ3jni4LiIt/hkIIGEdJ2HqJ0yoMh6aRiYANTWlkWRuCyLVZ+vrkiUw5nvhbyeRQ+G
	Y7hPAbHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odQTn-00EEic-Hg; Wed, 28 Sep 2022 06:23:35 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odQTk-00EEho-5h
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 06:23:33 +0000
Received: by mail-wm1-f48.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso441157wms.5
        for <linux-nvme@lists.infradead.org>; Tue, 27 Sep 2022 23:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=+lL0YYPIt6RG5pPpD8xP+x0mMww4TKcJM4kvnAiy0z4=;
        b=GtCyJo3UKcXvh8YM4+WbGWtCX927WnmLSfIhRD13LtBuNdtTMAeQP8YnIe3ETpBPf5
         HBYl22x2wA6FenAq0+VmqTN4DtNU4SE69+RDaeBBnspfPum4m9eozDEOYP8XzOmZOumq
         2kjoyjM+6OHAILfxjFyZtLDGV3myd09pEJq783ebOtSJBzsKQiGKZIXoNl3wmVr6qX8m
         3dhKtc5Pznursljb/wO0KSihaQvfRwNuFV2RI4ebhzhrL7JeoMYwXZqe/Hj3dazRRBvb
         g6OpL0K71CazPbBFjoe5artlnqvEYDSua1jtSHsVCyCgBEfRsHD2qvQTZSCVFcA8D0d6
         54dg==
X-Gm-Message-State: ACrzQf1XwIyDUUo0M1g3SH/GESMt2CB7HqwD3iCXOaTzHV+iFXpuW8v1
	OKkz5pWV7CGC9TLcwG9Adq4feU3ZtMU=
X-Google-Smtp-Source: AMsMyM6j3cu3TLFnYps7fMftb9ohqvpFQ9vdR1Krmmsvy3+UtPxShXFUwa8lkJGpDt8qvQOd3ypJtQ==
X-Received: by 2002:a7b:c047:0:b0:3b4:adc7:1ecb with SMTP id u7-20020a7bc047000000b003b4adc71ecbmr5356939wmc.144.1664346209118;
        Tue, 27 Sep 2022 23:23:29 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f13-20020a056000128d00b0022afcc11f65sm3411557wrx.47.2022.09.27.23.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 23:23:28 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Jonathan Nicklin <jnicklin@blockbridge.com>
Subject: [PATCH 1/2] nvme-tcp: fix possible hang caused during ctrl deletion
Date: Wed, 28 Sep 2022 09:23:25 +0300
Message-Id: <20220928062326.45119-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_232332_255259_4865BD94 
X-CRM114-Status: GOOD (  16.54  )
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

When we delete a controller, we execute the following:
1. nvme_stop_ctrl() - stop some work elements that may be
	inflight or scheduled (specifically also .stop_ctrl
	which cancels ctrl error recovery work)
2. nvme_remove_namespaces() - which first flushes scan_work
	to avoid competing ns addition/removal
3. continue to teardown the controller

However, if err_work was scheduled to run in (1), it is designed to
cancel any inflight I/O, particularly I/O that is originating from ns
scan_work in (2), but because it is cancelled in .stop_ctrl(), we can
prevent forward progress of (2) as ns scanning is blocking on I/O
(that will never be cancelled).

The race is:
1. transport layer error observed -> err_work is scheduled
2. scan_work executes, discovers ns, generate I/O to it
3. nvme_ctop_ctrl() -> .stop_ctrl() -> cancel_work_sync(err_work)
   - err_work never executed
4. nvme_remove_namespaces() -> flush_work(scan_work)
--> deadlock, because scan_work is blocked on I/O that was supposed
to be cancelled by err_work, but was cancelled before executing (see
stack trace [1]).

Fix this by flushing err_work instead of cancelling it, to force it
to execute and cancel all inflight I/O.

[1]:
--
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
--

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Reported-by: Jonathan Nicklin <jnicklin@blockbridge.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d5871fd6f769..2524b5304bfb 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2237,7 +2237,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 
 static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
 {
-	cancel_work_sync(&to_tcp_ctrl(ctrl)->err_work);
+	flush_work(&to_tcp_ctrl(ctrl)->err_work);
 	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
 }
 
-- 
2.34.1


