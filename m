Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CD1C55160
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 11:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=voVALDzUnmupBJEHA5KagX/vzlVJlXbPxhsRhxAvPsI=; b=llFDFNl9yeGHiRJMEw+I0TneSr
	WZDjUmgObXaC7paApNymK3/gvwjdTRG68WsOPdl9TCUhpIWvVnXontg2F9rd2zgnboizPJlMV+Ely
	BXiAuF9nS0oitUjLCuUHZXes8vE0dKjA2oftllDiJY7DvWzruPXsduZrGeCJYJMd0NHlR5jGeQeP8
	fzdHwm4yKd3WT0T1nW9ybDZDfAZ5h0PakhZ5+PTb0SlXF2DB0pqeUt4wmTt0Pqu05J4waQijleejP
	dDq+NfYVgCnxCyTBgbue+CL4oi0Ixbw+lp9aEYxoiq/cEt55UfvllDMCH/m0gU5AHLFnEPQ7kxmaw
	llzl96ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpP4S-0000000AMXE-2dyz;
	Thu, 30 Jul 2026 11:37:04 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpP4P-0000000AMWF-1otk
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 11:37:03 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2cacb8416a1so21722925ad.1
        for <linux-nvme@lists.infradead.org>; Thu, 30 Jul 2026 04:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785411420; x=1786016220; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=voVALDzUnmupBJEHA5KagX/vzlVJlXbPxhsRhxAvPsI=;
        b=t2bYDjKi/iHLTtb0xr+dmjc6rviGicUWyf4RqlwDP1sJ/R0gqMduB1n7JokxnUTOl7
         5LF6svv6i328+Brr/3y1kncy1eIJjQQ8bF1vxJs2L4YvfWJJ1nSWj0nsBxSzYXOi1Yw5
         4I1uctAijOJgSE9SOQ+1/d1SHdzi4NUMtIZJ81KFOTE5t88XZiLfxTwQfWvtwfJYhE1m
         BwilEE7zIOb4cL+g9aCVY8AiL5tPR9j7cNNIGtb2um9TTylCO1bVJJU51KK5O4BUyscy
         SICBNVa/lY37fIcTZvyJP7bxR9n8QRPIGs1zhfVHw9hB4ZEQytgqLYdu/0yJB/WxdSjJ
         wVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785411420; x=1786016220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=voVALDzUnmupBJEHA5KagX/vzlVJlXbPxhsRhxAvPsI=;
        b=NqJFcaX7M0HFTamFLSpbVHk8pXX5tNPd+4z5F7eumox0oXwMVRoJJBsZ2ypKakAjyu
         G0oTg7qmuTYiSGipQDp/2OROybUghjB2cOErNq0tpLgdJZxVHTuHNVvjvas24OGQc4Nq
         Nd6yNgYAPF8WrvtV6D7ZCA0pzSVdAHzBUd0baK7ppzY47OMWEybkoavQmcMUqjc6QRTR
         pFScJ24StQV1VSw3kQ7sET3VGAuJdV4n1qvll9pl999UxKUECTFfCFKkvvWnJCRh9/gb
         uwABfCtvaK3WXd2iQ2sYpP0+o1G61BSNiKSdWsb4CxvT1du/TRfumB0VllnGLX+2m6za
         abPA==
X-Forwarded-Encrypted: i=1; AHgh+RpqqeWGqZu1RLll98KckWYFv4CLy5wRDsUaR3RW1fyAxc0rr7t6mCwOpVQXHdS8N4b7Y1+eBcWA0hOT@lists.infradead.org
X-Gm-Message-State: AOJu0YxR84AGUGPueMJKN4aA3tb3b4yheR8N1C2ZZtnEaj3s9baFgElz
	fcdxEl8ZRTabQiuwLJ1WnafkbA4HTG4TvdysYKBgsIzqmSshaBekgJhRsLT8Ui8u6k9lTvVwgMF
	bHmSqKDh8Ww==
