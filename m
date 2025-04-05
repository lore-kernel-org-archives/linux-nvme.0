Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D939C36010
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Apr 2025 13:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/EaZbeyYI8dgCRPhyICOM4B0iUPyuNT8wroSf5SbNUg=; b=wY5eTSi9ev7c9S1cn5IOZgUhxF
	hr95/zl2iAW9Njtc+KR1JURb9JlouqDSM3P4maageR8qNI/s1BfmDkrpf3w3cei4xK/Dzw8QT4JTb
	82YpT0N/ocfmUyI1QdLJaAhGqRFpaRx42YRW8q6NMmGiXlVB1K2sZck6b95bYTrKHs8TWs9ZD4wor
	it0zh8lJtcuzbaXTUkARRTjUKct1qHpGi0sDe2Car+v4MoPKgotBbQqgu3IzmLvcp/35MqTZvaR19
	bd3+dId2OnST5+AN1gHjA1DgYkYRWHnolHSOoWH8Eses1gdmMHiPnw0VH3e71qZtR1yJQ5h5Q5W50
	bdMH1mJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u13B8-0000000Dy7j-0nJJ;
	Sat, 05 Apr 2025 13:03:18 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u13B2-0000000Dy76-084Q
	for linux-nvme@lists.infradead.org;
	Sat, 05 Apr 2025 13:03:13 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 535BtmSH005834;
	Sat, 5 Apr 2025 13:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=/EaZbeyYI8dgCRPhyICOM4B0iUPyuNT8wroSf5SbN
	Ug=; b=dvwLm7Fe7VPWP0maqUKi7JEnhISj2SE+rPlchPF75est1zgS1gjhY6yQu
	ZzAaPE/CY7YS9FFtEF2odDkiLdYQtSJy7pyVkF83wBj/i4nj3WBW3per4Rv0ORG2
	jZNyPa5Ruv1S10YOEuQm4rw7439WLX+rr7EFdUvxR5emkRBXP4SetBmLDPNnOYR7
	m10RuYgfLEWgnSZMkYrsRqOW6vuRAyMPaLrJeYKfBZ+uW5X6u5OTaD+nLn45jR5W
	MnWQ8IR6fCcfUKb70kMKFgE1nt0hF2+xq4xwV0BEKIE8+PYEYMOvP+Na2n8siV3L
	vbwqePrMEAmaX+ttoTC9+/R94taog==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45tvw99fgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Apr 2025 13:03:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 535ABusc002667;
	Sat, 5 Apr 2025 13:03:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45t2e6ff99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Apr 2025 13:02:59 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 535D2wkk51052842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 5 Apr 2025 13:02:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A99920043;
	Sat,  5 Apr 2025 13:02:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83F2620040;
	Sat,  5 Apr 2025 13:02:56 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.30.151])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  5 Apr 2025 13:02:56 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@kernel.org, kbusch@kernel.org, gjoyce@ibm.com
Subject: [PATCH 0/3] libnvme: add support for discovering multipath of a shared ns 
Date: Sat,  5 Apr 2025 18:32:46 +0530
Message-ID: <20250405130255.448345-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sIFMlwF3OdzWVZkSfQk_B2RX41Ln0bjU
X-Proofpoint-GUID: sIFMlwF3OdzWVZkSfQk_B2RX41Ln0bjU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-05_06,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 mlxlogscore=564 phishscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504050080
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250405_060312_080593_938D358E 
X-CRM114-Status: GOOD (  11.46  )
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

Recently released Linux kernel v6.14 added support for easily discovering
multiple paths to a shared NVMe namespace. This multipath information is
exposed to userspace via a new sysfs group attribute named "multipath",
located under /sys/block/<ns-blkdev>/. More details on this functionality
can be found here [1].

This patch series leverages that new functionality to discover multiple paths
to a shared namespace and exposes that information in libnvme so that it can
later be used by nvme-cli.

There are three patches in this series:
The first patch adds support for discovering NVMe paths using the sysfs
"multipath" group attribute.
The second patch adds a new "queue_depth" attribute under the NVMe path object.
The third patch adds a new "numa_nodes" attribute under the NVMe path object.

[1]: https://lore.kernel.org/all/20250112124154.60690-1-nilay@linux.ibm.com/

Nilay Shroff (3):
  tree: add support for discovering nvme paths using sysfs multipath
    link
  tree: add queue-depth attribute for nvme path object
  tree: add attribute numa_nodes for NVMe path object

 src/libnvme.map    |   2 +
 src/nvme/filters.c |   6 ++
 src/nvme/filters.h |   9 +++
 src/nvme/private.h |  11 ++-
 src/nvme/tree.c    | 184 ++++++++++++++++++++++++++++++++-------------
 src/nvme/tree.h    |  25 ++++++
 6 files changed, 184 insertions(+), 53 deletions(-)

-- 
2.49.0


