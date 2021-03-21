Return-Path: <SRS0=79y3=IT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B51C433DB
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Mar 2021 07:09:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F066192C
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Mar 2021 07:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F066192C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+nwwhkQA4VdFUSPbh7CdvxD4EV2YatJ8WGoq0TJTbjI=; b=VFG4GBJ79h0mcOw24yn5GiBzK
	Og90LvAqxtdbrFFEH3W+09o+FK3yt+WVaEdPo0D1LXODSbNtrFGUC35rHDcyIdaCzVb1Vq0BdD4Ay
	CpnsFlYQNUj/90WqPfYexNkMMIRNcjyP8nb3l+H+dwEed2m8bBsJZjM25LlzMLONK5G5vZgLaGe3r
	KQD9cpSq1cmN39IvOyqLe3TMlk+FAZ2n4mtdDvYfRtZ5aNZc8bxSxUK8mMevV+JCidxbbtA1BywaM
	mSrwzMN9Gx+SH2JenYqlF2rkH1duY0G6UGKcDa0z9b2MeAZp79GAhOCuzi9gG5rWvXW7Dkzfnv8Fj
	TT2ZxQCHA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lNsCy-009hUP-89; Sun, 21 Mar 2021 07:09:08 +0000
Received: from mail-pj1-f50.google.com ([209.85.216.50])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lNsCk-009hSQ-P9
 for linux-nvme@lists.infradead.org; Sun, 21 Mar 2021 07:08:56 +0000
Received: by mail-pj1-f50.google.com with SMTP id
 mz6-20020a17090b3786b02900c16cb41d63so6917432pjb.2
 for <linux-nvme@lists.infradead.org>; Sun, 21 Mar 2021 00:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/8WQ87OFt1cGlMvEAEyFaKZpk+17hYqgNAD/xn44yQc=;
 b=hbiJUMgCeEi0RGZzhftJXh47/9B31jepeA8jSmbB5ucvNux6NdOR4f65ynlDIkfOne
 OQhHtg1qs2MW+mQl0HtbC27pgrsb+8KjIqr+g8gkpuWh90uBvmSrPR9G0DgiGTjBUDr1
 YvesOsjARPtlI+4GLxdTHZsi+hRTvpG10xHi7Fz6b7/Dy0unLWP8gFlHw24KmA8PIzzC
 RaFQrst+4rfSeVU5oipwxeI/qv7y3/iTdsmHLKxocJhJIDFXtAX4THzjkRDc5vKnkt76
 TcGqosaueA8wAbRDMK7tsOPGvBGN7lD6e1stRIbE1GEcZtJ+ZRt2MIgZ/mm+0VBBIolU
 HTJQ==
X-Gm-Message-State: AOAM533IA6FDqvvu8WCdhtMiUdJd/ghKcMfE+2qJpUkm8EFhCTYwdp4t
 6VW6RWWFqWviqg3uXidb2BRAhmnmsuw=
X-Google-Smtp-Source: ABdhPJzMDEiaeXHkaj5+OEcmv/4ltvqJTni3PbtHmGUZ7she7CPO0zpgLgzOhNHQYnVv7qBvxoI8Ng==
X-Received: by 2002:a17:90b:4c0a:: with SMTP id
 na10mr7212188pjb.227.1616310532960; 
 Sun, 21 Mar 2021 00:08:52 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:b1ab:c8be:b97:f20c])
 by smtp.gmail.com with ESMTPSA id
 y194sm9891015pfb.21.2021.03.21.00.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Mar 2021 00:08:52 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH 2/2] nvmet-tcp: Fix incorrect locking in state_change sk
 callback
Date: Sun, 21 Mar 2021 00:08:49 -0700
Message-Id: <20210321070849.813104-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210321070849.813104-1-sagi@grimberg.me>
References: <20210321070849.813104-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210321_070855_086513_A5ACDF31 
X-CRM114-Status: GOOD (  14.83  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We are not changing anything in the TCP connection state so
we should not take a write_lock but rather a read lock.

This caused a deadlock when running nvmet-tcp and nvme-tcp
on the same system, where state_change callbacks on the
host and on the controller side have causal relationship
and made lockdep report on this with blktests:

================================
WARNING: inconsistent lock state
5.12.0-rc3 #1 Tainted: G          I
--------------------------------
inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-R} usage.
nvme/1324 [HC0[0]:SC0[0]:HE1:SE1] takes:
ffff888363151000 (clock-AF_INET){++-?}-{2:2}, at: nvme_tcp_state_change+0x21/0x150 [nvme_tcp]
{IN-SOFTIRQ-W} state was registered at:
  __lock_acquire+0x79b/0x18d0
  lock_acquire+0x1ca/0x480
  _raw_write_lock_bh+0x39/0x80
  nvmet_tcp_state_change+0x21/0x170 [nvmet_tcp]
  tcp_fin+0x2a8/0x780
  tcp_data_queue+0xf94/0x1f20
  tcp_rcv_established+0x6ba/0x1f00
  tcp_v4_do_rcv+0x502/0x760
  tcp_v4_rcv+0x257e/0x3430
  ip_protocol_deliver_rcu+0x69/0x6a0
  ip_local_deliver_finish+0x1e2/0x2f0
  ip_local_deliver+0x1a2/0x420
  ip_rcv+0x4fb/0x6b0
  __netif_receive_skb_one_core+0x162/0x1b0
  process_backlog+0x1ff/0x770
  __napi_poll.constprop.0+0xa9/0x5c0
  net_rx_action+0x7b3/0xb30
  __do_softirq+0x1f0/0x940
  do_softirq+0xa1/0xd0
  __local_bh_enable_ip+0xd8/0x100
  ip_finish_output2+0x6b7/0x18a0
  __ip_queue_xmit+0x706/0x1aa0
  __tcp_transmit_skb+0x2068/0x2e20
  tcp_write_xmit+0xc9e/0x2bb0
  __tcp_push_pending_frames+0x92/0x310
  inet_shutdown+0x158/0x300
  __nvme_tcp_stop_queue+0x36/0x270 [nvme_tcp]
  nvme_tcp_stop_queue+0x87/0xb0 [nvme_tcp]
  nvme_tcp_teardown_admin_queue+0x69/0xe0 [nvme_tcp]
  nvme_do_delete_ctrl+0x100/0x10c [nvme_core]
  nvme_sysfs_delete.cold+0x8/0xd [nvme_core]
  kernfs_fop_write_iter+0x2c7/0x460
  new_sync_write+0x36c/0x610
  vfs_write+0x5c0/0x870
  ksys_write+0xf9/0x1d0
  do_syscall_64+0x33/0x40
  entry_SYSCALL_64_after_hwframe+0x44/0xae
