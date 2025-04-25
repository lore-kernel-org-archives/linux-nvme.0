Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F90C369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 18:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fN+HCyhg/s7FlmIxaGjQXUbaWQhLgLg9dSB/7z34ucU=; b=KF6D72hfKwBa+bG8j58OOgSJWA
	LASNzV5PvqPGSLKXB/ALgbG6wiUBRasi0usFatF8BkdRiWrNZuecZrpvGGzz5qXB3W5RSgwDPGFNA
	dVZ8oHmc3aHcM6frjcMX0Lp0sMHodoufbsfTFqIL4D7SqHniMTzcVX4UHL6LN0hGGDzdm2tPAXV2E
	JUkD2LC4pDFbEYBP/97xr1GTJbWAUwcseQ9iCJgSKxTqObLVK1DNhe097KHgof+Jc0b+o9wMCka/H
	K7nKGTxgneWXYVfC2HEkQ9pGSH+3O7v5z4KJsUADKmCUnWZ0Af4u8WC1EsamW4xzlx+h9etB5kUTs
	B96eMjhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8ODs-00000000Zjc-3cUD;
	Fri, 25 Apr 2025 18:56:28 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8ODp-00000000ZjF-3LhP
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 18:56:27 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P9LRpW005345;
	Fri, 25 Apr 2025 18:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=fN+HCyhg/s7FlmIxaGjQXUbaWQhLgLg9dSB/7z34u
	cU=; b=oakv/Y/Guls/qCPtPvjCg1kLz9hKqrmhwwREyC1XBrkc1ZTR2QGrLrjsW
	cOImnHv012Qpd1FOHC+LUHoolp//UVGH1QkdwUk80QB9P5cRzKRyi1X1MxPz0OE4
	wKBxtZ/hyxBuhHV6mUwA+RfkxdGEo6Kb+r46FHXokY2G2xeryHgof8Eih+MhhzkJ
	gzF49Gztzs5/TUqVOCB6UscdKaYNG2PWD+xrOk2p8/PzmmceO0vkTSd/XQtuZC/I
	6dWYeTv5+CAXVgnmgdE8yACtLCXo0tTfMBsNNScdq4MhkdFQoCM5w77Zdq4texUb
	X++YOi9YsD5QMsyonU7nlWAuEb4LA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 467wd9n37a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 18:56:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53PGaEZW022288;
	Fri, 25 Apr 2025 18:56:22 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfxpqfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 18:56:22 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53PIuKPF46989738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 18:56:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C38E820049;
	Fri, 25 Apr 2025 18:56:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA04E20040;
	Fri, 25 Apr 2025 18:56:18 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.102.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Apr 2025 18:56:18 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, dwagner@suse.de, kbusch@kernel.org, gjoyce@ibm.com
Subject: [PATCHv3 0/4] libnvme: add support for discovering multipath of a shared ns
Date: Sat, 26 Apr 2025 00:26:05 +0530
Message-ID: <20250425185617.1242994-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TCGatDJKbanpn77gaGFvMhkI-bQyCJHg
X-Proofpoint-ORIG-GUID: TCGatDJKbanpn77gaGFvMhkI-bQyCJHg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEzMiBTYWx0ZWRfX6UpGKZMS+VPy G/c901gWs8ceuqS1TDCMlUjdNIONpzwuvmkEobLpd4H+5DSIC/WAOTBZpGLJzQjRelv+dsrg7WF Qdr2AzwAcRuzCzOqVzxQnV8kB/88lbxtVfXj7stmooby1V0Mj8alvg0c0Rizry2RWK1Mcr1DeN1
 GtJg0iQeajYXZ+n3vvrqoTLKEQL89Puqw/ZUAtDX1jg1/1RA4+nIpQPTzw0WDEU9cZlbNTNAMXh sRrEQYx9Jn8lK06+jVavx3LLFmM6ikzVcywjzPF5hucpsNnaD1RbSaACpdNpCEnuezdo2hhR8nh myVcXm/0vsYTQzCTEE7jf7GeiRdgDGPFdmx8xEqpMrZVhLJxbjDc3dYJUTpR2D+IBGVXiUEP0qI
 xIIB0bYid/rk0d7GSXxViOyz9pHDUF0KQMfPBT9JgRpXF8UHef3ZJf6957MFtEXcfo/UxQVl
X-Authority-Analysis: v=2.4 cv=M5lNKzws c=1 sm=1 tr=0 ts=680bdad7 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=VHpxXSUUm_A7q6o9S5EA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=909 lowpriorityscore=0
 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250132
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_115625_847878_C55DE495 
X-CRM114-Status: GOOD (  15.35  )
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

Recently released Linux kernel v6.15-rc1 added support for easily discovering
multiple paths to a shared NVMe namespace. This multipath information is
exposed to userspace via a new sysfs group attribute named "multipath",
located under /sys/block/<ns-blkdev>/. More details on this functionality
can be found here [1].

This patch series leverages that new functionality to discover multiple paths
to a shared namespace and exposes that information in libnvme so that it can
later be used by nvme-cli.

There are four patches in this series:
The first patch adds support for discovering NVMe paths using the sysfs
"multipath" group attribute.
The second patch adds a new "queue_depth" attribute under the NVMe path
object.
The third patch adds a new "numa_nodes" attribute under the NVMe path object.
The fourth patch extends the sysfs tree dump test to validate multipath link
support

[1]: https://lore.kernel.org/all/20250112124154.60690-1-nilay@linux.ibm.com/

Changes from v2:
    - Modified queue_depth get attribure function to always return the latest
      value insteda of cached value (Hannes Reinecke)

Changes from v1:
    - Fixed kernel version typo in the cover letter and commit
    - Updated the commit in first patch to explain the change in some
      detail (Daniel Wagner)
    - Added fourth patch to validate changes (Daniel Wagner)


Nilay Shroff (4):
  tree: add support for discovering nvme paths using sysfs multipath
    link
  tree: add queue-depth attribute for nvme path object
  tree: add attribute numa_nodes for NVMe path object
  test: extend sysfs tree dump test

 src/libnvme.map                  |   2 +
 src/nvme/filters.c               |   6 +
 src/nvme/filters.h               |   9 ++
 src/nvme/json.c                  |  90 +++++++++++++--
 src/nvme/private.h               |  11 +-
 src/nvme/tree.c                  | 191 ++++++++++++++++++++++---------
 src/nvme/tree.h                  |  25 ++++
 test/sysfs/data/tree-pcie.out    |  53 +++++++--
 test/sysfs/data/tree-pcie.tar.xz | Bin 19712 -> 12656 bytes
 9 files changed, 315 insertions(+), 72 deletions(-)

-- 
2.49.0


