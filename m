Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6638DC531FC
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2026 15:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cAs/mz6HxKqselQaWtqlpJ5lLl6Z6vbLeLaY3QnK+3A=; b=USGuG4/HQB+cV8/4X8PaGeegZW
	JQ7Pf69qKkBAcjytubB21DwW8+jMHTzJG3+2VdH6QLPxi2F+tO+yfZ83fxRwFNqePha2ExA19365y
	7ScFHZvVgbmICJIGruGVjczEEZvByc4xhe9wjqRPVChmogS8FS1Tlh5R+g6sbzVaSfFbVNB4mwSMe
	6HIkYNvJ+XUBg8v8v1yu0PHTA2Ps8ib3a4aHTU6Dm/osqErV2oNg7yzZ1JkL+DSwHvoJZCsaD1sD/
	dDyZg6kYuxR7K1vZnoykcevKt2+2PKv+9x+gymV97Fy00O8FeldubMn4i1wkumvKNW88JC8rZ9Rj0
	3a3+BiLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woN1W-000000038QR-370k;
	Mon, 27 Jul 2026 15:13:46 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woN1Q-000000038Q4-1KcU
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jul 2026 15:13:41 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDnOaF2292051;
	Mon, 27 Jul 2026 15:13:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=cAs/mz6HxKqselQaWtqlpJ5lLl6Z
	6vbLeLaY3QnK+3A=; b=sEM+JE55iO4s4rxZ4HHROOk9xGiTovAQnpNQ/Oi65vh+
	hVUMMTWevDnS3t41OcnxqNCLTy0dqvwROOCjtZQuGPZbD+O3K3vnpdkJPpoqLVfa
	60VplhWWVUazm6M16N86kh/C8SglJUI6ssCHZm7SKGLceHazRCz6tVJS2g5BJ4p/
	PhL2tigrMy5YGMMW/wHQxpYVphtUrh2d2rj+jV2iIWgy927pgGoibTEkKijaUie0
	/by7G/kTY2o55cVpREnoUUUnMP02scYe5bOtiYpyRkzFhPqB8JpD5kpbE5M1Nau1
	7IQCq0IU/87Hd/qZpxA6BzVJSrVDlYZjxPlfA8oORQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0ng845-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:13:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RFBHwf015275;
	Mon, 27 Jul 2026 15:13:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjwvjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:13:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RFDRaH50135516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 15:13:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76E2920103;
	Mon, 27 Jul 2026 15:13:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA8A720101;
	Mon, 27 Jul 2026 15:13:24 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.97.190])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 15:13:24 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me,
        chaitanyak@nvidia.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 0/4] nvme-tcp: NIC topology aware I/O queue scaling and queue info export
Date: Mon, 27 Jul 2026 20:43:00 +0530
Message-ID: <20260727151315.3658708-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0MCBTYWx0ZWRfX/iFyTsx6fm21
 ZJl3A3A/V9wSozD+tFddZK2ywBq8RNQhyT3tnMxhH9DfUuW7thQ2TNhL0PTfLpFbgTU8Y+m6d70
 RYrcqOOHicTeY4KA9Oae75WTetzkimY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0MCBTYWx0ZWRfX8e8C2mDvQ7tL
 qLGj6z0bI1GfoPvjGMKNHUBiwF8VYPLmpTuxmmFaNn/nOxRASvSi2hvusPZspsngA7hdre1n+7a
 NaI8sn3R6rN3NEJJ9fiDEIv7E0o/iBajaGXCBOrGCYFUXWoLqrE0mzKWnPloEEW5rn6epDi34A+
 onuqaAGiEqZEO6LASUTckKza/YrUUvGTB+9uvHQ+FMME6Or2wE4QLE3YKeCsGq6Y4GnECD1o3qh
 Wl7J9RPyMnMQBGkITpZo3Ltx7W1mwh9iKCpaUdoeC0KdXBSH60rsfBA0nMe1WGeEc98UI5p1jB2
 kO3H3fz20aXfW1Jyrl8Riy8ASmU8OHQvAHSlIGwEvJnqsXh8GH9gAc+jjTGt2J6mYUP+Wo2mTM9
 3NGnMbqBMjckh3mxHnhzhhzoO5+cWTY6VQA3+M6bcgM3DA2g6q8WBVIvWXL+wX14eZgcIX09Etg
 5eqUTgiLG8eV/q98rSQ==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a67759c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=QMeSkxUhXQUGZ0QmNXkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Rv3cyd2KD-_91OChIKaJdBarsaEcQkt_
X-Proofpoint-ORIG-GUID: Rv3cyd2KD-_91OChIKaJdBarsaEcQkt_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270140
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_081340_474902_9AC318A5 
X-CRM114-Status: GOOD (  20.63  )
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
 drivers/nvme/host/debugfs.c | 190 ++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h    |  12 +++
 drivers/nvme/host/tcp.c     | 120 ++++++++++++++++++++++-
 include/linux/netdevice.h   |   5 +
 net/core/dev.c              |  83 ++++++++++++++++
 7 files changed, 413 insertions(+), 2 deletions(-)
 create mode 100644 drivers/nvme/host/debugfs.c

-- 
2.53.0


