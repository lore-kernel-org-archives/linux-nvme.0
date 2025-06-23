Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AFCC77B7C
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jun 2025 06:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g8oV+S7HgcO0pummHHa1RfxONX1M6FiSJTscEpjL+90=; b=NKiRjtcOI4qltRqGoOZq6m0xD4
	/hUJ02IMvrH270qOnH4z0izi/sbyQeZvYixNHQb8Xp047XSez6d3CIWREaAOYq658pG5cxxoqJ0TD
	XRcfvgFnqKJgUm37ai6V9sCJh3LSh9NYZ47O+cO3LspoSAnXVBuGn97xhnd/f+7x6avgbJ0Pfn+7s
	iI+aOyBZ0Hb/O1RrPavzqMeH/JL29gMOvt4CAte1WYYuAdeo/fkAL44I9lWJD8wz2ONk6jEI4qhqT
	zUi+0i0uF8F9b3zPD96EFpYcjZ3t8Myna0xSMGlJE1uDe2bPTD1QjwEzy7fESAl4tXxZlIbC6Hn84
	oiMAKDTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTaxd-00000001mkb-3oXF;
	Mon, 23 Jun 2025 06:47:21 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTarr-00000001lQA-2QD4
	for linux-nvme@lists.infradead.org;
	Mon, 23 Jun 2025 06:41:25 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N0R5Hi015350;
	Mon, 23 Jun 2025 06:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=g8oV+
	S7HgcO0pummHHa1RfxONX1M6FiSJTscEpjL+90=; b=qOQosRvjamWUt6g00KLMI
	e4ZwSBmiyaZWDL4X/Au+8yLxsFNKZH5/s+G1rD37wLKoWkDuSVyjuLgvDXwkfKuw
	aStIVtEbo5PEDgmv9aNoQgdul/CrkQX0AhlGbbBPjeuCGa7aqvFbW/OBKoTyhQ/V
	PE3MLqRAV+yML6cR0oNviGGAW49yFHd33USDDnEwD4Ik+uitbi28BdRtZkAEH7qN
	/PUy1aqEqDyR+g2AsJT+urR/iGlGwxA5/ICqJtgpQRUb9Letu0LsYSnXpiubOkxB
	ytvRy245fWs447PBdidQqvBJKKrrrNbm3C5vZRgu/2B8Txqh3P+vNcnIVHzJyLxx
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt5gww2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 06:41:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55N6dpqX029719;
	Mon, 23 Jun 2025 06:41:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehpnfduy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 06:41:13 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55N6fAjw006422;
	Mon, 23 Jun 2025 06:41:12 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47ehpnfdt5-4;
	Mon, 23 Jun 2025 06:41:12 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
        hch@lst.de, sagi@grimberg.me, kch@nvidia.com, nilay@linux.ibm.com,
        corbet@lwn.net
Cc: alok.a.tiwari@oracle.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] nvme: Fix typo in status code constant for self-test in progress
Date: Sun, 22 Jun 2025 23:40:22 -0700
Message-ID: <20250623064036.4187788-5-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250623064036.4187788-2-alok.a.tiwari@oracle.com>
References: <20250623064036.4187788-2-alok.a.tiwari@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_02,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506230038
X-Proofpoint-GUID: jZEILuL1iFZME9RYnsZlGAZOlo23D8xE
X-Authority-Analysis: v=2.4 cv=PMYP+eqC c=1 sm=1 tr=0 ts=6858f70a cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=JPcgd-ljN0tfNaZuDOwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDAzOCBTYWx0ZWRfX2lvPxIXiJmYY qIueq9x7qr0rOvltWfOX7nfd24kreIeswg1k9+2vp7Na2bSCbhHoHOs4aXct1zm9VytU53DMnks ekEZywVepI8lvYBPdJzs2iWwfPcHSDwGazI7MDYG2GV9h8zC0EZ8bevl7qXkuaxj5U2Ip87TWNs
 FTzF+13HpxXY6rxsilL0pWic43chnhAwOLIrGHVL7KFnkTXYzMCpiSUPoTLI6ErV2NBLCh2epM6 jqDzKc6xKa1z89sElCCLaMtw1ItqtvebS3/NXjNrX3j+Pf7NVvx/3gHEZ+czBVXNBZl+gx/UupX SZMczYg1ceCT/iX1/dguEkC3o5z/54mbjNuHicEOIc98VUDBLY7sgb0t0n2Tl4+1dOHaov7l65i
 Z3D285LXuKCmr9roxdsJyfVO8p43hkgd7MNIVVvS4Z2pbbgFX78ZUqyEDYd25VXNnrqOaweb
