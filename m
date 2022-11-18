Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EFAC433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Nov 2022 23:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GKWU5emOEwGwA0WI4eCG9Dk/AXUEXVS9yrhYI8olhd8=; b=zINbLVpMEHDycqy6fQ6RqwVQwo
	LbL13Ym+hdoV1dLIuxRkXq2lBjXSIiPVQ12bdxGzaLHwBe/4y5i4h63taxvMj5duX8mfge39Y+ztE
	eXFCLspos9CDh6JEeUxXHWsklocX8Bf/UTCVsfkAWrygahggB2qlf7zo03/NUiSuNgI9e7sTFoCeV
	ERjHs16/gCwEpKiYFnqlGZwpCDdWhG6PAMOXNUGQHqAindSKDYs+U3PbH9AAkJEZFTzLVUCb1QLV0
	RyxUdid5358tHFpuK38YZLl3xNDZ1EndElSm0clst4oaqJ7XuJWee1v/ccGS/Fu4e3PPn1Y3mq1yC
	AWUySIxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1owAmX-009BFa-Hx; Fri, 18 Nov 2022 23:28:25 +0000
Received: from mail-oa1-x64.google.com ([2001:4860:4864:20::64])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1owAmU-009BDg-OF
	for linux-nvme@lists.infradead.org; Fri, 18 Nov 2022 23:28:24 +0000
Received: by mail-oa1-x64.google.com with SMTP id 586e51a60fabf-13be3ef361dso7687710fac.12
        for <linux-nvme@lists.infradead.org>; Fri, 18 Nov 2022 15:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GKWU5emOEwGwA0WI4eCG9Dk/AXUEXVS9yrhYI8olhd8=;
        b=UcjcNncWyuuwW2TkmXP+YSLH4cN45ID0txgytFuuHvGVVDKHXkfWmpcYwMmNkgdor+
         ltcM2IMCfBexCSfb0D0WJWUu0TpKpwBCiSo2y+7bFv+9MFTXWbl6wzIQro25bb4iuUFq
         LX5zB0l3V5wwu6GA96frYhkdW3u6PePvqx1Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GKWU5emOEwGwA0WI4eCG9Dk/AXUEXVS9yrhYI8olhd8=;
        b=Z3ptTxjsLJH8tq9HE0UdNXdEfoZuJMP9taGVYBkdNvCavtndXfgoWp4UmsOQrHIeJn
         MiX/jZVWeGOQMxjCsVn8H3QZRgOoZa2rGxopIYbzgfFnM9xrR53OoQdOAh7CLV4bUBkc
         L2XZtP0/P+Mk7mXbpFPlDyM6JTi6nM12C2tLRV+hggy94Ua/Qe/xLWVHR4uRn9SIIX3T
         d2GJF9W9fYAzBzxGpik/xFzSE6gv1FCxGNYvzlniyHCECvE6GVBTQ3q7yyLVIJgBzmDH
         t5/3KQWxviwMfxxyyTfMz7ONn1pILjmN79VrWnp4/lRgBu2632Qw5Kx5K1iZsOEopRA+
         3tTQ==
X-Gm-Message-State: ANoB5plCMiAl/cClXzGSDzT7hOWt+u95cgdyg4ZYQmgO2/5YRgzb+qgI
	A4Pqb9IImpY64X7/jgW4NZa/KUR35UJZb2mYRF7+i768o1ZkGg==
X-Google-Smtp-Source: AA0mqf5OTXKylMnrjqgvptuTnQlQmkFLrEr+ICbH8Zl09QqWLWVEitjkIo/rbgjEj/T8iV+MrKYhIYDFCb3e
X-Received: by 2002:a05:6870:ed95:b0:141:8986:3acc with SMTP id fz21-20020a056870ed9500b0014189863accmr8174241oab.13.1668814099431;
        Fri, 18 Nov 2022 15:28:19 -0800 (PST)
Received: from c7-smtp.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id a19-20020a056870b15300b001422eda72ddsm338659oal.25.2022.11.18.15.28.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Nov 2022 15:28:19 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 88AB6221B1;
	Fri, 18 Nov 2022 16:28:18 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 7DB56E40609; Fri, 18 Nov 2022 16:28:18 -0700 (MST)
From: Caleb Sander <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander <csander@purestorage.com>
Subject: [PATCH] nvme: fix SRCU protection of nvme_ns_head list
Date: Fri, 18 Nov 2022 16:27:56 -0700
Message-Id: <20221118232756.1457075-1-csander@purestorage.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221118_152823_071337_1B12AA88 
X-CRM114-Status: GOOD (  17.19  )
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

Walking the nvme_ns_head siblings list is protected by the head's srcu
in nvme_ns_head_submit_bio() but not nvme_mpath_revalidate_paths().
Removing namespaces from the list also fails to synchronize the srcu.
Concurrent scan work can therefore cause use-after-frees.

Hold the head's srcu lock in nvme_mpath_revalidate_paths() and
synchronize with the srcu, not the global RCU, in nvme_ns_remove().

Observed the following panic when making NVMe/RDMA connections
with native multipath on the Rocky Linux 8.6 kernel
(it seems the upstream kernel has the same race condition).
Disassembly shows the faulting instruction is cmp 0x50(%rdx),%rcx;
computing capacity !=3D get_capacity(ns->disk).
Address 0x50 is dereferenced because ns->disk is NULL.
The NULL disk appears to be the result of concurrent scan work
freeing the namespace (note the log line in the middle of the panic).

