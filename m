Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47ECBC02180
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2025 13:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dkrBROOdQifatuc9FPvDmFZLsUOPy8m05nx/QgVHt7w=; b=jhscdjBlieRd7FJve3guxQEQva
	aYJy6G+QhiOmcwO/v9TDFyN4b5gF4PZivUak7gkpvu2MJ15GW3B3abSiFwzNI082PH4FKDItbQjM7
	O2bKyLWauF0rQX1dyENfBkcNgal1FJWfU/JYxRQykj7XgohEbHEjq8OMT41G+R9BTWPASi5ghaUbF
	QV9VPLWhk24iq+6wH8ut/TvgxJYCigROCLE2CiU1ARaMHk2j0OzjcFi6WFRGu+OH8VH0gIoov+s7q
	SrBpq4ElB7r/WR48V+U7UIXd8dRrJ34/A+jpBgfYmgEr+6TQUrKN1VEXRdyDIlKio27qg2ie1xE4P
	WcSYjnnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYPpY-0000000F05f-3Hzb;
	Thu, 16 Jan 2025 13:22:40 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYPpV-0000000F05H-464j
	for linux-nvme@lists.infradead.org;
	Thu, 16 Jan 2025 13:22:39 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GD8Pem005656;
	Thu, 16 Jan 2025 13:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=dkrBROOdQifatuc9FPvDmFZLsUOPy8m05nx/QgVHt
	7w=; b=dkeHiH+p30X8WWCNSu7JdVvuUwLoZ9z8nzfvh05vsXBatVZfOoQb/NHYl
	edSq3D68SGWYaP2x8wfa8L8uYsZq4+1722KZ7K51SgtcAe5V+rE6F3LN6LJeP6UI
	pOj3lZ4PNPsvf8cG9LDvtlob58l4LTQvqbETGVKpN0cFakEUX/eQqUA7MJ6LeHTO
	rvGkTfnM+3SBZPkIFkHbCid053GEzuOUP+Cj/vynO9YBUi55etCifGoXUW11DKL+
	h60WViD2CyE8pszhUk35I8czFcoIZnU0bi7kocyta32bAj7wR1zFoAgTHaFnzSWs
	JtcqNrmgORiEFp1GDey7cIzdjx0aQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446tkcjj0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 13:22:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GBQOo4016498;
	Thu, 16 Jan 2025 13:22:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4445p1wmv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 13:22:35 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50GDMXe940304964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 13:22:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78BDA20043;
	Thu, 16 Jan 2025 13:22:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5951620040;
	Thu, 16 Jan 2025 13:22:32 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.241])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jan 2025 13:22:32 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: shinichiro.kawasaki@wdc.com, hare@suse.de, gjoyce@ibm.com
Subject: [PATCH blktests] nvme/058: detach loop device after test finish
Date: Thu, 16 Jan 2025 18:52:13 +0530
Message-ID: <20250116132231.349917-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vBLLzs6W_Bm_XKRcAgwsAhoLD9VgqoHL
X-Proofpoint-GUID: vBLLzs6W_Bm_XKRcAgwsAhoLD9VgqoHL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_05,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=826 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501160098
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250116_052238_026000_B7B8E789 
X-CRM114-Status: GOOD (  12.03  )
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

The nvme/058 creates three (temp file backed) namespaces and
attach each namespace to a loop device while starting the test.
However it never detach those namespaces from the loop device
once test finishes. Ideally, we should detach loop device from
namespace so that the associated loop device is later destroyed
and its resources are released. This patch helps detach each
namespace from its associated loop device after test finishes.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 tests/nvme/058 | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/nvme/058 b/tests/nvme/058
index d230a21..99e7e81 100755
--- a/tests/nvme/058
+++ b/tests/nvme/058
@@ -99,6 +99,17 @@ test() {
 	done
 
 	_nvme_disconnect_subsys
+
+	for ((d = 1; d <= num_namespaces; d++)); do
+		local file_path
+		local blkdev
+
+		file_path="${TMPDIR}/img${d}"
+		blkdev="$(losetup -l | awk -v path="${file_path}" '$6 == path { print $1 }')"
+
+		losetup -d "${blkdev}"
+	done
+
 	_nvmet_target_cleanup
 
 	echo "Test complete"
-- 
2.47.1


