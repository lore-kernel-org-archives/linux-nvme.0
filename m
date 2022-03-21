Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BA3C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Mar 2022 22:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wFQ4LydauyUSQTeyswtRUpqrPyi0VkkuRO3Flf5OHY0=; b=toGJ0U/aBX9B09KdpfxJ1+CeZJ
	sAuclOCs2r9G0hmkHj5b0Gl460FypHR4sPxqSVfofHgPzSb823yglAyBPOaJMlmLS/8DqUbMlXCpM
	Ov7PDEmcWmFy882mnXtSwTAoEs5wd1rbd/Fm+2m/mi34wFj7HszmgiGDMzBWSWoZyJ9Mn99PgI6OA
	pExvx5MS8YLw0C7n3xUawcYM4MzLKJn1knQZtcvexLX6BLeh14k97Ki30/ZkTmvyHwpO2Bphj/+5g
	go7HJdTAR41eAH3ajKSCtfmLvDQtBhzbMLsYUoxFeGVlSbhkr+xl6117Io7UMDxPDINgmB+XyyIEo
	ZcbPk5gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWQl4-009HkN-64; Mon, 21 Mar 2022 22:44:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWQko-009Hg8-Lo
 for linux-nvme@lists.infradead.org; Mon, 21 Mar 2022 22:44:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647902636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wFQ4LydauyUSQTeyswtRUpqrPyi0VkkuRO3Flf5OHY0=;
 b=aEZtAQGbVajEYw2szeq+I/+kWQCuC0/O49KSubGKeO3rwb9Qqt0WFSDXft5teO1X/Xwdnm
 oj0Gj3abuKDLXFrGRapis+N7j1GwQXk4SLMTkwyd2FSbuJBG65dfYQNCeSOj+TjNyiyU9R
 aRLm+JwUWVN51fh+IYNUNHwNQ6rPUuA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-h9F7JZXPMGSZXDg4dhTQLw-1; Mon, 21 Mar 2022 18:43:53 -0400
X-MC-Unique: h9F7JZXPMGSZXDg4dhTQLw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD47C102F1C6;
 Mon, 21 Mar 2022 22:43:52 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.2.17.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CAB1E1400E76;
 Mon, 21 Mar 2022 22:43:51 +0000 (UTC)
From: Chris Leech <cleech@redhat.com>
To: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de
Cc: lengchao@huawei.com, dwagner@suse.de, hare@suse.de, mlombard@redhat.com,
 jmeneghi@redhat.com
Subject: kdump details (Re: nvme-multipath: round-robin infinite looping)
Date: Mon, 21 Mar 2022 15:43:02 -0700
Message-Id: <20220321224304.955072-2-cleech@redhat.com>
In-Reply-To: <20220321224304.955072-1-cleech@redhat.com>
References: <20220321224304.955072-1-cleech@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cleech@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220321_154358_829637_DD744D89 
X-CRM114-Status: GOOD (  14.50  )
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

Backtrace of a soft-lockup while executing in nvme_ns_head_make_request

crash> bt
PID: 6      TASK: ffff90550742c000  CPU: 0   COMMAND: "kworker/0:0H"
 #0 [ffffb40a40003d48] machine_kexec at ffffffff93864e9e
 #1 [ffffb40a40003da0] __crash_kexec at ffffffff939a4c4d
 #2 [ffffb40a40003e68] panic at ffffffff938ed587
 #3 [ffffb40a40003ee8] watchdog_timer_fn.cold.10 at ffffffff939db197
 #4 [ffffb40a40003f18] __hrtimer_run_queues at ffffffff93983c20
 #5 [ffffb40a40003f78] hrtimer_interrupt at ffffffff93984480
 #6 [ffffb40a40003fd8] smp_apic_timer_interrupt at ffffffff942026ba
 #7 [ffffb40a40003ff0] apic_timer_interrupt at ffffffff94201c4f
--- <IRQ stack> ---
 #8 [ffffb40a403d3d18] apic_timer_interrupt at ffffffff94201c4f
    [exception RIP: nvme_ns_head_make_request+592]
    RIP: ffffffffc0280810  RSP: ffffb40a403d3dc0  RFLAGS: 00000206
    RAX: 0000000000000003  RBX: ffff9059517dd800  RCX: 0000000000000001
    RDX: 000043822f41b300  RSI: 0000000000000000  RDI: ffff9058da8d0010
    RBP: ffff9058da8d0010   R8: 0000000000000001   R9: 0000000000000000
    R10: 0000000000000003  R11: 0000000000000600  R12: 0000000000000001
    R13: ffff90724096e000  R14: ffff9058da8dca50  R15: ffff9058da8d0000
    ORIG_RAX: ffffffffffffff13  CS: 0010  SS: 0018
 #9 [ffffb40a403d3e18] generic_make_request at ffffffff93c6e8bb
