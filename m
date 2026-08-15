Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1270C5DF6A
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Aug 2026 17:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ES2h5p9qZ3ufijZEOrl9+GyYpyIghhGDn/eOvlAUCEA=; b=dRI808SMOp1j969sBVCoKgk4Ad
	qOdJA3/lEB7t6L5wTWe0Uo6IK9fXgc0rmleDvFmQurBppEUfhzkNCYgxBPqdtV6AwBR+8woWmP5Mv
	RVv3jueuoFy/MqmK1SG5IWft7ALCmVSoD0cq4MAi7N9XoYdsxSwEkfxgpTpzRwatevBTR1qX4okAh
	seIU+yxWwXzw7rjH5TsrtHhVn/3eyYPsFG5rVLROylEUt98P2cZFc5dffY+ByqCDP8K+VshoGkPUz
	HrI14DLn0464+/cC9muUq/ne3HzU07ijNoJzquYujnyzz/wD8/xtnFofpjMMDVIiuodtrVD+o8DvK
	GFuVMgkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvIIP-00000003zcm-1ws6;
	Sat, 15 Aug 2026 17:35:49 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvIIM-00000003zbF-15OP
	for linux-nvme@lists.infradead.org;
	Sat, 15 Aug 2026 17:35:47 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67FGVkxh349967;
	Sat, 15 Aug 2026 17:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=ES2h5p9qZ3ufijZEOrl9+GyYpyIg
	hhGDn/eOvlAUCEA=; b=f2X2cRrYwfgKjXfDfns/UnnubPsNGJD1Z2xPjesAZYVy
	27TB0qqT6y+uRmH1uKuJVnZSky0CMff41SoiSEP7IpS3V7JuH+zWzIB4BsIGWpUB
	yXRIWmn6Hn7sURGkl5N5YfJw2+lAVD7N8XprOaWsTCQoRl4fIHVIOT9jwP7SYGVI
	aNfsrt8PYvkPlylbuEqe1tZZB1+aJ3iBG6gnN9cgwdMcOvsOHnHBPOU/MfFHUFL3
	MpLPoIHXWddju2YuBgxBH0SNy0K9nPZQIRTKb5IxoIC/K1fGddrnC0v2SQnL5W+E
	K2eW+bDt1YJ8BJVbsznoQDWd4oQBsJ4r6Uq3ulHwWw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frst53f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Aug 2026 17:35:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67FHQPft011737;
	Sat, 15 Aug 2026 17:35:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gux24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Aug 2026 17:35:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67FHZKjK51184098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Aug 2026 17:35:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D6D82004E;
	Sat, 15 Aug 2026 17:35:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AB6720040;
	Sat, 15 Aug 2026 17:35:15 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.9.204])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 15 Aug 2026 17:35:14 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com
Subject: [PATCH v8 00/10] nvme-multipath: introduce latency I/O policy
Date: Sat, 15 Aug 2026 23:04:22 +0530
Message-ID: <20260815173502.1185929-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a80a35b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=gSPoBDCuv3IrOLJJCuQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDEzMCBTYWx0ZWRfX85YhORYrtlO0
 lq6UAJ6HIMKCdsa+RAbf6eJ2ZedVSTG41VmvBRu33C44v9/C4nrTcVlKrtbrQM3RgqrijnlC+zQ
 rG6EpvC0g+CTdE/78YmAw9zZZl5RMME=
X-Proofpoint-GUID: gbD-YC1LkUzuDAy8QQ5dP6QMmORNYwDn
X-Proofpoint-ORIG-GUID: Bdkx-bz45PktB3fS8F_0zyiTmxjE3whI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEzMCBTYWx0ZWRfXzkcAwhK/1D1r
 yOd6Q1568Ht5z0MUmuMeUCJjzuFNxY/RXqWVqFiT1DG0Vy0OeEKORX1TkdWIKTVEfFf16M90Yz6
 zaRGXdSU31Fsonch5Niyjwd3rl60HghBEKTRaRNCUJ2iJI6vLE93jBM3vUMVzSzh8+sY1oHJPJV
 BP3chdKPNveMB9jc4wXFReXBrY0/orfGAfKceHY8xw2wm1H42XFLMB75C9B7i+jJxRZE/MrthsO
 IYClR5VBz+0PjXSMWPQfJgN6moGjEQ+xilah7atw5a+dDHWrswL+5+EME7knP6dEiwKxDiCMinK
 9rTGVZoqA/d3WaniO0RwvvOEeEP9qqP1nHYOm4f3Xj9GsA2P5zB5illjFezkkJIlB3a3kdFOM8o
 k1YUgnQF+6n0cXAJ9AxWRGCrWDjKbLVqi1lTI5bEetmgYbp8X6t4g0HhdsrDOBNbLduJupeJzHF
 ttyC8ucW5PxOyZ+VGmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608150130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260815_103546_440950_0F5350A2 
