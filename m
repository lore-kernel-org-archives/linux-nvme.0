Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AA4CD8CB2
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2026 23:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zI6fupU0FppoNTWCTQKWlfeXF58eOXn3yMojhw64nbk=; b=dBDaAjrgLEb4cbNuaEdjqdXDBO
	fSIuctVt/qufqFieP8VYLmRbqhkgl5Ds3WgPTSl2SsLYtFt5+uj7/cBDpdMqP+LExiYwFEE02ma4t
	3rXLYYgs2rqQFZ4upCyEZhmRimH8K9sx+BxQvYbdbnNKHXo1NE7+R3+Yj9flp8Bq0tE+oGEDNbgai
	gZb0DZ0WsVMYQ3Pb2MslZ1qFdSbwepHyq6mUe5i4zHAvOp8DWGPubVtfxl9T8TcJU5ld2v1myRmXd
	Ukemu6JVvmgSnijkT2ACnXQT/MhEzbZ5bM/3vB4YKk6ZCUmO+XGNykRxk9kH/80pQ4rOHWriIvBZK
	PNL3XKtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX5cI-00000006VEU-1gX8;
	Tue, 09 Jun 2026 23:12:18 +0000
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX5cF-00000006VE0-2wQf
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jun 2026 23:12:17 +0000
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-7e6f4728b8dso719426a34.3
        for <linux-nvme@lists.infradead.org>; Tue, 09 Jun 2026 16:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1781046734; x=1781651534; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zI6fupU0FppoNTWCTQKWlfeXF58eOXn3yMojhw64nbk=;
        b=Inke+TsxeK0ewwgBSTARqEJ/ximrL0Af0MDr6hYQognBUiK9+wfv6JBB2f/fkG8iei
         +Vw1u59lzmwearxx72ecOzEL/k9kpKebOIehHMMNWEsNJ1NGADSXHp0UZf2/AMeHrciq
         e3mjNraj3UWwLmWELZ8vpiivNrZHgtuxtXduCgI00C48/imP05kJJgXpVNRC0RwTAdzg
         nff+XO8eC1heLouSYNWkPaUMAfdciPjZCNQQZVc5Fj0poHSE/lYC4CBu2nN16HLYUJbX
         NKKHzv1PpOuRCfmHB3WYcJKeYgN6CiFpS9IitqXDvj2Pcw2SkNn7ruUCSg6Jnsq0YMdU
         ddEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781046734; x=1781651534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zI6fupU0FppoNTWCTQKWlfeXF58eOXn3yMojhw64nbk=;
        b=fbxhprCZCNvwMLZ/J0VKT7xhHfV6RbHG4wHSS2wsvmoGkGJDzUfC0TrL4uViWCzhD8
         ct7y5ehkYvyKL0lcq1AqzyZ9PRsPBSwAZc07+RR5cCd6wqIbGzk10VmZlpXTHWjL5bwh
         bYEgEVOl77w7JrStmT6F51AI284bnkZx3MCdw9XzlGfVKMHR951GjkhJoq39wuj0/B6q
         VxyGm8WFvnbIzrVm9bETOelgoKzwcIidZmJ2W/BXBtXavehAmZPCUfM+xsXG2dT1QChy
         Ja0KGCLmn54TXISgDTlzktBtZbaNGhc6TUP15lLQl0lWAKuKdy7JZ4+BEahn8svez1S7
         etrA==
X-Forwarded-Encrypted: i=1; AFNElJ/N1BHeM7WPBjUEHrUksC3v9UMW6kcihP6A5xiLcXbmbjsSAvAVb3MvZeosZW5kf/H1Ht9QDQpcfdyc@lists.infradead.org
X-Gm-Message-State: AOJu0Yw8Yh8JJJD5lBaQ/ge8RpK4btI7OkqDBnTNrc3KVitYUFyvr9+K
	5RZRkXL/TuG5N+7Oi6cJ3xzuwikd5WreNRsS1MbWr/hEcbiT6v3IItqQw/4brbIatRc=
