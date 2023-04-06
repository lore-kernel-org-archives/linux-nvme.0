Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEA2C76196
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Apr 2023 21:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mFlijxnlFKAN9hGSAErLdM+7fvpiuKqV9fJkVSRg+PQ=; b=nmGbFF2rPTxRUbh3p/BfiNwqri
	bTPGuBqyvmgzv0MzVRbv52W5iDIlfrMWpRusMDgaNUqj7/iuCmJJtCft/BqwzzDVhbS5SXenae2M9
	d2fm52wdHgyb6Ziz7bHuKWpqe4J0DinhCKk4vh8F9R90/9d3ZIrgexXjCw1c24/RJEko7TDhxo+bV
	N0otbM3NX++PbCpEwHzGj1oS6aKvBGxuP9UqFpz+MfWWiYrwaBPPJc4h7mjugG7zlM1URJ2aVWBbF
	AbtZx+C4QgjDxZjw1qeCW5gE5w1SAbFoE2Q+GWDGUQqLUAnGbp59M+yqe8bssc8utTI6ku7M+19fi
	VV3hQwMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkXaE-008hEM-2u;
	Thu, 06 Apr 2023 21:55:54 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkXaC-008hDd-1B
	for linux-nvme@lists.infradead.org;
	Thu, 06 Apr 2023 21:55:53 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336Eo04x009307;
	Thu, 6 Apr 2023 21:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=mFlijxnlFKAN9hGSAErLdM+7fvpiuKqV9fJkVSRg+PQ=;
 b=RJRgYXWGXuHivS7gv0JaMFeaLHxN0qpP8+an5hyKV/dRte6TAFEN+WtkPh3CbzmgQw5O
 Koa+urlsqQDwz8s6seqgnj0ac4+U7HW4GHka8M1iFsBRYsuYb9FEjbnndTEZnME1J6+h
 ddz0tCikELYNIYMUFX4W2d2GHhrxNMKd/H8cDqOkAnP5RL19LvQcWKgcayWdG5C08nex
 0g1KhVQgnm47TDDzEd7jsPmRn2+SvOYKFGnWUrHaCzU9g/8DL3S/y55abPK3ubyBXrBJ
 9kwuXgpyaNMsTEveDt3DNHlhOqPFwLdYQjnpjkjrQG8qmQdYROFziuVi7Xh2H2+82rv8 aQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppb1duw31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Apr 2023 21:55:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336Kx8uQ036473;
	Thu, 6 Apr 2023 21:55:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptpawvgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Apr 2023 21:55:45 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 336LpxEk034232;
	Thu, 6 Apr 2023 21:55:45 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pptpawvgb-1;
	Thu, 06 Apr 2023 21:55:45 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Subject: [RFC v4 0/1] nvme: add passthrough admin error logging opt-in
Date: Thu,  6 Apr 2023 14:55:43 -0700
Message-Id: <20230406215544.113127-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060193
X-Proofpoint-GUID: 3tSRd4m9H87lTBeG1WGtsaKU1ijYqv-d
X-Proofpoint-ORIG-GUID: 3tSRd4m9H87lTBeG1WGtsaKU1ijYqv-d
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230406_145552_520226_58A59CAF 
X-CRM114-Status: GOOD (  13.96  )
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

v4:
- Change sysfs attribute to passthru_admin_err_logging
- Only log passthrough admin commands.  IO passthrough commands will always be logged.

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

Alan Adamson (1):
  nvme: add passthrough admin error logging opt-in

 drivers/nvme/host/core.c | 97 +++++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 93 insertions(+), 5 deletions(-)

-- 
2.31.1


