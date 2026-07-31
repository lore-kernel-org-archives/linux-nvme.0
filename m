Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B2BC5516D
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 07:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OM/jPgP+8hnz2owFSSCHYzFo5cC4nIebpSMnv5SHUys=; b=RAP3IQn7NDOJRbqqGjWVBAW5V1
	FAdIAyKgSWckIMs1uTqeVtbbi9+wtNI8p2a5A5QBQfywIE0slNoGj0r0NkRBvP2ssPljGo41yD3ha
	UKGaKB0CR6HzdQ92rECrjmCnCiFSCcb4d43cdRb5ap6RII7iTwJFH5SgHAruVOY969RMBijBwPFJ5
	va9i/lyFeuDRtyaso4HGoelqCEGojW8qHquq/iWqgL47nDyxXijiZoe+tA8DY6+Eus6XF0IxO2hZ2
	FpqQnwEOoImp/4bdGkgTc0DpDFXxNECfxzzYFVy/oUMCkUBEzDO9nQ7Seq+qsY+cWQHvJuIPbOS8F
	JFZBdHEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wphqZ-0000000Byes-1MVZ;
	Fri, 31 Jul 2026 07:39:59 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wphqW-0000000Byde-2wYY
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jul 2026 07:39:58 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V5Hj1V3252751;
	Fri, 31 Jul 2026 07:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=OM/jPgP+8hnz2owFSSCHYzFo5cC4
	nIebpSMnv5SHUys=; b=IXMdF7TKKHuSI2d4BU1Z9kcmCpB1zVZ/74Xe9xQlkf+d
	JrCp2qZtkdWFRtfPwFjsMwoQMFpJEyDsjk9StkNDwcRgeokFYurYyhIc+A7tOb8M
	i/yoM44BlaAc5aCwEoXRos/403ziniKNUMcKAR3uHxYQNi03MslWmDj6wvw28A+1
	gtut4HxfPpMbHoiMtxy45IxXSy3EDBYtdpRVv3mgZ5uP2qwSrHH+YJTgFZsCiZoM
	pk3QASq30m45EDnPrry/ZOO6c9HZREuv/78zMJVBdr4o8g7kptU0SZ17cQbVMrrV
	f2KvK8R5gQpLE/rAq9jnpT1f45duPRXnk4tUCywV/w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycuu2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 07:39:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V7QJjs030825;
	Fri, 31 Jul 2026 07:39:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqq5bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 07:39:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V7dfuY28312042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 07:39:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3B4B20040;
	Fri, 31 Jul 2026 07:39:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C41320043;
	Fri, 31 Jul 2026 07:39:37 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.125.83])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 07:39:37 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me,
        chaitanyak@nvidia.com, gjoyce@linux.ibm.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [RESEND PATCH v2 0/4] nvme-tcp: NIC topology aware I/O queue scaling and queue info export
Date: Fri, 31 Jul 2026 13:09:04 +0530
Message-ID: <20260731073918.614014-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: VlvQQgoDIOO3QUXYYJKv2qvTRQMmgNd_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA1MCBTYWx0ZWRfX13kFYXufqI5q
 H2Kc5j1jBBE6wBLDHxVrcdeWo1iqv2uPd4lMt+14iJ+OlYmjBjpKgS8I/UgJlANi9t1mAlOGWIc
 Tyhg49rr42k6PQsDL75xkuhFqwOgqsxIHUOUlG0PShgHe/8bZopYPxvWEe0nlGNu74cef7/9oh6
 CcB2mFBBLmQnB2CyCBNqfMhWDNnEsSE/JI+mwyOaFhil4bBYVvtrOzfknsEHlD/4JF4rSweQHTy
 6MLDfd2O0qfT18P/Dl9oJoIgvxtv8Fp+NoI0JFateqyN/oyI07JIaIx2nfEr1QM1ZTfdeqyjJL/
 O21Z8D/Ft8JKQfmPKcLaARSqwBDoQKjG9av0E9U0FNL4+vO1pZrPpT9DqtTVQ3eLjY1xF4xL5ex
 HRB5pSvxkzdzM2GB/zC7LYFxCsR9t9jdprCi4jx2ellnLRNg5oIbyCH5f6e25Me4JsKhDEQeNHn
 2mdVBPdxFGaA9qjktiw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA1MCBTYWx0ZWRfX/k1exCl0FOmM
 iIvxj26xLHaoiLIjCW2luqnFdVfAgnvqWYwzsIXJpTc06q0XztS4Mufk8XxDtgZktxLX1KRErJ/
 ZPhJeVy9VV4mIpECACzs0/ac+kiLcZ0=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6c5142 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=QMeSkxUhXQUGZ0QmNXkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: t8oL1UliF7Fj2j6WK-b9g7SmqS_izXXP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310050
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_003956_749656_5A7A3406 
X-CRM114-Status: GOOD (  21.18  )
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

This is a resend of the previous series to include the networking maintainers
and mailing list. There are no code or commit message changes since the
previous posting.

This series has been updated based on the feedback received during LSFMM.
The changelog is updated accordingly.

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

As usual, feedback/comment/suggestions are most welcome!

Changes from v1:
  - remove the "match-hw-queues" fabric option; always limit the number
    of NVMe/TCP I/O queues to min(num_online_cpus, num_nic_queues)
  - drop the diagnostic patch reporting NIC queue underutilization
  - split the netdev helper into a separate patch
  - move the netdev helper implementation to net/core/dev.c
 
Link to v1: https://lore.kernel.org/all/20260420115716.3071293-1-nilay@linux.ibm.com/

Nilay Shroff (4):
  net: add helper for device lookup by destination address
  nvme-tcp: limit I/O queue count based on NIC queue count
  nvme: add debugfs helpers for NVMe drivers
  nvme: expose queue information via debugfs

 drivers/nvme/host/Makefile  |   2 +-
 drivers/nvme/host/core.c    |   3 +
 drivers/nvme/host/debugfs.c | 191 ++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h    |  12 +++
 drivers/nvme/host/tcp.c     | 115 ++++++++++++++++++++++
 include/linux/netdevice.h   |   5 +
 net/core/dev.c              |  84 ++++++++++++++++
 7 files changed, 411 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvme/host/debugfs.c

-- 
2.53.0


