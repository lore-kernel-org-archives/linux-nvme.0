Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98A1105F79D
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2026 11:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wtJFkdYEix9KF1+5ubpED53HOggrxF9CISQfLJzRxE4=; b=h17Ir8grV0BJaAJbqa8goCQFla
	trCcdayqByCwJDwNf9Hy2T8onGRT7k75ANKWks7WaP1mLisuYea0XqU6+DA/rqENK0fRdXUKWglOu
	8erYxNavxuOzdXY3VBdFoz+T/02jlIDUFRgNRKdbROsNqanXnWghqHccCTGTEav9HhjVr0WO1z/Tt
	SOR4SZpx6UdGWp8vFOhhA5Y+zX6PYfI+tFhiCKoQ1S8D33rv8tznabX804HNs9Xte6wg6H6+yfMCo
	1dcuWMRWIDWSAjv6qiqWYk3BLYkCANIm+7pnR53tPHdBJ1ytT9m3hJs9iJNAYnu7haO5yg6hNV3Cu
	scLL7Bww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w10rT-000000002uo-42MW;
	Fri, 13 Mar 2026 11:39:23 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w10rQ-000000002tX-34Cb
	for linux-nvme@lists.infradead.org;
	Fri, 13 Mar 2026 11:39:21 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5evSU2256949;
	Fri, 13 Mar 2026 11:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=wtJFkdYEix9KF1+5ubpED53HOggrxF9CISQfLJzRx
	E4=; b=TVyNs8detsPZvKThbY4n/tqbLMSs7mmcr9j2PPKIWkDsJWK0lGMcvT8aR
	80I6lA8JTKfPIzOArGm8xuWav9uxWx8XJB3GYDw1yS8OqtTBdVTqz2O0FK+m4CyO
	XFLrmtY0ZjEvhx1fCymRQ7JsN0X5PVtPRYe8s+piP95m81eMfieQHiiHWsIWxbUV
	DWOYk75VMPpf/JoHIlPC6QHWW+Dz0Pphg8WKRaSvp4dHyLsee9Uph4l4LhaKzELg
	68WeTCoJ+W1irHsoK1SWye4T1FhI35v4gUfD7pjV0S3R+e4ZeMg9xRrpni2FZjUJ
	hUNVFDGfraS6mNND/FtALjuHEuaTw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh92fhyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 11:39:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DANWr1018897;
	Fri, 13 Mar 2026 11:39:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha86fn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 11:39:01 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DBcxpd30474862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 11:38:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 986002005A;
	Fri, 13 Mar 2026 11:38:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A09322004B;
	Fri, 13 Mar 2026 11:38:57 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.39.23.157])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Mar 2026 11:38:57 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, kch@nvidia.com,
        gjoyce@ibm.com
Subject: [PATCH 0/1] nvme-loop: avoid cancelling/aborting I/O and admin tagset
Date: Fri, 13 Mar 2026 17:08:47 +0530
Message-ID: <20260313113856.1366774-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xSU_3PoClZpRrWMInT63sE45ZKOhgQ-l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA4NiBTYWx0ZWRfX3uy4EfmCOD+h
 8pXRaylmXFvGsGt8gZN4Gka1lZDwZ2aD3eQQ6dGoqzbgrjgLx/KOaFkZhGxX/XqFYDP3twAEFE+
 qnbwhYUO5eslTfUsO8EBF9S3BdOp8slOwwAb5F0ztp6mev2v6KJpBQbgZaLB48X4lZpMsV/T/C7
 0oeWLFluJ8b5ECd4qls45O7wQVPf/MtufodVFwJQvzhocE7sshMhCEkPhMBNF+M+BK3rmLnHG+4
 QPV/2ZErJ/sv9DhftrnbdJCJjxHopL9/0CS9lADUVIQRiFE53+Yi+mbzAQh1LXxqHrsdhaWAuES
 y/BFbMcJ+9AFsFcaaG5HK+05G2tRZonY8Sw9Kd0ptjBYTFMyT4gcqVd+XoRqM0yYtlF63ZrCbZf
 3lHxAJ/KwVUjk8ToPurnR7Ka7jx0HQRuR460JBh9k8N/qYaeCFF8X3tVaEEr8NSCoArsvnPQkbS
 fwJSLXIPWAUdSK6goOw==
X-Proofpoint-GUID: xSU_3PoClZpRrWMInT63sE45ZKOhgQ-l
X-Authority-Analysis: v=2.4 cv=XNk9iAhE c=1 sm=1 tr=0 ts=69b3f756 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=LC9GS_3xLbqZSRdYUWMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130086
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260313_043920_772292_21FFD01C 
X-CRM114-Status: GOOD (  16.17  )
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

During nvme-loop controller reset or shutdown, the current code first
cancels/aborts the I/O and admin tagsets and then proceeds to destroy
the corresponding I/O and admin queues.

For the loop controller this cancellation is unnecessary. The queue
destruction path already waits for all in-flight target I/O and admin
operations to complete, which ensures that no outstanding operations
remain before the queues are torn down.

Cancelling the tagsets first also introduces a small race window where
a late completion from the target may arrive after the corresponding
request tag has been cancelled but before the queues are destroyed.
If this occurs, the completion path may attempt to access a request
whose tag has already been cancelled or freed, which can lead to a
kernel crash. So the patch in this patchset, avoids cancelling/aborting
the I/O and admin tagsets for nvme-loop target, as this step is redundant
and can expose the race described above.

This issue was observed while running blktests nvme/040. The kernel crash
encountered is shown below:

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
Kernel attempted to read user page (286) - exploit attempt? (uid: 0)
BUG: Kernel NULL pointer dereference on read at 0x00000286
Faulting instruction address: 0xc00000000090ca18
Oops: Kernel access of bad area, sig: 11 [#1]
[...]
[...]
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

The above kernel oops occured in blk_mq_complete_request_remote():
1319 bool blk_mq_complete_request_remote(struct request *rq)
1320 {
1321         WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
1322 
1323         /*
1324          * For request which hctx has only one ctx mapping,
1325          * or a polled request, always complete locally,
1326          * it's pointless to redirect the completion.
1327          */
1328         if ((rq->mq_hctx->nr_ctx == 1 &&
1329              rq->mq_ctx->cpu == raw_smp_processor_id()) ||
1330              rq->cmd_flags & REQ_POLLED)
1331                 return false;

In the above code on line #1328, when kernel attempts to dereference
rq->mq_hctx->nr_ctx it triggers carsh because rq->mq_hctx is NULL. 
This request has been already aborted/cancelled while loop controller
reset is initiated.

Nilay Shroff (1):
  nvme-loop: do not cancel I/O and admin tagset during ctrl
    reset/shutdown

 drivers/nvme/target/loop.c | 2 --
 1 file changed, 2 deletions(-)

-- 
2.53.0


