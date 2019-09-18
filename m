Return-Path: <SRS0=vpxS=XN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAF6C4CEC4
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 09:13:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D22C4218AE
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 09:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YQj57Tv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22C4218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:In-Reply-To:
	Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=G4N4uIt7AbQ0DEOHXHpLM+MSH4O9sx88+6Oymth5xDU=; b=YQj57Tv3lXAQPM
	P64apJ08nmvka1aSZJ1CkHytttlusrbAMHEZue6YduL6muDpbqUFC8OAeblFWpFy8o4S4vRNTdmg4
	J+QDL/MjmTztG7oVI9DFaBxLPOY8FrVLOeo5dFfQsjvAs4kMWUMZpUjWTaN7fEkqiuf2oq+Y1f+T2
	Wv1OGjkrnksEyu1s5DnyffA+aNrP4f/YVXSSMVtLRmdEsM2O/YtTf5O5Pg43LP5UMq7YWWcMwCtJo
	PcIBqW/lN7UHFRprRFrJGS3PjmUQSSedHBdCD3fADu1z6VQhu1V12VLD+oGtFpJtECfUbjA28HzKp
	/Isu1ZX4pTNLTbvNp0pQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iAW1x-0007Ib-VK; Wed, 18 Sep 2019 09:13:46 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAW1q-0007ID-Ha
 for linux-nvme@lists.infradead.org; Wed, 18 Sep 2019 09:13:44 +0000
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B80BC1DD3;
 Wed, 18 Sep 2019 09:13:36 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7CA25ED23;
 Wed, 18 Sep 2019 09:13:36 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 91ED31808878;
 Wed, 18 Sep 2019 09:13:36 +0000 (UTC)
Date: Wed, 18 Sep 2019 05:13:36 -0400 (EDT)
From: Yi Zhang <yi.zhang@redhat.com>
To: linux-nvme@lists.infradead.org
Message-ID: <1437535598.446597.1568798016422.JavaMail.zimbra@redhat.com>
In-Reply-To: <1823328454.445263.1568796846850.JavaMail.zimbra@redhat.com>
Subject: NVMeoF RDMA IB:  I/O timeout and NULL pointer observed during
 rescan_controller/reset_controller with fio background
MIME-Version: 1.0
X-Originating-IP: [10.66.12.105, 10.4.195.20]
Thread-Topic: NVMeoF RDMA IB: I/O timeout and NULL pointer observed during
 rescan_controller/reset_controller with fio background
Thread-Index: lV0Fx4Z4mxy2DNRwlRjCB4ZIhKMmpQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Wed, 18 Sep 2019 09:13:36 +0000 (UTC)
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190918_021342_460625_248EE674 
X-CRM114-Status: UNSURE (   8.71  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello 
I observed bellow I/O timeout and NULL pointer on 5.3.0, pls help check it, let me know if you need more info or test patch, thanks

reproducer:
1. do fio background testing
2. stress rescan/reset_controller operation
echo 1 > /sys/block/nvme2n1/device/nvme2/rescan_controller
echo 1 > /sys/block/nvme2n1/device/nvme2/reset_controller

kernel log:
[  384.865550] nvme nvme2: creating 48 I/O queues.
[  386.784069] nvme nvme2: creating 48 I/O queues.
[  387.771002] nvme_ns_head_make_request: 159989 callbacks suppressed
[  387.771004] block nvme2n1: no usable path - requeuing I/O
[  387.771012] block nvme2n1: no usable path - requeuing I/O
[  387.771051] block nvme2n1: no usable path - requeuing I/O
[  387.771061] block nvme2n1: no usable path - requeuing I/O
[  387.771065] block nvme2n1: no usable path - requeuing I/O
[  387.771070] block nvme2n1: no usable path - requeuing I/O
[  387.771077] block nvme2n1: no usable path - requeuing I/O
[  387.771124] block nvme2n1: no usable path - requeuing I/O
[  387.771146] block nvme2n1: no usable path - requeuing I/O
[  387.771155] block nvme2n1: no usable path - requeuing I/O
[  449.670780] nvme nvme2: I/O 0 QID 0 timeout
[  449.691674] nvme nvme2: Connect command failed, error wo/DNR bit: 7
[  449.697974] BUG: kernel NULL pointer dereference, address: 00000000000000c8
[  449.704945] #PF: supervisor read access in kernel mode
[  449.710082] #PF: error_code(0x0000) - not-present page
[  449.715221] PGD 0 P4D 0 
[  449.717761] Oops: 0000 [#1] SMP PTI
[  449.721254] CPU: 45 PID: 1145 Comm: kworker/u98:2 Not tainted 5.3.0 #12
[  449.727866] Hardware name: Dell Inc. PowerEdge R740/00WGD1, BIOS 2.2.11 06/13/2019
[  449.735448] Workqueue: nvme-reset-wq nvme_rdma_reset_ctrl_work [nvme_rdma]
[  449.742325] RIP: 0010:rdma_disconnect+0x2e/0x90 [rdma_cm]
[  449.747722] Code: 00 55 53 48 89 fb 48 8b bf a8 02 00 00 48 85 ff 74 65 48 8b 0b 0f b6 83 c0 01 00 00 48 69 c0 b8 00 00 00 48 03 81 80 04 00 00 <8b> 40 10 a8 04 75 0d a8 08 74 42 5b 31 f6 5d e9 fe 72 b2 ff 48 89
[  449.766466] RSP: 0018:ffffb01f87323de0 EFLAGS: 00010206
[  449.771693] RAX: 00000000000000b8 RBX: ffff9e4d5a474c00 RCX: ffff9e4d5a475c00
[  449.778825] RDX: 0000000000000819 RSI: ffff9e4dffb96b88 RDI: ffff9e41af404e00
[  449.785956] RBP: 0000000000000000 R08: 00000000000008e7 R09: 000000000000002d
[  449.793098] R10: ffffb01f87323df8 R11: ffffb01f87323ac0 R12: 0000000000000007
[  449.800229] R13: ffff9e4db1332000 R14: ffff9e42045e2540 R15: ffff9e4db1332000
[  449.807361] FS:  0000000000000000(0000) GS:ffff9e4dffb80000(0000) knlGS:0000000000000000
[  449.815456] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  449.821195] CR2: 00000000000000c8 CR3: 000000183e60a003 CR4: 00000000007606e0
[  449.828327] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  449.835457] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  449.842581] PKRU: 55555554
[  449.845287] Call Trace:
[  449.847758]  nvme_rdma_start_queue+0x8f/0xc0 [nvme_rdma]
[  449.853070]  nvme_rdma_setup_ctrl+0x4ef/0x6a0 [nvme_rdma]
[  449.858469]  nvme_rdma_reset_ctrl_work+0x4e/0x70 [nvme_rdma]
[  449.864132]  process_one_work+0x1a1/0x360
[  449.868140]  worker_thread+0x1c9/0x380
[  449.871894]  ? process_one_work+0x360/0x360
[  449.876081]  kthread+0x10c/0x130
[  449.879310]  ? kthread_create_on_node+0x60/0x60
[  449.883846]  ret_from_fork+0x35/0x40
[  449.887422] Modules linked in: nvme_rdma nvme_fabrics nvmet_rdma nvmet 8021q garp mrp stp llc ib_isert iscsi_target_mod ib_srpt target_core_mod ib_srp scsi_transport_srp iw_cxgb4 libcxgb mlx5_ib vfat fat opa_vnic ib_umad ib_ipoib intel_rapl_msr intel_rapl_common isst_if_common rpcrdma sunrpc skx_edac nfit rdma_ucm libnvdimm ib_iser rdma_cm x86_pkg_temp_thermal intel_powerclamp iw_cm ib_cm coretemp libiscsi kvm_intel scsi_transport_iscsi hfi1 kvm iTCO_wdt iTCO_vendor_support dcdbas ipmi_ssif irqbypass rdmavt bnxt_re crct10dif_pclmul crc32_pclmul ib_uverbs ghash_clmulni_intel intel_cstate intel_uncore ib_core dell_smbios mei_me ipmi_si intel_rapl_perf wmi_bmof dell_wmi_descriptor pcspkr sg mei i2c_i801 lpc_ich ipmi_devintf ipmi_msghandler acpi_power_meter xfs libcrc32c sd_mod mgag200 i2c_algo_bit drm_vram_helper mlx5_core ttm drm_kms_helper syscopyarea sysfillrect sysimgblt ahci fb_sys_fops nvme libahci csiostor drm cxgb4 bnxt_en crc32c_intel nvme_core libata megaraid_sas scsi_trans
 port_fc
