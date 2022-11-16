Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48291C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 00:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TfNZuRSK1rYDWpaEmMVhVZSMlQ8Ufn3t/rR4cl1Jzso=; b=cRkz7dT2VkqeD2npuCVGK/je1o
	+D5LTUCHAaUu01hLyc/w0f0cyjBRqOdX73ixijKUJSx+GvFtV3r9SZhPlH7w+hpDyaUDtslYQUvQZ
	BFyTZtdomjFM1QfKJJIeEvhiYBfP/3piHfWV5GwSr5GNiCPr6QSQ+MQXjYjOdY6KOzc82V8ih1ZRg
	3+FzvSBpj+VFQra5fqFSJF8aXwrzr6rcqe56yDk6Lb5vvGOOnxXT6vvsDo+e7/+6h1CNbpJixXheA
	16ejNjrhvI9EU3kmnLx68IXsQYm3AjVtJTKoc4bW9f/qtKGNIYNcenkhz/wMlRuU31RD2ko6cjw5U
	PZuqCIdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ov62l-00FyUZ-In; Wed, 16 Nov 2022 00:12:43 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ov62i-00FyU5-4c
	for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 00:12:42 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFME4Jo020916;
	Wed, 16 Nov 2022 00:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=TfNZuRSK1rYDWpaEmMVhVZSMlQ8Ufn3t/rR4cl1Jzso=;
 b=ObOf2ox951EOPcH+r/r5ipq9fP8eNuO2PjT2CP8klD7wRF4fZdKwVelSyQd6rdA1Xn30
 2QBhQiIyyB7g9vDOycKAGED8/7df8TYLZt4wKrTOA/A+7zo5QTyJ0c2w3RoDLGoZxfVi
 XBCwUMRnPwSvqJJmqlnbuj1WLnPcKDQgBiZwDROkHlOf/WpS14KZjLB7oVGiWVkTwybA
 x7aGeZquHEPKw2LuodJy556UfjAgJORolMfzqrEFu2ASGut84shUIBUX1H9g3fGhoB35
 9gFtt0xh0KF91K3risvgldB+93Gc+jEF0S7teCTVizHL3WhmMPM0cqIMBHu16xEOUbz5 rA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv8ykjmyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Nov 2022 00:12:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AFNcc7X004768;
	Wed, 16 Nov 2022 00:12:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ku3k7dqf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Nov 2022 00:12:35 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AG0CZsq013984;
	Wed, 16 Nov 2022 00:12:35 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ku3k7dqee-1;
	Wed, 16 Nov 2022 00:12:35 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-block@vger.kernel.org
Cc: alan.adamson@oracle.com, linux-nvme@lists.infradead.org,
        shinichiro.kawasaki@wdc.com
Subject: [PATCH] tests/nvme: Remove test output for passthrough error logging
Date: Tue, 15 Nov 2022 16:12:34 -0800
Message-Id: <20221116001234.581003-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211150166
X-Proofpoint-GUID: -FSbXsoXg8FdkoJdlK8wof_DkiRueA6l
X-Proofpoint-ORIG-GUID: -FSbXsoXg8FdkoJdlK8wof_DkiRueA6l
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_161241_355918_B94CAE91 
X-CRM114-Status: GOOD (  14.06  )
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

Commit d7ac8dca938c ("nvme: quiet user passthrough command errors")
disabled error logging for passthrough commands so the associated
error output in nvme/039.out should be removed.

When an error logging opt-in mechanism for passthrough commands is
provided, the error output can be added back.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 tests/nvme/039.out | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/nvme/039.out b/tests/nvme/039.out
index 162935eb1d7b..139070d22240 100644
--- a/tests/nvme/039.out
+++ b/tests/nvme/039.out
@@ -2,6 +2,4 @@ Running nvme/039
  Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR 
  Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x75) DNR 
  Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 / sc 0x80) DNR 
- Identify(0x6), Access Denied (sct 0x2 / sc 0x86) DNR 
- Unknown(0x96), Invalid Command Opcode (sct 0x0 / sc 0x1) DNR 
 Test complete
-- 
2.31.1


