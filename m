Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19639C48BDF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 15:31:24 +0000 (UTC)
Received: from bombadil.infradead.org (unknown [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1AA960FF4
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 15:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1AA960FF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=z44gQE1ZxcsltAyYiPPWHjAMHWIUoWgR63yBXyE1EFc=; b=TAE
	n30PDeWYPOqum69i1t5iqDEKbO3rA/qUeJdAycpbTR11OPVOi0LBdJWWFi8USAQn9sCJqM+wp3HZo
	vfZnf6+dfEeIrBzwhd5QTz+XBjbEgX8J3dKMejKLxswzusd9NkKmwA7b/4UIj5MVZKYr+gxC1ZcPR
	fq6sw3fKZa7QbjfpXyx3M8O5ls9236aDjqsLQCn54SWNwTCJw64aaD+rzAoeS7G8BeU0Erp9aQoOg
	WyMDExBoGtfq7XlCIf7Kw0yOfeofB22D1tPfQom54nK/9t16Z5+7bSnbu4cR6A27SKlHlS9gNGZaZ
	HPRctRGhTAUGqQVQUrGShmUFH0D5esw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltB1S-000yyK-BL; Tue, 15 Jun 2021 15:30:38 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt9Lv-000DDm-ET
 for linux-nvme@bombadil.infradead.org; Tue, 15 Jun 2021 13:43:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Type:To:Subject:Message-ID:
 Date:From:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=j2t8JlTPkTc+GpWklM7rrwU7V4xq9eUtURptOeYbTLM=; b=M3i8bqrlegjwwKefsFow1hwJBB
 qNoMRfU6IutFSE/WgQkDA2AvhOC/sMlMc6NUiSyQvRcF8TvvZC7FWSvbFgxsl9S7AcVkjAbLLPVyg
 YxDk5JS2dvocZnWjbz453oY0YK1DgrggizG53EBO5lgYu3QUQZn+xRuaPy3Lg358qcGNBV3XQzne8
 uSyFsFlzWDyiRo1vOY4ULtnoB93qoiR7sDllA/8YuipYQfryvILsAdcv63aWEnVAHRhPKH2ZpVF+z
 94QMYHQ6eqdHjl9/cxM4C7vKLe8rwO0sJ6s63VHLP137D0PqMtn3ybJMOjEb/AoGiXVoegrES1AqQ
 /JIl7TMg==;
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt2Nw-007Orm-BP
 for linux-nvme@lists.infradead.org; Tue, 15 Jun 2021 06:17:25 +0000
Received: by mail-pg1-x531.google.com with SMTP id m2so3867979pgk.7
 for <linux-nvme@lists.infradead.org>; Mon, 14 Jun 2021 23:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=j2t8JlTPkTc+GpWklM7rrwU7V4xq9eUtURptOeYbTLM=;
 b=gx6Ecf//HJqGMWcjoDP7GWenvQ+DblXFFrfhuAUT2lyzT+R4imE6NRN3G7m751zDgC
 P8Rvax1U4/Ix7DArDhQRKPH77+x5hZQ6oxqAq+kCYZU1uEtRp5LsZ83FOYUEQeN66WWl
 5W9V6nZlDrt6uxgRfrbieQ57B5sk2lFCGWq4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=j2t8JlTPkTc+GpWklM7rrwU7V4xq9eUtURptOeYbTLM=;
 b=g5RVJmkF87I50R6Z4EY9dG+1M32YM5YpNGj0MT3rCm1l1VcZH8ZNEi2hxoCCjLzj7X
 oeOJjE86+7H9+UZfIOoORZItBJzWab+PjG+vp+2ZwDHFDW+GFy0FU2gg3z49kiRz3msC
 EGzN3EKnFyvzlQed1ezbe/A2Tc5BoefG2rDiiHYRGJ6Cbm3I8hX7Gm7zfwgl5MvHtqUJ
 Hu3oyHccrNc37uwe8ruZehIC/A1KiaD1F6WYFCoUV97CNHi6Ynb86GwdaWmLAsQgkoZz
 QLpD8kUAof5dQKxOtmh74RymWnDqns7XiUjOomWcTQOlG7iON61rjaCG4Frgr1Djvvx+
 qmNA==
X-Gm-Message-State: AOAM532HO6JUvWrkxLxI8qXRZq2GeHbhnD3lewlj4J5/Atl5S+IPnYeZ
 Tp4BVSqQwk3W0Rlnuz4K26k4poHxXCxbBa9+dus1o6t74SH86Q==
X-Google-Smtp-Source: ABdhPJyBgi3YGwvKLshiRJvbgjGCC3/9R3bqwdaKhxbWNmICfDQGspg3MXIzaRqz4jz57p3d9QMo+S+XOT8VWKiAbFs=
X-Received: by 2002:a62:90:0:b029:2db:90a5:74dc with SMTP id
 138-20020a6200900000b02902db90a574dcmr2984418pfa.27.1623737840928; Mon, 14
 Jun 2021 23:17:20 -0700 (PDT)
MIME-Version: 1.0
From: Casey Chen <cachen@purestorage.com>
Date: Mon, 14 Jun 2021 23:17:10 -0700
Message-ID: <CALCePG0up2GK_ihFnLxHuUS4Zn0kfSAC2x1U4Vm_6BQw3Deo5w@mail.gmail.com>
Subject: nvme-pci: Fix multiple races in nvme_setup_io_queues()
To: linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210615_071723_318714_CA63F575 
X-CRM114-Status: GOOD (  23.12  )
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

Hi,

We found multiple races in nvme_setup_io_queues() by power-cycling a
PCIe NVMe drive for hours. nvme_setup_io_queues() could overlap with
nvme_dev_disable() if we power off a drive quickly after powering it
on. Multiple races exist because of shutdown_lock missing and improper
use of NVMEQ_ENABLED bit. All problematic places and their fix are
explained in the commit message. This is also reproducible on Intel
Optane drive. Fix has been tested for a week.

All tests and fix are based on tag nvme-5.14-2021-06-08 of repo
http://git.infradead.org/nvme.git

1. Testing Method
while :; power off drive X; sleep $((RANDOM%3)).$((RANDOM%10)); power
on drive X; sleep $((RANDOM%3)).$((RANDOM%10)); done

2. Crash Call Trace
[11668.533392] pcieport 0000:87:08.0: pciehp: pending interrupts
0x0008 from Slot Status
[11668.533431] pcieport 0000:87:08.0: pciehp: Slot(402): Card present
...
[11668.681298] nvme nvme12: pci function 0000:8c:00.0
[11668.681354] nvme 0000:8c:00.0: enabling device (0100 -> 0102)
[11669.046119] pcieport 0000:87:08.0: pciehp: pending interrupts
0x0108 from Slot Status
[11669.046142] pcieport 0000:87:08.0: pciehp: Slot(402): Link Down
[11669.046146] pcieport 0000:87:08.0: pciehp: Slot(402): Card not present
[11669.046149] pcieport 0000:87:08.0: pciehp:
pciehp_unconfigure_device: domain:bus:dev = 0000:8c:00
[11669.077428] ------------[ cut here ]------------
[11669.077431] kernel BUG at drivers/pci/msi.c:348!
[11669.077555] invalid opcode: 0000 [#1] SMP KASAN
[11669.077658] CPU: 31 PID: 716 Comm: irq/127-pciehp Not tainted 5.13.0-rc3+
[11669.077869] Hardware name: <MASKED OFF>
[11669.078022] RIP: 0010:free_msi_irqs+0x28a/0x2d0
[11669.078129] Code: f7 83 c5 01 e8 87 44 c7 ff 39 6b 14 0f 86 d6 fd
ff ff 4c 89 ef e8 76 44 c7 ff 8b 43 10 8d 7c 05 00 e8 8a 0d a7 ff 84
c0 74 d4 <0f> 0b 48 8d 7b 60 e8 5b 45 c7 ff 48 8b 7b 60 e8 52 46 9b ff
48 89
[11669.078453] RSP: 0018:ffff88813917fa38 EFLAGS: 00010202
[11669.078564] RAX: 0000000000000001 RBX: ffff88e042875800 RCX: ffffffff81160812
[11669.078703] RDX: dffffc0000000000 RSI: ffff88e54fc86740 RDI: ffff892fe1627ca0
[11669.078843] RBP: 0000000000000000 R08: ffffed278641a4fd R09: ffffed278641a4fd
[11669.078982] R10: ffff893c320d27e5 R11: ffffed278641a4fc R12: ffff893c320d22e8
[11669.079121] R13: ffff88e042875810 R14: ffff88e042875814 R15: ffff893c320d2000
[11669.079260] FS:  0000000000000000(0000) GS:ffff893ebe640000(0000)
knlGS:0000000000000000
[11669.079415] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11669.079531] CR2: 00007f1fc13fa000 CR3: 00000063a2de2002 CR4: 00000000005706e0
[11669.079670] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[11669.085209] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[11669.091054] PKRU: 55555554
[11669.093982] Call Trace:
[11669.096850]  pci_free_irq_vectors+0xe/0x20
[11669.099695]  nvme_dev_disable+0x140/0x760 [nvme]
[11669.102503]  ? _raw_spin_lock_irqsave+0x9c/0x100
[11669.105271]  ? trace_hardirqs_on+0x2c/0xe0
[11669.107994]  nvme_remove+0x191/0x1e0 [nvme]
[11669.110689]  pci_device_remove+0x6b/0x110
[11669.113316]  device_release_driver_internal+0x14f/0x280
[11669.115939]  pci_stop_bus_device+0xcb/0x100
[11669.118515]  pci_stop_and_remove_bus_device+0xe/0x20
[11669.121079]  pciehp_unconfigure_device+0xfa/0x200
[11669.123597]  ? pciehp_configure_device+0x1c0/0x1c0
[11669.126049]  ? trace_hardirqs_on+0x2c/0xe0
[11669.128444]  pciehp_disable_slot+0xc4/0x1a0
[11669.130771]  ? pciehp_runtime_suspend+0x40/0x40
[11669.133054]  ? __mutex_lock_slowpath+0x10/0x10
[11669.135289]  ? trace_hardirqs_on+0x2c/0xe0
[11669.137462]  pciehp_handle_presence_or_link_change+0x15c/0x4f0
[11669.139632]  ? down_read+0x11f/0x1a0
[11669.141731]  ? pciehp_handle_disable_request+0x80/0x80
[11669.143817]  ? rwsem_down_read_slowpath+0x600/0x600
[11669.145851]  ? __radix_tree_lookup+0xb2/0x130
[11669.147842]  pciehp_ist+0x19d/0x1a0
[11669.149790]  ? pciehp_set_indicators+0xe0/0xe0
[11669.151704]  ? irq_finalize_oneshot.part.46+0x1d0/0x1d0
[11669.153588]  irq_thread_fn+0x3f/0xa0
[11669.155407]  irq_thread+0x195/0x290
[11669.157147]  ? irq_thread_check_affinity.part.49+0xe0/0xe0
[11669.158883]  ? _raw_read_lock_irq+0x50/0x50
[11669.160611]  ? _raw_read_lock_irq+0x50/0x50
[11669.162320]  ? irq_forced_thread_fn+0xf0/0xf0
[11669.164032]  ? trace_hardirqs_on+0x2c/0xe0
[11669.165731]  ? irq_thread_check_affinity.part.49+0xe0/0xe0
[11669.167461]  kthread+0x1c8/0x1f0
[11669.169173]  ? kthread_parkme+0x40/0x40
[11669.170883]  ret_from_fork+0x22/0x30
[11669.172592] Modules linked in: iptable_nat nf_nat ip6table_raw
xt_CT iptable_raw ip6t_REJECT nf_reject_ipv6 ip6table_mangle
ipt_REJECT nf_reject_ipv4 xt_owner xt_conntrack iptable_mangle xt_ipvs
ip_vs nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_addrtype
br_netfilter xt_mark xt_tcpudp ip6table_filter ip6_tables
iptable_filter nvme ip6_gre ip6_tunnel tunnel6 gre macvlan bridge stp
llc nvme_rdma nvme_fabrics nvme_core vfio_pci vfio_virqfd
vfio_iommu_type1 vfio qede qed crc8 scsi_dh_alua intel_rapl_msr
intel_rapl_common skx_edac x86_pkg_temp_thermal coretemp kvm_intel kvm
irqbypass ntb_hw_intel ntb intel_pch_thermal hed sunrpc msr bonding
ip_tables x_tables autofs4 rdma_ucm rdma_cm mlx4_ib mlx4_core iw_cm
ib_umad ib_ipoib ib_cm mlx5_ib ib_uverbs ib_core ghash_clmulni_intel
aesni_intel crypto_simd cryptd mlx5_core mlxfw pci_hyperv_intf mpt3sas
raid_class scsi_transport_sas i2c_i801 i2c_smbus pure_gpio
pinctrl_lewisburg pinctrl_intel hid_generic usbhid hid
[11669.172735]  [last unloaded: qla2xxx]
[11669.201990] Dumping ftrace buffer:
[11669.204376]    (ftrace buffer empty)
[11669.206766] ---[ end trace 07b68fb4b0c1a54c ]---
[11669.652093] RIP: 0010:free_msi_irqs+0x28a/0x2d0
[11669.654461] Code: f7 83 c5 01 e8 87 44 c7 ff 39 6b 14 0f 86 d6 fd
ff ff 4c 89 ef e8 76 44 c7 ff 8b 43 10 8d 7c 05 00 e8 8a 0d a7 ff 84
c0 74 d4 <0f> 0b 48 8d 7b 60 e8 5b 45 c7 ff 48 8b 7b 60 e8 52 46 9b ff
48 89
[11669.661764] RSP: 0018:ffff88813917fa38 EFLAGS: 00010202
[11669.664271] RAX: 0000000000000001 RBX: ffff88e042875800 RCX: ffffffff81160812
[11669.669382] RDX: dffffc0000000000 RSI: ffff88e54fc86740 RDI: ffff892fe1627ca0
[11669.674692] RBP: 0000000000000000 R08: ffffed278641a4fd R09: ffffed278641a4fd
[11669.680179] R10: ffff893c320d27e5 R11: ffffed278641a4fc R12: ffff893c320d22e8
[11669.685880] R13: ffff88e042875810 R14: ffff88e042875814 R15: ffff893c320d2000
[11669.691587] FS:  0000000000000000(0000) GS:ffff893ebe640000(0000)
knlGS:0000000000000000
[11669.697296] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11669.700174] CR2: 00007f1fc13fa000 CR3: 00000063a2de2002 CR4: 00000000005706e0

3. Proposed Fix
From b609626a69d584ce36bad4787ea6b4c6e6dba453 Mon Sep 17 00:00:00 2001
From: Casey Chen <cachen@purestorage.com>
Date: Mon, 31 Aug 2020 18:14:23 -0600
Subject: [PATCH] nvme-pci: Fix multiple races in nvme_setup_io_queues()

Below two paths could overlap each other if we power off a drive quickly
after power it on. There are multiple races in nvme_setup_io_queues()
because of shutdown_lock missing and improper use of NVMEQ_ENABLED bit.

nvme_reset_work()
      nvme_remove()
  nvme_setup_io_queues()
   nvme_dev_disable()
  ...
                       ...
A1  clear NVMEQ_ENABLED bit for admin queue                  lock
    retry:
                 B1  nvme_suspend_io_queues()
A2    pci_free_irq() admin queue
B2  nvme_suspend_queue() admin queue
A3    pci_free_irq_vectors()
           nvme_pci_disable()
A4    nvme_setup_irqs();
    B3     pci_free_irq_vectors()
      ...
                          unlock
A5    queue_request_irq() for admin queue
      set NVMEQ_ENABLED bit
      ...
      nvme_create_io_queues()
A6      result = queue_request_irq();
        set NVMEQ_ENABLED bit
      ...
      fail to allocate enough IO queues:
A7      nvme_suspend_io_queues()
        goto retry

1). If B3 runs in between A1 and A2, it will crash if irqaction haven't
  been freed by A2. B2 is supposed to free admin queue IRQ but it simply
  can't fulfill the job as A1 has cleared NVMEQ_ENABLED bit.

