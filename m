Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A7FF36C5C
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2026 11:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RweQjUGd1Sjiunyd4M9mXiTDS7Jkf3uuafFIZf/nOTk=; b=Ns1/rHg0xOSiDJO3pzrumw7+EK
	gC9Gzjato4alwp+cdhE+stwOsMPBl8r6+Nt/6Oy23ZOHUEhNEqKONfFlnC6sS8XfL+9jPcXztURmz
	wIiKq0F/QG3v+VnRZsVrjMTd8kFZlyKVafErbe9CPVCJZf0rLaNkYslBUDytcwKzwmdcegNp+hDhW
	bcSg5ZizrqsUjHbK7SkOgIeSqajhr7C3s2e2jdjBSv5FDH0pwo0v83Tsy/Kg/FbYi+qkNy1eRImcM
	14YOEQ6Dg24as3PRPUMcH/9MI8DDa5Qqys2WmhxOuKFoaU3vDqJJ6vlOA/brjJWZZKJLhXqOkx8us
	botL5/Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEnG2-00000006pRq-2eHJ;
	Mon, 20 Apr 2026 11:57:42 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEnFy-00000006pQz-3sPO
	for linux-nvme@lists.infradead.org;
	Mon, 20 Apr 2026 11:57:40 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K1tZLB3929992;
	Mon, 20 Apr 2026 11:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=RweQjUGd1Sjiunyd4M9mXiTDS7Jk
	f3uuafFIZf/nOTk=; b=YPc6kKmVzWc+zH50vS35ZVexkK4kTIINOiIjgS/j1xBi
	GWXqiwhuSi3QKAiqz2pjbiJkVKaz99qD9kxKI6yUGlCob8iPqepweH7xPHz6rCqz
	A083nDq3xIpz3I0reJSInlPUuHHD+s+NShTzAm9zPJk9qmqyedAE3tuSLOnmK/PM
	kpBH7ifmD86NbeO0DfdoQY10Ku3A7IcwJ4d35Zx0we8WB8qZqwxTNOvou9vy3QLC
	CAOfXvHjjSUHLXq4unw4xMA1lnya1EB0kwOM2BIdG+g43Ns3YHun6it2m+0JRhBY
	WJt4QYfYmLcgcCNRV1MvQ/7yO7b/IEGt5hDnEOlJ3g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2neymhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 11:57:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63KBoLKZ000722;
	Mon, 20 Apr 2026 11:57:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpgg4f66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 11:57:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63KBvLke38011328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 11:57:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 501CC2004D;
	Mon, 20 Apr 2026 11:57:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65C412004B;
	Mon, 20 Apr 2026 11:57:19 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Apr 2026 11:57:19 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me,
        chaitanyak@nvidia.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [RFC PATCH 0/4] nvme-tcp: NIC topology aware I/O queue scaling and queue info export 
Date: Mon, 20 Apr 2026 17:19:32 +0530
Message-ID: <20260420115716.3071293-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3_vFl9vYfRmw02EtSYbzH8by2cXA-_8C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDExNSBTYWx0ZWRfXz1FhB6QfWty6
 QZcP8ACgWTIlRCoiXTT77oQytbNF5vsN2Z1qldNPUcfyNG5Jr52fIi/4o+MLGBvSaAfG9aJg4hM
 nrI7m293WZ2WnmYE/eerj0oTHwEmAkF9httimutlYO8qbNedV5bEyCsJpSso6N9FpD21FcXWX5p
 0GUXQPoVHCl4et/hgqsF2tpThScKqehzLxYBb/XbQR3PEP6IL0/V8T3RdQ6HqjeTdePHAwDw5yG
 HqBDCYr7oOsi1NC5Fp0xJeZH2++ytubYtaT1ooCyCgB5negneAOwFOe+XjMoTtUx1q9pxHF7j7T
 4a/z5nsKu9U4GeiYkT4MkL4FwVqrcLecr5jXOhfnEaOVD04/xQWAIWW3ypAQwXj9vmxDtUv0YpX
 xNSypxFGQNSFvGlkgapBuovlkBXJc0xjOAyjPIdpxJ9QalejmLNGokuuZ0HhKr6SgkoQVZOA1Qp
 OxnZ9JRV66glsG+iLkA==
X-Proofpoint-GUID: 3_vFl9vYfRmw02EtSYbzH8by2cXA-_8C
X-Authority-Analysis: v=2.4 cv=B7iJFutM c=1 sm=1 tr=0 ts=69e614a5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pCvF6Xk5LiJKsoi9nmMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200115
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_045739_015650_709644D7 
X-CRM114-Status: GOOD (  17.10  )
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

The NVMe/TCP host driver currently provisions I/O queues primarily based
on CPU availability rather than the capabilities and topology of the
underlying network interface.

On modern systems with many CPUs but fewer NIC hardware queues, this can
lead to multiple NVMe/TCP I/O workers contending for the same TX/RX queue,
resulting in increased lock contention, cacheline bouncing, and degraded
throughput.

