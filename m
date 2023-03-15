Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D4CC7618D
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 22:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BLJJy1+ZgwpNRd9swz3xcy/irzTsB/Fy3caGqVsf+bo=; b=M7fJTmzwKuV3tv9d+b9IY+PDUn
	5WSlr4c3JXpQs0A0VLkt0vtFB8P95Q/6PkHTr3rjBjkFzlhVmNRa7zBh9W0lC0e+R3pDfNVQX0DdM
	8ZNgrRvo+OXjy2tuEgmZvnPDXBcCsSk6kxeFfM2+/A/XBJELUEGnzIwvi4Ildl35bbIKdE/3D35Gp
	W091EoED0iGfn0SMAgafWEzlvuAYaT+KjIZz/4ZthX7cMSc0svA2AB/PA8G8pjEy0mNhalPObPghm
	Kn6dzRRAK/+hte25P9rEK/rlv7lxq/DJbvfO/EOvx3tL3uPgZ0LKi/bZyGUCngw7GRX2WWzVyr33A
	RxZc4CfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcZiR-00EcSf-2P;
	Wed, 15 Mar 2023 22:35:27 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcZiN-00EcSD-23
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 22:35:25 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FMIaDt012449;
	Wed, 15 Mar 2023 22:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=BLJJy1+ZgwpNRd9swz3xcy/irzTsB/Fy3caGqVsf+bo=;
 b=cY3x5ZOWY+3lie5X/xtgZRXu/WcBc+CEjhYemSws5LlIjFnbuEMz4DOGPeDeyFpe67/4
 jIrJsvYSC9RSyu6lc6sgPXVlfQjy22UaLc/MDd1s/ZcklcYwNR34K68fXx9zKTh006nn
 MgHCnVmEuGjshSt++1NwTziH0DFH8ENruyi7z+wp1qoFg5Ibe6hnWfTA3SSvKfCt/fIQ
 wC5sYfC1hDKJPdva/Z+Vxo1qzS6AWOpepZZmWF4r9MEod8azp2nDe1IXMXHbvVg0jQSY
 Rk1fOpi8XPs3UPFxJ+AauCM/nkI0FQrafxlH0xHL07g36pRDp7ZNozyLPqY+y9L0F2Tk tQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbp4q0297-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Mar 2023 22:35:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32FLwQIL033432;
	Wed, 15 Mar 2023 22:35:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pbpde96dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Mar 2023 22:35:09 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32FMZ8a5020420;
	Wed, 15 Mar 2023 22:35:08 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3pbpde96dj-1;
	Wed, 15 Mar 2023 22:35:08 +0000
From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
To: stable@vger.kernel.org
Cc: saeed.mirzamohammadi@oracle.com, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM173X
Date: Wed, 15 Mar 2023 15:34:36 -0700
Message-Id: <20230315223436.2857712-1-saeed.mirzamohammadi@oracle.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_12,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150001
 definitions=main-2303150184
X-Proofpoint-GUID: KZ1i8VvTwu8FNn7ESSBIxWJoDwD4WcPy
X-Proofpoint-ORIG-GUID: KZ1i8VvTwu8FNn7ESSBIxWJoDwD4WcPy
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_153524_401419_BDFFAEEB 
X-CRM114-Status: GOOD (  17.42  )
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

This adds a quirk to fix the Samsung PM1733a and PM173X reporting
bogus eui64 so they are not marked as "non globally unique" duplicates.

Cc: <stable@vger.kernel.org>
Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
---
 drivers/nvme/host/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5b95c94ee40f2..c0b1caba1c893 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3359,6 +3359,10 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
 				NVME_QUIRK_DISABLE_WRITE_ZEROES|
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	{ PCI_DEVICE(0x144d, 0xa824),   /* Samsung PM173X */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x144d, 0xa825),   /* Samsung PM1733a */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1987, 0x5012),	/* Phison E12 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1987, 0x5016),	/* Phison E16 */
-- 
2.39.2


