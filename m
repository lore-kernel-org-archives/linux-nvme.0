Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69357CCF9E3
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 23:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pX+WO24J38G/YYX7x1TloiaUtW2wNzcw2XV3cvOsnC0=; b=VL8Sr+WmjXnhuiqXh+9avD1uvy
	M/I1jS7vNXr7Mot8Oj/Qgt9VnQEDGuBhqsS7hfCFR5T08wMkTAsk4HU9w9wRQ5Rj422zB0BwNUo/v
	EiiqxtotJIpiIB3lp9KXo0b/+DqSUoNB/lCQSePGg8ZQPoR1hEoLQLFtI1PeUjJu4hfUN3QGfF32f
	mSCNdga+kMaea4+XMx6vB88/PCO5stiayctIWF72WXtaK8NJh7Wv1MUpymjPEdpYm7E8T0hCzJoXP
	50NpEs4SfZxCtgmQ3/8Y3Qae60msF5mXIPhCl9a7HE9z9WgupdvGWneSDD6Y/a5C7TZG1Yxg5S+Fe
	gY0qfQEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGQ0M-0000000CiiZ-2KGZ;
	Tue, 04 Nov 2025 22:59:58 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGQ0J-0000000Cii2-2dPT
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 22:59:56 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4MGhv11213055
	for <linux-nvme@lists.infradead.org>; Tue, 4 Nov 2025 14:59:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=pX+WO24J38G/YYX7x1
	TloiaUtW2wNzcw2XV3cvOsnC0=; b=clUNztb63UnwvjUAYN8h7A6LDndK4njMWp
	36NlrMmuycIki3q+F1DLej8c0WRrUwE+dtH8q/dVWy1oKhWagtOh/4sGEOqXO/o1
	nqDCp+1JOZ5K/9RM+UHKTHKubyoodaGO9sBqE5lnCDoknpoj5iatDK1+w3xJycpM
	465RpAoTud2Ro1BKxUGUZJ5IwbjOgDigCUTCa46YyFh0Ka/uX7BK1EepYwSOAXDE
	W5flGzlb1E0bFTEI5FspIcaLBkke1CIHjNdTl2dxgImjDXrXL7xN0xtsScEfjdPm
	OIjkAL8PZSyy6h2SmPbxBTOjLgXYVsCIuccDaDmTtjmOZlBVLOXg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a7mgabqmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 04 Nov 2025 14:59:54 -0800 (PST)
Received: from twshared13080.31.frc3.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 4 Nov 2025 22:59:53 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 9664736ECC08; Tue,  4 Nov 2025 14:59:39 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <ming.lei@redhat.com>, <chaitanyak@nvidia.com>,
        Keith Busch
	<kbusch@kernel.org>, Casey Chen <cachen@purestorage.com>
Subject: [PATCH] nvme: fix admin request_queue lifetime
Date: Tue, 4 Nov 2025 14:59:39 -0800
Message-ID: <20251104225939.3641605-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE5MyBTYWx0ZWRfXx/9Gp3bRmaS0
 +/KmSK9Rvzwh2NLNuszt1Ydj81zbJAxfhN6dZ2Z5JJg5iu8z1z1J1TtDh8p/8W5rgkjcb1W7SyV
 WaHII92ab07mEtTc0KaXQY+nIGdhxe9+1yeR4K2il9TpcKi6EOlKiyilEUnv769q5xWnvGrZ8kJ
 GySc2Z5vqcKrR6JmSQqX7dIYmGfQ2oEBmY1lEQnQC9YZHwu9YhpqCQfI8nnO/mSzMD02JQL7pPU
 kno7PQuZx/F+2XULhkQV2tkhJgjU++t4Y7MUZlf9gmpk8hJdd2t450b7x4+u+POq7DmyBHHGp4T
 Xn4rFgRDf7oZjlUp3UeXuPuusSIm15UN1JKTBzc77YZOUOw1lDIjGlBzYlUY9OfHwexZEmRXz+F
 4cu2rzSAFmuGhEWvhBbBQ/KQ6a6xXw==
X-Proofpoint-GUID: ciJTK9PtgX00IUU2XjxsO42SuL2mcevs
X-Proofpoint-ORIG-GUID: ciJTK9PtgX00IUU2XjxsO42SuL2mcevs
X-Authority-Analysis: v=2.4 cv=Hqt72kTS c=1 sm=1 tr=0 ts=690a856a cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=WTJdmG3rAAAA:8
 a=14QwOunS_wrhAvECUoYA:9 a=q3NGepEMMmKWaCv8Sx90:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_04,2025-11-03_03,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_145955_692709_62D203D4 