X-Proofpoint-ORIG-GUID: jZEILuL1iFZME9RYnsZlGAZOlo23D8xE
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250622_234123_728689_3EB0BFC4 
X-CRM114-Status: GOOD (  14.08  )
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

Corrected a typo error in the NVMe status code constant from
NVME_SC_SELT_TEST_IN_PROGRESS to NVME_SC_SELF_TEST_IN_PROGRESS to
accurately reflect its meaning.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/nvme/host/constants.c | 4 ++--
 include/linux/nvme.h          | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index 1a0058be58210..dc90df9e13a21 100644
--- a/drivers/nvme/host/constants.c
+++ b/drivers/nvme/host/constants.c
@@ -133,7 +133,7 @@ static const char * const nvme_statuses[] = {
 	[NVME_SC_NS_NOT_ATTACHED] = "Namespace Not Attached",
 	[NVME_SC_THIN_PROV_NOT_SUPP] = "Thin Provisioning Not Supported",
 	[NVME_SC_CTRL_LIST_INVALID] = "Controller List Invalid",
-	[NVME_SC_SELT_TEST_IN_PROGRESS] = "Device Self-test In Progress",
+	[NVME_SC_SELF_TEST_IN_PROGRESS] = "Device Self-test In Progress",
 	[NVME_SC_BP_WRITE_PROHIBITED] = "Boot Partition Write Prohibited",
 	[NVME_SC_CTRL_ID_INVALID] = "Invalid Controller Identifier",
 	[NVME_SC_SEC_CTRL_STATE_INVALID] = "Invalid Secondary Controller State",
@@ -145,7 +145,7 @@ static const char * const nvme_statuses[] = {
 	[NVME_SC_BAD_ATTRIBUTES] = "Conflicting Attributes",
 	[NVME_SC_INVALID_PI] = "Invalid Protection Information",
 	[NVME_SC_READ_ONLY] = "Attempted Write to Read Only Range",
-	[NVME_SC_CMD_SIZE_LIM_EXCEEDED	] = "Command Size Limits Exceeded",
+	[NVME_SC_CMD_SIZE_LIM_EXCEEDED] = "Command Size Limits Exceeded",
 	[NVME_SC_ZONE_BOUNDARY_ERROR] = "Zoned Boundary Error",
 	[NVME_SC_ZONE_FULL] = "Zone Is Full",
 	[NVME_SC_ZONE_READ_ONLY] = "Zone Is Read Only",
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b65a1b9f2116c..655d194f8e722 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -2155,7 +2155,7 @@ enum {
 	NVME_SC_NS_NOT_ATTACHED		= 0x11a,
 	NVME_SC_THIN_PROV_NOT_SUPP	= 0x11b,
 	NVME_SC_CTRL_LIST_INVALID	= 0x11c,
-	NVME_SC_SELT_TEST_IN_PROGRESS	= 0x11d,
+	NVME_SC_SELF_TEST_IN_PROGRESS	= 0x11d,
 	NVME_SC_BP_WRITE_PROHIBITED	= 0x11e,
 	NVME_SC_CTRL_ID_INVALID		= 0x11f,
 	NVME_SC_SEC_CTRL_STATE_INVALID	= 0x120,
-- 
2.46.0


