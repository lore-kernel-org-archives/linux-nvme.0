Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18047C4345F
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Apr 2024 09:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=h2RBnyKOu/nv+V5ZSZFNQ/LSKMNaX1q8sxQ+4kLLnas=; b=ZWRdx6l+pAuvIRU8zy2jXYdq/1
	7HlXftwfE73NuVn+cxhRN0ROYPa7oc2+VMPNHuB76DsOWEOot2r7XSJwXBPpStDz73XR3oitrGMoi
	XBz0R/3l99yOfm44WuSEQ9AlJ8vA5ngnT945E6ws73HUCFOiMhhisf+vHqakQWFS1YQzgf2NIV9bc
	P4/1rSC36Tdmz+I1erE/nkMdCnpXc7PuMO7zSHAeWZPgIVlw/1cZVdMPI5InQ6DpqHk3/s3E0NcMB
	hVFstiPJZcM08vgNgwf6upq4rCUZ+fE4EAyvGa4EggeHRb9kjF8woCTc9FP/EopJlyvSzwB7zVDtN
	ujYgGs8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvZLO-00000002oKT-10MH;
	Sat, 13 Apr 2024 09:06:42 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvZLH-00000002oJf-2NIl
	for linux-nvme@lists.infradead.org;
	Sat, 13 Apr 2024 09:06:37 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43D8jCEY022184;
	Sat, 13 Apr 2024 09:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=h2RBnyKOu/nv+V5ZSZFNQ/LSKMNaX1q8sxQ+4kLLnas=;
 b=hNey16PTSAcG1AtM6PiLct6ZajDJnUlSN2K31S7bPmp8ZT/v4Gz/us7YeZL2h959ytp7
 awnOOc0PCM6WGup28Hl0sTbpMrV95R1FO92H7sqG09gMOfOtcMwNr44vbRfXSzL1zLsI
 5s8orFe16AaAq347cqBnQSOxQBp52GNEidnPIEFuLC9aGhlVzqShfLWaQZAFQACu9SK/
 d2mj8UAnceERTsgbqTEgkXplA6wL7GDeXROfXlMdfucWvjN9YFZVjPVBbhjnOlrqRWiS
 oA66HHcpIOnHCNsJR2vkwuy6gfgmBJeK575eVVZWMdbIDlJZR3qqX49CaxFShEthHJyS pQ== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xfhq2rby9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Apr 2024 09:06:26 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43D7QrQp019089;
	Sat, 13 Apr 2024 09:06:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbh40y6hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Apr 2024 09:06:25 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43D96KIx49152358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Apr 2024 09:06:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17D9B2004B;
	Sat, 13 Apr 2024 09:06:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CBD820040;
	Sat, 13 Apr 2024 09:06:18 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.53.134])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 13 Apr 2024 09:06:18 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, gjoyce@linux.ibm.com,
        axboe@fb.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH] nvme: find numa distance only if controller has valid numa id
Date: Sat, 13 Apr 2024 14:34:36 +0530
Message-ID: <20240413090614.678353-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3W10HzFPBwP7c1H0ULTEP0J88z4NeLMA
X-Proofpoint-ORIG-GUID: 3W10HzFPBwP7c1H0ULTEP0J88z4NeLMA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_18,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 phishscore=0 mlxlogscore=925
 priorityscore=1501 mlxscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404130065
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240413_020635_993067_39C44C22 
X-CRM114-Status: GOOD (  17.16  )
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

On numa aware system where native nvme multipath is configured and 
iopolicy is set to numa but the nvme controller numa node id is 
undefined or -1 (NUMA_NO_NODE) then avoid calculating node distance 
for finding optimal io path. In such case we may access numa distance
table with invalid index and that may potentially refer to incorrect
memory. So this patch ensures that if the nvme controller numa node
id is -1 then instead of calculating node distance for finding optimal
io path, we set the numa node distance of such controller to default 10
(LOCAL_DISTANCE).

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/multipath.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 5397fb428b24..4c73a8038978 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -240,17 +240,19 @@ static bool nvme_path_is_disabled(struct nvme_ns *ns)
 
 static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 {
-	int found_distance = INT_MAX, fallback_distance = INT_MAX, distance;
+	int found_distance = INT_MAX, fallback_distance = INT_MAX;
 	struct nvme_ns *found = NULL, *fallback = NULL, *ns;
 
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
+		int distance = LOCAL_DISTANCE;
+
 		if (nvme_path_is_disabled(ns))
 			continue;
 
-		if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
-			distance = node_distance(node, ns->ctrl->numa_node);
-		else
-			distance = LOCAL_DISTANCE;
+		if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA) {
+			if (ns->ctrl->numa_node != NUMA_NO_NODE)
+				distance = node_distance(node, ns->ctrl->numa_node);
+		}
 
 		switch (ns->ana_state) {
 		case NVME_ANA_OPTIMIZED:
-- 
2.44.0