[  449.887456]  mlxfw tg3 wmi dm_mirror dm_region_hash dm_log dm_mod
[  449.980847] CR2: 00000000000000c8
[  449.984182] ---[ end trace aeab63ac2e6510db ]---
[  450.046884] RIP: 0010:rdma_disconnect+0x2e/0x90 [rdma_cm]
[  450.052282] Code: 00 55 53 48 89 fb 48 8b bf a8 02 00 00 48 85 ff 74 65 48 8b 0b 0f b6 83 c0 01 00 00 48 69 c0 b8 00 00 00 48 03 81 80 04 00 00 <8b> 40 10 a8 04 75 0d a8 08 74 42 5b 31 f6 5d e9 fe 72 b2 ff 48 89
[  450.071027] RSP: 0018:ffffb01f87323de0 EFLAGS: 00010206
[  450.076255] RAX: 00000000000000b8 RBX: ffff9e4d5a474c00 RCX: ffff9e4d5a475c00
[  450.083387] RDX: 0000000000000819 RSI: ffff9e4dffb96b88 RDI: ffff9e41af404e00
[  450.090517] RBP: 0000000000000000 R08: 00000000000008e7 R09: 000000000000002d
[  450.097642] R10: ffffb01f87323df8 R11: ffffb01f87323ac0 R12: 0000000000000007
[  450.104774] R13: ffff9e4db1332000 R14: ffff9e42045e2540 R15: ffff9e4db1332000
[  450.111899] FS:  0000000000000000(0000) GS:ffff9e4dffb80000(0000) knlGS:0000000000000000
[  450.119985] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  450.125729] CR2: 00000000000000c8 CR3: 000000183e60a003 CR4: 00000000007606e0
[  450.132853] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  450.139987] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  450.147118] PKRU: 55555554
[  450.149831] Kernel panic - not syncing: Fatal exception
[  450.155135] Kernel Offset: 0x17200000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  450.224883] ---[ end Kernel panic - not syncing: Fatal exception ]---

# gdb /lib/modules/5.3.0/kernel/drivers/nvme/host/nvme-rdma.ko 
Reading symbols from /lib/modules/5.3.0/kernel/drivers/nvme/host/nvme-rdma.ko...done.

(gdb) l *(nvme_rdma_start_queue+0x8f)
0x65f is in nvme_rdma_start_queue (drivers/nvme/host/rdma.c:568).
563	}
564	
565	static void __nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
566	{
567		rdma_disconnect(queue->cm_id);
568		ib_drain_qp(queue->qp);
569	}
570	
571	static void nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
572	{
(gdb) 

# lspci | grep -i mel
3b:00.0 Infiniband controller: Mellanox Technologies MT27800 Family [ConnectX-5]



Best Regards,
  Yi Zhang



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
