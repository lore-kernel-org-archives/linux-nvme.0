Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDA8C5DF87
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2026 11:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sjZ6o2B4u5+ODMneCLOWQXXYoRKfP63ZeuV0QIVzkkY=; b=CJoIw3eEfLGbrC
	hqhPlkwBZk7Lkkwo1JWtUYOA/iVmmZ0AZ3PgYGMzWvkUWUx77qns64h0R29NXxC9Ew7242NmcPaTW
	AH+GtqfrX0BbT3oCSF3laFDFvnmf3P9w75GNulTxs6ErVFN62Lq2D+Yyto7Ld6wOJc7Ddx7PR6qET
	Rv6M0UPKRmx5dmu1YvhQ9lx/lcg+AB57pXW8eVIYY7+Efo8kDDEWH915qwIMHn8nq/t0FFf5XY942
	06Nk79+uBjPckMPDWAWxJy44DJ3xr1wiCLz1hMvcaGIia/4rz/cJEhLXHAFJ+C1B5W36eBUDXbe7z
	sAmWKH1lbdGj7Ocl6sgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx1Ft-0000000BU9b-1Jee;
	Thu, 20 Aug 2026 11:48:21 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx1Fq-0000000BU7a-2TOo
	for linux-nvme@lists.infradead.org;
	Thu, 20 Aug 2026 11:48:20 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-495590dde14so24661775e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 20 Aug 2026 04:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadarastorage.com; s=google; t=1787226496; x=1787831296; darn=lists.infradead.org;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:organization:date:subject:cc
         :to:from:reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sjZ6o2B4u5+ODMneCLOWQXXYoRKfP63ZeuV0QIVzkkY=;
        b=QkqvQbBSEbXvTaXFQBO6GgQJFra7fcTBjRxMg0MthJp6+FE56Auz1Noz3ot0CC/H5y
         OZ+s3/Q5AfEEoGJU9ExFo8b9SbV9e/JggIS9asn62uHhTk044Fgjjmo73apqHLjGAREK
         THfsxA0gCcyAkpgEnQnQhFjZ434OIUxBz/3EWABuOfi4f5hXqHHd/w7DJoAb6+cGrAKP
         DxKkj1VUjH4oi+lqyqH6MdeZJ71y2WalKDQS49/OUZyaP5MfRFTrJX/p2ULHLNrlLgu0
         QDCQRyI96hR9O1G5jYgnW/Nt6CGH+4izOyxXIXcOHDCjqvtL2bqkJOqMXGjAs2YV1Teo
         fPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787226496; x=1787831296;
        h=content-language:thread-index:content-transfer-encoding
         :content-type:mime-version:message-id:organization:date:subject:cc
         :to:from:reply-to:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sjZ6o2B4u5+ODMneCLOWQXXYoRKfP63ZeuV0QIVzkkY=;
        b=G3sgJoWFHrqKI4Jn01HQyhGSktc0abJ6gzKJ0sz6mjJiWcqllFs0ZGNvFW7ZheoE6v
         NoDoyaF0vgIPmb7DBWo5QZUy/MYO3eXQW+bYy3t35+iHPPJJ6T0MvG3N9/C4h7N6J+yD
         l0zSwINxKvptsrWRgJBDP7YmgaKh2bdzw4aKf+uwp6NG5nwkyy1BR4gfP2cQBV2ANsIv
         jO8bEP6/AMtnCwHQQRkm/SMyGD1EU0Z42J2C7uXFkr/o3QtSU615KT9NMdcKz2ZWjQGF
         k9TKJjlJihIsSPOzEQW1e+/0Bb8GXeA9uDCWJgojH8wIXDr6qcwP9dx+AeoEgvRsi66E
         s4Ow==
X-Forwarded-Encrypted: i=1; AHgh+RptNgf+Vt9rf7jYwpOayj558Tcp357MfxNHLPb8YH+lCbP2nNUXhkloWGjBK3HTEU0uxY/JK+8SBLhF@lists.infradead.org
X-Gm-Message-State: AOJu0Yy9PmN+AiKvWDDqRaJWLcE4UILayhUPJhqxgn0e3idcR3BGQ7ZM
	Gb5/dQ91xWGwfU6ZSXW3A0wS61q7krK1U9FGL3D6IfaNAnid+Fpm2gZqEPTBUbadPkA=