Fix: combine A1 A2 so IRQ get freed as soon as NVMEQ_ENABLED bit get cleared.

2). After solved #1, A2 could race with B3 if A2 is freeing IRQ while B3
  is checking irqaction. A3 also could race with B2 if B2 is freeing
  IRQ while A3 is checking irqaction.

Fix: A2 and A3 take lock for mutual exclusion.

3) A3 could race with B3 since they could run free_msi_irqs() in parallel.

Fix: A3 takes lock for mutual exclusion.

4). A4 could fail to allocate all needed IRQ vectors if A3 and A4 are
  interrupted by B3.

Fix: A4 takes lock for mutual exclusion.

5). If A5/A6 happened after B2/B1, B3 will crash since irqaction is not NULL.
  They are just allocated by A5/A6.

Fix: Lock queue_request_irq() and setting of NVMEQ_ENABLED bit.

6). A7 could get chance to pci_free_irq() for certain IO queue while B3
  is checking irqaction.

Fix: A7 takes lock.

7). nvme_dev->online_queues need to be protected by shutdown_lock. Since it
  is not atomic, both paths could modify it using its own copy.

Co-developed-by: Yuanyuan Zhong <yzhong@purestorage.com>
Signed-off-by: Casey Chen <cachen@purestorage.com>
---
 drivers/nvme/host/pci.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3aa7245a505f..81e53aaaa77c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1590,8 +1590,9 @@ static int nvme_create_queue(struct nvme_queue
*nvmeq, int qid, bool polled)
  goto release_cq;

  nvmeq->cq_vector = vector;
