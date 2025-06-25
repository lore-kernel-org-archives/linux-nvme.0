Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 665F5C7EE30
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 04:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OUy9Nb6UnUkRJdShPkX1m4czJ6/Aj8FGvD0iprhAxto=; b=K/mEZw7XC3hsPkn6t0IOdi3zm+
	ZvBLGrV6GDAxZtLqK2Uw981TSapPAQ9o7lK2F4664rxWYk4nzXuF4Nzd28zONIS41h+B2lWKFv0mj
	z8XomEkuM8QBgL2XyxJi12LhZ1bmJibXdW3dArbnkxaVdQEmHaxXdf39q6Lya8n6Owy9FDnd2Tr2S
	Z6phDQh2Z/Q8VCbejlTZOCjYbtQCnppa7sGCyeZZGNV+vZ7g3UO0u63Ft2b9elznRQWob9FgWC7pF
	lXj/6aEzT73dtfoPhhLvJEi0po630eBosqfB/aoMQOSILmAfTPvg4mYD/6qQZ831m+mH3UP/Kij57
	1BulACbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUHZm-00000007T39-3art;
	Wed, 25 Jun 2025 04:17:34 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUHZj-00000007T0j-3DiJ
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 04:17:32 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OMj2xD005375;
	Wed, 25 Jun 2025 04:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=OUy9Nb6UnUkRJdShPkX1m4czJ6/Aj
	8FGvD0iprhAxto=; b=VI/r0PFkABHRaybxHzDZxOWf5zzVMcHt9/uuxlD645HZz
	I2Pqu1jxUXKkljrXo0lyZ9O7ukwN5i9GZyUeXl0Rqc4jX4/ie9u4SnAkBAGzQzjW
	A0CzzWMc58/QWrFZOr5hIt274gwU8fDFWj1ayxXlhdDb14CGyOLxwp5IIBhrWzOn
	peIlISdUcVZqWYnGgpv5nSRrch8QlbfuY9EoMd+8zl5Me4sZXVag38zgITP1/1/y
	q8bzuCKrg1ulM4CkJF0JQtUw3lTOwHJJEpdB24UGijLQRzZsQ2/LOByvd6WoNje3
	9Q3n2rU7vU9G7gwwOiGz8lX/pP6b7DXC+Ah1k7jSA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt7dd04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 04:17:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55P1V1Mr024180;
	Wed, 25 Jun 2025 04:17:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehkrhffd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 04:17:16 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55P4HGqY029022;
	Wed, 25 Jun 2025 04:17:16 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ehkrhfem-1;
	Wed, 25 Jun 2025 04:17:16 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: linux-nvme@lists.infradead.org, rdunlap@infradead.org, kbusch@kernel.org,
        axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
        nilay@linux.ibm.com, corbet@lwn.net
Cc: alok.a.tiwari@oracle.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] nvme: typo and minor cleanup fixes across host and target driver
Date: Tue, 24 Jun 2025 21:16:29 -0700
Message-ID: <20250625041643.174110-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_01,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506250029
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDAzMCBTYWx0ZWRfX1GGPDfPQ4c3Z 23J7uimBEyeqjywG3kJZMNF3A9TnWwJkjmP/Gz3EVXiuVoSiqToKcbLIgtNQN8KRQCQ++WE/sI8 +za4nIuYyuZUCkaTMa8WOkdd9RjNBPfoNNqjfv8p/6R9StuVEMtzSsID+/XozuVmTZfniZcBXfI
 BzcQPR9LTOk6rQ2VE5ZiEXG465cEMdJdQwzGEcjeY22cC2jbvFy2/c2+4eu8nI+qhKgNZEBw0pC fQtoaI9y7D9hwqYqsBSnr/1mlh0eZWK68Vo/fWK+n7c5x8NCs6c6fVyzkX4TIZ3Gw8XQNoaPlo7 fkZkIMih4eymPBpLwzqZusi8+wtK40P02XxX0qo9q/cW0rjU/BzFHVDamDC6DxOdTcV3HUPtaH6
 DGiUHmeTVc8ThTAcyaqMew6Gn3iBnctsW24dHUVIIPBUOhqv+F6xtRVRUlGbuUwUghFgSzxt
X-Proofpoint-GUID: TIy6MbB8EIsxWjghf5pD0xloqFKfNduR
X-Authority-Analysis: v=2.4 cv=QNpoRhLL c=1 sm=1 tr=0 ts=685b784d b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6IFa9wvqVegA:10 a=bqPIn-H1XwaJnLBdygsA:9 cc=ntf awl=host:13207
X-Proofpoint-ORIG-GUID: TIy6MbB8EIsxWjghf5pD0xloqFKfNduR
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250624_211731_923141_93C448D7 
X-CRM114-Status: GOOD (  13.26  )
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

Corrected typos and grammatical errors in comments and documentation
("terminaed" -> "terminated", "limitted" -> "limited",
"glace" -> "glance" etc.)

Normalizing hex format output (x%08x -> 0x%08x).

Improving grammar in explanatory comments for better clarity.

Identifier Correction: Renamed NVME_SC_SELT_TEST_IN_PROGRESS to
NVME_SC_SELF_TEST_IN_PROGRESS to fix a typographical error and align the
status code constant with its meaning.

Removed Redundant Assignment: Eliminated an unnecessary initialization
of an error code variable in nvmet_ns_enable() to clean up unreachable
or overridden logic.

Error Message Fix: Corrected incorrect variable usage in an error
message in pci-epf.c.

No functional or behavioral changes are introduced.

v1 -> v2
Extended the underline by one more character in
nvme-pci-endpoint-target.rst as suggested by Randy
and added Reviewed-by: Randy Dunlap for series.


Alok Tiwari (5):
  nvme: Fix multiple spelling and grammar issues in host drivers
  nvme: Fix incorrect variable in io cqes error message
  nvmet: Remove redundant assignment of error code in nvmet_ns_enable()
  nvme: Fix typo in status code constant for self-test in progress
  docs: nvme: fix grammar in nvme-pci-endpoint-target.rst

 .../nvme/nvme-pci-endpoint-target.rst         | 20 +++++++++----------
 drivers/nvme/host/apple.c                     |  4 ++--
 drivers/nvme/host/constants.c                 |  4 ++--
 drivers/nvme/host/core.c                      |  2 +-
 drivers/nvme/host/fc.c                        | 10 +++++-----
 drivers/nvme/host/nvme.h                      |  2 +-
 drivers/nvme/host/pci.c                       |  2 +-
 drivers/nvme/host/rdma.c                      |  2 +-
 drivers/nvme/target/core.c                    |  2 --
 drivers/nvme/target/passthru.c                |  4 ++--
 drivers/nvme/target/pci-epf.c                 |  2 +-
 drivers/nvme/target/zns.c                     |  2 +-
 include/linux/nvme.h                          |  2 +-
 13 files changed, 28 insertions(+), 30 deletions(-)

-- 
2.46.0