X-Gm-Gg: AR+sD100uYWRvu3mW33FILrY0bnTM1OlynRuRvXhIoAK7cFSkvZwYwBfdtihstV4CUF
	hsLDPX81rk0PTOdR4sxNILsl51NG5QpGEYWJnuM+xqwNOY0zP5/TST4ickWfnR0lpwF+9yvPTTb
	H49Ec+ewTOxzn6Jmgsy7XVPF1e+p7piy8jLrjHPKX/pWFPWvJAfbkj6Ihn6Lp7bLlbDcVE9ioHv
	K378R4Cp/d4gCb+8zZ9O3IReqBZ19wNVGXWbS3pGWrvSJnSkcSfiiQqYeEkUwvMB4diulysOFj1
	rzsVPCVcgs2xnZ804ICygKzXC1PB0OvQZaXCsAwdVua9RPXj099KUWjlXl4KjaYxX5o+8LUk8Nc
	Y7LlEGYzPwEDI0xvtFYqVwm7D6U+ArJlLVwpMuQPmsZUlIyNqo0dl6+2/iws8Jn7f8QJXE5QioJ
	rNWCJd4N8PxyNnueQJANlYAZsMJrbo3wtQLVtmaCYS/WG6XLwHqYGpuD8OXb+tj4X5h/E=
X-Received: by 2002:a05:600c:c167:b0:495:4d00:2fda with SMTP id 5b1f17b1804b1-499aa143546mr227118585e9.2.1787226495784;
        Thu, 20 Aug 2026 04:48:15 -0700 (PDT)
