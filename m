Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22208E668AB
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Nov 2024 13:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ib+A9tEwr4Cf/PkY0y7ZpBD0wncIrsDb5788WCUTyp8=; b=wWPJstHsKM5tdwu29Qu02Fxku6
	55mKZeE1SFQmQuDBdE+skwyuLtSPhMz4HJz3+7TieFwXbB/5VigzjWpmKXsv4Uu5SVci2dSGKLhte
	mJ52RBXXORem3TGcs3d/U/JYDuUU8+Wov50B4Bbh1ZFaqlygXaBJs9Npo3RIBA/PYlJ2RXXiEWXJC
	AkNiGtjZhvPUH5MG3Zrmr69YXD78yF0lgpifAbdwlUsxqb85tu1m+FEgejfVi9QN7PXFq1+Ty1x4k
	/qxCGI5Ag4BB3nDgBfhf35GwLeYoFGAwJVY2YXZqHrSrbAfaA4ADdpTpM5hrN/4RJzIU5FDAdFrqA
	feoRHJZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFCIr-00000005qFd-0JuZ;
	Sun, 24 Nov 2024 13:05:29 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFCAX-00000005oOQ-03it
	for linux-nvme@lists.infradead.org;
	Sun, 24 Nov 2024 12:56:54 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AO6hSKY026890;
	Sun, 24 Nov 2024 12:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Ib+A9tEwr4Cf/PkY0y7ZpBD0wncIrsDb5788WCUTy
	p8=; b=hUWlpiP8NsGPHv3xYgRkHH5zcUur6CId9Hho1YkIeE0m7CUWdsLZpLQld
	ka71CKHTVFcV/oNjlkDMBsDgPrvGWVwkKElUhgq9tsfjDn12BM6NmmmATeXNJj2i
	ZFmec9nINHTw3dwYit3SALzG2eKqKUCCq6+JNXeFoDcgMW6vhnN+Y0Vt69Z361hu
	RA1/0I6/wGi2qjvSna84E6H0v8K/XtumzPcLjYN2GfUIalCGLafe2Gf6xKt7zOR+
	v+9PKJLN8lhtDKir6CeXmODatSL8VA5I86dRzLmNe5BshL+wnKOm07O/6sy5eTWd
	sRUlV6WZWO7hlLPifKrrCmlyOLl8w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386jm1eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Nov 2024 12:56:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AO2gcTc027494;
	Sun, 24 Nov 2024 12:56:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 433ukj0mqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Nov 2024 12:56:34 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AOCuWWP48955650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 24 Nov 2024 12:56:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90ED220043;
	Sun, 24 Nov 2024 12:56:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2CFE20040;
	Sun, 24 Nov 2024 12:56:29 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.179.4.180])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 24 Nov 2024 12:56:29 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
        chaitanyak@nvidia.com, yi.zhang@redhat.com,
        shinichiro.kawasaki@wdc.com, mlombard@redhat.com, gjoyce@linux.ibm.com
Subject: [PATCHv2] nvmet: use kzalloc instead of ZERO_PAGE in nvme_execute_identify_ns_nvm()
Date: Sun, 24 Nov 2024 18:25:53 +0530
Message-ID: <20241124125628.2532658-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Yg3Lm6ZW3isdKx0V2hMI4aWlpsnWrVVJ
X-Proofpoint-GUID: Yg3Lm6ZW3isdKx0V2hMI4aWlpsnWrVVJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxlogscore=998 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411240105
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241124_045653_170230_003EF5D4 
X-CRM114-Status: GOOD (  16.13  )
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

The nvme_execute_identify_ns_nvm function uses ZERO_PAGE for copying
SG list with all zeros. As ZERO_PAGE would not necessarily return the
virtual-address of the zero page, we need to first convert the page
address to kernel virtual-address and then use it as source address
for copying the data to SG list with all zeros. Using return address
of ZERO_PAGE(0) as source address for copying data to SG list would
fill the target buffer with random/garbage value and causes the
undesired side effect.

As other identify implemenations uses kzalloc for allocating a zero
filled buffer, we decided use kzalloc for allocating a zero filled
buffer in nvme_execute_identify_ns_nvm function and then use this
buffer for copying all zeros to SG list buffers. So esentially, we
now avoid using ZERO_PAGE.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Fixes: 64a51080eaba ("nvmet: implement id ns for nvm command set")
Link: https://lore.kernel.org/all/CAHj4cs8OVyxmn4XTvA=y4uQ3qWpdw-x3M3FSUYr-KpE-nhaFEA@mail.gmail.com/
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
Changes from v1:
    - Use kzalloc instead of ZERO_PAGE() for allocating zero filled
	  buffer (Christoph Hellwing, Keith Busch)

 drivers/nvme/target/admin-cmd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 934b401fbc2f..f92c5cb1a25b 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -901,13 +901,18 @@ static void nvmet_execute_identify_ctrl_nvm(struct nvmet_req *req)
 static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
 {
 	u16 status;
+	struct nvme_id_ns_nvm *id;
 
 	status = nvmet_req_find_ns(req);
 	if (status)
 		goto out;
 
-	status = nvmet_copy_to_sgl(req, 0, ZERO_PAGE(0),
-				   NVME_IDENTIFY_DATA_SIZE);
+	id = kzalloc(sizeof(*id), GFP_KERNEL);
+	if (!id) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 out:
 	nvmet_req_complete(req, status);
 }
-- 
2.45.2


