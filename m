Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BD2C48BEB
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Feb 2024 18:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UUhBWSekF8OvZS2OoisYMBdZeWjZOlz86uYctiuXbh0=; b=iHFWiSqfX9vKTowdoX9w77ytts
	k0J7DSeIXtSXtg+asxMb4KZ7Lh9QxbACkRnVWOpZMGpgulKkeXwCtBhTPtvN/FhiyGKBPrTH7uUFx
	89LwgZsDBP7YFsH6g6BZVHPNuRZJSFPv4r30Espp73kN7asgU26LGBUo8+ln/SiuVXwSwS7xq8Zgz
	vA9lFz4fXesZLdMeFDE5HrNA+agFWWHR4rSpHNQO9gqqeThIiW+qwrbEypoQl4oP3Lr4HOFZoUNL2
	u0HA2qITbUgO7jjyAez1B1b6YFrNmkSgosLc4cjLOqialVTxf5xS+WHS4AoA3NpDdCW6FH5yQ1Ual
	nMOyI3hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcrSO-000000028X5-1lD9;
	Wed, 21 Feb 2024 18:36:36 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcrR8-0000000281J-0B85
	for linux-nvme@lists.infradead.org;
	Wed, 21 Feb 2024 18:35:20 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41LDis74028029;
	Wed, 21 Feb 2024 18:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=UUhBWSekF8OvZS2OoisYMBdZeWjZOlz86uYctiuXbh0=;
 b=ib5SF+CBWbHoyVbyXexrU6qvP8bLDxnaqfrnff4a0qFefevw3fK/qCjPsdFPzhoUQQkr
 IZ00q8KAJ0kGZ7aphEEtsIUcc+/jWVusVnzJ2jsnhXiAD1vXz3+78NB6tZy9L0a/i4jJ
 U9TqNu/keaihNo1qETaS62lNMXo4r+qcbG0OiCiDvemKhbn13qn0wB15I7IeUjH9fFEz
 HnrEjhC1p/dflbhVo5yUwmkeLkbPiD5Ln80evg1UzytSaQAg+fjcyQFDPGmLR1oi2imu
 Ay0Ixc2OG2TN5hD0SGSWoINHDb1Q0zSWLMu7lU9ZhF0NRGzn5KVr0+CQmJkxsHVhunhV Rw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakk42ngs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 18:35:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41LIUEZM039655;
	Wed, 21 Feb 2024 18:35:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak89evgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 18:35:13 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41LIVkxd039971;
	Wed, 21 Feb 2024 18:35:13 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wak89evfs-1;
	Wed, 21 Feb 2024 18:35:13 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-block@vger.kernel.org
Cc: alan.adamson@oracle.com, chaitanyak@nvidia.com,
        linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com
Subject: [PATCH blktests V3 0/1] nvme: Add passthru error logging tests to nvme/039 
Date: Wed, 21 Feb 2024 10:36:39 -0800
Message-Id: <20240221183640.3432605-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_06,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210145
X-Proofpoint-ORIG-GUID: 04_YxgoWM9t6p1JN5T1QGq9Tr3Xtr2NC
X-Proofpoint-GUID: 04_YxgoWM9t6p1JN5T1QGq9Tr3Xtr2NC
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_103518_731393_148326A3 
X-CRM114-Status: GOOD (  12.59  )
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

v3: - Use the availability of the passthru_err_log_enabled attribute rather than the
      kernel version to determine if the passthru tests should be run.

v2: - Pass namespace (/dev/nvme0n1) to nvme io-passthru rather than controller (/dev/nvme0).
      This resolves a issue when testing with multi-namespace devices.
    - Only run the passthru tests on kernels 6.8.0 and greater.

Alan Adamson (1):
  nvme: Add passthru error logging tests to nvme/039

 tests/nvme/039     | 43 +++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/039.out |  2 ++
 tests/nvme/rc      | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)

-- 
2.39.3


