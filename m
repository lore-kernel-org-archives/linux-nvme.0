Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9F4105F79C
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2026 11:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ImksWEP9okvvtn7WuL/dVqf+DGj2jd7BbcyAA9swmUc=; b=3H1v088r4M5a4qrBH86REI9R9O
	qXA7G++s5/6SQCPhFsyjHG/ge441wvhQG4W9PtftjNOkCKB97Q0CbxELJy79UbZx4WEMmZxEDta6K
	T3Kcjp0Q3FPGJtuUyr/cqbQq2jedOH834IQpCmFE+DyWpMKBH0RVoTY3LhlA0EhIWEyrFiyzQVm0p
	KuWSSayOylkUURkEu9SQ83dlfYHqpVxnu58xOu7H7mKSa53WTYo5ngMya/fCkflL7cwVqqHMLPsEh
	U2gXP7Wz926xev8dxIReRYbBgG6uWwYzSl/8J8++tmzm5Llek0xbTFwytO6FPqKUg6Kg4sgYdmAdK
	hv9oxTCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w10rR-000000002tz-2gTW;
	Fri, 13 Mar 2026 11:39:21 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w10rP-000000002tA-3baW
	for linux-nvme@lists.infradead.org;
	Fri, 13 Mar 2026 11:39:21 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D3PtKb1594003;
	Fri, 13 Mar 2026 11:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ImksWEP9okvvtn7Wu
	L/dVqf+DGj2jd7BbcyAA9swmUc=; b=UotHSSCfrOjX/AkQchQ8rl0KvKTh9wo2D
	m09BW1mWrBDQ72cQlYS+Ve3ag7+f760weNmDO+fgal1A5KcjzWPklyeyIkT9XRnA
	p6Ylag75gJ+QVd5I9UrK0TpMqULScNvxp/oJuK8GZsImPBanf2UK2qlxtO+YFl6D
	Kdnxy59oM70flFU1CCtpftM5Un6an9cBXNNp3xc0V6LxmlT36+W9KAgWfzj0ixWr
	5dzrbD/dnM02KgVfp7hrt/gX9eq6mWIT+EG97YkzsGGlCWzMLONLr5VK14j7VYUT
	6jCLV+sd/MyzdtAyI7qOglMzhVsLOMkB5xyzDvG/jIUSTfYBTepkA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh91qhv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 11:39:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DAR5mX020811;
	Fri, 13 Mar 2026 11:39:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha9pf3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 11:39:04 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DBd24r47448520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 11:39:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A8AC2004D;
	Fri, 13 Mar 2026 11:39:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16AEE2004B;
	Fri, 13 Mar 2026 11:39:00 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.39.23.157])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Mar 2026 11:38:59 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, kch@nvidia.com,
        gjoyce@ibm.com
Subject: [PATCH 1/1] nvme-loop: do not cancel I/O and admin tagset during ctrl reset/shutdown
Date: Fri, 13 Mar 2026 17:08:48 +0530
Message-ID: <20260313113856.1366774-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313113856.1366774-1-nilay@linux.ibm.com>
References: <20260313113856.1366774-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2wJXPj4MOhOuXlRnb-06qHyzjDMlfz4p
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69b3f759 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=TzVzBPhBHkBg1zJey1QA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA4NiBTYWx0ZWRfX6bokAE3FbrwF
 kbon5XAgWUDU28y7KKELjSgMS7k7RN6c/tcRFL7rLk+eG0wWv28wyuLpM2uJl8zbGex23gNClqQ
 /KEtrNYVouK2VICilaUSX2Ir5rFPSYizzLdK/QyUDJG1CLw6h/V1/YMBOu5YILoha6KRc7afD+A
 28KK/5uRvik8BIksudXg9YY/GWgfjLKZ2hFGmgU9HvbzVRWmro5RnJbIOksYNRuKW03A7HHrKjK
 5rFdDgEoUvMCbwVgaYRLCeMIfEXqtpmpoE0G9f1Drh45ZDOZ8xChzQ4uZZ5Tx18jt61Yo7639tO
 FzEEJGsWqjmWtCs1y+DdOR73pBs83SmJ/7M9t/yM4P1nRIkSXWgawR20ltPE8sHLsj5GsK4ycXP
 6qoBKHpdUsnrSh+K3JSdptmq/NlKbAVdDQ718BrEeMnfbeJA+kGsQa6Q8gcfbeKot+zF3J9V0lp
 r14Pr/1my7R46h8vh3g==
X-Proofpoint-ORIG-GUID: 2wJXPj4MOhOuXlRnb-06qHyzjDMlfz4p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130086
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260313_043920_072580_FDBF75C2 
X-CRM114-Status: GOOD (  17.12  )
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

Cancelling the I/O and admin tagsets during nvme-loop controller reset
or shutdown is unnecessary. The subsequent destruction of the I/O and
admin queues already waits for all in-flight target operations to
complete.

Cancelling the tagsets first also opens a race window. After a request
tag has been cancelled, a late completion from the target may still
arrive before the queues are destroyed. In that case the completion path
may access a request whose tag has already been cancelled or freed,
which can lead to a kernel crash. Please see below the kernel crash
encountered while running blktests nvme/040:

