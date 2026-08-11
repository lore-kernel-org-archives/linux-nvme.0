Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BE5C5CFC1
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 23:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=z4q6VLXN1W/AjdE0Kgnr8TrvBqnlevGmnuePCtTiNGw=; b=ZBw0vFmFaHGu37Tfw7ejxQn4l+
	tMongkSXgHJ5RNTVi2AWfLq1ust8t6/JU6TbJ+cyBCyZNwJQPJR0CcSxU84WlM2yr4hyvduuWYeb+
	C7t18f+rPJCApgPtx6MSF4t/rKjMtXbc0ali2HXb2Vw3UvR2kTDA0ch/ZSKY/8k05+T3m0sKkW4TE
	uHi+MOKWb3NnuFWm4JDmvA/DhjOFnwF/JJqnf4DQozIL/eMrj9Q2eh3y0weDTUtNrbxUNnIYCOg7U
	jrxJmUjfoXE2jgN3Q2w2Ird503IRXFWP+1vafkr88PvObpPx8tDNbKOcII0vOjmrMFWYcfnT+JM3c
	5pCHOLgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtvdp-0000000F4NN-2Ik1;
	Tue, 11 Aug 2026 23:12:17 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtvdm-0000000F4M8-2UHb
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 23:12:16 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso364412a91.1
        for <linux-nvme@lists.infradead.org>; Tue, 11 Aug 2026 16:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1786489932; x=1787094732; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z4q6VLXN1W/AjdE0Kgnr8TrvBqnlevGmnuePCtTiNGw=;
        b=HBiAYQOd+EnxOYw2peW3/dedEjRrgivTnttU+XNUOX779129d27+kAdUOnqEePP1ft
         f3DCtsorUVPEAENWAvAI2RMuBHk0PMz1mYNP2lq7Se8m5hIoxHHGYw0u8Yq5rthIABn+
         0+4BjTZzsFrrTgPzsZ4lhFs3JLPY6Gh92l4KBWPPmMr9CynDgc/SEy5OOFMhq9LSv8ND
         MRGJ5HZfnSFhBAvwP8TbAnJ1D0SRc0V3husVumEoeO10uxu7/zXQWVzIj+vJ6lvO/PaX
         Vj37RPGrwCjVGvldXlKLlIOea0TiPSoeP6KlHg7UzjOlbagOq+UPnozrci0JLe6Gn0cb
         LI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786489932; x=1787094732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z4q6VLXN1W/AjdE0Kgnr8TrvBqnlevGmnuePCtTiNGw=;
        b=hhYPX54eWxJ3HcOkwF/MTplMXOVIumlfKghirB788TDt+dVsw9yJeyLxP8v6sN3hrH
         4APOcVCFL0q/QkO29V6PgJF0YpxvTEs/+aSypPQR9hrC9clsmRzSvqpHDO3VgzJQTD+D
         39fseDo9KpHGxzdP5p/aArdSXV15qbeD8QdOzspkGmmsHDwjfGqfq9YsdLbnFCq5Bc89
         UgRDHDADvaIWU6j6ey3HC2sz6wK6vliEy6EWbO0hoUtkVHK9EEpnWgRpam0Vrc3CagXb
         SDnUWUWo9BWuAOG/GxyPzJyZcyZzDBgaCJ6FVsGN+zS0oIL57ngcM6HMFEmL5tZbC6R2
         iDJQ==
X-Gm-Message-State: AOJu0YyR7w32f5XWdXtuzkP+bMczX8kN5zAuQzG8A7S/v0RYoWNoQYhN
	65SYl6/ePdpYE2nrohjZYnThiuuBsqUaWujy/dUoJcv0P83G95xhfk41sPenBX+Jt9Q=
