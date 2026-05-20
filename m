Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD8FCD5BA4
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 18:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ftJfgh55HihaDrjGh+9uT+TRK5geDRYpzUXyfHdyUBk=; b=2z3XyB1wzk2Kt0iQ+xJfuINe0S
	68UkBwPTsiy5N2IGknoPEgStL5WTurLzBj93dXbtS7fdQXPkttaFdo7FSI4+6rKHJ8SnbyDTaIJw9
	GAuYuz8bowD/4xRyE4kzU4JrIFArsf6BfmMM2D1F0fuuLdmJze+QhdGORij4iN4Ese1FUYTYkVexE
	XtIXSRzJodWw4/YfREw8Qxyzxy9dVKIMikH240ZQlaNHSA+cCuUoJpvY6yX9Fi571nqFOJwfYkT7+
	qobEJr2nxQFI+uaW5joSs3wOj37CQ3dGXIlTpArBjzdD/WwdLeXy/KYYyS9fCkkpcf6lHbqy9DGc/
	stKQ4pKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPlY2-00000005Q8p-45T8;
	Wed, 20 May 2026 18:21:38 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPlXz-00000005Q81-2oTo
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 18:21:37 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KCKGLT3214577;
	Wed, 20 May 2026 18:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=ftJfgh55HihaDrjGh+9uT+TRK5ge
	DRYpzUXyfHdyUBk=; b=OsgfYIkItt6ZCMMd0H8rFNv/oCYHSWdwP23X3mxwhvjD
	4yM/LMEjHhylXsQ7HuM4GHvconb21nq6QxrcS4Sy1THjNA430Z6/LaVNQShnHBsc
	6NgkKuAHXPmvEFX2c2iQdQw9t7fsVMtiSeSRqDvfyap5TANHNWTjMnVZyEKgXb6S
	SokWQeW1Ghvj9z9chCrhbAH2LwQiIDiM9ItUfa+KWWuOTIie68Mxf2/c0LT7i+St
	bKUlk+CKoeE9e03aJnkmJEAnjj1lm6Omcy1fGaOR/IfmbfkrFj3dogmhXoNImQ1x
	yHOYs0DMa8A4UesQQZhRivV7AekgqRdSa6RZl/n5sQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hawacrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 18:21:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KI97DP006070;
	Wed, 20 May 2026 18:21:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739w0npp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 18:21:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KILJwW47907160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 18:21:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B600A2004B;
	Wed, 20 May 2026 18:21:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACCD820040;
	Wed, 20 May 2026 18:21:14 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.40.237])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 18:21:14 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com
Subject: [PATCHv6 0/8] nvme-multipath: introduce latency I/O policy
Date: Wed, 20 May 2026 23:50:56 +0530
Message-ID: <20260520182112.863076-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE3NyBTYWx0ZWRfXz4VwaTLkeG8U
 0gbmV61x4wBSxfZsBcoB6ybr4LmfKOiqDx8HwL/EZVGNLvst9WqAjYxZgFD0UtaktZU1KuehuD1
 XQ5UCwfRisxp+x9wOgYaagGtqp/N1X6wHL/mvLHr3Q5a3jA4dx2h/6CMYAsWZIlwJda3Gi2fX0y
 KzQS4tnUhjjT68YxMAshgeS5NQdPUcIhJy+ct7QGOQWY47klbVvNLf7gFOTglblq5LIL33pjAVb
 4YiiMiqEQYJaiJSW4vWEjrw+WsWuqGm32nZey5/HzIvAhAHNCmtKeW2SoqWjRl8K4c2IyhZqxSe
 UNT5bQnuvZCMWuot28FfUUL2g6yq5frojfPHRrl3Y1jMEzH1KEhOS2/bEhwKK2tfATLKyZnCyAG
 imH0oFpiyGEDRnOxWlj27M8KiirzyMH6/R5CYQypBMhyMRrB6YR/9lXjTngwJrRcJYv7yx0eWEx
 EmqpLJ/hPfPbA8dj4BA==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0dfba2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ajm_D_dPszzDciGcFXwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PrOs_Fgkt8S-wWDUiydX1W5Vr7dx4_qu
X-Proofpoint-GUID: LhjlmIimSoUPF-Z_MZShG4QTcgpVBlns
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200177
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_112135_837425_BA8E2ABB 
X-CRM114-Status: GOOD (  25.35  )
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
[PATCH 1/8] block: expose blk_stat_{enable,disable}_accounting()
  - Make blk_stat APIs available to block drivers.
  - Needed for per-path latency measurement.

[PATCH 2/8] nvme-multipath: pass I/O type to nvme_find_path()
  - This is the prep patch which updates nvme_find_path() signature
    
[PATCH 3/8] nvme-multipath: add latency I/O policy
  - Implement path scoring based on latency (EWMA).
  - Distribute I/O proportionally to per-path weights.

[PATCH 4/8] nvme: add generic debugfs support
  - Introduce generic debugfs support for NVMe module

[PATCH 5/8] nvme-multipath: add debugfs attribute latency_ewma_shift
  - Adds a debugfs attribute to control ewma shift

[PATCH 6/8] nvme-multipath: add debugfs attribute latency_batch_timeout
  - Adds a debugfs attribute to control latency batch window interval 

[PATCH 7/8] nvme-multipath: add debugfs attribute latency_stat
  - Add “latency_stat” under per-path and head debugfs directories to
    expose latency policy state and statistics.

[PATCH 8/8] nvme-multipath: add documentation for latency I/O policy
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

Nilay Shroff (8):
  block: expose blk_stat_{enable,disable}_accounting() to drivers
  nvme-multipath: pass I/O type to nvme_find_path()
  nvme-multipath: add support for latency I/O policy
  nvme: add generic debugfs support
  nvme-multipath: add debugfs attribute latency_ewma_shift
  nvme-multipath: add debugfs attribute latency_batch_timeout
  nvme-multipath: add debugfs attribute latency_stat
  nvme-multipath: add documentation for latency I/O policy

 Documentation/admin-guide/nvme-multipath.rst |  19 +
 block/blk-stat.h                             |   4 -
 drivers/nvme/host/Makefile                   |   2 +-
 drivers/nvme/host/core.c                     |  21 +-
 drivers/nvme/host/debugfs.c                  | 345 ++++++++++++++
 drivers/nvme/host/ioctl.c                    |  38 +-
 drivers/nvme/host/multipath.c                | 446 ++++++++++++++++++-
 drivers/nvme/host/nvme.h                     |  84 +++-
 drivers/nvme/host/pr.c                       |   6 +-
 drivers/nvme/host/sysfs.c                    |   2 +-
 include/linux/blk-mq.h                       |   4 +
 11 files changed, 941 insertions(+), 30 deletions(-)
 create mode 100644 drivers/nvme/host/debugfs.c

-- 
2.53.0