run blktests nvme/040 at 2026-03-08 06:34:27
loop0: detected capacity change from 0 to 2097152
nvmet: adding nsid 1 to subsystem blktests-subsystem-1
nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
nvme nvme6: creating 96 I/O queues.
nvme nvme6: new ctrl: "blktests-subsystem-1"
nvme_log_error: 1 callbacks suppressed
block nvme6n1: no usable path - requeuing I/O
nvme6c6n1: Read(0x2) @ LBA 2096384, 128 blocks, Host Aborted Command (sct 0x3 / sc 0x71)
blk_print_req_error: 1 callbacks suppressed
I/O error, dev nvme6c6n1, sector 2096384 op 0x0:(READ) flags 0x2880700 phys_seg 1 prio class 2
block nvme6n1: no usable path - requeuing I/O
Kernel attempted to read user page (236) - exploit attempt? (uid: 0)
BUG: Kernel NULL pointer dereference on read at 0x00000236
Faulting instruction address: 0xc000000000961274
Oops: Kernel access of bad area, sig: 11 [#1]
LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=2048 NUMA pSeries
Modules linked in: nvme_loop nvme_fabrics loop nvmet null_blk rpadlpar_io rpaphp xsk_diag bonding rfkill nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink pseries_rng dax_pmem vmx_crypto drm drm_panel_orientation_quirks xfs mlx5_core nvme bnx2x sd_mod nd_pmem nd_btt nvme_core sg papr_scm tls libnvdimm ibmvscsi ibmveth scsi_transport_srp nvme_keyring nvme_auth mdio hkdf pseries_wdt dm_mirror dm_region_hash dm_log dm_mod fuse [last unloaded: loop]
CPU: 25 UID: 0 PID: 0 Comm: swapper/25 Kdump: loaded Not tainted 7.0.0-rc3+ #14 PREEMPT
Hardware name: IBM,9043-MRX Power11 (architected) 0x820200 0xf000007 of:IBM,FW1120.00 (RF1120_128) hv:phyp pSeries
NIP:  c000000000961274 LR: c008000009af1808 CTR: c00000000096124c
REGS: c0000007ffc0f910 TRAP: 0300   Not tainted  (7.0.0-rc3+)
MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 22222222  XER: 00000000
CFAR: c008000009af232c DAR: 0000000000000236 DSISR: 40000000 IRQMASK: 0
GPR00: c008000009af17fc c0000007ffc0fbb0 c000000001c78100 c0000000be05cc00
GPR04: 0000000000000001 0000000000000000 0000000000000007 0000000000000000
GPR08: 0000000000000000 0000000000000000 0000000000000002 c008000009af2318
GPR12: c00000000096124c c0000007ffdab880 0000000000000000 0000000000000000
GPR16: 0000000000000010 0000000000000000 0000000000000004 0000000000000000
GPR20: 0000000000000001 c000000002ca2b00 0000000100043bb2 000000000000000a
GPR24: 000000000000000a 0000000000000000 0000000000000000 0000000000000000
GPR28: c000000084021d40 c000000084021d50 c0000000be05cd60 c0000000be05cc00
NIP [c000000000961274] blk_mq_complete_request_remote+0x28/0x2d4
LR [c008000009af1808] nvme_loop_queue_response+0x110/0x290 [nvme_loop]
Call Trace:
 0xc00000000502c640 (unreliable)
 nvme_loop_queue_response+0x104/0x290 [nvme_loop]
 __nvmet_req_complete+0x80/0x498 [nvmet]
 nvmet_req_complete+0x24/0xf8 [nvmet]
 nvmet_bio_done+0x58/0xcc [nvmet]
 bio_endio+0x250/0x390
 blk_update_request+0x2e8/0x68c
 blk_mq_end_request+0x30/0x5c
 lo_complete_rq+0x94/0x110 [loop]
 blk_complete_reqs+0x78/0x98
 handle_softirqs+0x148/0x454
 do_softirq_own_stack+0x3c/0x50
 __irq_exit_rcu+0x18c/0x1b4
 irq_exit+0x1c/0x34
 do_IRQ+0x114/0x278
 hardware_interrupt_common_virt+0x28c/0x290

Since the queue teardown path already guarantees that all target-side
operations have completed, cancelling the tagsets is redundant and
unsafe. So avoid cancelling the I/O and admin tagsets during controller
reset and shutdown.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/loop.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 4b3f4f11928d..d98d0cdc5d6f 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -419,7 +419,6 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 {
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_quiesce_io_queues(&ctrl->ctrl);
-		nvme_cancel_tagset(&ctrl->ctrl);
 		nvme_loop_destroy_io_queues(ctrl);
 	}
 
@@ -427,7 +426,6 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 	if (nvme_ctrl_state(&ctrl->ctrl) == NVME_CTRL_LIVE)
 		nvme_disable_ctrl(&ctrl->ctrl, true);
 
-	nvme_cancel_admin_tagset(&ctrl->ctrl);
 	nvme_loop_destroy_admin_queue(ctrl);
 }
 
-- 
2.53.0


