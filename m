Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69898D1CA37
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 06:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=KHj3QyAEJsCPFbXsy9sHx2x5Yi4U5pYH3HE69R7eug8=; b=Gdoav5Kuvu2FoY
	txe0Nc+6D8CjulRujs+EWZnyv4m+OFul7wttRH6SQPi1ChipPtKrFLwU9U9DY4MqbQBmQAAQO211N
	IL+wpZPwLG4+ZaXWGAAZmMllBI9UY6avzckI/jpFLkT/Gufh5EwjAPR53zrzQMufohJDPdl4nXb5u
	to+ZGkIR/eMzpCVvekTR1YSrAIj1FD3TAfjEcmOgXmRQGbVV+UwA5Pl7k37U2mjbFUJBa+JzvhHSv
	vFPh4jClN0LxTilWlVMV39PgeBL5QSOBQ10DwLTaUm7dA4uEbbAb8aOd6t0OdWSq4D0a6mRG8mDH2
	Ukyi8jxNtXvc/F7O/g9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Cnp-0000000G1Zt-1xSs;
	Tue, 05 Nov 2024 06:12:33 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Cnl-0000000G1YQ-3tCt
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 06:12:31 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A54AWHO010497;
	Tue, 5 Nov 2024 06:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=KHj3QyAEJsCPFbXsy9sHx2x5Yi4U5pYH3HE69R7eu
	g8=; b=EHJmMqgtcy27hMvCFPrQcXDU90uAkfGkF6TQW1pYw5JsI36gJvUcIcKyF
	vwNyrErzT5hbS2Dker7yZvOQcFk6x6ZK/ouCSp5YqoUb6uk4CZWepmUB7giEXEMz
	h3fSagqNl3jPVIX2Sijuq3TqxrMmqOFZLSzj9uQ0zbbXJzNtnFTPsUqKkuqenizz
	9oIpjQsDY83A2Qn+kBHqSdPllHWszByhWd5SwXoKLH91KMBaDtczwefodgo8zTs+
	JlB4pO6GR9aAfEDU0VEl8Vo8GeLstSSKEBtzASfM6Yn3Fp4Nf0nRr+NYjHulu9he
	sMH29NGE0LwU8pjYfh9937PsTCwRA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42qc3g0fkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 06:12:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4KwQhR012243;
	Tue, 5 Nov 2024 06:12:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p140ufkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 06:12:19 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A56CFLn44368354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Nov 2024 06:12:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DE4E20043;
	Tue,  5 Nov 2024 06:12:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3645420040;
	Tue,  5 Nov 2024 06:12:13 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.181])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Nov 2024 06:12:12 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, ming.lei@redhat.com,
        axboe@fb.com, chaitanyak@nvidia.com, dlemoal@kernel.org,
        gjoyce@linux.ibm.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv4 0/2] nvme: fix system fault observed while shutting down controller
Date: Tue,  5 Nov 2024 11:42:07 +0530
Message-ID: <20241105061212.1008143-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VIZdskYttign88Ole5QZMiAOm7PHAWhq
X-Proofpoint-ORIG-GUID: VIZdskYttign88Ole5QZMiAOm7PHAWhq
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxlogscore=905 bulkscore=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411050043
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_221230_001338_F53A8758 
X-CRM114-Status: GOOD (  20.53  )
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

Changes from v3:
    - Add a brief explanation in the first patch commit log describing the
      reason about why a commit is being reverted (Ming Lei)
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


