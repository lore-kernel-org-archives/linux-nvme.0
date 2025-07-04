Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED37C83F03
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Jul 2025 14:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=n/yGSlW5VXXn8E4dEMWJN14ZbPI1O9fys3I7qEylQ6c=; b=H0xP4RILwnhI2bPKCpMBJDnnfv
	PSdD2NGlrMl75b/YHdhUNRtoy5IhCqLFiugLsgRlzGANAPek92GyZ2HDJyrNkDT0Z++5NZz//TiDi
	gcS4s8PcPRZ9m7xZ9DIqxlcloZQa0Tjd09jDXmI31iY0Eyet0XLLZSJQhW8g6z2B1YacwYkb2SENv
	Lbj/ozF5Vu3UyUIJh5XZC/smy/fzjHrzBxCQs3Dur1HWYznxSkl65Gotn0dfJIfB9gnmBWwHkkZI0
	Nl0Vbi62w3g1JgezlgYN92CHKW2Igbcda6saEhOrtgy1MzGiqGADr6hZRwKnpmCgzvstTbMpUXHeC
	jzRFgP4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXh8V-0000000EczD-1Unw;
	Fri, 04 Jul 2025 14:11:31 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXgo9-0000000EZnZ-0bYe
	for linux-nvme@lists.infradead.org;
	Fri, 04 Jul 2025 13:50:30 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564ApXrl030201;
	Fri, 4 Jul 2025 13:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=n/yGSlW5VXXn8E4dEMWJN14ZbPI1O9fys3I7qEylQ
	6c=; b=KaZ+h/oHDdwf4YkwRE1UeQlg6X3tuI+FFfMDyZIRG0YG5PDUcG2Fq7FyX
	W/RNqRSDp8iI4C+MmsgRUIXix31y6xaWYeujdnYqmxjEqQ77i4SeafiF0UX8NXkE
	qTnrFcDhlcNlpJx4/g2dn+D2tI52qzYtfsmz6J4BhvXmMu2QrtfdqDoDxKP6MKys
	uv2Vj9MvSlQYIfpTrE845LjMb2v9e4uM+2AxXIVl+CMAJCL4kbg4jvphcSiloNjZ
	/FuKFMHDNxb0B1ZsOT9LH8O3DBBDMzlILYLhpMH4J24sHDeH2a7GBVMWs4aXBq6P
	cZ7t/KnJkSPGmOy4PULymvNqDAJOw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j6u29hdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Jul 2025 13:50:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 564BfhLA006928;
	Fri, 4 Jul 2025 13:50:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jvxmsyek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Jul 2025 13:50:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 564DoMWT45941150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Jul 2025 13:50:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9532020040;
	Fri,  4 Jul 2025 13:50:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B482720043;
	Fri,  4 Jul 2025 13:50:19 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.81.118])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Jul 2025 13:50:19 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.de, kbusch@kernel.org, gjoyce@ibm.com
Subject: [PATCH 0/2] nvme-cli: enhance the visibility of multipath using show-topology command
Date: Fri,  4 Jul 2025 19:19:52 +0530
Message-ID: <20250704135001.292763-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -yhUOixn3qA4fZbq0u8_oe_VbJ1UFpV4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwMSBTYWx0ZWRfX5bDDMb+cHRvZ s93XINzmWLcm2yrTDr5TMqnAfUbfzX+mekygBslrsSpAwXkhezQ96ULRrreww3i2cYQMQXwyV2t 2yt6ouSoEz2duMIgjDND5hwAjJAwCmncvvx2AKkHT9ZoDoWyV/cf3GKkfSB5iGctZfWbnqdFxTQ
 xj8vX3cO64/QGt6n/YbBssKpP8U0PUouv0XDFIm7i0m3Tvsuou3BvNQ+U3CvCEPAWefmNeRPuAE QCodraSO4+jJBBgbWRi+220p7jtjV5VTLnYURNxU0rtxxBop2akVK43+UoKdGmaC368bTOUBPig 4yGKqMj/syoK0Zpq7rj7mXAcDy1yqJLWVFjd3T9JtwNnH7MhUQ4tT5esqXeokTu7M4xZAJKWf8z
 bmzqZ+hyHXerIjQiQXt9zlgbhRRIKCutN5riTR3h48mswRWSZ2KMr8i/0W251nxEAxmKqpUG
X-Proofpoint-GUID: -yhUOixn3qA4fZbq0u8_oe_VbJ1UFpV4
X-Authority-Analysis: v=2.4 cv=GrRC+l1C c=1 sm=1 tr=0 ts=6867dc21 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=ChOlAOosrpkLgm1Qm-4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507040101
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250704_065029_643813_410E65C9 
X-CRM114-Status: GOOD (  15.90  )
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

There has been recent work to improve the visibility of NVMe multipath 
configurations. The native NVMe multipath kernel driver supports three
I/O path selection policies: numa, round-robin, and queue-depth. However,
until now, users have had no insight into which path is selected by the
multipath logic for forwarding I/O.

To address this, an RFC was proposed [1] and has since been merged into
the Linux kernel as of v6.15. Following that, libnvme was extended to
discover multiple paths to a shared NVMe namespace [2]. This patchset
builds on those efforts to improve userspace observability of multipath
configurations via nvme-cli.

This patchset contains two patches:
The first patch in the series fixes a <device> filter option using which
we could be able to filter the output of nvme show-topology command.

The second patch in the series enhances the nvme show-topology command to
display multipath configuration, including all discovered paths to a 
namespace, along with details such as ANA state, NUMA nodes, and queue
depth. The show-topology "--ranking" option is extended with a new sub-
option: multipath.

As usual, any feedback is most welcome!

Thanks!

[1] https://lore.kernel.org/all/20250112124154.60690-1-nilay@linux.ibm.com/#t
[2] https://lore.kernel.org/all/20250425185617.1242994-1-nilay@linux.ibm.com/

Nilay Shroff (2):
  nvme: support <device> option in show-topology command
  nvme: extend show-topology command to add support for multipath

 nvme-print-binary.c |  1 +
 nvme-print-json.c   | 25 ++++++++++++++-----
 nvme-print-stdout.c | 61 ++++++++++++++++++++++++++++++++++++++++++---
 nvme-print.c        |  4 ++-
 nvme-print.h        |  1 +
 nvme.c              | 21 ++++++++++++++--
 nvme.h              |  1 +
 7 files changed, 101 insertions(+), 13 deletions(-)

-- 
2.50.0