X-Gm-Gg: AR+sD132pQN0UGnuAFxpmn3DmzfAXKT6hoKHeHP+9tJKemeLcI9gYU7jB2HY+UF0ewK
	hvuJEGCV+pOBCc1t+0Ijb3Hdl8m46E08a8nq2d7uTCQdWhiMygapR/oROtEzJ0Xa8IjU28zOiOi
	FD9Cn2GHoLItrhma1dm9p9HF2KCO8w36Z/P2HzR9MHvdalKSTyTu/b40zTYon2UjfSt+PwQ3HQU
	eeRJ8rXCMGeyF9L5rsSD0fARWGdXsnzn7+3oLEXKaNOaJAhx71bieUzIVmylzfIY7oQZxvaFusw
	/SVP8oJFnIbi7pZGDPaxLmtFkl+PTLtUM4O9TLxmOF+iWQv9Gw24AryfnM7h7NWtT4MCVxpVThX
	sl1dul8+HqlmpJqs+nwYV9ohKHT0l054csSKvvnVRHhO+z0rfGMwmgZOMkhviN/r4JALi1NqOdh
	eygD3B9SRHiYo630Y6AhvF5z82oAbZxPp6w9Iq+KCakFvndw==
X-Received: by 2002:a17:90b:4a8f:b0:37f:df85:272f with SMTP id 98e67ed59e1d1-39301621e8fmr543940a91.19.1786489931363;
        Tue, 11 Aug 2026 16:12:11 -0700 (PDT)
Received: from ceto ([2607:fb90:9c20:7a99::791d])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-31cf361d292sm5255273eec.3.2026.08.11.16.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 16:12:10 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH] nvme: add opcode filtering for fault injection
Date: Tue, 11 Aug 2026 16:11:52 -0700
Message-ID: <20260811231152.1138761-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_161214_793794_830D1CCF 
X-CRM114-Status: GOOD (  19.62  )
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

Currently NVMe fault injection applies to every command routed through
nvme_should_fail(), which makes it hard to target a specific command
type when reproducing an issue in error-handling paths.

Add an "opcode" debugfs attribute alongside the existing "status" and
"dont_retry" knobs. It defaults to 0xffff, meaning "match any opcode"
and preserving the previous behavior. When set to a valid opcode
(<= 0xff), fault injection is only considered for commands whose opcode
matches.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 .../fault-injection/nvme-fault-injection.rst  | 65 +++++++++++++++++++
 drivers/nvme/host/fault_inject.c              | 14 +++-
 drivers/nvme/host/nvme.h                      |  1 +
 3 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/Documentation/fault-injection/nvme-fault-injection.rst b/Documentation/fault-injection/nvme-fault-injection.rst
index 1d4427890d75..09730acf0163 100644
--- a/Documentation/fault-injection/nvme-fault-injection.rst
+++ b/Documentation/fault-injection/nvme-fault-injection.rst
@@ -176,3 +176,68 @@ Message from dmesg::
    secondary_startup_64+0xa4/0xb0
   nvme nvme0: Could not set queue count (16385)
   nvme nvme0: IO queues not created
