Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936C5C44508
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 11:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2K9f9UMC288rNpZomqQoWokjlEBATFSb6ee88bjWywA=; b=ni/QCCm7Fx8DUjSJMN0OARGXTG
	yeetGzonlRbisBWv4rDdzNf/ehvG0YzlK+8z5GaQ7k6M+BiGEpOAarwl3MM8Q4IuBdoxmD5AXswmW
	aB7mFBqutWymCkZ8C73uRA9TQEaK++NYviysiB24UHOAhVZGpgI5JaUoOuZYGBAsrSFpA2VJu1bec
	7Ojd8VLGoiK+1m2rsuNCcDggzfH5oqgVV8aXBsjYQejWhqN1uuvEA3I2JU5CkXRBzGBYMAHw25oH7
	/XLHuoM8VtTdf17upQFDXEa7yGy6jIYrDP+VjhN7T55GP7uAB1+ci0ELTqfUfwLSv3zQk/W56olQj
	d8oFrztA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFFv-000000094Wo-0XeA;
	Mon, 13 Jul 2026 11:55:27 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFFs-000000094TN-49Ex
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 11:55:26 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6gD2d1672711;
	Mon, 13 Jul 2026 11:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2K9f9UMC288rNpZom
	qQoWokjlEBATFSb6ee88bjWywA=; b=SckQrmmpEGt4q3XpechK/HTfBvtvGEcdv
	6Vn2ChUg7RsbKmPbP0HNkvsjaTfyHIjEaXQcoBzFdsIM8zaV4dhqkKOSx3qVB+z/
	uNmE0pOD6egk9+WiDvB+HysgT1a2KM7TUU+M6h98DAx7Xo3bMr5O+U7lTKELdvM8
	LbSZVMMt2g+6qhQzJE3NnrgKwIX7eCqYVT/vGanVUhpAGSW9AnWnBgDDWW2kmXE9
	BLnAFH6iJkjHFMePXW9Z+MUmxX7sYwOl0DMzoLnfxPMm1lT2x77uPRIW1YfEZMCq
	Sjj+xUcbZWb1yyZuEKgshiYiAEMCWQRSv8rZSUjVrkmAVBBbCNw/g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2a01w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBnlCa023653;
	Mon, 13 Jul 2026 11:55:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nh5cw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DBtCth18350540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:55:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B0DD2004B;
	Mon, 13 Jul 2026 11:55:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7817E20040;
	Mon, 13 Jul 2026 11:55:10 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 11:55:10 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v4 07/20] nvme: add context annotations for nvme_ns_head::requeue_list
Date: Mon, 13 Jul 2026 17:24:08 +0530
Message-ID: <20260713115444.465704-8-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713115444.465704-1-nilay@linux.ibm.com>
References: <20260713115444.465704-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX17K9QyqB896N
 DKdM0UZ0CiSEkJPaz7B+JN+zUmtRJwrqtaPlS/N6kFKLTKU/BZesWuKEd6n+3PEPj0/BX9B8T+H
 oswuUzy/UR5Xz/XbAy0cZMqGVpd556Y=
X-Proofpoint-GUID: FqlIQZcrEEr67HKGM1SSgmrAxGWucDPx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX3V462lhtP5Fq
 R/D3qWMX5xWEiHtJeufOS8ynux8/dANWzNNqg5DY2lA7UaHinJDaDunc33CYkQJIxNzlUoIbJBA
 MZcq42DE0jrB8GUsmCUKMWXgoB1aBagSRsOHLQWpBSwgP/4yneAvVWS0WkP/uQqFoeX0YyDXktc
 8VqKKiOzj6bZ6cMGpwCa/a/TWdsjqkwT/i4tvnTtvFi+/fJ5dsixcJ+02fJW1ZG48Eokm70rROq
 U1yzLfwUx/mpdKWFxFt7eEsxw5wMfpKLlkBUoPjHzr2tNRoZuuPEs/NizL53VUqfjU6XgQ8smia
 xc5Aff49y4rkR7kos4PTP5qcIUXFEIE0B+wY6saY3JZdcdfhXR5qwj1nAvX9bLRrOrsPueQ2Qnq
 KSXRXQOoC4waJD8xSTFUxIs/VrVejNoQ4B+S3+v7A3+7jv4WJcFPhN+zLE+/G6e55oRZpNcYjL6
 D8uFeU21E7j/5lDQrRw==
X-Proofpoint-ORIG-GUID: nsI4EP-qNr3rEPcJvhwneWO3LccdaRzV
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a54d225 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=nWZzvH9bQxjurKPVp9IA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_045525_215906_FDD9CD8C 
X-CRM114-Status: GOOD (  14.01  )
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

nvme_ns_head::requeue_list is protected by
nvme_ns_head::requeue_lock. Annotate requeue_list with
__guarded_by(&requeue_lock) so that Clang's context analysis can
validate accesses to the list.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/nvme.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b7c3ba9c0fc1..5e746ae1c805 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -561,7 +561,8 @@ struct nvme_ns_head {
 	u16			nr_plids;
 	u16			*plids;
 #ifdef CONFIG_NVME_MULTIPATH
-	struct bio_list		requeue_list;
+	struct bio_list		requeue_list
+		__guarded_by(&requeue_lock);
 	spinlock_t		requeue_lock;
 	struct work_struct	requeue_work;
 	struct work_struct	partition_scan_work;
-- 
2.53.0