Received: from levpc4 ([82.166.81.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0d6721sm181074585e9.11.2026.08.20.04.48.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2026 04:48:14 -0700 (PDT)
From: <lev@zadarastorage.com>
To: <linux-block@vger.kernel.org>
Cc: "'Jens Axboe'" <axboe@kernel.dk>,
	<linux-kernel@vger.kernel.org>,
	<regressions@lists.linux.dev>,
	"'Ming Lei'" <tom.leiming@gmail.com>,
	"'Yu Kuai'" <yukuai@fygo.io>,
	"'Keith Busch'" <kbusch@kernel.org>,
	<linux-nvme@lists.infradead.org>
Subject: [REGRESSION] blk-mq: hctx loses BLK_MQ_F_TAG_QUEUE_SHARED across blk_mq_update_nr_hw_queues()
Date: Thu, 20 Aug 2026 14:48:10 +0300
Organization: Zadara
Message-ID: <00cb01dd3099$c82b66c0$58823440$@zadarastorage.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Ad0v5ziZbJoftdS9SsWisTfxJtxmzQ==
Content-Language: en-il
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260820_044818_691515_F0177187 
X-CRM114-Status: GOOD (  31.45  )
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
Reply-To: lev.vainblat@zadara.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

After blk_mq_update_nr_hw_queues(), every hctx on the tag set can end
up with BLK_MQ_F_TAG_QUEUE_SHARED cleared while set->flags still has
it (it alternates - see below).

blk_mq_alloc_hctx() deliberately masks the bit off:

  hctx->flags = set->flags & ~BLK_MQ_F_TAG_QUEUE_SHARED;

which is right at initial queue creation, because the queue is not yet
on set->tag_list and blk_mq_add_queue_tag_set() applies the bit
immediately afterwards. But __blk_mq_realloc_hw_ctxs() exits and
re-inits every hctx even when nr_hw_queues is unchanged, and
__blk_mq_update_nr_hw_queues() does that for every queue on the tag
set without re-applying the bit. On that path the queue is already on
set->tag_list, so nothing calls queue_set_hctx_shared().

The strip alternates, which is likely why this has gone unnoticed.
blk_mq_init_hctx() never assigns hctx->flags, blk_mq_exit_hctx()
pushes the old hctx to the head of q->unused_hctx_list, and
blk_mq_remove_hw_queues_cpuhp() runs only after every queue on the tag
set has been realloc'd. So the just-exited hctx is refused by
blk_mq_hctx_is_reusable() - still cpuhp hashed - while the hctx exited
during the *previous* update has since been unhashed and is reused
carrying its stale flags:

  after 0 resets: alloc_policy=FIFO SHOULD_MERGE|TAG_QUEUE_SHARED|BLOCKING
  after 1 reset:  alloc_policy=FIFO SHOULD_MERGE|BLOCKING
  after 2 resets: alloc_policy=FIFO SHOULD_MERGE|TAG_QUEUE_SHARED|BLOCKING

Within one update it is uniform: every hctx of every queue on the tag
set goes the same way, with no partial mix.

One namespace is enough for the tag set to be shared, since
nvme_alloc_io_tag_set() puts ctrl->connect_q on the same tag set for
fabrics, so the set is shared from the first connect.
nvme_tcp_configure_io_queues() and nvme_rdma_configure_io_queues() reach
blk_mq_update_nr_hw_queues() unconditionally on the !new path, so every
reconnect and every controller reset does it. nvme_fc_recreate_io_queues()
only calls it when the queue count actually changes across reconnect
(prior_ioq_cnt != nr_io_queues); nvme-pci calls it unconditionally on
reset.

__blk_mq_update_nr_hw_queues() does return early when the queue count
is unchanged and set->nr_maps == 1, which might look like it should
cover a same-count reset - but tcp and rdma pass nr_maps = 2 (or
HCTX_MAX_TYPES with poll queues), so that early return never triggers
for them. It does apply to fc, which passes nr_maps = 1 and is
filtered twice: once by its own prior_ioq_cnt check, once by this.

This is directly observable with no I/O scheduler and no load at all:

  # sized small for the stall reproducer below
  nvme connect -t tcp -a $ADDR -s $PORT -n $NQN \
       --nr-io-queues=1 --queue-size=16

  grep -H . /sys/kernel/debug/block/nvme0n1/hctx0/flags
  # alloc_policy=FIFO SHOULD_MERGE|TAG_QUEUE_SHARED|BLOCKING

  echo 1 > /sys/class/nvme/nvme0/reset_controller
  grep -H . /sys/kernel/debug/block/nvme0n1/hctx0/flags
  # alloc_policy=FIFO SHOULD_MERGE|BLOCKING   <- TAG_QUEUE_SHARED gone
  # set->flags still has it (retry the reset if not - see the
  # alternation above)

The general impact, independent of any I/O scheduler: hctx_may_queue()
opens with

  if (!hctx || !(hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED))
    return true;

so an affected hctx skips the fair-share depth division entirely and can
draw more than its share of the shared pool, starving sibling namespaces
of driver tags. This is not scheduler-specific: with no elevator,
__blk_mq_get_tag() applies hctx_may_queue() to every unreserved allocation
at request-allocation time, and with one attached,
__blk_mq_alloc_driver_tag() applies it when dispatch takes the driver tag.
Either way the stripped bit skips the check. Separately, blk_mq_tag_busy()
and blk_mq_inc_active_requests() are also gated on the same bit and become
no-ops, so tags->active_queues and hctx->nr_active read 0 regardless of
load - the exact diagnostic an operator would reach for to see the
contention above is blind. Both of these apply on every affected system,
with or without a scheduler, and with or without a request ever getting
stuck.

This is separate from the in-flight work to drop shared-tag fairness
throttling entirely - that would remove hctx_may_queue()'s fair share and
the active_queues symptom by design, but the flag itself would still be
mistracked, and the hang described below gates on the same bit through
code the fairness removal does not touch.

Presumably the fix is to re-apply the bit per queue after the realloc
loop. Dropping the mask in blk_mq_alloc_hctx() instead would not fix
this: the reuse path never goes through blk_mq_alloc_hctx() at all, so
a reused hctx keeps whatever flags it had in its previous life either
way, which is the actual bug (see the alternation above). I have not
tested a fix - I have no mainline test rig - but I can test patches on
6.6.y, and the reproducer below turns one around in about a minute.

I have not established when this started, and I do not have the resources
to bisect it. By inspection, 85672ca9ceea ("block: avoid to reuse `hctx`
not removed from cpuhp callback list") looks like the point where it
became reachable on the ordinary same-count reset path: before it the
reuse test was numa_node only, so the just-exited hctx at the head of
q->unused_hctx_list was reused and its flags carried over intact; after it
that candidate is refused while still cpuhp hashed. I could not test a
kernel without that commit, so please treat that as a hypothesis and not a
bisect result. The asymmetry in blk_mq_alloc_hctx() is older than that
commit either way, and the code path is unchanged in master as of
d58772d8520c.

I searched the linux-block archive for BLK_MQ_F_TAG_QUEUE_SHARED and
found no existing report of this, but I may well have missed one -
please point me at it if so.

Worst case: with an I/O scheduler attached, this can hang a request
forever, and it did in production.

With the bit clear, blk_mq_mark_tag_wait() takes the non-shared branch,
sets BLK_MQ_S_SCHED_RESTART and registers no waiter on the tag waitqueue,
and the dispatch tail schedules no re-run because no_tag is gated on the
same flag. The comment on that gate - "For non-shared tags, the RESTART
check will suffice" - is precisely the invariant a wrongly-cleared bit
breaks: the check does not suffice, because the tags really are shared.
Recovery then rests solely on a request completing on this hctx - but the
tags are shared, so they are freed by the sibling queues, whose
completions restart only their own hctx. Two or more namespaces actually
carrying I/O are needed for this part, because the tags have to be freed
by a different queue's hctx - the flag loss above needs only the one.

Reproducer. Continuing from the connection above, now with an I/O
scheduler and load across all four namespaces on the controller.
Reproduced on 6.6.146 and on stock Ubuntu 6.8.0-137-generic:

  # with a scheduler, driver tags are acquired at dispatch time
  for d in /sys/block/nvme0n*; do
      echo mq-deadline > $d/queue/scheduler
  done

  # confirm the flag is gone on every namespace, not just n1
  grep -H . /sys/kernel/debug/block/nvme0n*/hctx0/flags
  # alloc_policy=FIFO SHOULD_MERGE|BLOCKING   <- TAG_QUEUE_SHARED gone

  # moderate load now stalls the whole controller within a second
  fio --name=hammer --ioengine=libaio --direct=1 --rw=randread --bs=4k \
      --iodepth=64 --numjobs=8 \
      --filename=/dev/nvme0n1 --filename=/dev/nvme0n2 \
      --filename=/dev/nvme0n3 --filename=/dev/nvme0n4

All I/O stops permanently. Every fio task:

  io_schedule+0x46/0x70
  blk_mq_get_tag+0x155/0x2f0
  __blk_mq_alloc_requests+0xc4/0x290
  blk_mq_submit_bio+0x190/0x6b0
  submit_bio_noacct+0x162/0x5c0
  blkdev_direct_IO.part.0+0x40/0x90

Three of the four namespaces end up with parked requests - one alone
accumulates four. From one of the namespaces holding a single parked
request:

  hctx0/dispatch: {.op=READ, .state=idle, .tag=-1, .internal_tag=10,
                   .rq_flags=STARTED|SCHED_TAGS|USE_SCHED|IO_STAT}
  hctx0/state:    SCHED_RESTART
  hctx0/flags:    alloc_policy=FIFO SHOULD_MERGE|BLOCKING
  hctx0/tags:     nr_tags=15 nr_reserved_tags=1 active_queues=0
                  bitmap_tags: depth=14 busy=0 cleared=14 ws_active=0
                  ws={ all 8 .wait=inactive }

The empty namespace shows the identical tags line - same shared pool -
with no dispatch entry. All 14 non-reserved driver tags are in the
cleared word awaiting the deferred merge, none allocated, and no
waiter is registered anywhere.

While the shared pool is still busy with the sibling queues' inflight I/O,
every run of such an hctx - including runs triggered by later submissions
- fails to get a driver tag, re-parks what it pulled, and parks the new
requests behind it. Once every fio thread is blocked on scheduler tags and
the inflight I/O has drained via the sibling queues, nothing runs the hctx
again: the hctx has SCHED_RESTART set with no waiter registered, and
blk_mq_sched_restart() is only called by a completion on the same hctx.
Those parked requests, and the requests queued behind them in the
elevator, hold the *scheduler* tags the blocked tasks are waiting for. The
fourth namespace stays empty only because every fio thread was already
stuck by the time it was captured.

Once stalled there is no reliable way out from userspace - every
teardown path (elevator switch, reset_controller, nvme disconnect)
freezes the queue and waits on the same stuck request. Anyone
reproducing this should expect to reboot sometimes. Attaching no
scheduler beforehand prevents it (driver tags are then taken at
request-allocation time, where waiting works correctly) but won't
rescue an already-stalled queue.

We hit this in production as a 20 minute md/raid1 hang and hung_task
panic on nvme-rdma - same signature: sole entry on hctx->dispatch, all
126 driver tags free, and set->flags still carrying
BLK_MQ_F_TAG_QUEUE_SHARED while every hctx of the reconnected
controller had lost it; a second controller on the same host that
never reconnected retains it on every hctx.

Thanks,
Lev