+
+Example 4: Inject an error into the first write command
+-------------------------------------------------------
+
+::
+
+  echo 0x01 > /sys/kernel/debug/nvme0n1/fault_inject/opcode
+  echo 1 > /sys/kernel/debug/nvme0n1/fault_inject/times
+  echo 100 > /sys/kernel/debug/nvme0n1/fault_inject/probability
+  dd if=/dev/zero of=/dev/nvme0n1 oflag=direct bs=512 count=1
+
+Expected Result::
+
+  The first write command sent to nvme0n1 fails
+
+Message from dmesg::
+
+  FAULT_INJECTION: forcing a failure.
+  name fault_inject, interval 1, probability 100, space 0, times 1
+  CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Not tainted 7.1.0+ #5 PREEMPT(full)
+  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-20240910_120124-localhost 04/01/2014
+  Call Trace:
+   <IRQ>
+   dump_stack_lvl+0x6e/0xa0
+   dump_stack+0x10/0x16
+   should_fail_ex+0x461/0x510
+   should_fail+0xb/0x20
+   nvme_should_fail+0x11b/0x240 [nvme_core]
+   nvme_poll_cq+0x6ad/0xb30 [nvme]
+   nvme_irq+0x84/0xe0 [nvme]
+   ? __pfx_nvme_irq+0x10/0x10 [nvme]
+   ? rcu_core+0xa40/0xa90
+   ? __pfx_sched_balance_softirq+0x10/0x10
+   ? debug_smp_processor_id+0x17/0x20
+   ? rcu_is_watching+0x13/0xa0
+   __handle_irq_event_percpu+0x396/0x610
+   handle_irq_event_percpu+0xf/0x90
+   handle_irq_event+0xab/0x110
+   handle_edge_irq+0x1a3/0x210
+   __common_interrupt+0xff/0x170
+   common_interrupt+0x90/0xc0
+   </IRQ>
+   <TASK>
+   asm_common_interrupt+0x27/0x40
+  RIP: 0010:pv_native_safe_halt+0x13/0x20
+  Code: 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 8b 05 0a 2a 58 01 85 c0 7e 07 0f 00 2d ff cc 0d 00 fb f4 <c3> cc 0
+  RSP: 0018:ffff888100a67e40 EFLAGS: 00000242
+  RAX: 0000000000000001 RBX: ffff888100a49c40 RCX: ffffed102b6c645b
+  RDX: ffffed102b6c645b RSI: ffffffff82a0d3c0 RDI: ffffffff81428b9b
+  RBP: ffff888100a67e48 R08: ffffed102b6c645b R09: 0000000000000004
+  R10: ffffed102b6c645a R11: 0000000000000001 R12: 0000000000000000
+  R13: 0000000000000000 R14: ffffed1020149388 R15: dffffc0000000000
+   ? do_idle+0x19b/0x2c0
+   ? default_idle+0x9/0x20
+   arch_cpu_idle+0x9/0x10
+   default_idle_call+0x6b/0xa0
+   do_idle+0x19b/0x2c0
+   ? __pfx_do_idle+0x10/0x10
+   ? complete_with_flags+0x63/0x70
+   cpu_startup_entry+0x55/0x60
+   start_secondary+0x1df/0x1e0
+   common_startup_64+0x13e/0x158
+   </TASK>
+  nvme0n1: Write(0x1) @ LBA 0, 1 blocks, Invalid Command Opcode (sct 0x0 / sc 0x1) DNR
+  operation not supported error, dev nvme0n1, sector 0 op 0x1:(WRITE) flags 0x8800 phys_seg 1 prio class 2
diff --git a/drivers/nvme/host/fault_inject.c b/drivers/nvme/host/fault_inject.c
index 105d6cb41c72..783e1999fef4 100644
--- a/drivers/nvme/host/fault_inject.c
+++ b/drivers/nvme/host/fault_inject.c
@@ -42,9 +42,11 @@ void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
 	}
 	fault_inj->parent = parent;
 
-	/* create debugfs for status code and dont_retry */
+	/* create debugfs for opcode, status code, and dont_retry */
+	fault_inj->opcode = 0xffff;
 	fault_inj->status = NVME_SC_INVALID_OPCODE;
 	fault_inj->dont_retry = true;
+	debugfs_create_x16("opcode", 0600, dir,	&fault_inj->opcode);
 	debugfs_create_x16("status", 0600, dir,	&fault_inj->status);
 	debugfs_create_bool("dont_retry", 0600, dir, &fault_inj->dont_retry);
 }
@@ -59,6 +61,7 @@ void nvme_should_fail(struct request *req)
 {
 	struct gendisk *disk = req->q->disk;
 	struct nvme_fault_inject *fault_inject = NULL;
+	struct nvme_command *cmd = nvme_req(req)->cmd;
 	u16 status;
 
 	if (disk) {
@@ -72,7 +75,14 @@ void nvme_should_fail(struct request *req)
 		fault_inject = &nvme_req(req)->ctrl->fault_inject;
 	}
 
-	if (fault_inject && should_fail(&fault_inject->attr, 1)) {
+	if (!fault_inject)
+		return;
+
+	if (fault_inject->opcode <= 0xff &&
+	    fault_inject->opcode != cmd->common.opcode)
+		return;
+
+	if (should_fail(&fault_inject->attr, 1)) {
 		/* inject status code and DNR bit */
 		status = fault_inject->status;
 		if (fault_inject->dont_retry)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 28cec87e4427..9a0fb1e35a5d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -323,6 +323,7 @@ struct nvme_fault_inject {
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
 	struct fault_attr attr;
 	struct dentry *parent;
+	u16 opcode;
 	bool dont_retry;	/* DNR, do not retry */
 	u16 status;		/* status code */
 #endif
-- 
2.54.0