X-CRM114-Status: GOOD (  14.04  )
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

From: Keith Busch <kbusch@kernel.org>

The namespaces can access the controller's admin request_queue, and
stale references on the namespaces may exist. Ensure the request_queue
is active by moving the controller's 'put' after all references on the
controller have been released to ensure no one is trying to access the
request_queue. This fixes a reported use-after-free bug:

  BUG: KASAN: slab-use-after-free in blk_queue_enter+0x41c/0x4a0
  Read of size 8 at addr ffff88c0a53819f8 by task nvme/3287
  CPU: 67 UID: 0 PID: 3287 Comm: nvme Tainted: G            E       6.13.=
2-ga1582f1a031e #15
  Tainted: [E]=3DUNSIGNED_MODULE
  Hardware name: Jabil /EGS 2S MB1, BIOS 1.00 06/18/2025
  Call Trace:
   <TASK>
   dump_stack_lvl+0x4f/0x60
   print_report+0xc4/0x620
   ? _raw_spin_lock_irqsave+0x70/0xb0
   ? _raw_read_unlock_irqrestore+0x30/0x30
   ? blk_queue_enter+0x41c/0x4a0
   kasan_report+0xab/0xe0
   ? blk_queue_enter+0x41c/0x4a0
   blk_queue_enter+0x41c/0x4a0
   ? __irq_work_queue_local+0x75/0x1d0
   ? blk_queue_start_drain+0x70/0x70
   ? irq_work_queue+0x18/0x20
   ? vprintk_emit.part.0+0x1cc/0x350
   ? wake_up_klogd_work_func+0x60/0x60
   blk_mq_alloc_request+0x2b7/0x6b0
   ? __blk_mq_alloc_requests+0x1060/0x1060
   ? __switch_to+0x5b7/0x1060
   nvme_submit_user_cmd+0xa9/0x330
   nvme_user_cmd.isra.0+0x240/0x3f0
   ? force_sigsegv+0xe0/0xe0
   ? nvme_user_cmd64+0x400/0x400
   ? vfs_fileattr_set+0x9b0/0x9b0
   ? cgroup_update_frozen_flag+0x24/0x1c0
   ? cgroup_leave_frozen+0x204/0x330
   ? nvme_ioctl+0x7c/0x2c0
   blkdev_ioctl+0x1a8/0x4d0
   ? blkdev_common_ioctl+0x1930/0x1930
   ? fdget+0x54/0x380
   __x64_sys_ioctl+0x129/0x190
   do_syscall_64+0x5b/0x160
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x7f765f703b0b
  Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3=
 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f=
0 ff ff 73 01 c3 48 8b 0d dd 52 0f 00 f7 d8 64 89 01 48
  RSP: 002b:00007ffe2cefe808 EFLAGS: 00000202 ORIG_RAX: 0000000000000010
  RAX: ffffffffffffffda RBX: 00007ffe2cefe860 RCX: 00007f765f703b0b
  RDX: 00007ffe2cefe860 RSI: 00000000c0484e41 RDI: 0000000000000003
  RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
  R10: 00007f765f611d50 R11: 0000000000000202 R12: 0000000000000003
  R13: 00000000c0484e41 R14: 0000000000000001 R15: 00007ffe2cefea60
   </TASK>

Reported-by: Casey Chen <cachen@purestorage.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa4181d7de736..0b83d82f67e75 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4901,7 +4901,6 @@ void nvme_remove_admin_tag_set(struct nvme_ctrl *ct=
rl)
 	 */
 	nvme_stop_keep_alive(ctrl);
 	blk_mq_destroy_queue(ctrl->admin_q);
-	blk_put_queue(ctrl->admin_q);
 	if (ctrl->ops->flags & NVME_F_FABRICS) {
 		blk_mq_destroy_queue(ctrl->fabrics_q);
 		blk_put_queue(ctrl->fabrics_q);
@@ -5045,6 +5044,7 @@ static void nvme_free_ctrl(struct device *dev)
 		container_of(dev, struct nvme_ctrl, ctrl_device);
 	struct nvme_subsystem *subsys =3D ctrl->subsys;
=20
+	blk_put_queue(ctrl->admin_q);
 	if (!subsys || ctrl->instance !=3D subsys->instance)
 		ida_free(&nvme_instance_ida, ctrl->instance);
 	nvme_free_cels(ctrl);
--=20
2.47.3