X-Gm-Gg: Acq92OEMkSjtK67o5M05rc8+gA6DUK0dTukAEtrED3hx3WSnTmDDpx+qZhRvuawYVNs
	k2FRhUkMqkaHlNnbMlCbUHj0PFoXiFB0XU8cGE6Lo8yCWk3XKEWZBLi0P20e6zq6b5h+R0V64Ia
	9JrfEzfJde+ukDmtzPDygdUuL1QUNyGkcwY+P3trxzZ6DGuoDmAspMweKvs1cMmFLHMN9JFQRBc
	ebzqoda210TYh7jwTQJjqZMYM9FpDlaRIVCRnOsnzlbop+TfCAz4fQVWBhor2/5b7xVOAqFpKJF
	y+mHT4pZTsTAp+nGWhetDRTi7bJlT3qUHmc6D13IQU5MId3sLUiPCbFkFWSSXt6PX974ptPWB6A
	wyUMOzZA/njrYJZ4A+EECSsgT22oF2U+tQ/b4JU8gKhiaxxXHkxPF7W/S95mOCVKYHmU1AWs3ZO
	zgamk7+Q+3Q63WZQ6gWHTYIWthmhn6Stege7eS8ugJZZRXKeLG2u2rlpjnwPojqOI13zi4BIzv
X-Received: by 2002:a05:6830:81f3:b0:7d9:b338:a669 with SMTP id 46e09a7af769-7e70c5d052cmr7772080a34.2.1781046733931;
        Tue, 09 Jun 2026 16:12:13 -0700 (PDT)
Received: from dev-cachen2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7e6e78e14acsm15951911a34.14.2026.06.09.16.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 16:12:13 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Michael Liang <mliang@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>
Subject: Re: [PATCH] block: Fix blk_sync_queue() to properly stop timeout timer
Date: Tue,  9 Jun 2026 17:11:44 -0600
Message-Id: <20260609231145.3712029-1-cachen@purestorage.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620183419.GC4836-mkhalfella@purestorage.com>
References: <20250529214928.2112990-1-mkhalfella@purestorage.com> <aDjcA_H7Ec9VICps@kbusch-mbp> <20250529223345.GA2013185-mkhalfella@purestorage.com> <20250620183419.GC4836-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_161215_931692_FDBD149B 
X-CRM114-Status: GOOD (  24.83  )
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

On 2025-06-20 11:34:19 -0700, Mohamed Khalfella wrote:
> Following up on this patch. I think the issue with blk_sync_queue()
> needs to be addressed. If adding a queue flag is not the preferred way
> to do it, please let me know what do you suggest and I will make the
> code changes.

I'd like to add a second data point in support of this patch. We hit
the same blk_sync_queue() race in nvme-rdma during torture testing of
an nvme-multipath/dm-mpath stacked configuration, with a call pattern
distinct from the nvme-fc case Mohamed reported. The symptom on our
side is request double-completion leading to dm-rq clone double-free,
not the self-deadlock Mohamed observed; but the root cause is the
same q->timeout rearm window inside blk_sync_queue().

Importantly, nvme-rdma's blk_sync_queue() call happens from a
separate workqueue (nvme_rdma_error_recovery_work), NOT from inside
blk_mq_timeout_work. So Keith's earlier suggestion that the consumer
"just not sync the queues within the timeout workqueue context" --
which addresses nvme-fc's self-deadlock -- does not apply to us:
we already are outside that context, and the race still manifests
because blk_sync_queue() itself doesn't fence q->timeout_work
against post-return rearm. The fix has to be in blk_sync_queue().

Setup:
  - Linux 6.6.77, ~64 CPUs, ~50 nvme-rdma controllers, nvme-mpath
    paths each carrying a dm-mpath clone in flight.
  - "Stall an SPM" torture: target-side faults inducing per-controller
    nvme_rdma_error_recovery_work in parallel across many ctrls.

