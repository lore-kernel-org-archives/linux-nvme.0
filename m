Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9B1CCF9EA
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 09:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JbUHOiuz1SB0yjUp11hxf2h0X3eLh5V3raCP5129hVw=; b=3DPK/WlyHaewaZjxUTmUVXp8I+
	c9HF8s8Ej1t60zXK4ZC1QmqzqIwZkWlUCaGPv8J69xrofVEQUJb2BkqWPTXYX/RDEk2wvxGaWizYL
	L85CE7uNys4lgVQ/jdBaKmKlEypS7FLH/6zxwnNxVjU659pVjDgV5ddAmVOTTKwAIfP8LvBG2qh2o
	+ZFygdAI5Ky4mtm9Abh4LCBSJsJzgg2cyeO9LoIUyKt6VzNmyy9jrpRf+MvLphGJg5gZxDeu3KSVz
	zG5+xtkgfA1rmnXNApUPSBYU8Q34ps/iTUMw97yN1WUhi9Yno7kZdkMW/qw4DK8t7fpbCtjmv/9wc
	uM1Ju/Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDJYN-0000000DX13-2HdY;
	Mon, 27 Oct 2025 09:30:15 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDJYK-0000000DWzR-1deF
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 09:30:14 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59R7eHmq016650;
	Mon, 27 Oct 2025 09:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=JbUHOiuz1SB0yjUp11hxf2h0X3eL
	h5V3raCP5129hVw=; b=D1DUfshR2FtG44HrHKO2zgBaM4y95Zi3W21Pi2Z9KwcE
	1ad8NFCUsGqDAMoe8JoD275vq0B0GKcAk1+1yuESdhjwpxEbm3Lz4KqaDEpjz/DO
	0K0aIfq7bQd1/b8i4i09icSsmWMeZ82hXMxkgCIy9R1qRmXuWJPW5pDGgKWqJNeO
	cTG2Y7Gz8vzgYqPj2/xXa8+3dBUUAiSAiYN+rwGQHb+B5eM9aemrVhlfF/iDbzV7
	6hA02UnCINlRl6jwt7l8SMF15KAw+QAUY6DkdG/Bn0GnyI9bQhl8Yy9EGMsI8bS0
	Hxo8OLqbHT4yNrpYRZglkdVA9wsB+solcEx740M/Yw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p98x0yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 09:30:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59R8aXZK009411;
	Mon, 27 Oct 2025 09:30:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a1b3hvm0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 09:30:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59R9TtmL35389826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 09:29:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7242420043;
	Mon, 27 Oct 2025 09:29:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FBF320040;
	Mon, 27 Oct 2025 09:29:51 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.186.32])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Oct 2025 09:29:51 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: [RFC PATCHv3 0/6] nvme-multipath: introduce adaptive I/O policy
Date: Mon, 27 Oct 2025 14:59:34 +0530
Message-ID: <20251027092949.961287-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=JqL8bc4C c=1 sm=1 tr=0 ts=68ff3b9b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=c4tqL6jhy99PksLA3lUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=HhbK4dLum7pmb74im6QT:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-GUID: _uHg2P6j25STGxTvERMFHCf55fHQ7Lus
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxOSBTYWx0ZWRfX+Hu1cJnHtkBW
 YooSo2n1/q7hF+lctoSwRUAXJXc/OWyaL1ZiKapXYl/6vv0DZaRliQds4vX1fLbUlA5cPY7XRCk
 KpvikkRoDNE1js261fmygDmpTRmfQGBbvzipi6gh8j+UHAujvosaxL+UTy4Ia6z1ZwAys2kFdQp
 p7mBL7SRQ7u0qxE506vzKyq8Of6lOpPuvHzrxtneBeI5gppNRO2qBYZH2aOLVpaZjvxl6v0T5kX
 w+MR//jAfU3mZKZH78VDR4mDV0pHxK2hH3YRkrU10Is5Xk6ul4KkHFoSPMexHIWJzl3WWawgzxC
 Fy7YisvPUNPD7BkcII/F9qFJ/aDgdRW6GnmCfaCUkJFfcH7T/qPHqGPeOkDbhGPFgrWBKhqYpf7
 zPtuBIWq/Yxz3haFL6vuzENbcSf3EA==
X-Proofpoint-ORIG-GUID: _uHg2P6j25STGxTvERMFHCf55fHQ7Lus
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250019
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_023012_444253_6530D42B 
X-CRM114-Status: GOOD (  18.36  )
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

This series introduces a new adaptive I/O policy for NVMe native
multipath. Existing policies such as numa, round-robin, and queue-depth
are static and do not adapt to real-time transport performance. The numa
selects the path closest to the NUMA node of the current CPU, optimizing
memory and path locality, but ignores actual path performance. The
round-robin distributes I/O evenly across all paths, providing fairness
but not performance awareness. The queue-depth reacts to instantaneous
queue occupancy, avoiding heavily loaded paths, but does not account for
actual latency, throughput, or link speed.

The new adaptive policy addresses these gaps selecting paths dynamically
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

This pathcset includes totla 6 patches:
[PATCH 1/6] block: expose blk_stat_{enable,disable}_accounting()
  - Make blk_stat APIs available to block drivers.
  - Needed for per-path latency measurement in adaptive policy.

[PATCH 2/6] nvme-multipath: add adaptive I/O policy
  - Implement path scoring based on latency (EWMA).
  - Distribute I/O proportionally to per-path weights.

[PATCH 3/6] nvme: add sysfs attribute adp_ewma_shift
  - Adds a sysfs attribute to control ewma shift

[PATCH 4/6] nvme: add sysfs attribute adp_weight_timeout
  - Adds a sysfs attribute to control path weight calculation timeout

[PATCH 5/6] nvme: add generic debugfs support
  - Introduce generic debugfs support for NVMe module

[PATCH 6/6] nvme-multipath: add debugfs attribute for adaptive I/O policy stats
  - Add “adaptive_stat” under per-path and head debugfs directories to
    expose adaptive policy state and statistics.

As ususal, feedback and suggestions are most welcome!

Thanks!

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

Nilay Shroff (6):
  block: expose blk_stat_{enable,disable}_accounting() to drivers
  nvme-multipath: add support for adaptive I/O policy
  nvme: add sysfs attribute adp_ewma_shift
  nvme: add sysfs attribute adp_weight_timeout
  nvme: add generic debugfs support
  nvme-multipath: add debugfs attribute for adaptive I/O policy stat

 block/blk-stat.h              |   4 -
 drivers/nvme/host/Makefile    |   2 +-
 drivers/nvme/host/core.c      |  31 ++-
 drivers/nvme/host/debugfs.c   | 236 ++++++++++++++++
 drivers/nvme/host/ioctl.c     |  31 ++-
 drivers/nvme/host/multipath.c | 487 +++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h      |  86 +++++-
 drivers/nvme/host/pr.c        |   6 +-
 drivers/nvme/host/sysfs.c     |   4 +-
 include/linux/blk-mq.h        |   4 +
 10 files changed, 862 insertions(+), 29 deletions(-)
 create mode 100644 drivers/nvme/host/debugfs.c

-- 
2.51.0


