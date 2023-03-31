Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CDEC761A6
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Mar 2023 22:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0e6jo9ra0mvSTi1bLOHNaHkusvxsQtvmmD5brYzcIoI=; b=YvA5IrUnOsMQFVIEI6EzcpbqDH
	z7MSqgTCkwws7QhENqJ+2Jw2t1xzLC0Px5JQ4aMe51LcOM1PMx3ImB0CbHKjpr4HrQSUXCMy5JJ7b
	UME7YkBbBblGrmOE42DKvGe5fYaoPMcvpwYKVCitoaUixpNnw4e0rW1B5d0sRWRitslv4Z6Lm9wAy
	8gENcPNF6Pdm1BqelJHkpQA5Efe3XpNKLtA/k6em2evK7kWefbZ5/xgoCC2eU6IoNigQLeTh76i85
	JoJznNMoKyR5IapnDddBMnRrbUrujesiJmI0bJ4EsSTZdAz0FkFLrv5bOCSC2LyO1BL31HbU4gV+0
	75CinC1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1piN4x-0092WS-06;
	Fri, 31 Mar 2023 22:18:39 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1piN4s-0092Vl-32
	for linux-nvme@lists.infradead.org;
	Fri, 31 Mar 2023 22:18:36 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32VKrVEO007026;
	Fri, 31 Mar 2023 22:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=0e6jo9ra0mvSTi1bLOHNaHkusvxsQtvmmD5brYzcIoI=;
 b=fq5KEKNoNI+xcc6OzKskMYH+m2mjceE1Z2q/FDhNr42NQ1fMGbpgImtMd4pUJB1Lpeaa
 IvVy4NyhEvn8Z3woqu8k1knGbXJ250wkVA7jMhc49URcZS56RIsxJw0kZeYtkOJllRDO
 NOL+yslp2CMvE2dmyc1LWI/VIJ9Z9XARVMfoM0z0awZ79xoZ+Mp4QLpajbWl5xfbgesl
 QI6ly4CvK1XCf11LvTtv8XbLXXG4k6rnikNS2H098Hw8P7lgMFySEatvHK0I/YRgOUbR
 wwvxt2k9ieoxzkCLsn0gCJFwH4ggDYyUuNcf5KvLNn4RQed6efQRLZOH8qgM4+Ak/Tq4 9Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmq53f406-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Mar 2023 22:18:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32VJqLgY023465;
	Fri, 31 Mar 2023 22:18:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdkhm86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Mar 2023 22:18:26 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32VMIPaE003191;
	Fri, 31 Mar 2023 22:18:25 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3phqdkhm7h-1;
	Fri, 31 Mar 2023 22:18:25 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Subject: [RFC v3 0/1] nvme: add passthrough error logging opt-in
Date: Fri, 31 Mar 2023 15:18:22 -0700
Message-Id: <20230331221823.2806192-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=765 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303310182
X-Proofpoint-GUID: E7MpwwgPDUBJloZ8qKb6STbr100YwICN
X-Proofpoint-ORIG-GUID: E7MpwwgPDUBJloZ8qKb6STbr100YwICN
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230331_151835_245390_59D70882 
X-CRM114-Status: GOOD (  11.43  )
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

v3:
- Log a passthrough specific message that dumps CDW* contents.
- Enable/disable vis sysfs rather than debugfs.

v2:
- Included Pankaj Raghav's patch 'nvme: ignore starting sector while error logging for passthrough requests'
  with a couple changes.
- Moved error_logging flag to nvme_ctrl structure
- The entire nvme-debugfs.c does not need to be guarded by #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS.
- Use IS_ENABLED((CONFIG_NVME_ERROR_LOGGING_DEBUG_FS)) to determine if error logging should be
  initialized.
- Various other nits.