X-CRM114-Status: GOOD (  26.11  )
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

This series introduces a new latency I/O policy for NVMe native
multipath. Existing policies such as numa, round-robin, and queue-depth
are static and do not adapt to real-time transport performance. The numa
selects the path closest to the NUMA node of the current CPU, optimizing
memory and path locality, but ignores actual path performance. The
round-robin distributes I/O evenly across all paths, providing fairness
but not performance awareness. The queue-depth reacts to instantaneous
queue occupancy, avoiding heavily loaded paths, but does not account for
actual latency, throughput, or link speed.

The new latency policy addresses these gaps selecting paths dynamically
based on measured I/O latency for both PCIe and fabrics. Latency is
derived by passively sampling I/O completions. Each path is assigned a
weight proportional to its latency score, and I/Os are then forwarded
accordingly. As condition changes (e.g. latency spikes, bandwidth
differences), path weights are updated, automatically steering traffic
toward better-performing paths.

Early results show reduced tail latency under mixed workloads and
improved throughput by exploiting higher-speed links more effectively.
For example, with NVMf/TCP using two paths (one throttled with ~30 ms
delay), fio results with random read/write/rw workloads (direct I/O)
showed:

        numa         round-robin   queue-depth  adaptive
        -----------  -----------   -----------  ---------
READ:   50.0 MiB/s   105 MiB/s     230 MiB/s    350 MiB/s
WRITE:  65.9 MiB/s   125 MiB/s     385 MiB/s    446 MiB/s
RW:     R:30.6 MiB/s R:56.5 MiB/s  R:122 MiB/s  R:175 MiB/s
        W:30.7 MiB/s W:56.5 MiB/s  W:122 MiB/s  W:175 MiB/s

This pathcset includes totla 8 patches:
[PATCH 1/10] block: expose blk_stat_{enable,disable}_accounting()
  - Make blk_stat APIs available to block drivers.
  - Needed for per-path latency measurement.

[PATCH 2/10] block: record I/O request start time for passthru request
  - Record I/O start time for I/O passthru requests.
  - This is prep patch which allows measuring I/O completion latency 
    for passthru requests.

[PATCH 3/10] block: support nesting for blk-mq flag QUEUE_FLAG_SAME_FORCE
  - Support nesting for QUEUE_FLAG_SAME_FORCE as multiple users
    could toggle QUEUE_FLAG_SAME_FORCE.

[PATCH 4/10] nvme-multipath: pass I/O type to nvme_find_path()
  - This is the prep patch which updates nvme_find_path() signature
    
[PATCH 5/10] nvme-multipath: add latency I/O policy
  - Implement path scoring based on latency (EWMA).
  - Distribute I/O proportionally to per-path weights.

[PATCH 6/10] nvme: add generic debugfs support
  - Introduce generic debugfs support for NVMe module

[PATCH 7/10] nvme-multipath: add debugfs attribute latency_ewma_shift
  - Adds a debugfs attribute to control ewma shift

[PATCH 8/10] nvme-multipath: add debugfs attribute latency_batch_timeout
  - Adds a debugfs attribute to control latency batch window interval 

[PATCH 9/10] nvme-multipath: add debugfs attribute latency_stat
  - Add “latency_stat” under per-path and head debugfs directories to
    expose latency policy state and statistics.

[PATCH 10/10] nvme-multipath: add documentation for latency I/O policy
  - Includes documentation for latency I/O multipath policy.

LSFMM discussion:
=================
During lsfmm 2026, it was decided to rename this I/O policy from
"adaptive" to "latency". This series reflects that rename.

The discussion at lsfmm also focused extensively on the latency
measurement model, including whether latency should be tracked
per-CPU or per-NUMA, and whether separate I/O-size buckets should
be maintained for different request sizes.

After detailed discussion and evaluation of throughput results, the
consensus was to initially measure I/O completion latency on a
per-CPU basis. The available performance data showed that the
per-CPU implementation already provides sufficient averaging across
CPUs while keeping the design relatively simple.

The use of additional I/O-size buckets did not demonstrate meaningful
throughput improvement in the general case and would introduce extra
complexity into the fast path and accounting logic. As a result, the
consensus was to avoid I/O-size bucketing for now and keep the policy
focused on per-CPU latency measurement.

If future real-world workloads demonstrate a clear benefit from
I/O-size-aware latency accounting, the policy can be extended later
to support it.

As ususal, feedback and suggestions are most welcome!

Thanks!

Changes from v7:
  - Rebased on nvme-7.3 (John Garry)
  - Added Clang lock context annotations where appropriate (John Garry)
  - Added support for nesting QUEUE_FLAG_SAME_FORCE in a new patch
    3/10 (John Garry)
  - Free head->latency_path in nvme_mpath_put_disk() instead of
    nvme_free_ns_head() (John Garry)
  - Replaced this_cpu_ptr() with per_cpu_ptr() (John Garry)
  - Few miscellaneous and cosmetic changes such as adding comments
    updating commit description etc.

