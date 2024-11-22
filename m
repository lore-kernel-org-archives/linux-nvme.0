Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC92BE65D2F
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2024 08:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3WuS8K3W/HLOwRILSZs8BVVrEenqJoia5gwFjWbnA6I=; b=Bb58Ho7kr4JfZ1YpGufsDtGDXL
	SPhGPCcWxCuK0rL3yGZpF+jo/IxkmOYf4FUBcxyQo2NdlaHA71gwi0UPfn+I7F5mqisnwFu47Py4O
	736VaDS5zQbJUiCmGbLLNmlFat8SHU47PLEqbGluCadcXhSBWB2+J6GS7ThY2kIsZfrz3TYC8UID6
	m7Mn/MoNGzyaHHoHd5xP0tTYOLinugwW4zXgAPAUhwQQn20H1axjZEcKlGHmz3mdrfP85a/PDzo4L
	qWD1AQAefYaJeOa6beUkFokDbC02jc1njWeleeunhdFWQtyW755moBGOR0lcowowcNbxjTNE2Pl/9
	uVa6jQ5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEPO3-00000001z2j-2Hyt;
	Fri, 22 Nov 2024 08:51:35 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEPO1-00000001z2M-0mZK
	for linux-nvme@lists.infradead.org;
	Fri, 22 Nov 2024 08:51:34 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM1qWHk016849;
	Fri, 22 Nov 2024 08:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=3WuS8K3W/HLOwRILSZs8BVVrEenqJoia5gwFjWbnA
	6I=; b=NTKVGVUC0vCix+WfX6UjLfCSkocW4rEYDF9ov1XFYdzEwLABHYWcD3zH+
	6FVxHS6w2mGrI2OHb3EdOxIIttG21tY+XeDRtniK4OCPXzbu7Upns+fm/Xa8zF1m
	9ar2iPEaQSuQqjHBpRAUTGBIhvAEyZ6bMC+FHK9ff/QOsrB6JOiNTIyLY1/stPxC
	C/1/S+TM4Xd7F47EuMBOaPThUxJe+HeocJkKjUs4qenBsFXZO90yc/Mm6+F2iAsj
	A9Hq4o6VjoOMLo4DqrTP2QFoq2qkCvbsQz/i0SZhwtPf2U+Fb5QsGNUZduoHVZsH
	b/LlNmXp5SpquNfJln7JuC/A103uw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xgttqyn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 08:51:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM278cE012123;
	Fri, 22 Nov 2024 08:51:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42y7xjthcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 08:51:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AM8pHaj17433064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 08:51:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0852620040;
	Fri, 22 Nov 2024 08:51:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 730C32006A;
	Fri, 22 Nov 2024 08:51:14 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Nov 2024 08:51:14 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
        chaitanyak@nvidia.com, yi.zhang@redhat.com,
        shinichiro.kawasaki@wdc.com, mlombard@redhat.com, gjoyce@linux.ibm.com
Subject: [PATCH] nvmet: fix the use of ZERO_PAGE in nvme_execute_identify_ns_nvm()
Date: Fri, 22 Nov 2024 14:20:36 +0530
Message-ID: <20241122085113.2487839-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WGRYmL0WfAqHFqOj4cZiSfBgRFD0fTNi
X-Proofpoint-ORIG-GUID: WGRYmL0WfAqHFqOj4cZiSfBgRFD0fTNi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=944 adultscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411220070
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_005133_345508_81398C91 
X-CRM114-Status: GOOD (  16.78  )
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

The nvme_execute_identify_ns_nvm function uses ZERO_PAGE
for copying SG list with all zeros. As ZERO_PAGE would not
necessarily return the virtual-address of the zero page, we
need to first convert the page address to kernel virtual-
address and then use it as source address for copying the
data to SG list with all zeros.

Using return address of ZERO_PAGE(0) as source address for
copying data to SG list would fill the target buffer with
random value and causes the undesired side effect. This patch
implements the fix ensuring that we use virtual-address of the
zero page for copying all zeros to the SG list buffers.

Link: https://lore.kernel.org/all/CAHj4cs8OVyxmn4XTvA=y4uQ3qWpdw-x3M3FSUYr-KpE-nhaFEA@mail.gmail.com/
Fixes: 64a51080eaba ("nvmet: implement id ns for nvm command set")
[nilay: Use page_to_virt() for converting ZERO_PAGE address to
        virtual-address as suggested by Maurizio Lombardi]
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/admin-cmd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 934b401fbc2f..a2b0444f28ab 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -901,12 +901,14 @@ static void nvmet_execute_identify_ctrl_nvm(struct nvmet_req *req)
 static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
 {
 	u16 status;
+	void *zero_buf;
 
 	status = nvmet_req_find_ns(req);
 	if (status)
 		goto out;
 
-	status = nvmet_copy_to_sgl(req, 0, ZERO_PAGE(0),
+	zero_buf = page_to_virt(ZERO_PAGE(0));
+	status = nvmet_copy_to_sgl(req, 0, zero_buf,
 				   NVME_IDENTIFY_DATA_SIZE);
 out:
 	nvmet_req_complete(req, status);
-- 
2.45.2