#10 [ffffb40a403d3e80] nvme_requeue_work at ffffffffc02805aa [nvme_core]
#11 [ffffb40a403d3e98] process_one_work at ffffffff9390b237
#12 [ffffb40a403d3ed8] worker_thread at ffffffff9390b8f0
#13 [ffffb40a403d3f10] kthread at ffffffff9391269a
#14 [ffffb40a403d3f50] ret_from_fork at ffffffff94200255

RIP here is in the nvme_round_robin_path loop.  I've seen a report
without softlockup_panic enabled where multiple CPUs locked with a
variety of addresses reported all within the loop.

Disassembling and looking for the loop test expression, we can find the
instructions for ns && ns != old

236             for (ns = nvme_next_ns(head, old);
237                  ns && ns != old;
   0x000000000000982f <+575>:   test   %rbx,%rbx
   0x0000000000009832 <+578>:   je     0x98a8 <nvme_ns_head_make_request+696>
   0x0000000000009834 <+580>:   cmp    %rbx,%r13
   0x0000000000009837 <+583>:   je     0x98a8 <nvme_ns_head_make_request+696>

At this point ns is in rbx, and old is in r13, that doesn’t appear to
change while in this loop.

Similarly head is in r15, being used here in list_first_or_null_rcu

./include/linux/compiler.h:
276             __READ_ONCE_SIZE;
   0x0000000000009961 <+881>:   mov    (%r15),%rax

drivers/nvme/host/multipath.c:
222             return list_first_or_null_rcu(&head->list, struct nvme_ns, siblings);
   0x0000000000009964 <+884>:   mov    %rax,0x18(%rsp)
   0x0000000000009969 <+889>:   cmp    %rax,%r15
   0x000000000000996c <+892>:   je     0x99d4 <nvme_ns_head_make_request+996>

So, from the saved register values in the backtrace:
old = ffff90724096e000
head = ffff9058da8d0000

Checking that old.head == head

crash> struct nvme_ns.head ffff90724096e000
  head = 0xffff9058da8d0000

Dumping the nvme_ns structs on head.list

crash> list nvme_ns.siblings -H 0xffff9058da8d0000
ffff907084504000
ffff9059517dd800

Only 2, and neither of them match “old”

What do the list pointers in old look like?

crash> struct nvme_ns.siblings ffff90724096e000
  siblings = {
    next = 0xffff9059517dd830, 
    prev = 0xdead000000000200
  }

old.siblings->next points into a valid nvme_ns on the list, but prev has
been poisoned.

This loop can still exit if any ns on the list is not disabled and an
ANA optimized path.

crash> list nvme_ns.siblings -H 0xffff9058da8d0000 -s nvme_ns.ctrl
ffff907084504000
  ctrl = 0xffff90555c13c338
ffff9059517dd800
  ctrl = 0xffff90555c138338
crash> struct nvme_ctrl.state 0xffff90555c13c338
  state = NVME_CTRL_CONNECTING
crash> struct nvme_ctrl.state 0xffff90555c138338
  state = NVME_CTRL_CONNECTING

No good, both are disabled while connecting.

Dump head.current_path[], and there’s “old”

crash> struct nvme_ns_head ffff9058da8d0000 -o
struct nvme_ns_head {
  [ffff9058da8d0000] struct list_head list;
  [ffff9058da8d0010] struct srcu_struct srcu;
  [ffff9058da8dc510] struct nvme_subsystem *subsys;
  [ffff9058da8dc518] unsigned int ns_id;
  [ffff9058da8dc51c] struct nvme_ns_ids ids;
  [ffff9058da8dc548] struct list_head entry;
  [ffff9058da8dc558] struct kref ref;
  [ffff9058da8dc55c] bool shared;
  [ffff9058da8dc560] int instance;
  [ffff9058da8dc568] struct nvme_effects_log *effects;
  [ffff9058da8dc570] struct cdev cdev;
  [ffff9058da8dc5f8] struct device cdev_device;
  [ffff9058da8dc9c8] struct gendisk *disk;
  [ffff9058da8dc9d0] struct bio_list requeue_list;
  [ffff9058da8dc9e0] spinlock_t requeue_lock;
  [ffff9058da8dc9e8] struct work_struct requeue_work;
  [ffff9058da8dca28] struct mutex lock;
  [ffff9058da8dca48] unsigned long flags;
  [ffff9058da8dca50] struct nvme_ns *current_path[];
}
SIZE: 51792

crash> p *(struct nvme_ns **) 0xffff9058da8dca50 @ 4
$18 = 
 {0xffff90724096e000, 0x0, 0x0, 0x0}

So, we end up in an infinite loop because:

The nvme_ns_head list contains 2 nvme_ns.  Both of them have ctrl->state
as NVME_CTRL_CONNECTING, so they are considered as disabled and we will
execute the continue statement in the loop. “old” has been removed from
the siblings list, so it will never trigger the ns != old condition


