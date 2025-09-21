Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD58CAC5A8
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Sep 2025 11:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DB+Cu6o0APypUbonUqJJtksxbSSOsn8JCDF84Kqsafc=; b=KShf7uqo0jgUllSBoulZSKbhgU
	yaOcgG0ZXohezy/KzzI/obThyw4ZFWQm7R0v+ClGqrn2q3SyDu5XGtfRo9/reASRO85itNWyuCt01
	sMhsRitnjBY1vMNGBG4KZuhSTOa5kJxGW45fSeJZQUVm6pw0hzeQWs7T99iQWVn7lJ9QVkjY5l697
	PX0KORtbYJSllbtrsZCAQ+CR9daKaewPjVzjyOARMsJ+bKnmszvNu9xvUQN/rkKhdb0VpxYbltRgq
	IaBCkgPtHVY6BRgKpfNVzPCvFydsD2yNRrFg9RkNpqTZVcXatK9X+07E9hsyuXsidZNjTm9YzI6Yj
	qMq5GtNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0I0A-00000007MSY-2KYf;
	Sun, 21 Sep 2025 11:13:06 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0I07-00000007MQg-0gGJ
	for linux-nvme@lists.infradead.org;
	Sun, 21 Sep 2025 11:13:04 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58L4U60t005831;
	Sun, 21 Sep 2025 11:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=DB+Cu6o0APypUbonUqJJtksxbSSO
	sn8JCDF84Kqsafc=; b=K6RK/jkbZoEpGXSZsBMzuEKHTtNw1fJg1n9ZhUaZY6Ct
	cfspkZwudSOwph/HwW66+iWzR2p6Vnke1OKdf37LLJzUq3SboECdPLH5SZkBtwc7
	8skq/2xPcS12daRhFWcXqmincDXHkClAF4qRzCUFdAEfM73ntaww2ZDaCagalPVS
	Q8JitbNOefK/opeptj1H+mrmXmJ7iR1DQ08ka6tvhgWNzHWzR7JGQ9GrNcF0H/ED
	t7GME7RUNVY64Z+003M1GlU5BCnWYmTKfzz7aIny+UGQmoai3kD9g4n3KF8TuCSu
	WaA/qlijOij6oUCgnJE0JeDJpATnauwJWifjLIemWg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499n0j566m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 11:12:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58L8nuDH030367;
	Sun, 21 Sep 2025 11:12:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a0s79f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 11:12:40 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58LBCdJL42598870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Sep 2025 11:12:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3EAF2004D;
	Sun, 21 Sep 2025 11:12:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84DC520040;
	Sun, 21 Sep 2025 11:12:36 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.45.7])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 21 Sep 2025 11:12:36 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        hare@suse.de, dwagner@suse.de, gjoyce@ibm.com
Subject: [RFC PATCH 0/5] nvme-multipath: introduce adaptive I/O policy
Date: Sun, 21 Sep 2025 16:42:20 +0530
Message-ID: <20250921111234.863853-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX/2nFwYUa/vl7
 BuKj2qWR4aaVTrTeg5Q+XivTrsNBTJ7s9DpszQYzl3u0n7mlFGHxN+uGQAs8LWgFRyqtlBSJoE3
 0GNJVB4fE/FKXddtfxr5s/4i0YytnZK2v3YKC+rwkbS+2h0lAcoo1vf7HHeRxYYvaZrAdPj0Pag
 Ga50YBAMRugDjMwTjEAJPrZ3kpK7tsrKuJacyPdqfmEmuLQBfDevm6Tq5JUKcewFAaHuv2/OIMh
 RolhvbsxPqcgArdFQWrLnrcXJrmef5DSx5Cb7x5HrqEh4YGVuX4yoCWsnyh9N0xJgi9621B/sJ4
 XoxrzwmlqB6gXShWIrIh4FMqd7VxZeegyXasKaqvVejPRvtD9inbri/li+36oN6ZsEin/sVuIhy
 pW1Cx9Tz
X-Authority-Analysis: v=2.4 cv=TOlFS0la c=1 sm=1 tr=0 ts=68cfdda9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=K3iqpqGGxfkY350c-uMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HNC17yATtusSIGoYcu6f7Cdl4i_qjEjf
X-Proofpoint-GUID: HNC17yATtusSIGoYcu6f7Cdl4i_qjEjf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_041303_208023_A54AE1E1 
X-CRM114-Status: GOOD (  16.56  )
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
multipath. Existing policies—numa, round-robin, and queue-depth—are
static and do not adapt to real-time transport performance. The numa
selects the path closest to the NUMA node of the current CPU, optimizing
memory and path locality, but ignores actual path performance. The 
round-robin distributes I/O evenly across all paths, providing fairness
but not performance awareness. The queue-depth reacts to instantaneous
queue occupancy, avoiding heavily loaded paths, but does not account for
actual latency, throughput, or link speed.

The new adaptive policy addresses these gaps selecting paths dynamically
based on measured I/O latency and, for fabrics, the negotiated link 
speed. Latency is derived by passively sampling I/O completions. Link
speed is queried from the adapter and factored into path scoring. Each
path is assigned a weight proportional to its score, and I/Os are then
forwarded accordingly. As conditions change (e.g. latency spikes,
bandwidth differences), path weights are updated, automatically 
steering traffic toward better-performing paths.

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

This pathcset includes totla 5 patches:
[PATCH 1/5] block: expose blk_stat_{enable,disable}_accounting()
  - Make blk_stat APIs available to block drivers.
  - Needed for per-path latency measurement in adaptive policy.

[PATCH 2/5] nvme-multipath: add adaptive I/O policy
  - Implement path scoring based on latency (EWMA).
  - Distribute I/O proportionally to per-path weights.

[PATCH 3/5] nvme-multipath: add sysfs attribute for adaptive policy
  - Introduce "adp_stat" under nvme path block device.
  - Provide observability of latency, weight, and selection stats.

[PATCH 4/5] nvme-tcp: export NIC link speed
  - Retrieve negotiated link speed (Mbps) from the adapter.
  - Expose via sysfs for visibility/debugging.

[PATCH 5/5] nvme-multipath: factor link speed into path scoring
  - Adjust adaptive path weights using link speed as a multiplier.
  - Favor higher bandwidth links while still considering latency.

Currently, link speed reporting is implemented only for TCP NICs.
Support for Fibre Channel adapters will follow in a future patch.

As ususal, feedback and suggestions are most welcome!

Thanks!

Nilay Shroff (5):
  block: expose blk_stat_{enable,disable}_accounting() to drivers
  nvme-multipath: add support for adaptive I/O policy
  nvme-multipath: add sysfs attribute for adaptive I/O policy
  nvmf-tcp: add support for retrieving adapter link speed
  nvme-multipath: factor fabric link speed into path score

 block/blk-stat.h              |   4 -
 drivers/nvme/host/core.c      |  10 +-
 drivers/nvme/host/ioctl.c     |   7 +-
 drivers/nvme/host/multipath.c | 441 +++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h      |  38 ++-
 drivers/nvme/host/pr.c        |   6 +-
 drivers/nvme/host/sysfs.c     |  12 +-
 drivers/nvme/host/tcp.c       |  66 +++++
 include/linux/blk-mq.h        |   4 +
 9 files changed, 562 insertions(+), 26 deletions(-)

-- 
2.51.0


