Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCB2E88D66
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2026 10:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DHzpb9z6y5MPsVXSv2QPxRfRuIPacxaK4SxJwue9sag=; b=IcB4LoxF1DZiDWPUfNN0pK+JLr
	rMUHPoLhFn8UZeGpRoCdhSYqPFU5G0dbkX8qXSB8+rIUW+Rkc+CNIn/XMEu8svFc9kdxUBTJy81JZ
	L+RRUHsYDagQQ5s2u9d0lUX8gv8MML56tm+BoDnKthhT6QONFPnbsQIKvzSqCpqGiTWCXC6fOPMjf
	o5lNb1MwymaUCwDUZCctCk98E0t6rJzOsUEEJY1tsS3PsQr6ZzOmpl00++2lXnvbB3xes8fFiu/RA
	wUHiZGuslIqGkkDBY+bPyExv7n64BKSzNJ1ViVPNe+Gr0HOQAN/aT03lXNDuUSv9nLeogCW/nDqmg
	B7th8njg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8y2D-00000003MFH-14DT;
	Sat, 04 Apr 2026 10:15:21 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8y2A-00000003MEu-0V9P
	for linux-nvme@lists.infradead.org;
	Sat, 04 Apr 2026 10:15:19 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6348x9eH3742884;
	Sat, 4 Apr 2026 10:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=DHzpb9z6y5MPsVXSv2QPxRfRuIPacxaK4SxJwue9s
	ag=; b=fm6WBDEj9o/ZzSZ3IeITAanYXVJ46F64Cfc5HJw4Y+wOpWhUl2SRX0jlG
	4j5ia8NdtlYFMo8Ih5VGQAl7pkFBsTfMAkzvD/X1xdr4KUFZyTWKU589zLV/m0KZ
	j/xnqteyP+OdGvoL7c47lFu6yjL87i+oitqejoSOZs3NDsV7TgrC3BlWicJ24hdy
	AxdIqupFVaCU7+BAAa6n3VnWGnz9E+PwWnPQvWqH+ZSTudT0Gk4ZfUAKZpQOH23R
	Ca4JXbOWHBXScHNIGdM5x/OhvXy5glwXinBSbIXWVa/jitOHejwf9dBgzFnY7KeO
	VJH6loALIxSiAtC+0uhkdnFqnhntA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4datap0qfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 10:15:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63430qAp008751;
	Sat, 4 Apr 2026 10:15:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v120vrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Apr 2026 10:15:14 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 634AFAop62456318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 4 Apr 2026 10:15:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C3912004F;
	Sat,  4 Apr 2026 10:15:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 794B32004E;
	Sat,  4 Apr 2026 10:15:06 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.124.211.35])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  4 Apr 2026 10:15:06 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
Subject: [PATCHv2 0/9] libnvme: add support for retrieving additional NVMe stat
Date: Sat,  4 Apr 2026 15:44:50 +0530
Message-ID: <20260404101504.44539-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Bp+QAIX5 c=1 sm=1 tr=0 ts=69d0e4b3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=xxtA3AYBEPDFT9ljYxMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDA4OCBTYWx0ZWRfX3Q84uyrBNglY
 KW9DuWSnL1nOWqxnPR17B5GxWaOYDdhfKxuwcDCSSB0TEzA/M4g7oJHRwuBIrx7ArJvgf9EHq5B
 5EGooCeTZHisAJRyUpLM7TQXxjnOQb/wAItbNCGtJT4ZAcKdEQdqxQ0aR3plRQ/pJmXE5K6G62A
 nhk0muheVEC80XDWXiVYIwWd469F7fmZxMRkvi9qqvXij/x9mFo4WXvxyiaFLwECF/20bZyQYGi
 3SzVlkQEdE3IjEUzc+YuCchQeehgi1O2Dgn2F4izYlxTg0UHbtTADX/mq7XT/uN23PRTVwwkdyl
 TxU9WMUdar32uBET5eJ7Wn4UxKsQR5Vbf+qwO6PZB/wmkyhQQkYzOAnJVulyUKh66l+wha62+Z0
 CFBs//5tlpjU/ORweyun188ihuIP842vdRfYLysSqX2qAjUv3x0lU8E2mWqXdMh1J0fnozo8PfK
 BOf7BtmGDjtG4eEnnWw==
X-Proofpoint-GUID: HPngHhHPzkj45sQKhG-HwOTD3l9OBq5D
X-Proofpoint-ORIG-GUID: HPngHhHPzkj45sQKhG-HwOTD3l9OBq5D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260404_031518_170653_92C8BC08 
X-CRM114-Status: GOOD (  12.03  )
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

Certain NVMe attributes and statistics can change dynamically at runtime.
However, the current libnvme implementation caches attribute values while
scanning and building the topology. Subsequent libnvme API calls return
these cached values.

While this approach works well for one-shot nvme-cli commands, it is not
suitable for use cases that require upto date information. In particular,
real-time monitoring tools such as nvme-top require access to the latest
(non-cached) values of such attributes.

To address this, this patchset introduces support for retrieving
non-cached values for selected attributes whose values may change
dynamically. The first three patches disable auto-generated accessors
for ana_state, numa_nodes, and iopolicy using "!accessors:none", and
provide custom implementations that always return the latest values.

In addition, libnvme lacks support for retrieving gendisk statistics, which
provide useful insight into disk activity (e.g., number of I/Os processed,
time spent servicing I/O, and in-flight I/O counts). This patchset adds
support for retrieving gendisk I/O statistics for both per-path and namespace
gendisks.

Finally, this series adds support for retrieving diagnostic counters at 
different levels, including per-path, namespace, nshead, and controller.
These counters should improve visibility into NVMe native multipath behavior.

All of the above statistics and counters can be leveraged by tools such as
nvme-top to provide real-time monitoring and analysis.

As usual, feedback and suggestions are welcome!

Changes from v1:
  - Avoid exposing internal state of libnvme to its users
    while exporting the nvme stat; add a switch while updating
    nvme stat which determines whether getters shall return the
    nvme diffstat or absolute stat (Daniel Wagner)
  - If libnvme API fails then return appropriate error code
    instead of -1 (Daniel Wagner)
Link to v1: https://lore.kernel.org/all/20260321152823.3197870-1-nilay@linux.ibm.com/

Nilay Shroff (9):
  libnvme: annotate nvme_path::ana_state with !accessors:none
  libnvme: annotate nvme_path::numa_nodes with !accessors:none
  libnvme: annotate nvme_subsystem::iopolicy with !accessors:none
  libnvme: add support for retrieving per-path gendisk I/O statistics
  libnvme: add support for retrieving namespace gendisk I/O statistics
  libnvme: add support for per-path diagnostic counters
  libnvme: add support for namespace diagnostic counters
  libnvme: add support for nshead diagnostic counters
  libnvme: add support for ctrl diagnostic counters

 libnvme/src/accessors.ld     |   6 -
 libnvme/src/libnvme.ld       |  36 +++
 libnvme/src/nvme/accessors.c |  39 ---
 libnvme/src/nvme/accessors.h |  47 ---
 libnvme/src/nvme/private.h   |  51 +++-
 libnvme/src/nvme/tree.c      | 563 +++++++++++++++++++++++++++++++++++
 libnvme/src/nvme/tree.h      | 297 ++++++++++++++++++
 7 files changed, 944 insertions(+), 95 deletions(-)

-- 
2.53.0


