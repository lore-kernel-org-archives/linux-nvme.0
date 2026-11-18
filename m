Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6307D606A32A
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wX6bRMzM;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TxHTlnTD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=uTUP1wATFkQLjPQ28dR6tD07MK4U7TertbzWdOnXNNI=; b=wX6bRMzMgtrz5K
	WulUbwLskcFwYdwj4IV5y+NEA4jD0YLbx5nd2ZHold7fI1restocXB79mZ5jqW7r6GzyDX0DKucRb
	/zrRNRxcPTL2VB8KFtCLiXbY/RwfBj/PzaCf8RVniLys7tIjRMOA6bnVz3cfBkps/O0hV1lP6NMyj
	EgQ9TnRAfzVmPcOHfYTliKZaierijB4vr5Nf17o9qDU5UWUlOxm8WF5Gn42VoizKeICscQmTRz/U7
	usD5pvE8XlBrjwCVtmJc0AfFp0WJCZ3jgxt0vpJYGviUheSRhcGraZh/pDtMVbEAxBEcaedPq6dlJ
	vKQpkB5FZN63OsgNgi5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaDP-000000080wB-01nv;
	Wed, 18 Nov 2026 07:36:23 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaDM-000000080uo-3Nvr
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 07:36:21 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2RpRx030927;
	Wed, 18 Nov 2026 07:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uTUP1wATFkQLjPQ28
	dR6tD07MK4U7TertbzWdOnXNNI=; b=TxHTlnTDbx1yWlJHV4YGzHcDHb2h25cNV
	hB32wkwq09DXBhdinLXgaSIuNjqVdpUzs5pUuAgehSZOCtPaj8kEMKYu25UINhhy
	8sgoUoB0Wwpik6FPbYJC6JbmFdBk3x2bbDJH1OYYb1BVM7j/XAcSB6jMey3CJiDH
	GcB4jgoifE8ch+o0SkoQa06y+alOUeQQPuiN33vGlKG4Y8SNid0H2D5C0ONj/FTc
	J/dSIZbTAMGiupUOh6c47crnTpafwlrsvT//TM43wicZdV9eK8JRmFIiH+wfkIK6
	vTSiy70nOkCfIBHyy/ooevxPQEAVa5duiR7LqDdWzLVFinuXopnxA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105n9cuh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:36:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2Z95E2477308;
	Wed, 18 Nov 2026 07:36:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j02jufaxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:36:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI7a56t52560258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 07:36:05 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F8992004E;
	Wed, 18 Nov 2026 07:36:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEFE82004B;
	Wed, 18 Nov 2026 07:36:00 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.157.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 07:36:00 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, bvanassche@acm.org, sagi@grimberg.me,
        axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 04/22] nvmet: add context annotation for nvmet_ns::bdev_file
Date: Wed, 18 Nov 2026 13:04:45 +0530
Message-ID: <20261118073505.288910-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118073505.288910-1-nilay@linux.ibm.com>
References: <20261118073505.288910-1-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX40KstQxPpFfG
 eykrPncsY9O66dpHXtDLU3kzquFcKnF7oQN/y1oYSHEDFFGzaGf6JLYFs/l/6mFU5YTT0gNwQ4Y
 1S0/s0z18oQToJ2lPLyoXOaWWoG0koDCqZWGQVjRYGEP1Xcp8Fpkhz24AxsbKO3323FsKjivx26
 086jjIoPumeLk0apIXMhzEwdA5401sVncc4tdGvGZ5R6YJw0FSv/UB4JDC9ft1GSosR4kVs4/RJ
 Zi7UW+2lVCIW+Vv25JOdXsTzEzpXvTxMiI8wbEPhHSu3rmEijZX/JFj/V0PBHlFj97BZCkfXr0d
 TU8wL4H6EVwIH0cUs348MuNwlkzGjxrIqMGWUPlVJaILJ7wHGopaPDEJEOKkTPnS3Oqb/5zDkEC
 88bA3d3VXX9GxmNhBPCc+nZEdVW0BX2c95TLJ6qSOWq7hGCeGBCRqGnEsYW7x37Tlm3wvlTazAk
 L4bptrrIYjg+UtS1xGQ==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afd556d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ytfzEcs4y3VMyTrQ1fAA:9
X-Proofpoint-GUID: JtG56dZ15zbEBhq-uADh_-EcAmgwky6K
X-Proofpoint-ORIG-GUID: tNZ8Q2wRmailgmcPNl_99XPSPFSk3nIU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX7ckbtKKr8n6y
 5utM7TqkfFGZHq6IweRuIyWhk2XhvqsvKW071FF2v3LpD4YcX1vWBH/6PZkyLaC1gF8QZav2C92
 piqNmr3Mh91c1p+5/7TvfppzoRRmwJk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_233620_867572_01DDFF3A 
X-CRM114-Status: GOOD (  12.34  )
X-Spam-Score: -2.6 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The nvmet_ns::bdev_file field is protected by nvmet_subsys::lock.
Annotate it with __guarded_by(&subsys->lock) so that the clang
context analyzer can validate accesses to this field.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/nvmet.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 20b87de18054..256ffa3c08cc 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -149,7 +149,8 @@ struct nvmet_subsys {
 
 struct nvmet_ns {
 	struct percpu_ref	ref;
-	struct file		*bdev_file;
+	struct file		*bdev_file
+		__guarded_by(&subsys->lock);
 	struct block_device	*bdev
 		__guarded_by(&subsys->lock);
 	struct file		*file
-- 
2.53.0


