Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C168CFA76E
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Oct 2024 11:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=R9T7mlfTlTqE7Q295820Dm9EoDK+SntwNYf3awaxCHA=; b=CReakzlNtiWX3IbPcT11EIVGII
	GePtW8fKgaTpp27rXKSUWp3Ss38ctZW1DYT/LILoGdoEONXpQOoWBjhPTn6i0lcRSNbH/RQmaSIdB
	9SQ6uwA/YnpJ864IFE23z+rXAh6ckybqMVlt5MRRZtKY4/oC2WEewxJU1mZ8kHVW3xfahWnscEJ53
	o8hlJhCXbM88X6s9gJ4K8LudOZc1xHhIELC+UG34ocoYYbXWnctDXKsN0TXJqZKvfjgKVWN7dwi8t
	5iFFRGumq9HSuBnErYRxPEXrMjoyRLWERXmTgJNyFOXw7H6qoQcqEC2eYU5dyfOwfmdSqwBuRV0na
	uBBJzXFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swgng-0000000CB6D-4Ael;
	Fri, 04 Oct 2024 11:48:48 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swgmS-0000000CAnp-2Hls
	for linux-nvme@lists.infradead.org;
	Fri, 04 Oct 2024 11:47:34 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494Aslop019217;
	Fri, 4 Oct 2024 11:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=R9T7mlfTlTqE7Q295820Dm9EoD
	K+SntwNYf3awaxCHA=; b=jyR9nI8csV/McBDbMrWHUp5kBWBlT8M4EmwH/7Pzvx
	3tfhHMjLN2M0q5vzR1Akdi/qkyIbPN7+ZK6bEHnyAVkmvPgzV7Yl8G2dJrHxFkAJ
	hKrJooyhDZIjm1GZkRunK1XzaNIRdf+8Viz7Q/HNzM2rnNRPr17KQ6jEM26nsAHF
	5H1cR5IR1BFlOfKGBUh6mn4CExWbNQ1/8KihEFxtXbohGGftbUDRwzSMWYDtszmY
	lWvhY41XyixV/XtsF4ZNWDUgi2hitdQ37K0KBZY6wm7cP55bbiaXvY4OXmEOTAGo
	9vl0cveMO95AJnKIpCO4zmqAMXHzyo0MpWkxvq8wqZ/g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 422f1a8a15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 11:47:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 494AGxN4017902;
	Fri, 4 Oct 2024 11:47:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42207jbvtn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 11:47:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 494BlEOe41156906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Oct 2024 11:47:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6437A20043;
	Fri,  4 Oct 2024 11:47:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A26120040;
	Fri,  4 Oct 2024 11:47:12 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.143])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Oct 2024 11:47:12 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
        chaitanyak@nvidia.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 0/2] nvme: system fault while shutting down fabric controller
Date: Fri,  4 Oct 2024 17:16:55 +0530
Message-ID: <20241004114711.780809-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -c9rsU__NKTod6b7vou45rYU3gqsv1P5
X-Proofpoint-ORIG-GUID: -c9rsU__NKTod6b7vou45rYU3gqsv1P5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_08,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040084
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241004_044732_613400_E1B1725D 
X-CRM114-Status: GOOD (  24.79  )
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

We observed a kernel task hang up and a kernel crash while shutting down 
NVMe fabric controller. These issues were observed while running blktest
nvme/037. And this patch series address issues encountered while running 
this test.

We intermittently observe the blow kernel task hang while running the 
blktest nvme/037. This test setup NVMeOF passthru controller using loop 
target, connect to it and then immediately terminate/cleanup the 
connection. 

dmesg output:
-------------
run blktests nvme/037 at 2024-10-04 00:46:02
nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
nvme nvme1: D3 entry latency set to 10 seconds
nvme nvme1: creating 32 I/O queues.
nvme nvme1: new ctrl: "blktests-subsystem-1"
nvme nvme1: Failed to configure AEN (cfg 300)
nvme nvme1: resetting controller
INFO: task nvme:3082 blocked for more than 120 seconds.
      Not tainted 6.11.0+ #89
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:nvme            state:D stack:0     pid:3082  tgid:3082  ppid:2983   flags:0x00042080
Call Trace:
    0xc000000070f5bf90 (unreliable)
    __switch_to+0x148/0x230
    __schedule+0x260/0x6dc
    schedule+0x40/0x100
    blk_mq_freeze_queue_wait+0xa4/0xec
    blk_mq_destroy_queue+0x68/0xac
    nvme_remove_admin_tag_set+0x2c/0xb8 [nvme_core]
    nvme_loop_destroy_admin_queue+0x68/0x88 [nvme_loop]
    nvme_do_delete_ctrl+0x1e0/0x268 [nvme_core]
    nvme_delete_ctrl_sync+0xd4/0x104 [nvme_core]
    nvme_sysfs_delete+0x78/0x90 [nvme_core]
    dev_attr_store+0x34/0x50
    sysfs_kf_write+0x64/0x78
    kernfs_fop_write_iter+0x1b0/0x290
    vfs_write+0x3bc/0x4f8
    ksys_write+0x84/0x140
    system_call_exception+0x124/0x320
    system_call_vectored_common+0x15c/0x2ec