- nvme_init_queue(nvmeq, qid);

+ mutex_lock(&dev->shutdown_lock);
+ nvme_init_queue(nvmeq, qid);
  if (!polled) {
  result = queue_request_irq(nvmeq);
  if (result < 0)
@@ -1599,10 +1600,12 @@ static int nvme_create_queue(struct nvme_queue
*nvmeq, int qid, bool polled)
  }

  set_bit(NVMEQ_ENABLED, &nvmeq->flags);
+ mutex_unlock(&dev->shutdown_lock);
  return result;

 release_sq:
  dev->online_queues--;
+ mutex_unlock(&dev->shutdown_lock);
  adapter_delete_sq(dev, qid);
 release_cq:
  adapter_delete_cq(dev, qid);
@@ -2176,7 +2179,16 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
  if (nr_io_queues == 0)
  return 0;

- clear_bit(NVMEQ_ENABLED, &adminq->flags);
+ /*
+ * Free IRQ resources as soon as NVMEQ_ENABLED bit transitions
+ * from set to unset. If there is a window to it is truely freed,
+ * pci_free_irq_vectors() jumping into this window will crash.
+ * And take lock to avoid racing with pci_free_irq_vectors() in
+ * nvme_dev_disable() path.
+ */
+ mutex_lock(&dev->shutdown_lock);
+ if (test_and_clear_bit(NVMEQ_ENABLED, &adminq->flags))
+ pci_free_irq(pdev, 0, adminq);

  if (dev->cmb_use_sqes) {
  result = nvme_cmb_qdepth(dev, nr_io_queues,
@@ -2192,14 +2204,17 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
  result = nvme_remap_bar(dev, size);
  if (!result)
  break;
- if (!--nr_io_queues)
+ if (!--nr_io_queues) {
+ mutex_unlock(&dev->shutdown_lock);
  return -ENOMEM;
+ }
  } while (1);
  adminq->q_db = dev->dbs;

  retry:
  /* Deregister the admin queue's interrupt */
- pci_free_irq(pdev, 0, adminq);
+ if (test_and_clear_bit(NVMEQ_ENABLED, &adminq->flags))
+ pci_free_irq(pdev, 0, adminq);

  /*
  * If we enable msix early due to not intx, disable it again before
@@ -2208,8 +2223,10 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
  pci_free_irq_vectors(pdev);

  result = nvme_setup_irqs(dev, nr_io_queues);
- if (result <= 0)
+ if (result <= 0) {
+ mutex_unlock(&dev->shutdown_lock);
  return -EIO;
+ }

  dev->num_vecs = result;
  result = max(result - 1, 1);
@@ -2222,9 +2239,12 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
  * number of interrupts.
  */
  result = queue_request_irq(adminq);
- if (result)
+ if (result) {
+ mutex_unlock(&dev->shutdown_lock);
  return result;
+ }
  set_bit(NVMEQ_ENABLED, &adminq->flags);
+ mutex_unlock(&dev->shutdown_lock);

  result = nvme_create_io_queues(dev);
  if (result || dev->online_queues < 2)
@@ -2233,6 +2253,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
  if (dev->online_queues - 1 < dev->max_qid) {
  nr_io_queues = dev->online_queues - 1;
  nvme_disable_io_queues(dev);
+ mutex_lock(&dev->shutdown_lock);
  nvme_suspend_io_queues(dev);
  goto retry;
  }
--
2.17.1

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
