Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF83CA5FA5
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 11:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rYjkpSRdeQjW3moct2qtoyue9tWNESNXk/7/c0jf8yE=; b=k8JR8DvGsPRqtvIv9FYewWRQ3o
	X2MjdPtJ8V/ugXGE6Z3qnK72GLGFMZbKgYrBioTbzJX4vyuwbchIOXw2Vnzt8XUcPnlSOqsbLcPkj
	3jS9qCve0iVDebnalx3If8AapSeAQngJEFhQ/y12tj5WJRmdR/WmbVQOgq21ohTCtudFcJ7u2PWRv
	wkPGXO1LxVKWxo4lImLp+SLOIvS6yRTvJvUkqlcmcBR9TbQlLfMr7LcOvMbPZiYW//+hbUI+FWYfF
	ZlnbxmQYG+DIrY420/AGkZaMw4GAjUWAxWp+6OPBb+XGumOgQ6KcwQUD4teD/2Pw0y6sVhvpqaRgo
	dfgZAiNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBW0U-00000003P8g-0Juy;
	Tue, 29 Sep 2026 11:28:22 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBW0Q-00000003P6f-2CcP
	for linux-nvme@lists.infradead.org;
	Tue, 29 Sep 2026 11:28:20 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB5aSe3836671;
	Tue, 29 Sep 2026 11:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=rYjkpSRdeQjW3moct2qtoyue9tWNESNXk/7/c0jf8
	yE=; b=hQUB1B7sBKZnHNAxQPXkG9qUZjzGDNU0h9dNHrpimHobsrW7ExIZmAxnk
	W/KXe7UssYT4gdhT2Hp0oxjB1CwsmZDtErZut+lbN0SN4x5frFWmUwYHVKtW3psj
	eCpbGE37Rbv2zEDzWSaLcLqeyScKYm63s7zIcOiokjT68ZEbQlUn+tCbaVtaq95Z
	Kg6gml4nMOpzhOFKswSm8X3J+RrYTFXtZErUN8giYH22dE09HQsy8gDs6ok5MYGE
	hlNN3RR63V2ABbeDggy3rTczQsaB4jHx7CvM0afDV//QkrcA0OznBbZ2iT5WWp2B
	h0AaWGkS2kkPz1NfuHjEwnrT2++6w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fk6b4b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:28:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAloq41647411;
	Tue, 29 Sep 2026 11:28:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxu2y984f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:28:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68TBS2LT31589032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 11:28:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA98C20043;
	Tue, 29 Sep 2026 11:28:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64AA520040;
	Tue, 29 Sep 2026 11:27:59 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.28.159])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 11:27:59 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, gjoyce@linux.ibm.com,
        chaitanyak@nvidia.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 0/2] nvmet: passthru cleanup and fixup I/O hotpath
Date: Tue, 29 Sep 2026 16:56:46 +0530
Message-ID: <20260929112751.2985483-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: k5cYKz4dGPg80zLb_0DyhMLCSEcGrg41
X-Proofpoint-GUID: k5cYKz4dGPg80zLb_0DyhMLCSEcGrg41
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfX24Ihbrll43Yc
 xy3Wfxi4ORqk2Vfzjt5VSpedGfBRN/5AuUxMbd9YqigN5abCdvwKEBmAcFD0E/EE2kSTsHHleG3
 7gKO6Hid1AuGKFapAIHwILRSkdxnm/E=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abba0c7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=cq81qsH83kapr4BpBQYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfX3FfCPX8B0oAf
 WhzzMQW/uFnS1hVO4nTXN0e9aHCZx4XrL0CIpcihcbB2/6TqkrqQLGDyZL34NcEsoxI+20glxLl
 kqBu5kG1fuaS9dXAJjmAK3ajrlnMgaRF+sxSiWrDZX9P3Nmt/BX/CIGPUN/CsCaXrHqtOEQeRHY
 tH0z3yPLTg1lXp2MT70PTVQp3Vy2+LAkQQAMGh3jx+FIGl1q7z6v+9d9KkIOfKDq8iu3heO2YIA
 s/J24/3EwOVarZ5Z1eltmiGZmPW50At6VPFPGlHnFnu+BG9aKXKbilS3UgahUvYCTnCSNb2nUGs
 Bng10bLaqzX885TwcedkaRWZ55e7MwjRXDATnTAC0kfC968XlPYPa2ZFAiJ1x9OSkHXAhPuC1rC
 9sgXm7JkfWtCpMWBfVpLxC1p+Xiaz8K8YLxbZdZNeemeirhguvdOaMpnzTZr2GiXzq3hM8YdMU7
 8HthLIVVRZelzEijRow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290044
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260929_042818_684542_EA103BA0 
X-CRM114-Status: GOOD (  14.58  )
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

This series addresses a race in the passthru I/O hotpath where
concurrently disabling the passthru controller while I/Os are in flight
can result in a use-after-free bug.

We were able to reproduce this bug with NVMe/TCP configured and by
injecting an additional delay into the target-side I/O processing code.
If the passthru controller is disabled while an I/O is still in flight,
it results in the following kernel crash:

BUG: Kernel NULL pointer dereference on read at 0x00000030
[...]
CPU: 9 UID: 0 PID: 4143 Comm: kworker/9:5H Kdump: loaded Not tainted 7.3.0-rc3+ #14 PREEMPT 
Hardware name: IBM,9080-HEX Power11 (architected) 0x820200 0xf000007 of:IBM,FW1110.00 (NH1110_031) hv:phyp pSeries
Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
[...]
NIP [c0080000156d8fe0] nvmet_passthru_execute_cmd+0x58/0x45c [nvmet]
LR [c0080000156d8fc4] nvmet_passthru_execute_cmd+0x3c/0x45c [nvmet]
Call Trace:
 nvmet_passthru_execute_cmd+0x3c/0x45c [nvmet] (unreliable)
 nvmet_tcp_done_recv_pdu+0x2d0/0x718 [nvmet_tcp]
 nvmet_tcp_try_recv_pdu+0x29c/0x348 [nvmet_tcp]
 nvmet_tcp_io_work+0xe8/0x838 [nvmet_tcp]
 process_one_work+0x224/0x5ec
 worker_thread+0x1f8/0x3e8
 kthread+0x178/0x1ac
 start_kernel_thread+0x14/0x18

There are two patches in this series. The first patch groups all
passthru-related fields into a separate struct nvmet_passthru, which
makes the code easier to maintain and reason about. The second patch
fixes the use-after-free bug described above.

As usual, code review comments and feedback are most welcome!

Thanks!

Changes from v1:
  - In patch 1/2, dynamically allocate struct nvmet_passthru when the
    passthru controller is configured, reducing memory overhead for
    subsystems that don't use passthru. (hch)

Nilay Shroff (2):
  nvmet: introduce struct nvmet_passthru
  nvmet: fix use-after-free in passthru I/O hotpath

 drivers/nvme/target/configfs.c |  90 ++++++++++++++++++++++++----
 drivers/nvme/target/core.c     |  15 ++++-
 drivers/nvme/target/nvmet.h    |  66 +++++++++++++++++++--
 drivers/nvme/target/passthru.c | 103 ++++++++++++++++++++++++++-------
 4 files changed, 232 insertions(+), 42 deletions(-)

-- 
2.53.0


