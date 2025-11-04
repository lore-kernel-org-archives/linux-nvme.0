Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7F5CCFA04
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 10:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lz1pNnjdWkRPI3gBQdwqRapjeCbIsOqVSpbiOYXr4sA=; b=vqCzTyyPM0jZCk1tPa4ABRk4IW
	zVzbJi1higOEFUqd9w4VjsK4inQIM+SpGbqwrZTonJLn/WTtFbqy1JqblfBtUB2qp3uxYXT7Ln7ip
	OO17w0bMLgg6hXREDlZhMObZ9C2niOiJEyuqd4WPEu/QUPPHhBqMaOu3F/ZXxg3kewNn4go3GJbqG
	2xwmfyT/kaakywki/i/yQXvWhl+GfiYalhIdUz9lq9VbPDS65kyK8Akobq/xNCtD25m46dga1XHEu
	cIJAOqupfqYCQv72c9z7keQ3uF56EWVVqqBD/dW8mzgTxME0WB42Vjs6xJwKmuUNtrNEgJQKQAP92
	TjsO5OeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEXv-0000000BdoO-03FO;
	Tue, 04 Nov 2025 10:45:51 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEXr-0000000BdnZ-3eFS
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 10:45:49 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A45Vm1H031322;
	Tue, 4 Nov 2025 10:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=lz1pNnjdWkRPI3gBQdwqRapjeCbI
	sOqVSpbiOYXr4sA=; b=DDCnM5Gvtn0UshzjpNoRdQzb4sq2T9PGgT4EzhDmMMZO
	EeWBF3/aYdwobqMJMVArqYJH0SRP5bZ/4TUzOl6SQrTNIXvvPFVJNd7LVvfF6TS8
	eS1wFEceoHEj6dOi1L/1ehudinqFzixQUH4mxlAYlJ+JYU11dU0Fl/ikC0jn0WPr
	B1aAPdpqKW++UuyvoXscVDOUdqQTiLdmpTNcOaVA4liuqI4F/FrOpWPk1rhmDXF5
	BJyQab7s3p+7RfMh6hgygHGVpkds5Mts3j+tRI26EW7tmZiUjwC0boO/1OAoysXv
	nYT/5tFgTAN+cK0BX+KGLNtIoP0Zvg/ksep9W7BP0Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59vubd3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 10:45:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A46eLsA018804;
	Tue, 4 Nov 2025 10:45:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5whnajdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 10:45:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A4AjalS51183936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Nov 2025 10:45:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C865E20043;
	Tue,  4 Nov 2025 10:45:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4FB72004B;
	Tue,  4 Nov 2025 10:45:34 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.245])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Nov 2025 10:45:34 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        dwagner@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: [RFC PATCHv4 0/6] nvme-multipath: introduce adaptive I/O policy
Date: Tue,  4 Nov 2025 16:15:15 +0530
Message-ID: <20251104104533.138481-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bYM1Wg2zRUefeoBErzgEhmf0JoQG2sKg
X-Proofpoint-GUID: bYM1Wg2zRUefeoBErzgEhmf0JoQG2sKg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX01Gb2BE4qIJX
 lUMPi15lu9nIZSJ9b8s83C38qxTKF61fB7JvBJiqSx2L1lCzLgBCjECi2Jshfcl3Ihq+CnxBGMG
 gGmS+Fb7tedSK8MyuHewagpkx0ngNYKF87cW76zUPUuN0nu7VaUdVEQ52kzwWjBg1gJxpX+hcEV
 9iQozhEZB6pAPtful0hQR7lMbAmFXX3R/u9Dcr6F8V2uHClppq74PSBusrzVTZ6L3sAhSFN0SX4
 SpQ2Fqy0V/SeoJ88gwTmnvARE7W8sfQwq/eZn999ufoOHwAF07fTl0UhPh2aac2r29SbEta93Qc
 9xJ9WiI32XzFdL8uxUAlA3pBihq2rh378xxmgizE4rUvuqFPB22MG6/TCcadHQlB/ycEb0g89yJ
 qg3oSCjZcnrQfd7Wr0YAm3Nvb3j0/A==
X-Authority-Analysis: v=2.4 cv=U6qfzOru c=1 sm=1 tr=0 ts=6909d954 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=-E36bldeX9-4_nm2YjoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=HhbK4dLum7pmb74im6QT:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511010021
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_024547_949470_6A7B58E3 
X-CRM114-Status: GOOD (  19.25  )
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

[PATCH 3/6] nvme: add generic debugfs support
  - Introduce generic debugfs support for NVMe module

[PATCH 4/6] nvme-multipath: add debugfs attribute adaptive_ewma_shift
  - Adds a debugfs attribute to control ewma shift

[PATCH 5/6] nvme-multipath: add debugfs attribute adaptive_weight_timeout
  - Adds a debugfs attribute to control path weight calculation timeout

[PATCH 6/6] nvme-multipath: add debugfs attribute adaptive_stat
  - Add “adaptive_stat” under per-path and head debugfs directories to
    expose adaptive policy state and statistics.

As ususal, feedback and suggestions are most welcome!

Thanks!

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

Nilay Shroff (6):
  block: expose blk_stat_{enable,disable}_accounting() to drivers
  nvme-multipath: add support for adaptive I/O policy
  nvme: add generic debugfs support
  nvme-multipath: add debugfs attribute adaptive_ewma_shift
  nvme-multipath: add debugfs attribute adaptive_weight_timeout
  nvme-multipath: add debugfs attribute adaptive_stat

 block/blk-stat.h              |   4 -
 drivers/nvme/host/Makefile    |   2 +-
 drivers/nvme/host/core.c      |  22 +-
 drivers/nvme/host/debugfs.c   | 335 ++++++++++++++++++++++++++
 drivers/nvme/host/ioctl.c     |  31 ++-
 drivers/nvme/host/multipath.c | 430 +++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h      |  87 ++++++-
 drivers/nvme/host/pr.c        |   6 +-
 drivers/nvme/host/sysfs.c     |   2 +-
 include/linux/blk-mq.h        |   4 +
 10 files changed, 895 insertions(+), 28 deletions(-)
 create mode 100644 drivers/nvme/host/debugfs.c

-- 
2.51.0