Call pattern:

  blk_mq_timeout_work       (per-queue, kblockd)
    ... nvme_rdma_timeout(rq) -- ctrl state != NVME_CTRL_LIVE
        path A -> nvme_rdma_complete_timed_out(rq)
            blk_mq_complete_request(rq)        <- forced completion A

  nvme_rdma_error_recovery_work (per-ctrl, separate workqueue)
    nvme_rdma_teardown_io_queues
      nvme_quiesce_io_queues
      nvme_sync_io_queues       <- calls blk_sync_queue per ns->queue
      nvme_rdma_stop_io_queues
      nvme_rdma_cancel_tagset
        blk_mq_tagset_busy_iter(nvme_cancel_request)
          nvme_cancel_request(rq)
            blk_mq_complete_request(rq)        <- forced completion B

We instrumented the kernel to capture per-request event histories
(stack + cpu + timestamp) at each forced-completion entry point, at
blk_mq_complete_request() entry on the orig, and at
multipath_release_clone(). In an unpatched 6.6 we captured the
following sequence on the same nvme-rdma clone within ~5 ms, which
walks step-by-step from the two racing producers through the
double-completion of the orig to the double-free of the clone.
Records below are verbatim from the kernel log:

  rq=ffff889589967d00 tag=10 qid=16 ctrl=nvme33 op=DRV_IN

(1) Timeout (T) and cancel (C) reach forced-completion entry within
    ~1 us, on different CPUs (note 'age=4751us' vs 'age=4750us'):

     by-source[2] source=T age=4751us cpu=8 op=DRV_IN nr_bytes=32768 sts=0 ctx=ffff889589967d00 stack(10):
       [0] nvme_rdma_timeout+0x58/0x110 [nvme_rdma]
       [1] blk_mq_handle_expired+0x5d/0x90
       [2] bt_iter+0x7e/0x90
       [3] blk_mq_queue_tag_busy_iter+0x2b3/0x590
       [4] blk_mq_timeout_work+0x15f/0x1b0
       [5] process_one_work+0x133/0x380
       [6] worker_thread+0x30d/0x420
       [7] kthread+0xe5/0x110
       [8] ret_from_fork+0x2d/0x50
       [9] ret_from_fork_asm+0x11/0x20

     by-source[1] source=C age=4750us cpu=14 op=DRV_IN nr_bytes=32768 sts=0 ctx=ffff889589967d00 stack(10):
       [0] nvme_cancel_request+0x52/0xb0 [nvme_core]
       [1] bt_tags_iter+0x4b/0xa0
       [2] blk_mq_tagset_busy_iter+0x186/0x2c0
       [3] nvme_rdma_teardown_io_queues.part.0+0x73/0xf0 [nvme_rdma]
       [4] nvme_rdma_error_recovery_work+0x41/0xe0 [nvme_rdma]
       [5] process_one_work+0x133/0x380
       [6] worker_thread+0x30d/0x420
       [7] kthread+0xe5/0x110
       [8] ret_from_fork+0x2d/0x50
       [9] ret_from_fork_asm+0x11/0x20

  (The dump CPU is C8; cpu=N inside each record is the producing
  CPU. T came from cpu=8 with stack rooted at blk_mq_timeout_work;
  C came from cpu=14 with stack rooted at
  nvme_rdma_error_recovery_work. Two independent producers, no
  re-entry, captured ~1us apart on the same rq.)