Link to v7: https://lore.kernel.org/all/20260809100825.2014133-1-nilay@linux.ibm.com/ 

Changes from v6:
  - Add patch 2/9, which records I/O start time for the passthru
    requests (Guixin Liu)
  - Correctly record the passthru I/O data direction (Guixin Liu)
  - Clear NVME_NS_PATH_STAT before cancelling the latency weight work.
    (Guixin Liu)
    
Link to v6: https://lore.kernel.org/all/20260520182112.863076-1-nilay@linux.ibm.com/

Changes from v5:
  - Rename the policy from "adaptive" to "latency". The entire series
    updates policy names, function names, and variable names accordingly,
    without introducing any functional changes. (lsfmm discussion)
  - The second patch is now splitted into two patches:
    Patch #2: prep patch where we pass op_type to nvme_find_path()
    Patch #3: core patch which introduces latency I/O policy 
    (Sagi)
  - Rename ewma_update() to calc_ewma_update() (Sagi)
Link to v5: https://lore.kernel.org/all/20251105103347.86059-1-nilay@linux.ibm.com/

Changes from v4:
  - Added patch #7 which includes the documentation for adaptive I/O
    policy. (Guixin Liu)
Link to v4: https://lore.kernel.org/all/20251104104533.138481-1-nilay@linux.ibm.com/    

Changes from v3:
  - Update the adaptive APIs name (which actually enable/disable
    adaptive policy) to reflect the actual work it does. Also removed
    the misleading use of "current_path" from the adaptive policy code
    (Hannes Reinecke)
  - Move adaptive_ewma_shift and adaptive_weight_timeout attributes from
    sysfs to debugfs (Hannes Reinecke)
Link to v3: https://lore.kernel.org/all/20251027092949.961287-1-nilay@linux.ibm.com/

Changes from v2:
  - Addede a new patch to allow user to configure EWMA shift
    through sysfs (Hannes Reinecke)
  - Added a new patch to allow user to configure path weight
    calculation timeout (Hannes Reinecke)
  - Distinguish between read/write and other commands (e.g.
    admin comamnd) and calculate path weight for other commands
    which is separate from read/write weight. (Hannes Reinecke)
  - Normalize per-path weight in the range from 0-128 instead
    of 0-100 (Hannes Reinecke)
  - Restructure and optimize adaptive I/O forwarding code to use
    one loop instead of two (Hannes Reinecke)
Link to v2: https://lore.kernel.org/all/20251009100608.1699550-1-nilay@linux.ibm.com/

Changes from v1:
  - Ensure that the completion of I/O occurs on the same CPU as the
    submitting I/O CPU (Hannes Reinecke)
  - Remove adapter link speed from the path weight calculation
    (Hannes Reinecke)
  - Add adaptive I/O stat under debugfs instead of current sysfs
    (Hannes Reinecke)
  - Move path weight calculation to a workqueue from IO completion
    code path
Link to v1: https://lore.kernel.org/all/20250921111234.863853-1-nilay@linux.ibm.com/

Nilay Shroff (10):
  block: expose blk_stat_{enable,disable}_accounting() to drivers
  block: record I/O request start time for passthru request
  block: support nesting for blk-mq flag QUEUE_FLAG_SAME_FORCE
  nvme-multipath: pass I/O type to nvme_find_path()
  nvme-multipath: add support for latency I/O policy
  nvme: add generic debugfs support
  nvme-multipath: add debugfs attribute latency_ewma_shift
  nvme-multipath: add debugfs attribute latency_batch_timeout
  nvme-multipath: add debugfs attribute latency_stat
  nvme-multipath: add documentation for latency I/O policy

 Documentation/admin-guide/nvme-multipath.rst |  19 +
 block/blk-mq.c                               |  53 +-
 block/blk-stat.h                             |   4 -
 block/blk-sysfs.c                            |   6 +-
 drivers/nvme/host/Makefile                   |   2 +-
 drivers/nvme/host/core.c                     |  15 +-
 drivers/nvme/host/debugfs.c                  | 347 ++++++++++++++
 drivers/nvme/host/ioctl.c                    |  44 +-
 drivers/nvme/host/multipath.c                | 478 ++++++++++++++++++-
 drivers/nvme/host/nvme.h                     | 110 ++++-
 drivers/nvme/host/pr.c                       |   6 +-
 drivers/nvme/host/sysfs.c                    |   2 +-
 drivers/ufs/host/ufs-mediatek.c              |   2 +-
 include/linux/blk-mq.h                       |   6 +
 include/linux/blkdev.h                       |   3 +
 15 files changed, 1057 insertions(+), 40 deletions(-)
 create mode 100644 drivers/nvme/host/debugfs.c

-- 
2.53.0


