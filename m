Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA785D11187
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Nov 2024 18:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+9Ru1rlOzia1lIFM9QRo6kt14Nprm6Fs43REGYNgLB4=; b=abmYk8KsXbHZuqaU0M79Xo2tPb
	oXdIKO9nLLd6w89qDsvay//KYm3qdA3hXKGm6Zd6CbBHYibHLKaq0JBoBhqrCnD7hEBdi+XSoedG4
	1/fX/2gU4eLHohlck762DgysJFR3sUYG61C+cx28BEM7jgxFLPgl88yoVgT1LsrjsxQHoKru5Kmqq
	Sk+uPIbEueFzeNUO7o8up3u92TN+D5TuwcixIe7tG6TDApU1Fh1cXUbWgarvBIn+eQneo4d0moeSi
	EebG2McoHsBmN/mgRHYpbXg5GZvJWUwYEmLRKVDPHhokqgTLa875CRZdPXJY2A4Uvwag+iFtJsLg5
	baN0XDCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7f8D-0000000Bpuv-1aYN;
	Sun, 03 Nov 2024 18:15:21 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7f8A-0000000Bps6-10MY
	for linux-nvme@lists.infradead.org;
	Sun, 03 Nov 2024 18:15:19 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3IBi7E005639;
	Sun, 3 Nov 2024 18:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+9Ru1rlOzia1lIFM9
	QRo6kt14Nprm6Fs43REGYNgLB4=; b=Tax6XarBtulyFqRZc9EVYJLYL+ZoAanGr
	sY1mWSNaz9RAfGw9+h1p9rbI0+JnBV4QEfWQuBAYvbWBbXDaVJCs9TbBH2LL8+JX
	5wIgNuwBMUXRW3AzrOP8d6ar3OYDoD1q2t0HZoYRKaggccF9L5OJHcx5Lmuso1B2
	0Qc+/l/XLBNt0gfbWo3YOnI+53fDs5s4B5LCGHBYoT1XTk5rW24rga7TDWvinpxU
	rejIDufXS+fLjCuNCkewYnOLU+2dFy++FhgyG2t5NCv2mL46Qpqfe7S6Crx/GGjX
	Vgb68JcvVYeBzv2q++3Yc05pAPTWZWdhMeUK44M9cTlvKNHJMAuHA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42pe77005t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Nov 2024 18:15:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3GVidi024253;
	Sun, 3 Nov 2024 18:15:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42nxds10rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Nov 2024 18:15:03 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A3IExsv49676598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 3 Nov 2024 18:14:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B223120043;
	Sun,  3 Nov 2024 18:14:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7379220040;
	Sun,  3 Nov 2024 18:14:57 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.89.247])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  3 Nov 2024 18:14:57 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, ming.lei@redhat.com,
        axboe@fb.com, chaitanyak@nvidia.com, dlemoal@kernel.org,
        gjoyce@linux.ibm.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv3 2/2] nvme-fabrics: fix kernel crash while shutting down controller
Date: Sun,  3 Nov 2024 23:44:42 +0530
Message-ID: <20241103181450.933737-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241103181450.933737-1-nilay@linux.ibm.com>
References: <20241103181450.933737-1-nilay@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: T0QnznZoh7YMGUyK27Im5FD6s-5oXbzs
X-Proofpoint-GUID: T0QnznZoh7YMGUyK27Im5FD6s-5oXbzs
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411030164
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241103_101518_318791_287A3A1A 
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
nvme_uninit_ctrl()"). Ideally we should stop keep-alive before destroyin
g the admin queue and freeing the admin tagset so that it wouldn't sneak
in during the shutdown operation. However we removed the keep alive stop
operation from the beginning of the controller shutdown code path in commit
a54a93d0e359 ("nvme: move stopping keep-alive into nvme_uninit_ctrl()")
and added it under nvme_uninit_ctrl() which executes very late in the
shutdown code path after the admin queue is destroyed and its tagset is
removed. So this change created the possibility of keep-alive sneaking in
and interfering with the shutdown operation and causing observed kernel
crash.

To fix the observed crash, we decided to move nvme_stop_keep_alive() from
nvme_uninit_ctrl() to nvme_remove_admin_tag_set(). This change would ensure
that we don't forward progress and delete the admin queue until the keep-
alive operation is finished (if it's in-flight) or cancelled and that would
help contain the race condition explained above and hence avoid the crash.

Fixes: a54a93d0e359 ("nvme: move stopping keep-alive into nvme_uninit_ctrl()")
Link: https://lore.kernel.org/all/1a21f37b-0f2a-4745-8c56-4dc8628d3983@linux.ibm.com/
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ddf07df243d3..a55c56123bfe 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4593,6 +4593,11 @@ EXPORT_SYMBOL_GPL(nvme_alloc_admin_tag_set);
 
 void nvme_remove_admin_tag_set(struct nvme_ctrl *ctrl)
 {
+	/*
+	 * As we're about to destroy the queue and free tagset
+	 * we can not have keep-alive work running.
+	 */
+	nvme_stop_keep_alive(ctrl);
 	blk_mq_destroy_queue(ctrl->admin_q);
 	blk_put_queue(ctrl->admin_q);
 	if (ctrl->ops->flags & NVME_F_FABRICS) {
-- 
2.45.2