X-Gm-Gg: AR+sD11mQV/gLQMCeXPyTOoRHSe2np4z6bAjU35ob9NlQ7QWoQPpEA5qflrIzKuU6A9
	zugiarJmar4iv3Kyzfe+2bhqGKJa2Ws+MtovR504BnwiGD6gYEKDpGhjGdnStVBQbKnpmpcFkt5
	cbotdgL/xC9OG1wun5BOt2FVChY/C2ppbq/Fd469EFGfQv1W3Lyi1zckw31YQi2jVv4gQCN9w2i
	HxobSCl7md5y+6QnZiE1kMpgi3x+dB5WyxtyeC7tFgSrDhW2qYon4vkWKoOqWpn32ZdQFHxOOp+
	uHFCc/BdY/oiTum03xXtZbs5CA1+ZC73sMXIg8yKTW9MLjaU7b6aZ6n6+VTPXIz2+6CXSfYXWZm
	z/6zdW8yvLpZ4vPfpO4nEhvK4APsxATpbq0pPwD2PX/LHCVYQxpELV2ATcCpWELND9qqRVvkAEQ
	hWtAflBtqOgNm+cFCYP+onF9LhhTqjCuFU+Denk89aJzFh797LgEgd0LpN+d0ik5k+u4dt
X-Received: by 2002:a17:903:1745:b0:2cc:df15:91f5 with SMTP id d9443c01a7336-2d035d14d1cmr20430405ad.44.1785411419868;
        Thu, 30 Jul 2026 04:36:59 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c1b529sm25328235ad.69.2026.07.30.04.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 04:36:59 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: eduard@hasenleithner.at,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH] nvme: zero the discard fallback page
Date: Thu, 30 Jul 2026 20:36:24 +0900
Message-ID: <20260730113624.1605213-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_043701_648110_2DE555B2 
X-CRM114-Status: GOOD (  18.78  )
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

nvme_setup_discard() always maps sizeof(struct nvme_dsm_range) *
NVME_DSM_MAX_RANGES = 4096 bytes as the DSM payload however many ranges
the command declares, because some devices ignore the 'Number of Ranges'
field - the Fixes: commit records two that read past the declared ranges.
A single-range discard fills only the first 16 bytes.

Normally the buffer comes from kzalloc() and the other 4080 bytes are
zero.  When that allocation fails the code falls back to the
per-controller ctrl->discard_page, which nvme_init_ctrl() obtains with
alloc_page(GFP_KERNEL) and nothing ever zeroes, so those 4080 bytes are
whatever the page last held and are handed to the controller.  Reaching
it requires the kzalloc(GFP_ATOMIC | __GFP_NOWARN) to fail, that is
memory pressure; it is not remotely triggerable.  Failing the allocation
under KMSAN reproduces it, with the leaked tail full of vmemmap struct
page pointers.  The extent in the report is a partial transfer of the
payload, not the whole 4096 bytes; the 16-byte boundary in it is the one
declared range:

[   11.991601] BUG: KMSAN: uninit-value in dma_map_phys+0x14c8/0x1900
[   11.991969]  dma_map_phys+0x14c8/0x1900
[   11.992220]  dma_map_page_attrs+0xcf/0x130
[   11.992485]  e1000_xmit_frame+0x4099/0x6d10
[   11.992768]  dev_hard_start_xmit+0x22f/0xa80
[   11.993068]  sch_direct_xmit+0x35c/0xcb0
[   11.993315]  __dev_queue_xmit+0x1ee5/0x5eb0
[   11.993608]  ip_finish_output2+0x1903/0x1c30
[   11.993881]  ip_finish_output+0x288/0x870
[   11.994125]  ip_output+0x15e/0x400
[   11.994365]  __ip_queue_xmit+0x1e85/0x1fb0
[   11.994639]  ip_queue_xmit+0x60/0x80
[   11.994899]  __tcp_transmit_skb+0x4e71/0x5fa0
[   11.995210]  tcp_write_xmit+0x3a36/0x9160
[   11.995533]  __tcp_push_pending_frames+0xc5/0x3c0
[   11.995854]  tcp_push+0x7dc/0x840
[   11.996076]  tcp_sendmsg_locked+0x766c/0x8400
[   11.996371]  tcp_sendmsg+0x4b/0x90
[   11.996572]  inet_sendmsg+0x134/0x2a0
[   11.996823]  __sock_sendmsg+0x265/0x360
[   11.997076]  sock_sendmsg+0x100/0x1e0
[   11.997293]  nvme_tcp_try_send+0x196f/0x6370
[   11.997605]  nvme_tcp_queue_rq+0x1d54/0x20b0
[   11.997882]  blk_mq_dispatch_rq_list+0x5ee/0x2e50
[   11.998175]  __blk_mq_sched_dispatch_requests+0x16dc/0x24a0
[   11.998539]  blk_mq_sched_dispatch_requests+0x11b/0x2c0
[   11.998865]  blk_mq_run_work_fn+0x13b/0x280
[   11.999146]  process_scheduled_works+0x966/0x1ad0
[   11.999465]  worker_thread+0xe44/0x1480
[   11.999709]  kthread+0x53b/0x600
[   11.999927]  ret_from_fork+0x29f/0x7c0
[   12.000191]  ret_from_fork_asm+0x1a/0x30
[   12.000460]
[   12.000558] Uninit was created at:
[   12.000788]  __alloc_frozen_pages_noprof+0x8bf/0xd30
[   12.001096]  alloc_pages_mpol+0x1d0/0x5f0
[   12.001326]  alloc_pages_noprof+0x102/0x290
[   12.001627]  nvme_init_ctrl+0x5a3/0x9f0
[   12.001891]  nvme_tcp_create_ctrl+0xd75/0x19b0
[   12.002170]  nvmf_dev_write+0x4c68/0x4fd0
[   12.002426]  vfs_write+0x587/0x1a10
[   12.002636]  __x64_sys_write+0x207/0x4f0
[   12.002874]  x64_sys_call+0x2ff0/0x3ea0
[   12.003123]  do_syscall_64+0x147/0x3b0
[   12.003400]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   12.003680]
[   12.003777] Bytes 16-2843 of 2844 are uninitialized
[   12.004068] Memory access of size 2844 starts at ffff888109f82000
[   12.004412]
[   12.004530] CPU: 0 UID: 0 PID: 101 Comm: kworker/0:1H Not tainted 7.2.0-rc5-NVMECTL-gf5098b6bae76 #1 PREEMPT(lazy)
[   12.005127] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   12.005762] Workqueue: kblockd blk_mq_run_work_fn
[   12.006073] =====================================================

Allocate the page with __GFP_ZERO.  The single allocation site covers
every use of it: bytes no discard has written stay zero, and bytes one
did write hold that controller's own range list, which it has already
been sent.

Fixes: 530436c45ef2 ("nvme: Discard workaround for non-conformant devices")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
Measured over nvme-tcp under KMSAN, with the kzalloc failed by fault
injection and a fresh controller per cycle so that every fallback is the
first use of that controller's page:

  unpatched, injection on    40 of 40 cycles reported, 10 runs
  patched,   injection on     0 of 40 cycles reported, 10 runs
  unpatched, injection off    0 of 10 runs

The target-side dump of the 4096-byte payload showed a non-zero tail in
33 of the 40 unpatched cycles - 3526 and 258 non-zero bytes of 4080 were
the two recurring shapes - and in none of the patched ones.  The 7 zero
tails are recycled pages that happened to be zero, which KMSAN still
reports because it tracks whether a byte was initialised, not what it
holds.

Scope: a single VM over loopback.  This is not a test against a remote
target.  What the source shows is that the DSM payload is transferred to
the controller; what was measured is that the host kernel reads
uninitialised bytes and puts them on the wire.

Reproducing it: a KMSAN kernel with CONFIG_EXPERT=y and
CONFIG_CRC_OPTIMIZATIONS=n, booted with slab_nomerge; nvme-tcp connected
to a target; SLAB_FAILSLAB set on kmalloc-4k and failslab armed with
probability=100 times=1 cache-filter=1 around a BLKDISCARD ioctl.

 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd0..ee993dfa1e41 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5195,7 +5195,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
 			PAGE_SIZE);
-	ctrl->discard_page = alloc_page(GFP_KERNEL);
+	ctrl->discard_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 	if (!ctrl->discard_page) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.43.0


