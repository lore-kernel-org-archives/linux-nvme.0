Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C2ED13573
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Oct 2024 17:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=MK8CAtP2wEShfQ3fSz7l55s1WH+oDvf/YZz8IzERxh8=; b=X2aQ+/jUfssehJ
	OqxEcB3BOFFfMCx5Cd9pLn7BLvhFBSUpc5ss3yqT5b6gOS/judb4tuzyAlSqSBK5jC9xJeOb0Ifbo
	L9l9itmXtRKez5noTbuiT1WKlz+MSLKNHtRAuJLfsCznCtJoUb9bYcFn7yFK1OIlbppAD6reZhdkH
	Jd/LaPNcjv8bcie4I3ygA+yr0fuWjvfHM4c1qVxAy0A0/r6wfU0W1ugRF8+QqcbP94hbYzQNFrjn3
	puT0RW3TvlTQG4ue9+xSDdaJmLQsMtSHLv3mJJRKmZ5DJbBUsiQR7YQ04374DF+9sMMx8TwEFKbLo
	f2ZUC19hDGHyqPOq70gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t56fI-00000008Zs4-2Ioo;
	Sun, 27 Oct 2024 17:02:56 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t56fE-00000008ZqC-1iss
	for linux-nvme@lists.infradead.org;
	Sun, 27 Oct 2024 17:02:53 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49RFP3AM009108;
	Sun, 27 Oct 2024 17:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=MK8CAtP2wEShfQ3fSz7l55s1WH+oDvf/YZz8IzERx
	h8=; b=GfwXlu2Siuek947DNQ9R09a1tZ05FLGZxAGCj883BoRr999ElCw01T9ey
	hrpqMxKo2lEiHJ2qHdZP3wMZcYzqegcRpxjDqc7dopwTLoM2NG62BONZ8h79Xy7b
	yXZOcrM7EYku4imw3mB0HLEj/BaNKMEM+RXXm3GcJJUJA9TC/MpmzS6/1QLrUgYU
	C0CB9tG/TpW8fuJNlqIzEhmX8tBhdz5vYbTO1QzvCopZNDLTOb+3lQt7+a5lCqbr
	rjqRdcudci8Ty4JMAOdFwQE4cla2A3JDoHMrQ/OebOEqTAX0XTWx6P4QNKNTU8q8
	6p9POYShLDrakIJFXS75tkRYNdPJg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42grftw14h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 27 Oct 2024 17:02:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49RG1P16017410;
	Sun, 27 Oct 2024 17:02:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42hars2th7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 27 Oct 2024 17:02:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49RH2OQ143123146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 27 Oct 2024 17:02:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6377720043;
	Sun, 27 Oct 2024 17:02:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B854620040;
	Sun, 27 Oct 2024 17:02:21 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.179.2.58])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 27 Oct 2024 17:02:21 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
        chaitanyak@nvidia.com, dlemoal@kernel.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 0/3] nvme: fix system fault observed while shutting down controller
Date: Sun, 27 Oct 2024 22:32:03 +0530
Message-ID: <20241027170209.440776-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WUIF54psXobKG9FgbL-hX3Pbfz5JNs1T
X-Proofpoint-GUID: WUIF54psXobKG9FgbL-hX3Pbfz5JNs1T
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=804
 mlxscore=0 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410270148
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241027_100252_597534_491262DA 
X-CRM114-Status: GOOD (  19.14  )
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

Hi,

This patch series addresses the system fault observed while shutting
down fabric controller. We already fixed it[1] earlier however it was
later relaized that we do have a better and optimal way to address it
[2].

The first patch in the series reverts the changes implemented in [3] and
[4]. So essentially we're making keep-alive operation asynchronous again 
as it was earlier.
The second patch in the series fix the kernel crash observed while 
shutting down fabric controller.
The third patch in the series uses the nvme_ctrl_state function for 
retrieving the controller state.

The system fault was observed due to the keep-alive request sneaking in
while shutting down fabric controller. We encounter the below intermittent
kernel crash while running blktest nvme/037:

dmesg output:
------------
run blktests nvme/037 at 2024-10-04 03:59:27
<snip>
nvme nvme1: new ctrl: "blktests-subsystem-5"
nvme nvme1: Failed to configure AEN (cfg 300)
nvme nvme1: Removing ctrl: NQN "blktests-subsystem-5"
nvme nvme1: long keepalive RTT (54760 ms)
nvme nvme1: failed nvme_keep_alive_end_io error=4
BUG: Kernel NULL pointer dereference on read at 0x00000080
Faulting instruction address: 0xc00000000091c9f8
Oops: Kernel access of bad area, sig: 7 [#1]
LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
<snip>
CPU: 28 UID: 0 PID: 338 Comm: kworker/u263:2 Kdump: loaded Not tainted 6.11.0+ #89
Hardware name: IBM,9043-MRX POWER10 (architected) 0x800200 0xf000006 of:IBM,FW1060.00 (NM1060_028) hv:phyp pSeries
Workqueue: nvme-wq nvme_keep_alive_work [nvme_core]
NIP:  c00000000091c9f8 LR: c00000000084150c CTR: 0000000000000004
<snip>
NIP [c00000000091c9f8] sbitmap_any_bit_set+0x68/0xb8
LR [c00000000084150c] blk_mq_do_dispatch_ctx+0xcc/0x280
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

We realized  that the above crash is regression caused due to changes 
implemented in commit a54a93d0e359 ("nvme: move stopping keep-alive into 
nvme_uninit_ctrl()"). Ideally we should stop keep-alive at the very 
beggining of the controller shutdown code path so that it wouldn't sneak 
in or interfere with the shutdown operation. However we removed the keep
alive stop operation from the beginning of the controller shutdown code 
path in commit a54a93d0e359 ("nvme: move stopping keep-alive into nvme_
uninit_ctrl()") and that now created the possibility of keep-alive 
sneaking in and interfering with the shutdown operation and causing 
observed kernel crash. So to fix this crash, now we're adding back the
keep-alive stop operation at very beginning of the fabric controller
shutdown code path so that the actual controller shutdown opeation only
begins after it's ensured that keep-alive operation is not in-flight and
also it can't be scheduled in future. This fixed in the second patch of 
the series. 

The third patch in the series addresses the use of ctrl->lock before
accessing NVMe controller state in nvme_keep_alive_end_io function.
With introduction of helper nvme_ctrl_state, we no longer need to
first acquire ctrl->lock before accessing the NVMe controller state.
So this patch removes the use of ctrl->lock from nvme_keep_alive_end_io
function and replaces it with helper nvme_ctrl_state call.

[1]https://lore.kernel.org/all/ZxFSkNI2p65ucTB5@kbusch-mbp.dhcp.thefacebook.com/
[2]https://lore.kernel.org/all/196f4013-3bbf-43ff-98b4-9cb2a96c20c2@grimberg.me/
[3]https://lore.kernel.org/all/20241016030339.54029-3-nilay@linux.ibm.com/
[4]https://lore.kernel.org/all/20241016030339.54029-4-nilay@linux.ibm.com/

Nilay Shroff (3):
  Revert "nvme: make keep-alive synchronous operation"
  nvme-fabrics: fix kernel crash while shutting down controller
  nvme: use helper nvme_ctrl_state in nvme_keep_alive_end_io function

 drivers/nvme/host/core.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

-- 
2.45.2