[37314.206036] BUG: unable to handle kernel NULL pointer dereference at 000=
0000000000050
[37314.206036] nvme0n3: detected capacity change from 0 to 11811160064
[37314.299753] PGD 0 P4D 0
[37314.299756] Oops: 0000 [#1] SMP PTI
[37314.299759] CPU: 29 PID: 322046 Comm: kworker/u98:3 Kdump: loaded Tainte=
d: G        W      X --------- -  - 4.18.0-372.32.1.el8test86.x86_64 #1
[37314.299762] Hardware name: Dell Inc. PowerEdge R720/0JP31P, BIOS 2.7.0 0=
5/23/2018
[37314.299763] Workqueue: nvme-wq nvme_scan_work [nvme_core]
[37314.299783] RIP: 0010:nvme_mpath_revalidate_paths+0x26/0xb0 [nvme_core]
[37314.299790] Code: 1f 44 00 00 66 66 66 66 90 55 53 48 8b 5f 50 48 8b 83 =
c8 c9 00 00 48 8b 13 48 8b 48 50 48 39 d3 74 20 48 8d 42 d0 48 8b 50 20 <48=
> 3b 4a 50 74 05 f0 80 60 70 ef 48 8b 50 30 48 8d 42 d0 48 39 d3
[37315.058803] RSP: 0018:ffffabe28f913d10 EFLAGS: 00010202
[37315.121316] RAX: ffff927a077da800 RBX: ffff92991dd70000 RCX: 00000000016=
00000
[37315.206704] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff92991b7=
19800
[37315.292106] RBP: ffff929a6b70c000 R08: 000000010234cd4a R09: c0000000fff=
f7fff
[37315.377501] R10: 0000000000000001 R11: ffffabe28f913a30 R12: 00000000000=
00000
[37315.462889] R13: ffff92992716600c R14: ffff929964e6e030 R15: ffff92991dd=
70000
[37315.548286] FS:  0000000000000000(0000) GS:ffff92b87fb80000(0000) knlGS:=
0000000000000000
[37315.645111] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[37315.713871] CR2: 0000000000000050 CR3: 0000002208810006 CR4: 00000000000=
606e0
[37315.799267] Call Trace:
[37315.828515]  nvme_update_ns_info+0x1ac/0x250 [nvme_core]
[37315.892075]  nvme_validate_or_alloc_ns+0x2ff/0xa00 [nvme_core]
[37315.961871]  ? __blk_mq_free_request+0x6b/0x90
[37316.015021]  nvme_scan_work+0x151/0x240 [nvme_core]
[37316.073371]  process_one_work+0x1a7/0x360
[37316.121318]  ? create_worker+0x1a0/0x1a0
[37316.168227]  worker_thread+0x30/0x390
[37316.212024]  ? create_worker+0x1a0/0x1a0
[37316.258939]  kthread+0x10a/0x120
[37316.297557]  ? set_kthread_struct+0x50/0x50
[37316.347590]  ret_from_fork+0x35/0x40
[37316.390360] Modules linked in: nvme_rdma nvme_tcp(X) nvme_fabrics nvme_c=
ore netconsole iscsi_tcp libiscsi_tcp dm_queue_length dm_service_time nf_co=
nntrack_netlink br_netfilter bridge stp llc overlay nft_chain_nat ipt_MASQU=
ERADE nf_nat xt_addrtype xt_CT nft_counter xt_state xt_conntrack nf_conntra=
ck nf_defrag_ipv6 nf_defrag_ipv4 xt_comment xt_multiport nft_compat nf_tabl=
es libcrc32c nfnetlink dm_multipath tg3 rpcrdma sunrpc rdma_ucm ib_srpt ib_=
isert iscsi_target_mod target_core_mod ib_iser libiscsi scsi_transport_iscs=
i ib_umad rdma_cm ib_ipoib iw_cm ib_cm intel_rapl_msr iTCO_wdt iTCO_vendor_=
support dcdbas intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powercl=
amp coretemp kvm_intel ipmi_ssif kvm irqbypass crct10dif_pclmul crc32_pclmu=
l mlx5_ib ghash_clmulni_intel ib_uverbs rapl intel_cstate intel_uncore ib_c=
ore ipmi_si joydev mei_me pcspkr ipmi_devintf mei lpc_ich wmi ipmi_msghandl=
er acpi_power_meter ext4 mbcache jbd2 sd_mod t10_pi sg mgag200 mlx5_core dr=
m_kms_helper syscopyarea
[37316.390419]  sysfillrect ahci sysimgblt fb_sys_fops libahci drm crc32c_i=
ntel libata mlxfw pci_hyperv_intf tls i2c_algo_bit psample dm_mirror dm_reg=
ion_hash dm_log dm_mod fuse [last unloaded: nvme_core]
[37317.645908] CR2: 0000000000000050

Fixes: e7d65803e2bb ("nvme-multipath: revalidate paths during rescan")
Signed-off-by: Caleb Sander <csander@purestorage.com>
---
 drivers/nvme/host/core.c      | 2 +-
 drivers/nvme/host/multipath.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index da55ce45ac70..69e333922bea 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4304,7 +4304,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	mutex_unlock(&ns->ctrl->subsys->lock);
=20
 	/* guarantee not available in head->list */
-	synchronize_rcu();
+	synchronize_srcu(&ns->head->srcu);
=20
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 93e2138a8b42..7e025b8948cb 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -174,11 +174,14 @@ void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
 	struct nvme_ns_head *head =3D ns->head;
 	sector_t capacity =3D get_capacity(head->disk);
 	int node;
+	int srcu_idx;
=20
+	srcu_idx =3D srcu_read_lock(&head->srcu);
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
 		if (capacity !=3D get_capacity(ns->disk))
 			clear_bit(NVME_NS_READY, &ns->flags);
 	}
+	srcu_read_unlock(&head->srcu, srcu_idx);
=20
 	for_each_node(node)
 		rcu_assign_pointer(head->current_path[node], NULL);
--=20
2.25.1


