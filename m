Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD99C3DA4A
	for <linux-nvme@archiver.kernel.org>; Fri, 16 May 2025 06:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hTVZkUq6ZMHCC6+7FY0NJW+BhC66fNvyx9Xi/qUkQ0Q=; b=Kdvmj7+aanmCHvIKlQh1BWP1aM
	SQ/OYj/znpIskBz04AiG9/wtoOI+16lhSspkqDdA8qH/IBLFqKCTYF+q+qlo9dvHZsgmpz5nUjoxR
	r5Wn1S3iCdW7+24qghje4TDD+aT8gmTxo5WftPIzEWN0HEEOZZ29sUoA2b2QDaMPyW/uyIb/bRr3Y
	ImpHWNqEUjFXeL6zX+CejZCEgGYus/m+uRBla0hsMt+f/OUru8pNEskNqX0hByarEi5BLQddejAf9
	oV3xtlY3nlsjhkreIwDATWdta70DUGk/0kQ//sePLiTbZ3bPrjvDn7SqTo903rMUEE0BMVb1eZBcA
	+B5jgOfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFodI-00000002ZuK-1ept;
	Fri, 16 May 2025 06:33:24 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFobG-00000002Zfi-1vUX
	for linux-nvme@lists.infradead.org;
	Fri, 16 May 2025 06:31:20 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FLbRot028092;
	Fri, 16 May 2025 06:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=hTVZk
	Uq6ZMHCC6+7FY0NJW+BhC66fNvyx9Xi/qUkQ0Q=; b=SsyThTh2l5VXa6p+n4u42
	uGYrkWneHr/scm0Eg8LzJBieAnKv2FdflLYgONnP1S6tv+MhKRizCmVr1yGcpzNG
	iSli9NJzQm5pNN6pTnCRlDB6UL44DWqx0+a7OpfYuanoTD8PYjbWLkecHurDrZYZ
	nRGmpGvO7MXwjrPy/Q82/w4rJRVh8cCbifayVCrIQqLwxiwaXvFQnPLOuWkSLbKA
	7wUI+kjUmUetBmGJ0/BeRfR9bJOJ48IpH1PEWDmZOmM2KpwSC0HYcxc4TbUTLA2Z
	QYZZZvqkzzpCEAENKnG2s6lxzmfjLr+96H8hzo6Z51yMgLEk/Uo7xWfX+PkLOEzr
	w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nrbdgs1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 06:31:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54G5ibQM004951;
	Fri, 16 May 2025 06:31:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mrmf0y3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 06:31:02 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54G6UlYo035769;
	Fri, 16 May 2025 06:31:02 GMT
Received: from shmsingh-git.osdevelopmeniad.oraclevcn.com (shmsingh-git.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.255.137])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 46mrmf0y1v-2;
	Fri, 16 May 2025 06:31:01 +0000
From: Shminderjit Singh <shminderjit.singh@oracle.com>
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org
Cc: shminderjit.singh@oracle.com, junxiao.bi@oracle.com
Subject: [PATCH 1/1] nvme-pci: Add quirk for Samsung PM173X with Subsystem Vendor id:0x108e
Date: Fri, 16 May 2025 06:30:59 +0000
Message-ID: <20250516063059.3456399-2-shminderjit.singh@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250516063059.3456399-1-shminderjit.singh@oracle.com>
References: <20250516063059.3456399-1-shminderjit.singh@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_02,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505160059
X-Proofpoint-GUID: QwlLW1RE-Cy-6lyNWI8d2Y6B-Jz_Z9W6
X-Proofpoint-ORIG-GUID: QwlLW1RE-Cy-6lyNWI8d2Y6B-Jz_Z9W6
X-Authority-Analysis: v=2.4 cv=G/McE8k5 c=1 sm=1 tr=0 ts=6826dba7 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=SMlHW2x7kTy8SIR8vz4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDA1OSBTYWx0ZWRfX1eZSz36AQXoF en7byC3iraJlNYCtfre4RxsrIptBf88dTZ2OQz1qfZOYFBuGBjcGCBMPFz9oTcKhfjmlXpbgVBs 6pS9WXyBph24eUWfxApjLBCwMhR7XTTfdu0WIQwFnspskYT7f9QF4v26FsgWE+7eSafv7K3Mjmk
 jNG6+r+/vA3Ik1D85GZDCtypqulPb1Y8MmLslefm8wN6+5VGeQO/yeoJ1qvnfDEugytiJ2TD+DB 4awtNCINFt+wr3c8p1MdJn9V7SDgjly/0j1R6Nu76x0ueScIyuGymHWlrYMS/XaGIV7FkDt6FrR ZFa28MMR58KAAk73fs2LSPab4x5tw1XzqWsW9FsR3JsVF9Lm0f3sk89W+cKR4cbwoZjw6YXVLsw
 VBHL/knSu8A9jQ1kgjMnNHA4fMk/e8BGPNp7v+0C2NJOkCraezXrBHlOhooT8jzvNI/t+CWi
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250515_233118_616188_93DADE3F 
X-CRM114-Status: GOOD (  13.41  )
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

This commit adds NVME_QUIRK_BOGUS_NSID for devices with Vendor ID 0x144d,
Device ID 0xa824 and Subsystem Vendor id 0x108e.

Signed-off-by: Shminderjit Singh <shminderjit.singh@oracle.com>
---
 drivers/nvme/host/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2e30e9be7408..767cdac056df 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3163,6 +3163,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 		    dmi_match(DMI_BOARD_NAME, "PH4PRX1_PH6PRX1") ||
 		    dmi_match(DMI_BOARD_NAME, "PH6PG01_PH6PG71"))
 			return NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND;
+	} else if (pdev->vendor == 0x144d && pdev->device == 0xa824 &&
+			pdev->subsystem_vendor == 0x108e) {
+		/*
+		 * Set NVME_QUIRK_BOGUS_NID for Samsung PM173X
+		 * with subsystem vendor id 0x108e.
+		 */
+		return NVME_QUIRK_BOGUS_NID;
 	}
 
 	/*
-- 
2.43.5


