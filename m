Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A72CA5FA5
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 08:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5cwydG5wsQtN0cZkN780gx8GmDGw8aCnNB0UYeCsBrQ=; b=QFMdIh1Bur6Z4QN3Gppzm3v7ki
	cZG4Ib4qU01DJ0NkMC6CUbsi8oOgiuOIi9TyJ/c2+9n6zTzQ7tRFKxTicB/qrpsESjOTq/YGUVoi0
	Ykg1Wpd4CSHSajoYujtr7aJya79AAekj1nRH06chivFcVwwAisAqz3p0VfWcSKiUU2NDtr4ZRFHRc
	NMO4xRM9/X6NYk5PM5Z83mpcBpKupwaEokOL0RQAFMNuNp1IHA4ont/zu3CnJT/WdTu/1b12p6oyb
	e+EZglffJAOqTIRSqnhjpE9WrGeIc4uQQ2VWNaefHyolV/zxg4nF+z0rGHT9xwgHoJkgF2vJ0YdxQ
	DtX6whGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBTIc-00000002n6U-2teT;
	Tue, 29 Sep 2026 08:34:54 +0000
Received: from mail-pz2-x2b.google.com ([2607:f8b0:4864:3b::2b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBTIZ-00000002n50-0Joe
	for linux-nvme@lists.infradead.org;
	Tue, 29 Sep 2026 08:34:53 +0000
Received: by mail-pz2-x2b.google.com with SMTP id d2e1a72fcca58-8807e5b8fa9so2327678b3a.0
        for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2026 01:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1790670890; x=1791275690; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5cwydG5wsQtN0cZkN780gx8GmDGw8aCnNB0UYeCsBrQ=;
        b=bj9yZ2pd4DZ89ubGazrb0Fc8E9ypAhSnF6s8/gz1yoegpB+HrEqKmLUs0uLNX/f9zd
         JCePTsHUOHT232367mmZowHeHtNBXYDI8ffPwNMA9U7F4av61k7KSaa11VHP8IpTIzcv
         CVZWMBeShXSxE9Nm+qXvi+7eUX35LEdp/4Sh1sYa7TiB46v2kM3Q6MXK5GGOAhio17Nk
         0CbKlIo4AbehxR1KqlqpQkcRpkZuyvjWhVgwh3AyLIabO+2Ci1Tgj8t5gBvCtRPXBmI1
         RejkExYFCaVFnL04zRTz750dSNm7w2L1BPWUxRsuF4dlvJNdzWX3AQTkezpyEZTd7jzj
         PMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790670890; x=1791275690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5cwydG5wsQtN0cZkN780gx8GmDGw8aCnNB0UYeCsBrQ=;
        b=S3AgE9+3dGqrPb6X8RM520ela0pzH6yeLuRI3s7Hpks/gO2863zZzenCT2+O4v2fC7
         GKRl1PfVd1Vfkf4hy4jSsz1oQuK3YfBvBUeXJzp5lTfuX2LSy61IvNKExxu4w/7lNlzz
         2KW2MEcVbZKek+oDzNZTLms6dQQmHuHc6lLkjxUDC2OsYAZnRWUhvBZ/J38e7b9M3U++
         C3nlH4nV5VdZrefvLemQ9xfxcYxtreXwwgkiEMzQmZMzO7xnEMixJIIXmO3tpx/EoPjv
         T6EdxR5yogs4wr0+PER7kI9cNOu2bPC4v9cDANtVnBTxGILjR6fHOKjFZUDm8FKnUD/J
         SVkg==
X-Gm-Message-State: AFuF++kxaKjmJg5Gp1zeRDwEvYbjkriQ43fPLHLq54zglR/08gptIhUA
	WVjY6I9xbA7vw/D6z8ceT+5b2KdoogqhwSN+chA2/+dswS2ZrRttXGGqdai9K3lCYajxClhlJQk
	FSkfdHe0=
X-Gm-Gg: AYBFou26Ug9U0hBf89bHIZRq/7K0LmpgdPkKI8XUkb4NQlcXbQzKykyN8Bw+Ja44uBY
	XzdlXg6A3dxSCyxetoMwemiogEfxcK9IiBCG8C0yGKOxHNRBhFEzEbm16RJ7BQ0llErcR8z+xbk
	cY49EHqdlIrGhkP/jxHTt+gpcdxZhNwEH8qxDNPH3qJwGSVVNzpj+3ytScw0o193xXCPfbwlIQs
	CSLf5x+VJyUMozkp5UXO4jqPfrZlmxTQ8jU8Xk97PrPGOU7YD28ipwah8j9H8l8d+Oj2duCLwX5
	XBOzSNNB4fW0qo7DH00+yIWeIDNYNGpOaCzNgzgVZGKEeRkycYQUzLOu1MfWvGikxCj2EGZCBL4
	ULnSiFSoHtrKC0AoFyRrRoqnphCVUcJN/v0/XFbZ+Wy/Ojikehgk9vmt4tbTwLZhI8ipPjBnydX
	hK9m8vdrBMTYfFgbuXxHpeZ8x30sxgBGYsqiAeFU4jGiMFs5wNBvN6/Wnz7CqC+oGux3WCP9O/a
	dAIng==
X-Received: by 2002:aa7:914c:0:b0:881:77d6:8d91 with SMTP id d2e1a72fcca58-88177d69009mr6653281b3a.7.1790670889773;
        Tue, 29 Sep 2026 01:34:49 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-885e23e9947sm420275b3a.47.2026.09.29.01.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 01:34:49 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH] nvme-rdma: reject a second completion for a command already answered
Date: Tue, 29 Sep 2026 17:34:32 +0900
Message-ID: <20260929083432.1601397-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260929_013451_385949_5BB94935 
X-CRM114-Status: GOOD (  21.31  )
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

nvme_rdma_process_nvme_rsp() does not always complete the request it just
looked up.  When the request owns a memory region and the response arrived
without a remote invalidation, it posts a local invalidation and returns,
leaving nvme_rdma_inv_rkey_done() to drop the reference later.  Until that
completion runs the request is still live and its generation counter has
not advanced, so a controller that sends a second completion for the same
command_id passes nvme_find_rq() and reaches nvme_rdma_end_request() a
second time.

req->ref is initialised to 2, for the send and the recv completion.  A
duplicate answer produces three decrements -- the send completion, the
duplicate itself, and the deferred local invalidation -- and the last of
them takes the reference count below zero.

The generation counter added by commit e7006de6c238 ("nvme: code
command_id with a genctr for use-after-free validation") does not help
here: it is incremented in nvme_try_complete_req(), so it catches a
completion that arrives after the command has completed, not a second
completion that arrives before the first one has finished.

Both outcomes are a denial of service.  A duplicate that lands inside the
window trips the refcount_t saturation warning, which taints the kernel
and panics it when panic_on_warn is set; one that arrives after the window
instead trips "got bad command_id" and resets the controller.  In the runs
below every stray decrement landed on a request that had completed but had
not yet been reissued, and no KASAN report accompanied any of them, so
this is not a use-after-free with attacker-controlled reuse.

Mark a request once its completion has been consumed and refuse a second
one before it can touch status, result or the reference count.  The flag
is cleared per submission, beside the refcount it protects, so a reused
tag always starts clean.  A command whose duplicate is refused still
terminates normally through the local invalidation that the first response
posted.

Reproduced against a modified nvmet-rdma that answers one command twice,
first with a plain SEND and then with SEND_WITH_INV:

  refcount_t: underflow; use-after-free.
  WARNING: lib/refcount.c:28 at refcount_warn_saturate+0xad/0xe0,
    CPU#0: kworker/u8:0/12
  Modules linked in:
  CPU: 0 UID: 0 PID: 12 Comm: kworker/u8:0 Not tainted
    7.3.0-rc5-nvmerdma-atk-g72d3fcf802c4-dirty #27 PREEMPT(lazy)
  Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix,
    1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  Workqueue: rxe_wq do_work
  RIP: 0010:refcount_warn_saturate+0xad/0xe0
  Call Trace:
   <IRQ>
   __ib_process_cq+0xe1/0x390
   ? __pfx__raw_spin_lock_irq+0x10/0x10
   ib_poll_handler+0x6e/0x200
   irq_poll_softirq+0x1df/0x480
   ? __pfx_irq_poll_softirq+0x10/0x10
   ? __pfx__raw_spin_lock+0x10/0x10
   handle_softirqs+0x182/0x5a0
   ? __pfx_handle_softirqs+0x10/0x10
   do_softirq+0x3d/0x60
   </IRQ>
   <TASK>
   __local_bh_enable_ip+0x6a/0x70
   __alloc_skb+0x5f5/0x890
   ? enqueue_timer+0xe6/0x3f0
   ? __pfx___alloc_skb+0x10/0x10
   ? _raw_read_unlock_irqrestore+0x16/0x50
   rxe_init_packet+0x16b/0x4f0
   rxe_requester+0xeab/0x51f0
   ? rxe_completer+0x29e5/0x38c0
   ? wakeup_preempt_fair+0x5dd/0xdd0
   ? __pfx_rxe_completer+0x10/0x10
   ? __pfx_rxe_requester+0x10/0x10
   ? wakeup_preempt+0x1d5/0x330
   ? ttwu_do_activate+0x124/0x590
   ? _raw_spin_lock_irqsave+0x86/0xe0
   ? __pfx__raw_spin_lock_irqsave+0x10/0x10
   ? pwq_dec_nr_in_flight+0x2b2/0xc60
   ? __pfx_rxe_sender+0x10/0x10
   rxe_sender+0xe/0x30
   do_work+0x144/0x470
   process_one_work+0x6b4/0x10e0
   ? __pfx___schedule+0x10/0x10
   ? __pfx_process_one_work+0x10/0x10
   ? _raw_spin_lock_irq+0x81/0xe0
   ? __pfx_do_work+0x10/0x10
   ? assign_work+0x11d/0x370
   worker_thread+0x45b/0xd10
   ? __pfx_worker_thread+0x10/0x10
   kthread+0x2c8/0x3b0
   ? recalc_sigpending+0x15c/0x1e0
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x36e/0x5a0
   ? __pfx_ret_from_fork+0x10/0x10
   ? __switch_to+0x572/0xdd0
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x1a/0x30
   </TASK>
  ---[ end trace 0000000000000000 ]---

The window is narrow and load dependent.  With an idle completion queue
the local invalidation completes in about 85 us and the second answer
arrives too late to matter; under concurrent I/O the invalidation
completion is delayed to milliseconds and the duplicate lands inside it.
Counting the warning is misleading because REFCOUNT_WARN is WARN_ONCE, so
the stray decrements were counted directly:

  unpatched: 18 duplicates accepted inside the window, 18 stray
             decrements on a zero reference count, 1 warning
  patched:   5 duplicates landed inside the window, all refused,
             0 stray decrements, 0 warnings

Every refused command still completed, and an unmodified target is
unaffected with register_always set either way.

Fixes: 2f122e4f5107 ("nvme-rdma: wait for local invalidation before completing a request")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/nvme/host/rdma.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9cb811a2ce1f7..f96d421518293 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -82,6 +82,7 @@ struct nvme_rdma_request {
 	struct nvme_rdma_sgl	data_sgl;
 	struct nvme_rdma_sgl	*metadata_sgl;
 	bool			use_sig_mr;
+	bool			rsp_seen;
 };
 
 enum nvme_rdma_queue_flags {
@@ -1568,6 +1569,7 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 
 	req->num_sge = 1;
 	refcount_set(&req->ref, 2); /* send and recv completions */
+	req->rsp_seen = false;
 
 	c->common.flags |= NVME_CMD_SGL_METABUF;
 
@@ -1738,6 +1740,15 @@ static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 	}
 	req = blk_mq_rq_to_pdu(rq);
 
+	if (unlikely(req->rsp_seen)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"Duplicate completion for command_id %#x on QP %#x\n",
+			cqe->command_id, queue->qp->qp_num);
+		nvme_rdma_error_recovery(queue->ctrl);
+		return;
+	}
+	req->rsp_seen = true;
+
 	req->status = cqe->status;
 	req->result = cqe->result;
 
-- 
2.43.0