(2) Each chain proceeds through dm-rq's clone-end-io to call
    blk_mq_complete_request() on the dm-mpath orig that owns this
    clone via tio->clone. Our hook at blk_mq_complete_request()
    captured *two* invocations on the same orig, one from each
    upstream forced-completion chain (both age=4743us):

     by-source[6] source=B age=4743us cpu=14 op=DRV_IN nr_bytes=32768 sts=0 ctx=ffff889589967d00 stack(14):
       [0] nvme_rdma_dbg_blk_complete_hook+0xcd/0x130 [nvme_rdma]
       [1] blk_mq_complete_request+0x17/0x70
       [2] end_clone_request+0x1f/0x30
       [3] __blk_mq_end_request+0x60/0x150
       [4] nvme_cancel_request+0x5a/0xb0 [nvme_core]
       [5] bt_tags_iter+0x4b/0xa0
       [6] blk_mq_tagset_busy_iter+0x186/0x2c0
       [7] nvme_rdma_teardown_io_queues.part.0+0x73/0xf0 [nvme_rdma]
       [8] nvme_rdma_error_recovery_work+0x41/0xe0 [nvme_rdma]
       [9] process_one_work+0x133/0x380
       [10] worker_thread+0x30d/0x420
       [11] kthread+0xe5/0x110
       [12] ret_from_fork+0x2d/0x50
       [13] ret_from_fork_asm+0x11/0x20

     ring[4] source=B age=4743us cpu=8 op=DRV_IN nr_bytes=32768 sts=0 ctx=ffff889589967d00 stack(14):
       [0] nvme_rdma_dbg_blk_complete_hook+0xcd/0x130 [nvme_rdma]
       [1] blk_mq_complete_request+0x17/0x70
       [2] end_clone_request+0x1f/0x30
       [3] __blk_mq_end_request+0x60/0x150
       [4] nvme_rdma_timeout+0xff/0x110 [nvme_rdma]
       [5] blk_mq_handle_expired+0x5d/0x90
       [6] bt_iter+0x7e/0x90
       [7] blk_mq_queue_tag_busy_iter+0x2b3/0x590
       [8] blk_mq_timeout_work+0x15f/0x1b0
  (frames [9..13] truncated in our log dump by interleaved console
   output during the dump; the lower frames are the standard
   process_one_work/worker_thread/kthread tail.)

  Two B records on the same orig at the same age=4743us, with two
  *different* upstream chains (frame [4] is nvme_cancel_request in
  the first, nvme_rdma_timeout in the second), is the direct
  observation that the orig has been double-completed.

