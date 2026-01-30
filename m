Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E760E6BF30
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 18:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6iIRBk8PsIfO0bGy5vZkvJ5MMgdjEtS+rFbcBCh1Jp0=; b=ZJDv+imf1/C67PaPE7OQXkHGeD
	V8/wCdr7lofJ8O/rbwKLEDLwHAzRdnW2hBGgQjo/9uVKhrzMEXdFAcGKKxI6gwUyUqeXq2bAD8Ix3
	G74DgdAmZWIXTuYd0OSzm4FfPqmrzL0ghs1qPQErtTgBKztbiJN41wVM/im/KZxvJGHrCfqDzEu5b
	44675SL+26Ik6ThzdzkOrTNdX3Y8rWv6IOyO/q/KZRAorli0XtFXgf8CBD5FR74al0QVlAI5xDwWz
	HBvq+zeVntgXea5gy2Gvb++ZVwz94N00yOpq12G7ldtXkUmHGH6SW+PEHzWwpfCKwZyBrWjDZkLE0
	sE8Doolg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlt7I-00000001oyk-0wKy;
	Fri, 30 Jan 2026 18:21:12 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlt7A-00000001oxY-3AVm
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 18:21:06 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60UGOsig015530;
	Fri, 30 Jan 2026 18:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=6iIRBk8PsIfO0bGy5vZkvJ5MMgdjEtS+rFbcBCh1J
	p0=; b=svPO7TPvzPTJjdMPGLFnq7ovCSpKNhphKvkaT1To2l9bl/z8XDYyTfF0g
	MS5fdSzT9uBOqxRGBZrFIw8dikNMXx6GvDyg1lBX/iDcXEj2yob/QFVNHDtzqXyM
	2K7TUOBT59mDHcYW9ZIwGGY+/2755RWw+1sgPCvxJefvdQY8Ch6GRfui82AbEg+Z
	WFw/736nt8SFqq/7CMg8iVdBpj9OaTiJn5aGEvDr8lUGP0TeNf23zeGsO1lnhoOs
	YYIf0V0bLwTP0kFj5Pc8N6a8BCEDRLJbae5yJ5zsSgSVZkNa9VQF+4D3NeE2SjUi
	NPoA7meu44louW+fumJN45rVGCeGA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnt87d6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 18:20:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60UG5inT026357;
	Fri, 30 Jan 2026 18:20:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9wkq95j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 18:20:49 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60UIKjWY40894836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 18:20:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 792262004B;
	Fri, 30 Jan 2026 18:20:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 384C420040;
	Fri, 30 Jan 2026 18:20:41 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.87.154.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 30 Jan 2026 18:20:40 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 0/7] nvme: export additional diagnostic counters via sysfs
Date: Fri, 30 Jan 2026 23:50:17 +0530
Message-ID: <20260130182028.885089-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N15RRS2RJBvk_gQuzXoihBlir34kl-Xr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDE1MCBTYWx0ZWRfX/A0Nqs+U5mjz
 Mhf/AUjxEfgki8KVuPyH/YviCsuJhwWuAx4GXdn3p9jfQvrECBdgai8hGOxKo6A9sHjQ0qSUi1u
 c38P+Fx0znf0lVcNwGdUbQCPJ9oFxhTQnH390OGspdMiK8T5DucdgTWASEsT06QXqxl7ZFK7+lo
 4CCl1mCqRvgFI8eJgNK1Ryiijllnp3qgqiMj74vZvKKmURBWQNhwlkPnHAV/37id5Pywp+2rfy1
 R41vZvy8yJpe9OX+GNGK4jnCU8a/Cj5iIZqy8wbj3G3953gfhtvVkoIrE2yuflXwsYUJqyhJpa+
 xWboAU4J0ufO02QXDW4dxzGzM9S48qBUVhOUCowEwMCw4Q37ELZZQHcwQVB3AtCoWc6Tz8tUK7k
 +18P81JOPxzVhmX1BZngRiBsJKfDefmqRnO+GAKXmfau/bUhbkV8Gn09okKqjLyGeUGbcuxhCwP
 MlrpjPje3dbi1VtUe2Q==
X-Authority-Analysis: v=2.4 cv=Zs3g6t7G c=1 sm=1 tr=0 ts=697cf682 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=y4OcVJxQ2b40wQSunWoA:9
X-Proofpoint-ORIG-GUID: N15RRS2RJBvk_gQuzXoihBlir34kl-Xr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601300150
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_102104_792880_64CC9797 
X-CRM114-Status: GOOD (  11.00  )
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

Nilay Shroff (7):
  nvme: export command retry count via sysfs
  nvme: export multipath failover count via sysfs
  nvme: export command error counters via sysfs
  nvme: export I/O requeue count when no path is available via sysfs
  nvme: export I/O failure count when no path is available via sysfs
  nvme: export controller reset event count via sysfs
  nvme: export controller reconnect event count via sysfs

 drivers/nvme/host/core.c      | 23 ++++++++-
 drivers/nvme/host/multipath.c | 32 +++++++++++++
 drivers/nvme/host/nvme.h      | 12 ++++-
 drivers/nvme/host/sysfs.c     | 90 +++++++++++++++++++++++++++++++++++
 4 files changed, 154 insertions(+), 3 deletions(-)

-- 
2.52.0


