Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B346D1039A
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 12:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=og/Dy3fviAE6DnCeVkavNuuFNiaHWqntJTJuEG8zFL4=; b=a/BoE3btSh6RyaCGICGt3EE8xQ
	O9umgstQhWuLaiM4O9JKtyNErAPgeeiFZ9b1l+QBlEIfZahw8ExGR7Ndz4gBBpFJrwfEdksCWCngs
	0FROP9dzxX1ZIHZ9kCDVtaMo7J3sS8/gjFJ2nfOhqmb6xz/M24kinZjUAxoq7MudOeq89qMFe2Uwt
	0ziFRUIzSFC/zXVmn/EFaJTwCTjgf3vOktOhBbHoJTZTtcIMMYSIxmu6SQOlJbeyhixPFDOYVnWIH
	yjq4BLsgAL1ebNMZbkRPs+NM2axWuWRTUhdbihRQ0Z5yy+JkBtZy6n0ymFWN5oWOQd6CaVz3YMu5g
	3yq6wMrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5PIu-0000000Aqm0-33wt;
	Mon, 28 Oct 2024 12:57:04 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5PA8-0000000ApIV-35Px
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 12:48:02 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SBAKuK024484;
	Mon, 28 Oct 2024 12:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=og/Dy3fviAE6DnCeV
	kavNuuFNiaHWqntJTJuEG8zFL4=; b=IZjeprMYqYwCIlBJsLMe5C0KqifBdybBV
	zR90CwKgTVq+YNFdTTWKOW/FeI12p/KqWV26AK+rbkEK0ePGEiw4/PO9lf2OsppV
	kT7W26DKlZoHClqKHouD2TDrUzeiB7QxqAi0jNGvA4VvCaI4gunVyvkq2p0kQJFh
	nQ9XY6I8Jx3UYBJ2IWM5CeFjZznqWMrQwkAS/87eCqMyQNlFpr3L95vUBL0gOdzO
	B9EE33VDEwWdJNRYe0MieqWbJaUArss0OFk2tVY64rONR4G1q2izLgxOiekK+/mQ
	GhEay2KLWdQSr7K7MdQVErz7iil1v09lzbRnX4aiLG6oQa7F11drQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42j43ftehg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 12:47:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49SBIbYm017362;
	Mon, 28 Oct 2024 12:47:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42hars6e41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 12:47:29 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49SClQ5i54460878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 12:47:26 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CA3D20040;
	Mon, 28 Oct 2024 12:47:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17FA82004D;
	Mon, 28 Oct 2024 12:47:24 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.1.253])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Oct 2024 12:47:23 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
        chaitanyak@nvidia.com, dlemoal@kernel.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 2/3] nvme-fabrics: fix kernel crash while shutting down controller
Date: Mon, 28 Oct 2024 18:17:10 +0530
Message-ID: <20241028124717.517132-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028124717.517132-1-nilay@linux.ibm.com>
References: <20241028124717.517132-1-nilay@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CiMilnJLY_ANCp7c7E9FJlkRsx0BL1og
X-Proofpoint-ORIG-GUID: CiMilnJLY_ANCp7c7E9FJlkRsx0BL1og
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 adultscore=0 mlxscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410280103
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_054800_836449_6A346F39 
X-CRM114-Status: GOOD (  21.35  )
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

The nvme keep-alive operation, which executes at a periodic interval,
could potentially sneak in while shutting down a fabric controller.
This may lead to a race between the fabric controller admin queue
destroy code path (invoked while shutting down controller) and hw/hctx
queue dispatcher called from the nvme keep-alive async request queuing
operation. This race could lead to the kernel crash shown below:

Call Trace:
    autoremove_wake_function+0x0/0xbc (unreliable)
    __blk_mq_sched_dispatch_requests+0x114/0x24c
    blk_mq_sched_dispatch_requests+0x44/0x84
    blk_mq_run_hw_queue+0x140/0x220
    nvme_keep_alive_work+0xc8/0x19c [nvme_core]
    process_one_work+0x200/0x4e0
    worker_thread+0x340/0x504
    kthread+0x138/0x140
    start_kernel_thread+0x14/0x18

While shutting down fabric controller, if nvme keep-alive request sneaks
in then it would be flushed off. The nvme_keep_alive_end_io function is
then invoked to handle the end of the keep-alive operation which
decrements the admin->q_usage_counter and assuming this is the last/only
request in the admin queue then the admin->q_usage_counter becomes zero.
If that happens then blk-mq destroy queue operation (blk_mq_destroy_
queue()) which could be potentially running simultaneously on another
cpu (as this is the controller shutdown code path) would forward
progress and deletes the admin queue. So, now from this point onward
we are not supposed to access the admin queue resources. However the
issue here's that the nvme keep-alive thread running hw/hctx queue
dispatch operation hasn't yet finished its work and so it could still
potentially access the admin queue resource while the admin queue had
been already deleted and that causes the above crash.

The above kernel crash is regression caused due to changes implemented
in commit a54a93d0e359 ("nvme: move stopping keep-alive into
nvme_uninit_ctrl()"). Ideally we should stop keep-alive at the very
beggining of the controller shutdown code path so that it wouldn't
sneak in during the shutdown operation. However we removed the keep
alive stop operation from the beginning of the controller shutdown
code path in commit a54a93d0e359 ("nvme: move stopping keep-alive into
nvme_uninit_ctrl()") and that now created the possibility of keep-alive
sneaking in and interfering with the shutdown operation and causing
observed kernel crash. So to fix this crash, now we're adding back the
keep-alive stop operation at very beginning of the fabric controller
shutdown code path so that the actual controller shutdown opeation only
begins after it's ensured that keep-alive operation is not in-flight and
also it can't be scheduled in future.

Fixes: a54a93d0e359 ("nvme: move stopping keep-alive into nvme_uninit_ctrl()")
Link: https://lore.kernel.org/all/196f4013-3bbf-43ff-98b4-9cb2a96c20c2@grimberg.me/#t
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5016f69e9a15..865c00ea19e3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4648,6 +4648,11 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_mpath_stop(ctrl);
 	nvme_auth_stop(ctrl);
+	/*
+	 * the transport driver may be terminating the admin tagset a little
+	 * later on, so we cannot have the keep-alive work running
+	 */
+	nvme_stop_keep_alive(ctrl);
 	nvme_stop_failfast_work(ctrl);
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fw_act_work);
-- 
2.45.2