irq event stamp: 10687
hardirqs last  enabled at (10687): [<ffffffff9ec376bd>] _raw_spin_unlock_irqrestore+0x2d/0x40
hardirqs last disabled at (10686): [<ffffffff9ec374d8>] _raw_spin_lock_irqsave+0x68/0x90
softirqs last  enabled at (10684): [<ffffffff9f000608>] __do_softirq+0x608/0x940
softirqs last disabled at (10649): [<ffffffff9cdedd31>] do_softirq+0xa1/0xd0

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(clock-AF_INET);
  <Interrupt>
    lock(clock-AF_INET);

 *** DEADLOCK ***

5 locks held by nvme/1324:
 #0: ffff8884a01fe470 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0xf9/0x1d0
 #1: ffff8886e435c090 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x216/0x460
 #2: ffff888104d90c38 (kn->active#255){++++}-{0:0}, at: kernfs_remove_self+0x22d/0x330
 #3: ffff8884634538d0 (&queue->queue_lock){+.+.}-{3:3}, at: nvme_tcp_stop_queue+0x52/0xb0 [nvme_tcp]
 #4: ffff888363150d30 (sk_lock-AF_INET){+.+.}-{0:0}, at: inet_shutdown+0x59/0x300

stack backtrace:
CPU: 26 PID: 1324 Comm: nvme Tainted: G          I       5.12.0-rc3 #1
Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS 2.10.0 11/12/2020
Call Trace:
 dump_stack+0x93/0xc2
 mark_lock_irq.cold+0x2c/0xb3
 ? verify_lock_unused+0x390/0x390
 ? stack_trace_consume_entry+0x160/0x160
 ? lock_downgrade+0x100/0x100
 ? save_trace+0x88/0x5e0
 ? _raw_spin_unlock_irqrestore+0x2d/0x40
 mark_lock+0x530/0x1470
 ? mark_lock_irq+0x1d10/0x1d10
 ? enqueue_timer+0x660/0x660
 mark_usage+0x215/0x2a0
 __lock_acquire+0x79b/0x18d0
 ? tcp_schedule_loss_probe.part.0+0x38c/0x520
 lock_acquire+0x1ca/0x480
 ? nvme_tcp_state_change+0x21/0x150 [nvme_tcp]
 ? rcu_read_unlock+0x40/0x40
 ? tcp_mtu_probe+0x1ae0/0x1ae0
 ? kmalloc_reserve+0xa0/0xa0
 ? sysfs_file_ops+0x170/0x170
 _raw_read_lock+0x3d/0xa0
 ? nvme_tcp_state_change+0x21/0x150 [nvme_tcp]
 nvme_tcp_state_change+0x21/0x150 [nvme_tcp]
 ? sysfs_file_ops+0x170/0x170
 inet_shutdown+0x189/0x300
 __nvme_tcp_stop_queue+0x36/0x270 [nvme_tcp]
 nvme_tcp_stop_queue+0x87/0xb0 [nvme_tcp]
 nvme_tcp_teardown_admin_queue+0x69/0xe0 [nvme_tcp]
 nvme_do_delete_ctrl+0x100/0x10c [nvme_core]
 nvme_sysfs_delete.cold+0x8/0xd [nvme_core]
 kernfs_fop_write_iter+0x2c7/0x460
 new_sync_write+0x36c/0x610
 ? new_sync_read+0x600/0x600
 ? lock_acquire+0x1ca/0x480
 ? rcu_read_unlock+0x40/0x40
 ? lock_is_held_type+0x9a/0x110
 vfs_write+0x5c0/0x870
 ksys_write+0xf9/0x1d0
 ? __ia32_sys_read+0xa0/0xa0
 ? lockdep_hardirqs_on_prepare.part.0+0x198/0x340
 ? syscall_enter_from_user_mode+0x27/0x70
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 5a62590e8804..902831eadcc2 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1472,7 +1472,7 @@ static void nvmet_tcp_state_change(struct sock *sk)
 {
 	struct nvmet_tcp_queue *queue;
 
-	write_lock_bh(&sk->sk_callback_lock);
+	read_lock_bh(&sk->sk_callback_lock);
 	queue = sk->sk_user_data;
 	if (!queue)
 		goto done;
@@ -1490,7 +1490,7 @@ static void nvmet_tcp_state_change(struct sock *sk)
 			queue->idx, sk->sk_state);
 	}
 done:
-	write_unlock_bh(&sk->sk_callback_lock);
+	read_unlock_bh(&sk->sk_callback_lock);
 }
 
 static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