As we can see from the above trace that nvme task hangs up indefinitely
while shutting down loop controller. This task couldn't forward progress 
because it's waiting for unfinished/outstanding requests which haven't 
yet finished. 

The first patch in the series fixes the above hang by ensuring that while
shutting down nvme loop controller, we flush off any pending I/O to the 
completion, which might have been queued after that queue has been quiesced. 
So the first patch adds a missing unquiesce admin and IO queue operation in 
the nvme loop driver just before the respective queue is destroyed.

The second patch in the series fixes another issue with the nvme keep-alive 
operation. The keep-alive operation could potentially sneak in while 
the fabric controller is shutting down. We encounter the below intermittent 
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

The above crash occurred while shutting down fabric/loop controller.

While shutting down fabric controller, if nvme keep-alive request sneaks in 
and later flushed off then nvme_keep_alive_end_io() function is 
asynchronously invoked to handle the end of the keep-alive operation. The 
nvme_keep_alive_end_io() decrements the admin-queue-usage-ref-counter and 
assuming this is the last/only request in the admin queue then the admin 
queue-usage-ref-counter becomes zero. If that happens then blk-mq destroy 
queue operation (blk_mq_destroy_queue()) which could be potentially 
running simultaneously on another cpu (as this is the controller shutdown 
code path) would forward progress and deletes the admin queue. However at 
the same time nvme keep-alive thread running on another cpu hasn't yet 
returned/finished from it's async blk-mq request operation (i.e blk_execute_
rq_nowait()) and so it could still access admin queue resources which could 
have been already released from controller shutdown code path and that 
causes the observed symptom. 
For instance, find below the sequence of operations running simultaneously 
on two cpus and causing this issue:

cpu0:
nvme_keep_alive_work()
  ->blk_execute_rq_no_wait()
    ->blk_mq_run_hw_queue()
      ->blk_mq_sched_dispatch_requests()
        ->__blk_mq_sched_dispatch_requests()
          ->blk_mq_dispatch_rq_list()
            ->nvme_loop_queue_rq()
              ->nvme_fail_nonready_command() -- here keep-alive req fails because admin queue is shutting down
                ->nvme_complete_rq()
                  ->nvme_end_req()
                    ->blk_mq_end_request()
                      ->__blk_mq_end_request()
                        ->nvme_keep_alive_end_io() -- here we decrement admin-queue-usage-ref-counter
cpu1:
nvme_loop_delete_ctrl_host()
  ->nvme_loop_shutdown_ctrl()
    ->nvme_loop_destroy_admin_queue()
      ->nvme_remove_admin_tag_set()
        ->blk_mq_destroy_queue() -- here we wait until admin-queue-usage-ref-counter reches to zero 
        ->blk_put_queue() -- here we destroy queue once admin-queue-usage-ref-counter becomes zero
                          -- From here on we are not supposed to access admin queue
                             resources, however, nvme keep-alive thread running on 
                             cpu0 which is not yet finished and so may still access 
                             the admin qeueue pointer and causing the observed crash.

So prima facie, from the above trace it appears that the nvme keep-alive 
thread running on one cpu races with the shutdown controller operation 
which could be running on another cpu.

The second patch in the series addresses above issue by making nvme keep-
alive a synchronous operation so that we decrement admin-queue-usage-ref- 
counter only after keep-alive operation/command finish and returns status.
This would also ensure that blk_mq_destroy_queue() doesn't return until
the nvme keep-alive thread finish it's work and so it's safe to destroy the
queue.

Moreover, the Keep-alive command is lightweight and low-frequency, making 
it a synchronous approach shall be reasonable from a performance 
perspective. Since this command is not frequent compared to other NVMe 
operations (like reads/writes), it does not introduce a significant 
performance overhead when handled synchronously.

Nilay Shroff (2):
  nvme-loop: flush off pending I/O while shutting down loop controller
  nvme: make keep-alive synchronous operation

 drivers/nvme/host/core.c   | 25 ++++++++++---------------
 drivers/nvme/target/loop.c | 13 +++++++++++++
 2 files changed, 23 insertions(+), 15 deletions(-)

-- 
2.45.2


