Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFD6D13573
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Oct 2024 17:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mhvl4vL0SfIp6mez0uiAv+EsxxTLKn/KCkuldeoMMf8=; b=mVpjs1U77++Ho5bmzhfL/C1fTe
	OcAdtEG+F7mHBRlva7OlHWDNpu8B80n4y6kuHBz7NAIPxAfUdC5x7MOZfHmYsQBMNHcBJ1pgMSnvm
	pp3Xq8kWhYDvXMaouGouGPE56OV/uRobMuNFeoc7Be+s7XKaKRWgO1BKriQhVYYLLQoe1YUEQ5/s4
	r8J+ciP/4M3gJYQHniZeCDVl7UPaFCUPDfKwt/ksjF0JW0Ia7t2z0ZdXolLSvoSWxATdngrUVtPUm
	ql8QPbbgBrr+ncqsLPxPqy61BlauRzH0zHTz0U1/a4xyEmV6TcZ+tbLhFWNRDSPjSnrtcjSre6KHE
	gzZq/DDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t56fG-00000008ZrB-2p8X;
	Sun, 27 Oct 2024 17:02:54 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t56fD-00000008ZpU-25bB
	for linux-nvme@lists.infradead.org;
	Sun, 27 Oct 2024 17:02:53 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49R6oMuG028528;
	Sun, 27 Oct 2024 17:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mhvl4vL0SfIp6mez0
	uiAv+EsxxTLKn/KCkuldeoMMf8=; b=ZYwuW+j2c6ktOd/1ndf7EhYgFd3EcV2/G
	eD9I8UdicEB1T5iGGch36FpbCE5eoca9w4KwYutH4Jejqvna2UUZNFkuI1a5drrn
	zq13WOePzTAhvINmCdbFkKzS/3ICgjnC1ttCKQNGU8WKwqWaxsv0ruLTlgewtBfQ
	549BVkZuyJVZCaivB+QTq0MauH4kSafut6UG1wNS+WoXxqA9X+XXvPUCEHeedSEA
	mLwk+I3bBa8V/wo80JKj8606/hN9t7likIGDQ1i37rV71118HTcrEzmXYb+aZWAT
	/lUB3XXDhOREVgSD63Ea6bmSld40ngd/P4usHonX0M5F7T7kKl0nw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42grftw14r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 27 Oct 2024 17:02:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49RGaCFs028275;
	Sun, 27 Oct 2024 17:02:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42hb4xjr2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 27 Oct 2024 17:02:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49RH2ULf49283450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 27 Oct 2024 17:02:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D58CE2004B;
	Sun, 27 Oct 2024 17:02:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABE5720040;
	Sun, 27 Oct 2024 17:02:27 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.179.2.58])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 27 Oct 2024 17:02:27 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
        chaitanyak@nvidia.com, dlemoal@kernel.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 2/3] nvme-fabrics: fix kernel crash while shutting down controller
Date: Sun, 27 Oct 2024 22:32:05 +0530
Message-ID: <20241027170209.440776-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241027170209.440776-1-nilay@linux.ibm.com>
References: <20241027170209.440776-1-nilay@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Wr6JGS1Y8zrcDcn_a2uvKjK-A6b9W0M6
X-Proofpoint-GUID: Wr6JGS1Y8zrcDcn_a2uvKjK-A6b9W0M6
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410270148
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241027_100251_724217_D976E29F 
X-CRM114-Status: GOOD (  21.17  )
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


