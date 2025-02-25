Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B8EC021BB
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 18:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jqvPWh1XotWX+Uhry/+cGJzjY5ak8C0eomurxRwFRJg=; b=oBZzcSxUFUsK/WEGzEk9hh2gX2
	g6RSE4uDNPObpyFH9HSKqUax9c80gCwBvmxO5CceMGSl1M9rpR3f5p2Q+PLrS1EQqdmz5Iyy/GbwF
	PsHp8ZlLxBPY5R2ijAHxDTKTlP9IqjrtZKnc/ujdQuwqShRpqy1aU9/DxoTtdr8ZM7daRDJ0GNtjC
	mCzMSOycuSZU50n2JlOXtc/8caFYn3LPn55tVOmd2BRNL16S8CZZGyLhY+bdLu0Ko9wQesGzpcctm
	SmBbtp1x9+EB50UdVUDz/QkoYtVe9yFniDQmDOqAq0TGKpag+juFXAtq7zqo6c7q+bGtZcMvK3DAi
	xiOaC+Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmzse-0000000100i-0INA;
	Tue, 25 Feb 2025 18:42:08 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmzZl-00000000uOR-2EoP
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 18:22:38 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PHtccq028274;
	Tue, 25 Feb 2025 18:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=jqvPW
	h1XotWX+Uhry/+cGJzjY5ak8C0eomurxRwFRJg=; b=RPhh6bNkMT/3V2e0cUm8I
	Bp98apH+lQ6Wh04r0tjDK3BkoAQQ9Ho9yNEa75qUQkEMkEzM31vpUlSYLaYmWobO
	KNT/DEpp360+TOOqDi2dopNW2liQce0Ft8wTwL4GY3IJ6uYHlIEUsh5cMqgWpoyE
	EPgPNesPQKJ5TTXg9vwR1q2vGwZ/2zarXoFE5XAkl1xHPSwWP/XwPANnE8174ge1
	tC6yIBu3BMaFYdhW9MrHu2khtAWtc33dykUMMdd+1N7NvT4IMkS+3FxJVZNNNr7y
	rWZeOpPzudJ8414chOwKC9f1EEO4ON0KSUdsPeAh20/vSl9k5kI/uHEDqSvVcfei
	A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y560604v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 18:22:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PHA6H1024384;
	Tue, 25 Feb 2025 18:22:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y519n6yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 18:22:35 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51PIMXe6038769;
	Tue, 25 Feb 2025 18:22:34 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44y519n6x8-2;
	Tue, 25 Feb 2025 18:22:34 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-block@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, alan.adamson@oracle.com,
        linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com
Subject: [PATCH blktests 1/1] common/xfs: verify xfs_io supports statx atomic write attributes
Date: Tue, 25 Feb 2025 10:31:08 -0800
Message-ID: <20250225183108.3881328-2-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250225183108.3881328-1-alan.adamson@oracle.com>
References: <20250225183108.3881328-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_06,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250114
X-Proofpoint-GUID: 1Jq9aL3QLj6_Tjn4rS3-IQVoU6JxQyzU
X-Proofpoint-ORIG-GUID: 1Jq9aL3QLj6_Tjn4rS3-IQVoU6JxQyzU
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_102237_585923_6FE7A678 
X-CRM114-Status: GOOD (  13.58  )
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

xfs_io atomic write support is a dependency of the scsi and nvme atomic write
tests. The xfs_io atomic write support was introduced across different
versions so if xfs_io pwrite supports the -A (Atomic Write) option, it doesn't
necessarily support statx atomic write fields so that needs to be verified
separately.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 common/xfs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/xfs b/common/xfs
index 10ecda7c75c8..79e79e7f45ae 100644
--- a/common/xfs
+++ b/common/xfs
@@ -11,6 +11,14 @@ _have_xfs_io_atomic_write() {
 
 	_have_program xfs_io || return $?
 
+	# Determine if the statx command returns the atomic writes fields.
+	s=$(xfs_io -c "statx -r -m 0x00010000" /dev/null | grep atomic_write_unit_min)
+	if [[ $s == "" ]];
+	then
+		SKIP_REASONS+=("xfs_io does not support the statx atomic write fields")
+		return 1
+	fi
+
 	# If the pwrite command supports the -A option then this version
 	# of xfs_io supports atomic writes.
 	s=$(xfs_io -c help | grep pwrite | awk '{ print $4}')
-- 
2.43.5


