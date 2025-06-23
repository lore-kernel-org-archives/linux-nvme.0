Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A426C7EE2E
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jun 2025 06:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TMTr+p8j4YQ2PYbbjdw8+mvac9Gens2uxW0oUSjKPbQ=; b=eYaG3ndZ1Th53Paw56ZcFeoTPD
	9Mi2SiB8FW0W1tvphs+wjJ+vxx22ObmxEePLnkZxu7UyjcGE/bhxo6P+FIzTTIsUdEloPm8U3jwyh
	dqFsnGCF1xNjm12czXnqDj4MZ0dta5d62Rt9WkLM+2NGnpV4NcCfy/oOQXqRWNRN7a3oNEo6vLfvZ
	zYpIeZjP4++oewAp/Z6wYTZjmfnzk1ze8BcCE6T+0RdFNUDU1EUNHDi3Y5iIU6icUxxnDFck/v88A
	c6EZyU2bjYbv2oVg1x7QuepLlkDN9EfXR4W1CHjakHl+B0Yul/TGrzSSzb9IWMi5gE9Ih0ocSmsD/
	QOCaf2dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTaxh-00000001mnU-04Oy;
	Mon, 23 Jun 2025 06:47:25 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTavu-00000001mQD-23yC
	for linux-nvme@lists.infradead.org;
	Mon, 23 Jun 2025 06:45:35 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N0QefF013311;
	Mon, 23 Jun 2025 06:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=TMTr+p8j4YQ2PYbbjdw8+mvac9Gen
	s2uxW0oUSjKPbQ=; b=ob1hZlCNq0vm4baXhJg8qiSygbQB1eFjpy5BUHjs/qVGE
	ngWFv2KROGmlLs9bpbGukjcn1BhHgTE2z17Hc0K/T5bP5WMbMIG6yl4QuZ1KJfT1
	k71rozOcmYVp4i42BPAX+xzXCz6ucNwqfB0wRhMyQKRAtRbDc/M1Hd3R5Jhhmn8x
	DnE+AUyArf5toMsTUryNlbJ5bVy66OBc73RTPn8dHPP7UUdO3tAACGkxkUJEl1B/
	OxPogH1SzANMZFEIPQv8vSIukDQ0BEgN53W3b9owpjcSfUsF32G9yBDZDC8fdtMo
	iE1k+vkaTrTZgiDuTxOk1C16G0C+WcFjRYdFW882Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt18wr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 06:45:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55N50REJ025574;
	Mon, 23 Jun 2025 06:45:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehvufbsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 06:45:27 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55N6jRRc021681;
	Mon, 23 Jun 2025 06:45:27 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ehvufbrm-1;
	Mon, 23 Jun 2025 06:45:27 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
        hch@lst.de, sagi@grimberg.me, kch@nvidia.com, nilay@linux.ibm.com,
        corbet@lwn.net
Cc: alok.a.tiwari@oracle.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] nvme: typo and minor cleanup fixes across host and target driver
Date: Sun, 22 Jun 2025 23:44:53 -0700
Message-ID: <20250623064456.4188056-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_02,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506230038
X-Proofpoint-GUID: iyNzwmiBGMLigoRdOXqA8FOH-xWPE-Je
X-Proofpoint-ORIG-GUID: iyNzwmiBGMLigoRdOXqA8FOH-xWPE-Je
X-Authority-Analysis: v=2.4 cv=cpebk04i c=1 sm=1 tr=0 ts=6858f808 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6IFa9wvqVegA:10 a=kdh0kE6_XUOs-LRwJDgA:9 cc=ntf awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDAzOCBTYWx0ZWRfX+wpgd+oGOhAv eeasPhJ7JVIaxFPmv98lu5V8RCMStYixGyB11MrzaMnhJSDTxY29VSqe7nop2VB+rpfHPawXep0 WQFwTHqR2Dm9cDjb9JPusrs9QjqEEu/xGbPGRCYVPFhwjlgmVqOeNJoVruwpHt8r6DyAVREckas
 D6PCmTZzzuR5VksyQ4sbzZSchKryTV2nWjVSpyvEfjKZuFhq3Se1MrS+9rkYrX07qQ9PzoTAl5d Xm9nxl/cf4ukUN9my+W5xIZxGFlLElX1lVh2vcNwt3tIwO5Jc+a1/ZMeuzUotgK8N0A50GdEPKs SgNr8JUw415LxxbA6QyPFHuFbW+2YuvdI7ypaWZI2dRRIlmsGLn/u9ABnozh+OE3dmQF7jM+t9K
 KvRO83RY68RO33v2gDSSy6rXwKMnxRZEZdXGQuIh7q0UUjZ04ZOoN5TEWHAgJdETAVufT2CS
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250622_234534_646917_2D8E4A00 
X-CRM114-Status: GOOD (  12.92  )
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

Alok Tiwari (5):
  nvme: Fix multiple spelling and grammar issues in host drivers
  nvme: Fix incorrect variable in io cqes error message
  nvmet: Remove redundant assignment of error code in nvmet_ns_enable()
  nvme: Fix typo in status code constant for self-test in progress
  docs: nvme: fix grammar in nvme-pci-endpoint-target.rst

 Documentation/nvme/nvme-pci-endpoint-target.rst | 16 ++++++++--------
 drivers/nvme/host/apple.c                       |  4 ++--
 drivers/nvme/host/constants.c                   |  4 ++--
 drivers/nvme/host/core.c                        |  2 +-
 drivers/nvme/host/fc.c                          | 10 +++++-----
 drivers/nvme/host/nvme.h                        |  2 +-
 drivers/nvme/host/pci.c                         |  2 +-
 drivers/nvme/host/rdma.c                        |  2 +-
 drivers/nvme/target/core.c                      |  2 --
 drivers/nvme/target/passthru.c                  |  4 ++--
 drivers/nvme/target/pci-epf.c                   |  2 +-
 drivers/nvme/target/zns.c                       |  2 +-
 include/linux/nvme.h                            |  2 +-
 13 files changed, 26 insertions(+), 28 deletions(-)

-- 
2.46.0


