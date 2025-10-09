Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280B2CCA470
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Oct 2025 10:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rwqwlIKikluPF+B0DwbZhi7c/ZlRQoeKrnbCJ9QIRPc=; b=qNtsAY9qna1GHftztgUVRXphil
	EmMuWaR36QnfRMA/lAUappZKghlg6TkWLxf8cwpHXr1TAY/GuiHNCJzz5k0iz1SMWjjn58Fb590qG
	ahpNNKfOxaPYdE8lg/OcUWBqStN62V68ffC4C0HpQL58rm8q1oSl7TaEPwJ1R4pfl+WLVAtmWkUvb
	IuKeTM2wfA4BV0LFMUk3QGIsh4txgEKywHCHX+ej7rwijJNzR5w/do6i0wPqFBamZ+5qsisjYlc/c
	ytFcpwIsb4hk/PWPLBjVZcnziZt3cH9gQGS8CUwi1ZgnJ9HAlH66aU/qC4EIksvgs+fvmJTlitKAs
	8jyylLTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6nXT-00000005jZA-43Q0;
	Thu, 09 Oct 2025 10:06:23 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6nXQ-00000005jXk-0Uar
	for linux-nvme@lists.infradead.org;
	Thu, 09 Oct 2025 10:06:22 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5995wK8S014540;
	Thu, 9 Oct 2025 10:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=rwqwlIKikluPF+B0DwbZhi7c/ZlR
	QoeKrnbCJ9QIRPc=; b=ZsfL5iHoMlcx/riQQbiTSE5mdc7F01Ypw+IdP4G40T2N
	HZMCpVf6EnELM8tlDIUUVcttVcRhAb/HAcxazMGNyvL0+jpNQHw9QVeIlp3AkAv5
	GDLhNozh0XCqaM3d1GglSxqBUtCe13lXxA+m8xJXXaEuWUG/zmcNUkOs6vDgxHwX
	CKmo6O6aL3nmp+jtHedlUjFicPsh3QQ4g+lPwbzuepx3jIa7ynlLzfMjtEnkKQ/J
	EUR55Pv82kdydVmW9s58hQFBtTJWHLDVSe4OPfFGXJL5i8gkG9BSp0VtH2gZ/WCC
	j8iXpuPSKF2zkeqXD5MbgIiRAlhTptebbTWjaxuMRg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv84m1s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 10:06:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5998EvCs026053;
	Thu, 9 Oct 2025 10:06:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49nvamkwu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 10:06:14 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 599A6CGC33030614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Oct 2025 10:06:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6735120088;
	Thu,  9 Oct 2025 10:06:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0870620087;
	Thu,  9 Oct 2025 10:06:11 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.200])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Oct 2025 10:06:10 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, axboe@kernel.dk,
        dwagner@suse.de, gjoyce@ibm.com
Subject: [RFC PATCHv2 0/4] nvme-multipath: introduce adaptive I/O policy
Date: Thu,  9 Oct 2025 15:35:22 +0530
Message-ID: <20251009100608.1699550-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HKPO14tv c=1 sm=1 tr=0 ts=68e78917 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s2JoJq24bkZd9Ia6FsUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=HhbK4dLum7pmb74im6QT:22
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-GUID: DbrRh5g5SMXoxDdDQyK_e_TtEVeeHAOQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX695UsNOEBvaI
 mxijp2DkwmplFR5wDrrlZJMfqd4FMXhqTP4c8Q3UAocH+2Mywk37d8dGePmwyKC1ecBVYuW7xYm
 gi5TGmrfgRXzaTdlNpR6NyxkD6hzP42gxTthb1veSWhrFyBKRntDrz3KVOkvl9lNhtmLtWVQh+t
 431TCQiwqa53OUkTf0+3i9XT7ZTSs+8Ap9W17JSYegG9Zn/OrwBNdK46HxuLz+ZZtySYhyy/asL
 AEde2OJN4QZOQS2td9TnUjjsqiA44XzI9lYiqxXxWrkz9eLwj1ATgjefU18dEP0fRCayHQgMniJ
 /2KRfjNzT+oAisdsmq0RpMUl3sa+Je6bqKu2eMwbsuo0Z7ZDM44xcAdqA8GeYKNSJTUppGVVQ1j
 XqB7M+ZSpVWHe7Oi7RQLlHSmkm01+Q==
X-Proofpoint-ORIG-GUID: DbrRh5g5SMXoxDdDQyK_e_TtEVeeHAOQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251009_030620_271651_4131ADEE 
X-CRM114-Status: GOOD (  17.85  )
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

This pathcset includes totla 5 patches:
[PATCH 1/4] block: expose blk_stat_{enable,disable}_accounting()
  - Make blk_stat APIs available to block drivers.
  - Needed for per-path latency measurement in adaptive policy.

[PATCH 2/4] nvme-multipath: add adaptive I/O policy
  - Implement path scoring based on latency (EWMA).
  - Distribute I/O proportionally to per-path weights.

[PATCH 3/4] nvme: add generic debugfs support
  - Introduce generic debugfs support for NVMe module

[PATCH 4/4] nvme-multipath: add debugfs attribute for adaptive I/O policy stats
  - Add “adaptive_stat” under per-path and head debugfs directories to
    expose adaptive policy state and statistics.

As ususal, feedback and suggestions are most welcome!

Thanks!

Changes from v1:
  - Ensure that the completion of I/O occurs on the same CPU as the
    submitting I/O CPU (Hannes Reinecke)
  - Remove adapter link speed from the path weight calculation
    (Hannes Reinecke)
  - Add adaptive I/O stat under debugfs instead of current sysfs
    (Hannes Reinecke)  
  - Move path weight calculation to a workqueue from IO completion
    code path

Nilay Shroff (4):
  block: expose blk_stat_{enable,disable}_accounting() to drivers
  nvme-multipath: add support for adaptive I/O policy
  nvme: add generic debugfs support
  nvme-multipath: add debugfs attribute for adaptive I/O policy stats

 block/blk-stat.h              |   4 -
 drivers/nvme/host/Makefile    |   2 +-
 drivers/nvme/host/core.c      |  13 +-
 drivers/nvme/host/debugfs.c   | 239 ++++++++++++++++++++
 drivers/nvme/host/ioctl.c     |   7 +-
 drivers/nvme/host/multipath.c | 400 ++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  55 ++++-
 drivers/nvme/host/pr.c        |   6 +-
 drivers/nvme/host/sysfs.c     |   2 +-
 include/linux/blk-mq.h        |   4 +
 10 files changed, 705 insertions(+), 27 deletions(-)
 create mode 100644 drivers/nvme/host/debugfs.c

-- 
2.51.0


