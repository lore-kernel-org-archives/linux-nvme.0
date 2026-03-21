Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12F51094486
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Mar 2026 15:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PO0OAhTwUcc7iyq49ZVsV8WpgB6fLkKk2j3HnDqxBX8=; b=4KQ9oKdumdPVNBbZr1TDU4Lkvs
	h8Nt8jpOS7bbh3jdNrgmJcv+sVMcNHhN1HRl+4Y45gcxrN/wB3JnZjqRnNJ5NhzmLOjyxZrdPvZ5U
	hiQy9XdvtiYjpvF81tTezK7tHRXwW7FGNOpgQlQ01Lb+jD4khWCMchXSRxe+hKXtiF0AkTUCIs8Er
	zOLxYXkU73mWvrBVajFI0hsBW1HIQ/DOM1yMq2kJ5oMJ+sStaCqZYCAcqE/em1xwb0YJSOKvh4tt9
	tH/qC2Tl0X70+CEpseDdCe3naH400nxIAqWpdf8uP20DDUv4JsTx3px6KDjCfqfzWIeut/1uh/w5w
	lQoqjg/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3yFv-0000000Ea22-0n34;
	Sat, 21 Mar 2026 15:28:51 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3yFo-0000000Ea0H-2gGl
	for linux-nvme@lists.infradead.org;
	Sat, 21 Mar 2026 15:28:46 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62LDx2dS980479;
	Sat, 21 Mar 2026 15:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=PO0OAhTwUcc7iyq49ZVsV8WpgB6fLkKk2j3HnDqxB
	X8=; b=eVx8wPLhxY1GjyhPV1bPwUxnEMmvx+d1hDo6r7KBoeDW5Xv0eXGj6RfVj
	ptGvajGKDDOkigkzCeeNsOiRpEzmmqsyJT8qK1XoImePrQThyxMpv8dq096bhW6C
	FHCNLGkUBTAIFH/OYB8t+uyebLmAqdZzGoG0NeDBPMoHBT8tgFSQ08e/tkNTfIRr
	Fwibo0B4QHY/Xs5qKlIplbSXrET2bleO3H57Y6+1XGwob4Cj0e2KDreblxUGAyMH
	kmoGMOmSX7Q+aPd803bmvWuSp5mWjhuSAwinlc6fn5BK5sQL7O2BPuz+1UXGFMLp
	yzhANEdUmYFQNs5ylWiwDNz2ylTtA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxys66a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 15:28:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62LA5P66012760;
	Sat, 21 Mar 2026 15:28:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq1upyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 15:28:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62LFSYXf45547958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Mar 2026 15:28:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5241B20049;
	Sat, 21 Mar 2026 15:28:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E24E920040;
	Sat, 21 Mar 2026 15:28:31 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.124.222.150])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Mar 2026 15:28:31 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
        gjoyce@ibm.com, wenxiong@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 0/9] libnvme: add support for retrieving additional NVMe stat
Date: Sat, 21 Mar 2026 20:57:59 +0530
Message-ID: <20260321152823.3197870-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDEyOSBTYWx0ZWRfX/CPkGcFACj8+
 hh5VBjriqwH/A9/23Eksg2hyD8A5Gbw7xWaOhTPBug9gSt2KfUXTA3uXkJVV5XxzUpj/xfkVPUU
 +YYQTkFnijj3cgamY/KbR0062fr0D/xhDGf2161NlvXfl7LZufg1rVjyjTGh8Gr0Y+pk2E3veE8
 ngIg5HXnLiJyg6eSVepAOehqJbSJfTfoCGecPapRHmZu08Jbus1VwV6ZjAr67aIUi7ZU33+hb77
 /dY4HAymaLIboJWldD0Mr6H1sekkqrHgKD0JimQh9iDs19jlqhWu0e0vOctnONocyEXBIWM4rSo
 N+Tp2MZ5LP6qeWk2eJedKHhEMYQA+i0jMZog+RfP2iAFaW12Xyh3Y8u7VN0/e6pkAoWaZlFIrnH
 gFHgXWdMcGcJoKnSUSb0BmYTutTTEmnPAaIah67cGPDFhYabHfXqVufl2TdYlXjCHe7yZy6J0uq
 jxetaWjpuAX7O9rjpPw==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69beb927 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=xxtA3AYBEPDFT9ljYxMA:9
X-Proofpoint-ORIG-GUID: gviD5p1EtNnN0hD1IqHgb3jp9ULj37KH
X-Proofpoint-GUID: gviD5p1EtNnN0hD1IqHgb3jp9ULj37KH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_05,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603210129
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_082845_160262_4E2194F8 
X-CRM114-Status: GOOD (  11.72  )
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

Certain NVMe attributes and statistics can change dynamically at runtime.
However, the current libnvme implementation caches attribute values while
scanning and building the topology. Subsequent libnvme API calls return
these cached values.

While this approach works well for one-shot nvme-cli commands, it is not
suitable for use cases that require upto date information. In particular,
real-time monitoring tools such as nvme-top require access to the latest
(non-cached) values of such attributes.

To address this, this patchset introduces support for retrieving
non-cached values for selected attributes whose values may change
dynamically. The first three patches disable auto-generated accessors
for ana_state, numa_nodes, and iopolicy using "!accessors:none", and
provide custom implementations that always return the latest values.

In addition, libnvme lacks support for retrieving gendisk statistics, which
provide useful insight into disk activity (e.g., number of I/Os processed,
time spent servicing I/O, and in-flight I/O counts). This patchset adds
support for retrieving gendisk I/O statistics for both per-path and namespace
gendisks.

Finally, this series adds support for retrieving diagnostic counters at 
different levels, including per-path, namespace, nshead, and controller.
These counters should improve visibility into NVMe native multipath behavior.

All of the above statistics and counters can be leveraged by tools such as
nvme-top to provide real-time monitoring and analysis.

As usual, feedback and suggestions are welcome!

Nilay Shroff (9):
  libnvme: annotate nvme_path::ana_state with !accessors:none
  libnvme: annotate nvme_path::numa_nodes with !accessors:none
  libnvme: annotate nvme_subsystem::iopolicy with !accessors:none
  libnvme: add support for retrieving per-path gendisk I/O statistics
  libnvme: add support for retrieving namespace gendisk I/O statistics
  libnvme: add support for per-path diagnostic counters
  libnvme: add support for namespace diagnostic counters
  libnvme: add support for nshead diagnostic counters
  libnvme: add support for ctrl diagnostic counters

 libnvme/src/accessors.ld     |   6 -
 libnvme/src/libnvme.ld       |  36 +++
 libnvme/src/nvme/accessors.c |  39 ---
 libnvme/src/nvme/accessors.h |  47 ---
 libnvme/src/nvme/private.h   |  46 ++-
 libnvme/src/nvme/tree.c      | 551 +++++++++++++++++++++++++++++++++++
 libnvme/src/nvme/tree.h      | 314 ++++++++++++++++++++
 7 files changed, 944 insertions(+), 95 deletions(-)

-- 
2.53.0


