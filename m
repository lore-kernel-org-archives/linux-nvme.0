Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8D8C61DA3
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Feb 2023 09:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=akvuOwcRtodNewPKq5elGkjRSlY8KzxF+I6SuGahJ0I=; b=X4XL638TIPdjwzP8AGLLrra9/x
	eSuGh/ni65j8ec6mntO/CEqJXqHC6y3hJKLwNWPyiAWe3tljA+EaF+VQaSi8vBm/wCxMkK1ZmOUZz
	eIB+bZePJHyWY+D/ix/H3HBRBG8eO4ym1EeEsZag+X7xqF//7UqBatq6fD1i6BMgN5dsA13gc4Fv4
	VyHI8C0voalXJE8gSp44AneGPnPi2YWkos5b62ui1GylFXqEZJLtl2oG7u2ix9kwZTkVt0Szu9aIG
	RngQPmDce25PI4ugBtjYtXFvdhp0JLB97tpHRODVaMx8WIAthJozYhJ7TLYzWeuucif0HZM8mQU0l
	m1xqslbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUPOf-007IVe-3A; Tue, 21 Feb 2023 09:57:17 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUPOc-007IV4-CS
	for linux-nvme@lists.infradead.org; Tue, 21 Feb 2023 09:57:15 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31L702mK006806;
	Tue, 21 Feb 2023 01:57:13 -0800
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3nty303ku3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 21 Feb 2023 01:57:13 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Feb
 2023 01:57:11 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Tue, 21 Feb 2023 01:57:11 -0800
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
	by maili.marvell.com (Postfix) with ESMTP id 433B83F7075;
	Tue, 21 Feb 2023 01:57:11 -0800 (PST)
From: Nilesh Javali <njavali@marvell.com>
To: <linux-nvme@lists.infradead.org>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <GR-QLogic-Storage-Upstream@marvell.com>,
        <bhazarika@marvell.com>, <agurumurthy@marvell.com>,
        <sdeodhar@marvell.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] nvme-fc: initialize nvme fc ctrl ops
Date: Tue, 21 Feb 2023 01:57:08 -0800
Message-ID: <20230221095708.29094-1-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: h81V4yMmDoeQ5nUPdUYNpJ_UxassGi2m
X-Proofpoint-ORIG-GUID: h81V4yMmDoeQ5nUPdUYNpJ_UxassGi2m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_06,2023-02-20_02,2023-02-09_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230221_015714_562227_2AE8B456 
X-CRM114-Status: GOOD (  11.57  )
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

The system crashed while performing qla2xxx nvme discovery with
below call trace,

qla2xxx [0000:21:00.0]-2102:12: qla_nvme_register_remote: traddr=nn-0x245e00a098f4684a:pn-0x245f00a098f4684a PortID:5a247a
qla2xxx [0000:21:00.0]-2102:12: qla_nvme_register_remote: traddr=nn-0x245e00a098f4684a:pn-0x246100a098f4684a PortID:5a2d6e
BUG: kernel NULL pointer dereference, address: 0000000000000010
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 61 PID: 6064 Comm: nvme Kdump: loaded Not tainted 6.2.0-rc1 #3
Hardware name: Dell Inc. PowerEdge R7525/0590KW, BIOS 2.5.6 10/06/2021
RIP: 0010:nvme_alloc_admin_tag_set+0x51/0x120 [nvme_core]
Code: 00 00 00 00 81 c1 b0 00 00 00 48 c7 86 a8 00 00 00 00 00 00 00
      c1 e9 03 f3 48 ab 4c 89 46 38 c7 46 44 1e 00 00 00 48 8b 45 30
      <f6> 40 10 01 74 07 c7 46 48 01 00 00 00 8b 45 5c c7 43 58 40 00 00
RSP: 0018:ffffafe6cd7cbd10 EFLAGS: 00010212
RAX: 0000000000000000 RBX: ffff898e0c39c050 RCX: 0000000000000000
RDX: 00000000000001d8 RSI: ffff898e0c39c050 RDI: ffff898e0c39c100
RBP: ffff898e0c39c398 R08: ffffffffc0afe1a0 R09: ffff896ed602a600
R10: 0000000000000010 R11: f000000000000000 R12: ffff898e06ea2600
R13: ffff898e070ffbc0 R14: ffff898e0c39c040 R15: ffff898e0c39c398
FS:  00007f9368279780(0000) GS:ffff89ad7fb40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000010 CR3: 000000210c570000 CR4: 0000000000350ee0
Call Trace:
nvme_fc_init_ctrl+0x328/0x460 [nvme_fc]
nvme_fc_create_ctrl+0x1b0/0x260 [nvme_fc]
nvmf_create_ctrl+0x141/0x240 [nvme_fabrics]
nvmf_dev_write+0x81/0xe0 [nvme_fabrics]
vfs_write+0xc5/0x3b0
? syscall_exit_work+0x103/0x130
? syscall_exit_to_user_mode+0x12/0x30
ksys_write+0x5f/0xe0
do_syscall_64+0x5c/0x90
? exc_page_fault+0x62/0x150
entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7f936813e967
Code: 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f
      1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05
      <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
SP: 002b:00007fff4197a468 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000560862447d40 RCX: 00007f936813e967
RDX: 000000000000012b RSI: 0000560862447d40 RDI: 0000000000000003
RBP: 0000000000000003 R08: 000000000000012b R09: 0000560862447d40
R10: 0000000000000000 R11: 0000000000000246 R12: 00005608624473f0
R13: 000000000000012b R14: 00007f93682e6100 R15: 00007f93682e613d

Initialize the nvme_fc_ctrl_ops before allocating the nvme admin
tag set.

Fixes: 6dfba1c09c10 ("nvme-fc: use the tagset alloc/free helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
v2:
- correct the cleanup path
- Add Cc tag

 drivers/nvme/host/fc.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 4564f16a0b20..53297cad49ea 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3521,13 +3521,6 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	nvme_fc_init_queue(ctrl, 0);
 
-	ret = nvme_alloc_admin_tag_set(&ctrl->ctrl, &ctrl->admin_tag_set,
-			&nvme_fc_admin_mq_ops,
-			struct_size((struct nvme_fcp_op_w_sgl *)NULL, priv,
-				    ctrl->lport->ops->fcprqst_priv_sz));
-	if (ret)
-		goto out_free_queues;
-
 	/*
 	 * Would have been nice to init io queues tag set as well.
 	 * However, we require interaction from the controller
@@ -3537,7 +3530,14 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_fc_ctrl_ops, 0);
 	if (ret)
-		goto out_cleanup_tagset;
+		goto out_free_queues;
+
+	ret = nvme_alloc_admin_tag_set(&ctrl->ctrl, &ctrl->admin_tag_set,
+			&nvme_fc_admin_mq_ops,
+			struct_size((struct nvme_fcp_op_w_sgl *)NULL, priv,
+				    ctrl->lport->ops->fcprqst_priv_sz));
+	if (ret)
+		goto out_free_queues;
 
 	/* at this point, teardown path changes to ref counting on nvme ctrl */
 
@@ -3592,8 +3592,6 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	return ERR_PTR(-EIO);
 
-out_cleanup_tagset:
-	nvme_remove_admin_tag_set(&ctrl->ctrl);
 out_free_queues:
 	kfree(ctrl->queues);
 out_free_ida:
-- 
2.23.1


