Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A97BC3DA4A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Aug 2024 13:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3gJtEpifjQUBNoaUiZwY04O7sYieNa7gCBa8EDEyDp4=; b=nUe2QgCCz/Jm0Bb82DE+DCkjlw
	6wfJzWtpEX4LPzd9VQJ7uvS/6cTMJUxRRY7XsELx49prbWOsI6Ys+cqdRkETkAefd/tcsthe8wC/+
	0RQJuAKg5I0H04QACZTw9KjxFFW/ipILw5MFph4tXKSxR5qgHfPaeIwsnedT7sZBoUp9+C8r6OMXZ
	CkyWCECJ41a4Yi9Y3sGPoNt7gWzorCEG0rDSMDvg3bs1dWkq76O0uyHmwxIQuTi2IrLsWem70Jwvs
	7DqrjVOVFMoOS3p3H8ciLMKX8WFTU2d3xsJP5JKkykA8HfyZPJa5mR8MaCf6FgxS9hXAXtmXqLTGU
	dyd+wNYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seEVK-00000007Azj-20ut;
	Wed, 14 Aug 2024 13:57:34 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seEVI-00000007AzK-09sf
	for linux-nvme@lists.infradead.org;
	Wed, 14 Aug 2024 13:57:33 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47ECdhmc012016;
	Wed, 14 Aug 2024 13:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=3gJtEpifjQUBNoaUiZwY04O7sY
	ieNa7gCBa8EDEyDp4=; b=OjhmfN1J3PkJcHkQJE1ic4BRfYqwYRxWKpCF8itfxV
	CObZY9gVe9X/JXVqkmnHiOWz0ECx4wpabBtTlYlMpQUUX0C1QzFhPZRHq7MBhrYp
	Wvs2mVa7hPlNsINRDr0h7f2Y6mdqr54EeG8BrR6DwkhxPXlmyNkyDAQWPmaXHO+O
	FWfa/N5ew4ZDOLMgfYzvBbGfY2KYq/MHi9qEQboUh8RM9Kqd/pogD80L6ING4S6+
	GJ2fq2G2jUqnWFwzqlmbNwF22GduFbiTknZQDTwVSOdtlhp+8mLu6FOS/9ms3p0G
	bQxk4YJpwZv5Lj08UeG7XjT2kzq1/aFVmGTMYPPIZYsg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 410vs9gbvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 13:57:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47EBCP9n030998;
	Wed, 14 Aug 2024 13:57:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xmrmhe1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 13:57:22 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47EDvG5T31130162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 13:57:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2FBB20049;
	Wed, 14 Aug 2024 13:57:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0344620040;
	Wed, 14 Aug 2024 13:57:15 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.179.26.14])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Aug 2024 13:57:14 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        gjoyce@linux.ibm.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH] nvme: Remove unused parameter
Date: Wed, 14 Aug 2024 19:26:50 +0530
Message-ID: <20240814135702.99402-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7NqC20o0vyMrHqTAeztdAc2DPnf9v46z
X-Proofpoint-GUID: 7NqC20o0vyMrHqTAeztdAc2DPnf9v46z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_10,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 mlxlogscore=840 priorityscore=1501 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408140095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240814_065732_312019_1AD1CD54 
X-CRM114-Status: GOOD (  12.99  )
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

The "name" field in struct nvme_ctrl is unsued so removing it.
This would help save 12 bytes of space for each nvme_ctrl instance
created.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/nvme.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ae5314d32943..da57947130cc 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -301,7 +301,6 @@ struct nvme_ctrl {
 
 	struct opal_dev *opal_dev;
 
-	char name[12];
 	u16 cntlid;
 
 	u16 mtfa;
-- 
2.45.2


