Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F34C369C9
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Apr 2025 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LqfUuO9r71//cuPt7ZT753ol9bLl5yx2RLMYt6uBqX8=; b=Yu6mSYjfceUzeV7x3VpooGDVZ2
	CPztc1Z8RlU9dzKQOR/1dkSBxYerMh/pCBU7lJzNk4VepFSWHUV/NozNwgXpyvAoyyMamjwfRxvZK
	sltXUPBy9HUeKB2EtDGg3m2yI4eSaIl4/tNiTG1bGj2gecOcQK+N3PVxhAnrC4AVuSWTA+bwwE565
	oCZCk9Azcwt6bLa1atIWpUr/zhsmYcI95dRNbsqYl9w7awPrjLetO4J4uABHVuutqWbKXPj95D7Gp
	7Tva694NAQQPlCUSEpVe0eQ+9xCTwXXFgO34s4AQKpErl8Wq7G+0m+heqYtN62TZfJIXyrzbWXVZx
	E9gDJtZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5Po1-0000000DEnB-05tJ;
	Thu, 17 Apr 2025 14:01:29 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5Pmb-0000000DEaj-0PV1
	for linux-nvme@lists.infradead.org;
	Thu, 17 Apr 2025 14:00:02 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H81oPE017994;
	Thu, 17 Apr 2025 13:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=LqfUuO9r71//cuPt7ZT753ol9bLl5yx2RLMYt6uBq
	X8=; b=MvIS8wq8ncBERB8BSUhZBM6b4OZtS/t6HV8yw0w/Yiw4pqt+weYIytQSQ
	BRfFs9Bnq4xHfbvDpu3Lyy6W7a7TdUo8dg5QNWbwD6PknQvKzzJBCPb+teZmdmOo
	Kcv6NGAuIHUO1qGpIla+eQDIqciOBTsTtI/2B/91ed84x9Mu9c/cm/nv0hz/hM8f
	vXiymli1RLPzaPGfIGSeRvaPcjtd0pR2TkDOBOn0PQvAkyhjgT0iLTUqvKn+uzJl
	U4MXm5Q/YeHMRJ+UrR0g2jy9hSiAM7s+qPu5hkrv7HM7nNqc8LdEL+tJ1kRx5soT
	XLH1MeJSM/0MSmjBLJIuAFb+y/9NA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462mhu409d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 13:59:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53HAM1r9017174;
	Thu, 17 Apr 2025 13:59:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46040m5u1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 13:59:55 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53HDxrHW49349112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 13:59:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC0F420043;
	Thu, 17 Apr 2025 13:59:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A30B520040;
	Thu, 17 Apr 2025 13:59:52 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.111.1.254])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Apr 2025 13:59:52 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@kernel.org, kbusch@kernel.org, gjoyce@ibm.com
Subject: [PATCHv2 0/4] libnvme: add support for discovering multipath of a shared ns
Date: Thu, 17 Apr 2025 19:29:42 +0530
Message-ID: <20250417135951.239447-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Hvd2G1TS c=1 sm=1 tr=0 ts=6801095d cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=SPq7MFt2JQEO-bUaDlEA:9
X-Proofpoint-ORIG-GUID: o0cVfZx6zEFD7hVvf4fq0q-8Gk1ZLoBU
X-Proofpoint-GUID: o0cVfZx6zEFD7hVvf4fq0q-8Gk1ZLoBU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_04,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=861 suspectscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170101
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250417_070001_142782_C86ACEBF 
X-CRM114-Status: GOOD (  15.00  )
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

Recently released Linux kernel v6.15-rc1 added support for easily discovering
multiple paths to a shared NVMe namespace. This multipath information is
exposed to userspace via a new sysfs group attribute named "multipath",
located under /sys/block/<ns-blkdev>/. More details on this functionality
can be found here [1].

This patch series leverages that new functionality to discover multiple paths
to a shared namespace and exposes that information in libnvme so that it can
later be used by nvme-cli.

There are four patches in this series:
The first patch adds support for discovering NVMe paths using the sysfs 
"multipath" group attribute.
The second patch adds a new "queue_depth" attribute under the NVMe path 
object.
The third patch adds a new "numa_nodes" attribute under the NVMe path object.
The fourth patch extends the sysfs tree dump test to validate multipath link 
support 

[1]: https://lore.kernel.org/all/20250112124154.60690-1-nilay@linux.ibm.com/

Changes from v1:
    - Fixed kernel version typo in the cover letter and commit
    - Updated the commit in first patch to explain the change in some
      detail (Daniel Wagner)
    - Added fourth patch to validate changes (Daniel Wagner)  

Nilay Shroff (4):
  tree: add support for discovering nvme paths using sysfs multipath
    link
  tree: add queue-depth attribute for nvme path object
  tree: add attribute numa_nodes for NVMe path object
  test: extend sysfs tree dump test

 src/libnvme.map                  |   2 +
 src/nvme/filters.c               |   6 +
 src/nvme/filters.h               |   9 ++
 src/nvme/json.c                  |  90 +++++++++++++--
 src/nvme/private.h               |  11 +-
 src/nvme/tree.c                  | 184 ++++++++++++++++++++++---------
 src/nvme/tree.h                  |  25 +++++
 test/sysfs/data/tree-pcie.out    |  53 +++++++--
 test/sysfs/data/tree-pcie.tar.xz | Bin 19712 -> 12656 bytes
 9 files changed, 308 insertions(+), 72 deletions(-)

-- 
2.49.0


