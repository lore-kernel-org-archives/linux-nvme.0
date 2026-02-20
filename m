Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C1FC5AD44
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 17:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bVePjqMO2KgQcSYgQi1fOs0rVs9ZVj13N+iuH413LpM=; b=eWgCV391b3JC2KL5mOnwNLovvl
	OPtArUMYUVJ0oCGhlUewPsz6MIyA+VwkM0BvqcVYIUBqsHfhi0XGO9q1J4dMKP+V7NkoV08+8Gllq
	I+fOCnwlfXM/KDSyhgywrfOt9PFWmpOO6F3lwBy8tVWktH2GbYXD+uf+ApRa3wSgf08k/8MKO3qlY
	KFftzjxBd7OravEcQfFXSxahHbYwJgQ/Yd8YvaWRuNU22HTodD1gGgUnnB2mqgmMKheNJVCTscI5g
	Cj7LfmpaSBMNUU1Udk3R9cuTfNI6H+W0kosJ/uDHrrRs+OrnzQ4mM8ZsE2ZBrJfUaZrHZ2zlCUQHM
	uxTfQZVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtUeW-0000000FOwc-2cvm;
	Fri, 20 Feb 2026 17:50:56 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtUeT-0000000FOvt-3e61
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 17:50:55 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KGKmEk1273496;
	Fri, 20 Feb 2026 17:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=bVePjqMO2KgQcSYgQi1fOs0rVs9ZVj13N+iuH413L
	pM=; b=V7qXIUpB+Kna7aYUl7YG6u0CYQC6ipP1wr0/LN3M2ImsD+HcV9UGqWw8N
	iU+MOnIFbwFa+GDfxAn6/7CztyPZQxMir+ndpVMnURimOBDoSRG6LQOO6INkbYsr
	Nidf2hzRH8RoJTtZD2dK1VmKUfKvuJcPizzD0R7azvB05NyyFvFUwHENaVoxy/i/
	Mpu7Q0AcnROUvx23f0FuKLPkr1xg/qLy8ZyNhxAU/DwElOKxCCSyWSDDShIy3faV
	xepj7f9Xd0b4z9RVVsOwiasXjedehFDBSxl3Za4Nhb0PxMxweFg7rwjgXpmIxMS6
	3Yz5LVpb/x0jt4dwMrPt3gdjIYcnQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6v4bpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 17:50:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61KErKwH001432;
	Fri, 20 Feb 2026 17:50:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb2bsc4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 17:50:44 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61KHoeAw22086106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 17:50:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37D4F20043;
	Fri, 20 Feb 2026 17:50:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 576F820040;
	Fri, 20 Feb 2026 17:50:35 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.111.6.227])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Feb 2026 17:50:27 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv3 0/7] nvme: export additional diagnostic counters via sysfs
Date: Fri, 20 Feb 2026 23:18:45 +0530
Message-ID: <20260220175024.292898-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E+/AZKdl c=1 sm=1 tr=0 ts=69989ef5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=y4OcVJxQ2b40wQSunWoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE1MSBTYWx0ZWRfX3KkQuqyDPWpy
 ChDn9ApfAbIk41yXJFJYzCubB0LFdbS62UC/OaMVsc7ZoinJ8Nysq1Hw2WwdVsdBEG8/uKG9GdA
 8TcvPeTXQZrD31bS6hGc/5RTbwIWkUweGtznIQXnuwgdX1siS+chq5iveL9FZVzEEE8rHLVvffB
 ZmGEmx3dGKynOc22ikA/vVNSHiaYVFVnnZIvAn7W+yD/E687sdv2JtBr9d9fhuHqcIgg3TJa+vG
 /Absu0fJRDiMCpkUw0VUBoPRiUKT/YsDDLjghpSklW8m+XIIJ3zv2BD3r30MuT57Uuqq1inSBoH
 SWi0PQWnISE/4xevOlGaqo1VHqrC2gy3TDP8WHu51eGdxVFYcup5+q/psN8WVlEeBQr+V7lxKYy
 1zyQ9/X3GtDYD0s6d0PrZFVIbgUNbXcmiSFGwjVTEMX2cOczyXkWGkDLaphHBH/++EygiUOM3s4
 SwsN48MiWOXr/fQ2ZWg==
X-Proofpoint-ORIG-GUID: 7D5apwNwCBmEyUnReAskCXLP9rIEoxUJ
X-Proofpoint-GUID: 7D5apwNwCBmEyUnReAskCXLP9rIEoxUJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_02,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200151
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_095053_916432_CF668B04 
X-CRM114-Status: GOOD (  13.44  )
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

The NVMe driver encounters various events and conditions during normal
operation that are either not tracked today or not exposed to userspace
via sysfs. Lack of visibility into these events can make it difficult to
diagnose subtle issues related to controller behavior, multipath
stability, and I/O reliability.

This patchset adds several diagnostic counters that provide improved
observability into NVMe behavior. These counters are intended to help
users understand events such as transient path unavailability,
controller retries/reconnect/reset, failovers, and I/O failures. They
can also be consumed by monitoring tools such as nvme-top.

Specifically, this series proposes to export the following counters via
sysfs:
  - Command retry count
  - Multipath failover count
  - Command error count
  - I/O requeue count
  - I/O failure count
  - Controller reset event counts
  - Controller reconnect counts

The patchset consists of seven patches:
  Patch 1: Export command retry count
  Patch 2: Export multipath failover count
  Patch 3: Export command error count
  Patch 4: Export I/O requeue count
  Patch 5: Export I/O failure count
  Patch 6: Export controller reset event counts
  Patch 7: Export controller reconnect event count

Please note that this patchset doesn't make any functional change but
rather export relevant counters to user space via sysfs.

As usual, feedback/comments/suggestions are welcome!

Changes from v2:
  - Allow user to write to sysfs attributes so that user could
    reset stat counters, if needed (Sagi)
  - The controller reconnect counter nr_reconnects could reset
    to zero once connection is re-established, so instead of
    exposing nr_reconnects counter via sysfs introduce a new
    counter which accumulates the reconnect attempts and export 
    this accumulated counter via sysfs (Sagi)
Link to v2: https://lore.kernel.org/all/20260205124810.682559-1-nilay@linux.ibm.com/

Changes from v1:
  - Remove export of stats for admin command rerty count (Keith)
  - Use size_add() to ensure stat counters don't overflow (Keith)
Link to v1: https://lore.kernel.org/all/20260130182028.885089-1-nilay@linux.ibm.com/  

Nilay Shroff (7):
  nvme: export command retry count via sysfs
  nvme: export multipath failover count via sysfs
  nvme: export command error counters via sysfs
  nvme: export I/O requeue count when no path is available via sysfs
  nvme: export I/O failure count when no path is available via sysfs
  nvme: export controller reset event count via sysfs
  nvme: export controller reconnect event count via sysfs

 drivers/nvme/host/core.c      |  18 +++-
 drivers/nvme/host/fc.c        |   5 +
 drivers/nvme/host/multipath.c |  89 ++++++++++++++++++
 drivers/nvme/host/nvme.h      |  13 ++-
 drivers/nvme/host/rdma.c      |   4 +
 drivers/nvme/host/sysfs.c     | 167 ++++++++++++++++++++++++++++++++++
 drivers/nvme/host/tcp.c       |   3 +
 7 files changed, 297 insertions(+), 2 deletions(-)

-- 
2.52.0


