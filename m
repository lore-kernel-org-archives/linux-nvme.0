Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA00D11188
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Nov 2024 18:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=N7tUmVhnliRokygMGR6Td0kNwCfQ7RVja7rIKEpxV4w=; b=cWwShOYIVfmWNZ
	2wMNvqNbwW9YhbKCNMvNKckz/Yxn7bkQpH4iqmQzaRocALGmvJqO8HRumZ02eoUnS/7kC/H3X9U4b
	KHYC69erossH4HZzke0BPzm9LRazuIw3MTWDBN1aMmD1VVd3wWltWYQciLkfsp5QN/WXh0aCdZ0Wy
	Oahinq+SoX9bB9lpdcZAamn//CVFHwZrPImP/+4zsRgxGmJLEtxmkKgUYKX+8CoDJphTt0J21qNzT
	darH26VtkTT4NZGkKX2rHQyPwXpdV1mkhu2jaF0byxr5hyUA0GTBTYL4YhTp4d6/ZyqHlYpZYsscF
	IPG7AzGDj0xGeqPr6QYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7f7z-0000000BplU-3LRw;
	Sun, 03 Nov 2024 18:15:07 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7f7w-0000000Bpj1-2dgj
	for linux-nvme@lists.infradead.org;
	Sun, 03 Nov 2024 18:15:06 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3IEw3x018795;
	Sun, 3 Nov 2024 18:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=N7tUmVhnliRokygMGR6Td0kNwCfQ7RVja7rIKEpxV
	4w=; b=jdvq2DdHr+Q6i6DjFl+EUCcFrI6DcrAukMwvYM7oF3M4RrOjpM5vujuOp
	H698yEbUC85ei7erQy8SV2WxzPPrqA+5sTvtZ7Nex0HHzNkQS7kYQkFU+YqGq0db
	hkqNhZHiaax4vZ1rDFOqDrupIXqCFtoGdoXBNyIJ9D8/f8HgkRwztIhg3W2wOMus
	JRcG+/1e0SrCXeBCtveThSimsg/jIZ+M0H9RqOqVhiqV8bigi7tOV9391hVivS7l
	8HiztrnPdVyWkNpJ0w4fSDMMQTcr1ysp4uXbMuFy9LcxHN5ZBiHfAEHKlHQ7u3yX
	wZdp3gMTYzeQqkKff3ckAUxlhe0pg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42pcf207k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Nov 2024 18:14:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A33FL0S012249;
	Sun, 3 Nov 2024 18:14:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p140ru2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Nov 2024 18:14:57 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A3IEsO034472692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 3 Nov 2024 18:14:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1810820043;
	Sun,  3 Nov 2024 18:14:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3C9420040;
	Sun,  3 Nov 2024 18:14:51 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.89.247])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  3 Nov 2024 18:14:51 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, ming.lei@redhat.com,
        axboe@fb.com, chaitanyak@nvidia.com, dlemoal@kernel.org,
        gjoyce@linux.ibm.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv3 0/2] nvme: fix system fault observed while shutting down controller
Date: Sun,  3 Nov 2024 23:44:40 +0530
Message-ID: <20241103181450.933737-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sg4tKZdh_9AlQFuYlGZoVldzLP0aKlGp
X-Proofpoint-GUID: sg4tKZdh_9AlQFuYlGZoVldzLP0aKlGp
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 mlxlogscore=926 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411030164
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241103_101504_819114_347E2674 
X-CRM114-Status: GOOD (  19.76  )
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

This patch series addresses the system fault observed while shutting down 
fabric controller. We already fixed it[1] earlier however it was later 
relaized that we do have a better and optimal way to address it [2].

The first patch in the series reverts the changes implemented in [3].
So essentially we're making keep-alive operation asynchronous again as 
it was earlier.

The second patch in the series fix the kernel crash observed while 
shutting down fabric controller. The system fault was observed due 
to the keep-alive request sneaking in while shutting down fabric 
controller. We encounter the below intermittent kernel crash while 
running blktest nvme/037:

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
beginning of the controller shutdown code path or before destroying admin 
queue and freeing admin tagset, so that keep-alive wouldn't sneak in or 
interfere with the shutdown operation. However we removed the keep alive 
stop operation from the beginning of the controller shutdown code path in 
commit a54a93d0e359 ("nvme: move stopping keep-alive into nvme_uninit_
ctrl()") and that now created the possibility of keep-alive sneaking in and 
interfering with the shutdown operation and causing observed kernel crash. 

To fix the observed crash, we decided to move nvme_stop_keep_alive() from
nvme_uninit_ctrl() to nvme_remove_admin_tag_set(). This change would ensure
that we don't forward progress and delete the admin queue until the keep-
alive operation is finished (if it's in-flight) or cancelled. The second 
patch in the series help address the kernel crash.

[1]https://lore.kernel.org/all/ZxFSkNI2p65ucTB5@kbusch-mbp.dhcp.thefacebook.com/
[2]https://lore.kernel.org/all/196f4013-3bbf-43ff-98b4-9cb2a96c20c2@grimberg.me/
[3]https://lore.kernel.org/all/20241016030339.54029-3-nilay@linux.ibm.com/

Changes from v2:
    - Move nvme_stop_keep_alive() from nvme_uninit_ctrl() to
      nvme_remove_admin_tag_set() instead of adding it to
      nvme_stop_ctrl() which would help save one callsite of
      nvme_stop_keep_alive() (Ming Lei)
    - The third patch in the series isn't necessary if we avoid the full
      revert and squash the series to just one fixing commit (Keith
      Busch)
Changes from v1:
    - Update the commit log of the third patch to make the intent of the
      changes clear (Sagi Grimberg)

Nilay Shroff (2):
  Revert "nvme: make keep-alive synchronous operation"
  nvme-fabrics: fix kernel crash while shutting down controller

 drivers/nvme/host/core.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

-- 
2.45.2


