Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F2FF8FA78
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2026 14:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=z5h0boKMyjpYlZ1lN19NX7XUnwxxxpcjZAyFgisaVjc=; b=RKnBZsrF3LhgvV2rUmMrjdVJSl
	9WAQLrS2m6HebgKisUPPvYKFsYt1N/JEGtinQ4FjNimlV9tIaPJzp35FxSgS5yy+t9mxc0ODfJIxP
	TxPIkmuDvG5Lqf31fvsj4WM50Kil8dAO0snViCQHteCCvx7c9LXrJzH7UT6xtWWKFSzVNfjKdnWCO
	lXF6xwdzYOHoWKHuRBEUzeh7Srd5Y02bGf9H1QxD2fyPdZJUyopysD57CQfdQGVA7kZy/f6FEJzRk
	/Trkn4KAdwZ3piplOsV3NGQOOf1qph6EWVpYm+DiCggbGaUw0D9Gw/ulQOUw6kvGOmOWUV7OF5o01
	tLIpqvBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFCRF-00000008lgK-38wv;
	Tue, 21 Apr 2026 14:50:57 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFCRC-00000008lfL-1cee
	for linux-nvme@lists.infradead.org;
	Tue, 21 Apr 2026 14:50:55 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LCEWqi2037223;
	Tue, 21 Apr 2026 14:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=z5h0boKMyjpYlZ1lN19NX7XUnwxxxpcjZAyFgisaV
	jc=; b=IjTKyObu6sd4BOBZ7RDpJ15NLFBhKD95Xy4TPDt6v5l2lV1PBMhW2QEm8
	6ypKi/CL/Hxcnfsa93ZbXb4bC1skmXCWGomIddAl9gOFtkL7pQiSWGU7VUKU/OlJ
	OzrM3+VsXQgvZzfS0Zx0YCGcy5DfgYReoU+jT4cGcgnJiQc1kWrwniknBS++KGLK
	CfyXFLL1Q6QSRVBsMUmDmtdxIWGO3GplqWynNgigjl1BaXLp++uSAYJp/XFoC/nS
	7YH9qRboKUIJAojROG+/AE/xrVqfR4lmOoPibaq3aAGNEOhf3lzrNGxn5f+pFRwd
	pk3LyhuvzU9eG5WWhwSItceEVIoSA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2h9m2sv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 14:50:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LEoGRY010978;
	Tue, 21 Apr 2026 14:50:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmnsh126d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 14:50:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LEoieI28770574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 14:50:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0530920043;
	Tue, 21 Apr 2026 14:50:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 776742004B;
	Tue, 21 Apr 2026 14:50:41 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.39.30.130])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 14:50:41 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv3 0/9] libnvme: add support for retrieving additional NVMe stat
Date: Tue, 21 Apr 2026 20:20:21 +0530
Message-ID: <20260421145038.3458987-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iMukOqJ1HEo6YcLZPcpbiExTWeJBXlVj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE0OCBTYWx0ZWRfX3Rxo7wmbIvAN
 PyUQ3rlPyMHw3nBih3QnFuMcsE9t9uodeylSinm/fdqyQlJ7pzvMK5m6yxqi60g9N9tytb3khpw
 exLeKiQGhLzrujdnz7pJoI2jdFTbdCet0DZasZZfO1FjZtcDWS6gg9QhNAePpua4SLAw27QoGe8
 ZM+0p1yww0Nxf7rtSAB1FVUioLFeySYguqGhd98Cl3zwPXa/J804zXlGaxOGzoyb6+LMoYOmoAh
 H9x62kQgQjMmcfpHT+Y3ltIiSwOKeclFpjXZJZ1O4w9kYMwIRr51duQQMOM+CmAphCaWD7BPDUx
 ryEfNDb6EewRThMAI2eFMCEBqC/0Xw/9tX2iAjheCxt7hiytogpKA6CMqNiV1xIQhcaWJzZExhR
 PvpbkJkzBNOQuOUYlYAAy6TiK5mUqCIOGapuaDPEKWxrv7aoYzhneiVP8gxir9yf2mfd3MVsI2l
 PfiepA5STfd1nXtEYNA==
X-Authority-Analysis: v=2.4 cv=XLYAjwhE c=1 sm=1 tr=0 ts=69e78ec8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=8saYlWQVEWJM7Idh8C0A:9
X-Proofpoint-GUID: iMukOqJ1HEo6YcLZPcpbiExTWeJBXlVj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210148
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_075054_544901_0817BFC1 
X-CRM114-Status: GOOD (  13.29  )
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

Changes from v2:
  - Rebase the code against the latest nvme-cli (Daniel Wagner)
    (base-commit: 6f3cfb15a515ddc62aef94c1d8b4f3be5ad33ad0)
Link to v2: https://lore.kernel.org/all/20260404101504.44539-1-nilay@linux.ibm.com/

Changes from v1:
  - Avoid exposing internal state of libnvme to its users
    while exporting the nvme stat; add a switch while updating
    nvme stat which determines whether getters shall return the
    nvme diffstat or absolute stat (Daniel Wagner)
  - If libnvme API fails then return appropriate error code
    instead of -1 (Daniel Wagner)
Link to v1: https://lore.kernel.org/all/20260321152823.3197870-1-nilay@linux.ibm.com/

Nilay Shroff (9):
  libnvme: annotate libnvme_path::ana_state with !accessors:none
  libnvme: annotate libnvme_path::numa_nodes with !accessors:none
  libnvme: annotate libnvme_subsystem::iopolicy with !accessors:none
  libnvme: add support for retrieving per-path gendisk I/O statistics
  libnvme: add support for retrieving namespace gendisk I/O statistics
  libnvme: add support for per-path diagnostic counters
  libnvme: add support for namespace diagnostic counters
  libnvme: add support for nshead diagnostic counters
  libnvme: add support for ctrl diagnostic counters

 libnvme/src/accessors.ld     |   6 -
 libnvme/src/libnvme.ld       |  35 +++
 libnvme/src/nvme/accessors.c |  40 ---
 libnvme/src/nvme/accessors.h |  49 ---
 libnvme/src/nvme/private.h   |  54 +++-
 libnvme/src/nvme/tree.c      | 568 +++++++++++++++++++++++++++++++++++
 libnvme/src/nvme/tree.h      | 296 ++++++++++++++++++
 7 files changed, 949 insertions(+), 99 deletions(-)

-- 
2.53.0


