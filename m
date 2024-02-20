Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE6BC48BC3
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Feb 2024 23:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bqGCULEBWiOTsXd46lhnk+JCijZWOS5tGdu1mCkkVVM=; b=eRjxZyu6ezxSOWasSag33J4Rzx
	aT6DnRchvLiZ3LN5MWxp+mGVSxj+Y2RTFIhSfVFKOKLOo0v0pQYx0s1bCiLkr6x1JPAZtxODd1CJD
	fMTiTxj/rmMBJuTpk4OjevKc7kvTlvKxYLTZZ+MQJWqBNYh1Aae+cNrjo197qdeCkvRsECT2xIVYq
	jpELNB58U+L+q4g/ZVX9Ekb5HGagdfrrsN84gZKPDqoYnIlRaXqUW7XupveHzAM6qHi2+GoFKkZNo
	2mwOoF7dyX2DMyTg9CmmsKKWqw5W4mvDhUCvmESXC7W0/Ii2BKdYlmXeSmDvEVY14QDKfAT5dzRSa
	6Dzv/uLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcZY8-0000000GVXH-3DIZ;
	Tue, 20 Feb 2024 23:29:20 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcZY5-0000000GVWX-3PJw
	for linux-nvme@lists.infradead.org;
	Tue, 20 Feb 2024 23:29:18 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KKXcGL004113;
	Tue, 20 Feb 2024 23:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=bqGCULEBWiOTsXd46lhnk+JCijZWOS5tGdu1mCkkVVM=;
 b=chdKGdinGEbGPd8U2R/wizhhGu5B0kkT7of5YhPF5dcdGKQo1zAvvj0zgULaaCyxS7bB
 rycVL8yUqHVoUBpXz3By3MVlNvdn6WVW1D6hR/7XxLi/nxT9CoKGoenqVgAirMu3Ats2
 JTen7oBTcIFrhf6SL6pczeMIPpRFp8iBGxC75RkO+/DqxUiG+OdERvX5khk5wf+aAZ/B
 xlX05BJ9BMqu+ZxIFbj7uMebEbyuzQawRQW5JXs2UdcEHTl3KePf+Z+I38Nci//VsYsA
 i55JT/C8nKkocHHP4Diqw3bX3LGlyu1i0hPuYCUjG7V23EmMTEdkDLm7IYY3BGobdPak bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakqc8bfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 23:29:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41KN3woj006646;
	Tue, 20 Feb 2024 23:29:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak88b8cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 23:29:15 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41KNTFFN021792;
	Tue, 20 Feb 2024 23:29:15 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wak88b8c5-1;
	Tue, 20 Feb 2024 23:29:15 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-block@vger.kernel.org
Cc: alan.adamson@oracle.com, chaitanyak@nvidia.com,
        linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com
Subject: [PATCH blktests V2 0/1] nvme: Add passthru error logging tests to nvme/039
Date: Tue, 20 Feb 2024 15:30:41 -0800
Message-Id: <20240220233042.2895330-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200168
X-Proofpoint-GUID: RR6VnzOfvjebOi04zV0ojA82cVV4mBhI
X-Proofpoint-ORIG-GUID: RR6VnzOfvjebOi04zV0ojA82cVV4mBhI
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240220_152917_879721_C57039EB 
X-CRM114-Status: GOOD (  11.74  )
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

v2: - Pass namespace (/dev/nvme0n1) to nvme io-passthru rather than controller (/dev/nvme0).
      This resolves a issue when testing with multi-namespace devices.
    - Only run the passthru tests on kernels 6.8.0 and greater.

Alan Adamson (1):
  nvme: Add passthru error logging tests to nvme/039

 tests/nvme/039     | 63 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/039.out |  2 ++
 tests/nvme/rc      | 37 +++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)

-- 
2.39.3