This RFC proposes a set of changes to better align NVMe/TCP I/O queues
with NIC queue resources, and to expose queue/flow information to enable
more effective system-level tuning.

Key ideas
---------

1. Scale NVMe/TCP I/O queues based on NIC queue count
   Instead of relying solely on CPU count, limit the number of I/O workers
   to:
       min(num_online_cpus, netdev->real_num_{tx,rx}_queues)

2. Improve CPU locality
   Align NVMe/TCP I/O workers with CPUs associated with NIC IRQ affinity
   to reduce cross-CPU traffic and improve cache locality.

3. Expose queue and flow information via debugfs
   Export per-I/O queue information including:
       - queue id (qid)
       - CPU affinity
       - TCP flow (src/dst IP and ports)

   This enables userspace tools to configure:
       - IRQ affinity
       - RPS/XPS
       - ntuple steering
       - or any other scaling as deemed feasible

4. Provide infrastructure for extensible debugfs support in NVMe

Together, these changes allow better alignment of:
    flow -> NIC queue -> IRQ -> CPU -> NVMe/TCP I/O worker

Performance Evaluation
----------------------
Tests were conducted using fio over NVMe/TCP with the following parameters:
    ioengine=io_uring
    direct=1
    bs=4k
    numjobs=<#nic-queues>
    iodepth=64
System:
    CPUs: 72
    NIC: 100G mlx5

Two configurations were evaluated.

Scenario 1: NIC queues < CPU count
----------------------------------
- CPUs: 72
- NIC queues: 32

                Baseline        Patched        Patched + tuning
randread        3141 MB/s       3228 MB/s      7509 MB/s
                (767k IOPS)     (788k IOPS)    (1833k IOPS)

randwrite       4510 MB/s       6172 MB/s      7518 MB/s
                (1101k IOPS)    (1507k IOPS)   (1836k IOPS)

randrw (read)   2156 MB/s       2560 MB/s      3932 MB/s
                (526k IOPS)     (625k IOPS)    (960k IOPS)

randrw (write)  2155 MB/s       2560 MB/s      3932 MB/s
                (526k IOPS)     (625k IOPS)    (960k IOPS)

Observation:
When CPU count exceeds NIC queue count, the baseline configuration
suffers from queue contention. The proposed changes provide modest
improvements on their own, and when combined with queue-aware tuning
(IRQ affinity, ntuple steering, and CPU alignment), enable up to 
~1.5x–2.5x throughput improvement.

Scenario 2: NIC queues == CPU count
-----------------------------------

- CPUs: 72
- NIC queues: 72

                Baseline                Patched + tuning
randread        4310 MB/s               7987 MB/s
                (1052k IOPS)            (1950k IOPS)

randwrite       7947 MB/s               7972 MB/s
                (1940k IOPS)            (1946k IOPS)

randrw (read)   3583 MB/s               4030 MB/s
                (875k IOPS)             (984k IOPS)

randrw (write)  3583 MB/s               4029 MB/s
                (875k IOPS)             (984k IOPS)

Observation:
When NIC queues are already aligned with CPU count, the baseline performs
well. The proposed changes maintain write performance (no regression) and
still improve read and mixed workloads due to better flow-to-CPU locality.

Notes on tuning
---------------
The "patched + tuning" configuration includes:
    - aligning NVMe/TCP I/O workers with NIC queue count
    - IRQ affinity configuration per RX queue
    - ntuple-based flow steering
    - CPU/queue affinity alignment

These tuning steps are enabled by the queue/flow information exposed through
this patchset.

Discussion
----------
This RFC aims to start discussion around:
  - Whether NVMe/TCP queue scaling should consider NIC queue topology
  - How best to expose queue/flow information to userspace
  - The role of userspace vs kernel in steering decisions

As usual, feedback/comment/suggestions are most welcome!

Reference to LSF/MM/BPF abstarct: https://lore.kernel.org/all/5db8ce78-0dfa-4dcb-bf71-5fb9c8f463e5@linux.ibm.com/

Nilay Shroff (4):
  nvme-tcp: optionally limit I/O queue count based on NIC queues
  nvme-tcp: add a diagnostic message when NIC queues are underutilized
  nvme: add debugfs helpers for NVMe drivers
  nvme: expose queue information via debugfs

 drivers/nvme/host/Makefile  |   2 +-
 drivers/nvme/host/core.c    |   3 +
 drivers/nvme/host/debugfs.c | 162 +++++++++++++++++++++++++++
 drivers/nvme/host/fabrics.c |   4 +
 drivers/nvme/host/fabrics.h |   3 +
 drivers/nvme/host/nvme.h    |  12 ++
 drivers/nvme/host/tcp.c     | 211 +++++++++++++++++++++++++++++++++++-
 7 files changed, 395 insertions(+), 2 deletions(-)
 create mode 100644 drivers/nvme/host/debugfs.c

-- 
2.53.0