(3) Each B schedules a per-cpu BLOCK_SOFTIRQ for the orig on its
    mq_ctx->cpu. The first softirq drain runs dm_softirq_done ->
    dm_done -> dm_requeue_original_request -> release_clone_rq,
    which releases this clone via multipath_release_clone ->
    blk_mq_free_request. req_ref_put_and_test sees refcount=1,
    dec to 0, free runs; "R" source captures this (age=4736us,
    7us after the two B's):

     by-source[5] source=R age=4736us cpu=8 op=DRV_IN nr_bytes=0 sts=0 ctx=ffff889589967d00 stack(10):
       [0] nvme_rdma_dbg_release_clone_hook+0x3f/0x120 [nvme_rdma]
       [1] multipath_release_clone+0x1f/0x60
       [2] dm_requeue_original_request+0x61/0xd0
       [3] blk_complete_reqs+0x3a/0x50
       [4] handle_softirqs+0x1ee/0x4a0
       [5] run_ksoftirqd+0x3c/0x70
       [6] smpboot_thread_fn+0xdf/0x1a0
       [7] kthread+0xe5/0x110
       [8] ret_from_fork+0x2d/0x50
       [9] ret_from_fork_asm+0x11/0x20

(4) The second softirq drain on the same orig (queued by the other
    chain's blk_mq_complete_request) runs the same path. tio->clone
    still points to the just-freed clone (dm-rq does not clear it),
    so dm_done -> release_clone_rq -> blk_mq_free_request is called
    again. This is the double-free: refcount is already 0 entering
    req_ref_put_and_test, which trips the WARN_ON_ONCE:

  [ 7122.320733] ------------[ cut here ]------------
  [ 7122.320742] WARNING: CPU: 3 PID: 77382 at block/blk.h:508 \
                 blk_mq_free_request+0x64/0x90
  [ 7122.320811] CPU: 3 PID: 77382 Comm: foed
  [ 7122.320821] RIP: 0010:blk_mq_free_request+0x64/0x90
  [ 7122.320942] Call Trace:
  [ 7122.320952]  ? __warn+0xa3/0x1d0
  [ 7122.320956]  ? blk_mq_free_request+0x64/0x90
  [ 7122.320962]  ? report_bug+0x200/0x230
  [ 7122.320966]  ? handle_bug+0x57/0x90
  [ 7122.320984]  dm_requeue_original_request+0x61/0xd0
  [ 7122.320989]  blk_complete_reqs+0x3a/0x50
  [ 7122.320993]  handle_softirqs+0x1ee/0x4a0
  [ 7122.321003]  __irq_exit_rcu+0x79/0xa0
  [ 7122.321007]  irq_exit_rcu+0xa/0x20
  [ 7122.321011]  common_interrupt+0x43/0xa0
  [ 7122.321014]  asm_common_interrupt+0x22/0x40
  [ 7122.321050] ---[ end trace 0000000000000000 ]---

The premise for the race is that nvme_rdma_teardown_io_queues calls
nvme_quiesce_io_queues -> nvme_sync_io_queues BEFORE
nvme_rdma_cancel_tagset, so after sync returns we expect no
blk_mq_timeout_work can fire concurrent with cancel_tagset. With the
unpatched blk_sync_queue(), that expectation breaks:
nvme_rdma_timeout() returning BLK_EH_RESET_TIMER causes a per-request
blk_add_timer() to re-arm q->timeout from inside the timeout work
that blk_sync_queue is in the middle of draining. After sync's
del_timer_sync (which ran first in the old ordering) and
cancel_work_sync return, q->timeout is once again armed. It fires
shortly afterwards, queueing a new blk_mq_timeout_work that races
nvme_rdma_cancel_tagset on the same rqs.

The race also corrupts wire ordering, since the clone is released
by dm-rq while its SEND/RECV WRs are still outstanding (the forced
completions bypassed end_request's refcount drain gate). A late
recv CQE then lands on the freed slot, dereferences NULL mq_hctx
inside blk_mq_complete_request_remote, and panics the kernel:

  [ 3079.146243] BUG: kernel NULL pointer dereference, address: 0000000000000136
  [ 3079.150802] #PF: supervisor read access in kernel mode
  [ 3079.150811] PGD 0 P4D 0
  [ 3079.150813] Oops: 0000 [#1] SMP
  [ 3079.150819] CPU: 1 PID: 10069 Comm: foed
  [ 3079.150834] RIP: 0010:blk_mq_complete_request_remote+0x15/0x130
  [ 3079.155506] CR2: 0000000000000136
  [ 3079.155516] Call Trace:
  [ 3079.166933]  ? blk_mq_complete_request_remote+0x15/0x130
  [ 3079.166953]  ? nvme_should_fail+0x3e/0x90 [nvme_core]
  [ 3079.166958]  nvme_rdma_end_request+0x55/0x80 [nvme_rdma]
  [ 3079.166962]  nvme_rdma_recv_done+0x1a4/0x5e0 [nvme_rdma]
  [ 3079.185939]  __ib_process_cq+0x79/0x150 [ib_core]
  [ 3079.193425]  ib_poll_handler+0x2c/0xb0 [ib_core]

(CR2=0x136 = offsetof(struct blk_mq_hw_ctx, nr_ctx); the deref is
rq->mq_hctx->nr_ctx with rq->mq_hctx already nulled by
__blk_mq_free_request from the racy double release above.)

We backported your patch to 6.6 (QUEUE_FLAG_NOTIMEOUT is still in
the #define-with-slot-number style there; allocated slot 2). With
the patch applied, both upstream signals went silent across
multiple-hour torture runs:

  - WARN_ON_ONCE at block/blk.h:508 (double-free): 0 occurrences.
  - NULL deref panic at blk_mq_complete_request_remote+0x15 (stale
    CQE on freed slot): 0 occurrences.

In response to Keith's earlier comment about this being an nvme-fc
problem:

  - The deadlock you described (sync called from within timeout work)
    is specific to nvme-fc's call pattern, agreed.

  - The race in blk_sync_queue() is not. nvme-rdma does not sync from
    within timeout work; sync is called from nvme_rdma_error_recovery_work
    (a separate workqueue) under the assumption that after sync returns
    no further timeout work for that queue can run. That assumption is
    what blk_sync_queue's name and existing callers imply, and what
    Mohamed's patch makes true.

  - Any driver returning BLK_EH_RESET_TIMER from .timeout and having a
    teardown path that calls blk_sync_queue is subject to the same
    race. nvme-fc and nvme-rdma both qualify; we expect nvme-tcp does
    too (haven't reproduced there yet).

A driver-local fix for each consumer doesn't address the contract:
blk_sync_queue() should provide what its name says it provides.

Tested-by: Casey Chen <cachen@purestorage.com>

Casey

