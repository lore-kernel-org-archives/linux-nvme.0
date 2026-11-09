Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEAA606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 03:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LDCaGl2y;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OXuN1nq5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=tqmnBtTKZiYw9fcfsHkKXtP+4gfVyu6mHkAplCXMMiM=; b=LDCaGl2yvqiRtz
	Nb5IZQaGB7YqlB9DFrRg9ILpsUU2tdz7ktB8FwtfjfOp4nTh9CASUxiUnweZJFBCLp2t5146cXfb3
	4XjeURAa8wl0Aut0IaPC3MRWmQcYT7SHvpt9a6GguYC990nkypHzqZOVOOFsBlJt2SRaht8tjCI1B
	iTpOn5AuZMAWLN8ANTalyegzL8xxkNsz+x5l7ukTShsRjTV1Sx3n1TOEFaV0qw8YgrrwF19RsK7vm
	esSlPJQBVqNv3aPOiQJlnDJUz5R+FBaZmMQDjTqedb++sV6ly7BCK8wwixl+xkaktkdn7+lBJNoFY
	AY/rbq/NSAlE4n8U2qBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG8b-0000000HE5S-2e8X;
	Mon, 09 Nov 2026 03:33:41 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG8X-0000000HE0h-0PNp
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 03:33:39 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90iSuB311691;
	Mon, 9 Nov 2026 03:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tqmnBtTKZiYw9fcfs
	HkKXtP+4gfVyu6mHkAplCXMMiM=; b=OXuN1nq5LKitjz6Du8fCG59EChiKT7OGm
	Alj4LRKsRhqfdFXUu94KV8aHZTEVlrg6nNCftGbPFEKZB3N4zPZ+Xq7fww69Rju5
	0hcRJtWSICT+LJaXcSZTUF2IanFrL4aU5x3RtxTcThnoREZwHkHSgLcjXesMjdQ5
	p1hyod9ds9wWF0zMKFQusK95kP13YnZqtfbEvUJbg8eZB7cF8GVnbHK3+LA97XQF
	nal0q3PMcl9fr/C5K8xxdhRFOWdmTg6ufofSyTI2jYfe536DufKTnezUaV+8z+6s
	3C1/i7Qs/UxY808/aVqGBMWIH2l6m/uNVeH2gI9jX+jR6wMXTSqSg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsunstfg3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:33:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A93Jww03674789;
	Mon, 9 Nov 2026 03:33:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfthdbmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:33:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A93XM9x43844026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 03:33:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BAB420043;
	Mon,  9 Nov 2026 03:33:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4EDC20040;
	Mon,  9 Nov 2026 03:33:15 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.101.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 03:33:15 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, bvanassche@acm.org, elver@google.com,
        linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 18/23] nvmet: fix nvmet_ns::device_path access using nvmet_subsys::lock
Date: Mon,  9 Nov 2026 08:58:23 +0530
Message-ID: <20261109033102.982191-43-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109033102.982191-25-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfXz5JjgRze01dt
 J11Bb4PbXZ+nNrHMvpBbSgFo8oB5qp/kw+mXG+AJcmiHDQ7O4QP2LYcF3qvrYhL74m1O3e2cEcF
 HjDJqb42P0HywAKm/AiuGR5kaCqkQCRmcsGb9ZfIR+7FH5lOzLscnv4Af6QBwzGljhzojEU32vD
 JytMwAKBNhHCU+0q84HsihAO0ccavBdFMB0KFfQd8hNMu0CWy/bhm/o/IkTlz7j2AkEPhC/9O1j
 MaOecmkAnU5kPmWYm48IwmuE3HZN7FRUQpdpWkdp9OIU1u7yMX26HWwJ18R9vmco+4pmr6+h6vf
 lSuY+VWGKX6tfHaxCo5FOgbI/4bwnsLOG6ZyIloBd06w9It/osXext/1BI/O37fdesK5oUDCW17
 m2Sy7BUNl7MHIVNv8op7YC2CG5zWznwvvo/zedE2hJ95AOsfNdYTPV9v8d4+qtrnRW9qb5UpiYW
 T3HB63B+12iIa2MyFfg==
X-Proofpoint-ORIG-GUID: J9IecOMDtF7DNFihO0vC9YaaQWY4EdG6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX7qKdS76fTPWb
 JrDlpq+jyphqngznX5oAS96O1/bUYsIGjtOT13sqJh/EoyqAR8y7tUIoP2CNQEAsTPSYDlmPYsO
 OFKVjmvlKcNY5pEegE5onLOfE2QlTPI=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af13f07 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=naH_Sv8VKW2vHdK1hH4A:9
X-Proofpoint-GUID: 5ncweNzttlisfsJA4BKDH8sbBCsnEQmN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_193337_161924_64520250 
X-CRM114-Status: GOOD (  15.08  )
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

The nvmet_ns::device_path field is protected by nvmet_subsys::lock.
However, nvmet_ns_device_path_show() accesses ns->device_path without
holding the corresponding lock, triggering a Clang context analyzer
error:

drivers/nvme/target/configfs.c:535:50: error: reading variable 'device_path' requires holding mutex 'to_nvmet_ns(item).subsys->lock'
      [-Werror,-Wthread-safety-analysis]
  535 |         return sprintf(page, "%s\n", to_nvmet_ns(item)->device_path);
      |                                                         ^

Fix this by acquiring ns->subsys->lock before accessing ns->device_path
in nvmet_ns_device_path_show().

Additionally, nvmet_ns_free() frees ns->device_path without holding
subsys->lock, triggering another context analyzer error:

drivers/nvme/target/core.c:737:12: error: reading variable 'device_path' requires holding mutex 'ns->subsys->lock'
      [-Werror,-Wthread-safety-analysis]
  737 |         kfree(ns->device_path);
      |                   ^

Fix the above error, by moving the kfree() call into the existing
subsys->lock critical section to ensure that the field is accessed
while holding the required lock.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/configfs.c | 9 ++++++++-
 drivers/nvme/target/core.c     | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index ba44d404ad56..a87917381093 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -531,7 +531,14 @@ CONFIGFS_ATTR(nvmet_, addr_tsas);
  */
 static ssize_t nvmet_ns_device_path_show(struct config_item *item, char *page)
 {
-	return sprintf(page, "%s\n", to_nvmet_ns(item)->device_path);
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	ssize_t ret;
+
+	mutex_lock(&ns->subsys->lock);
+	ret = sprintf(page, "%s\n", ns->device_path);
+	mutex_unlock(&ns->subsys->lock);
+
+	return ret;
 }
 
 static ssize_t nvmet_ns_device_path_store(struct config_item *item,
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 805b5f70eb06..6b11beb2e2b2 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -730,13 +730,13 @@ void nvmet_ns_free(struct nvmet_ns *ns)
 		subsys->max_nsid = nvmet_max_nsid(subsys);
 
 	subsys->nr_namespaces--;
+	kfree(ns->device_path);
 	mutex_unlock(&subsys->lock);
 
 	down_write(&nvmet_ana_sem);
 	nvmet_ana_group_enabled[ns->anagrpid]--;
 	up_write(&nvmet_ana_sem);
 
-	kfree(ns->device_path);
 	kfree(ns);
 }
 
-- 
2.53.0


