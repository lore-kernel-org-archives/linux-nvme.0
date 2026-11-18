Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7562D606A325
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 07:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LLjTkbzD;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=d6g4890m;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PLRgUoZh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=nK1v63M+HYfXBSkh3gnJlH2MsfCwqya2MHfBbnO2HSk=; b=LLjTkbzD2qWYne
	+BjgYk1w1zNXjWfuJeluY/q1TlMFJ9hsw39WkVmh0iQ1MIGwDOmxxQ7tgWAqJa05EB98hQeLm/O3k
	T68lTrzuUhbM4BqShuGNd4m378fUgeSzZTbSu7vnB2zp4i4ZuIw2T0fPR5MRl+LkbrXRLoQ1UmQAS
	/ywPc16QmwssPWpOUUbENIFUKUSzcesqsCWgxSV2jP1kBZAzj9nwgZXDFPCSOdLNHRNLkORQWWdEr
	f0KijdIZsHVWG1BiDjz7Wk+3ZcmdGlCRO+vKLMVVxl8Fr77jIfOFxvrmcqv/8sEFwskW99OiDJayH
	ChbSb+PJddewtApNWe4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaEb-000000081m2-0Thm;
	Wed, 18 Nov 2026 07:37:37 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaEZ-000000081jV-0s3Z
	for linux-nvme@bombadil.infradead.org;
	Wed, 18 Nov 2026 07:37:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=nK1v63M+HYfXBSkh3gnJlH2MsfCwqya2MHfBbnO2HSk=; b=d6g4890mOXmg6vsQ3Z9HkMb2oi
	gdSYJR2HXLbGB/PgZTlkMkGdRIOp4OVE8AoqlZh8b6OvrdwODzaEnss+MRwapxP/x5Uu65Hv0yiz2
	l2o8aLaXmEaytP7Tm0BSsuYgiC+ejBhW+oZHsnQZt29KvltZyPLDjOpnqDAiKWNutagGKuINNYwRx
	0R33uoCwWXF9m2FmqVqEc45MT3WVFTcbChF3UIESHy7yU6xD40ZdpIDa4wJ5Wl1bxYdg9r/NKk3tI
	B6JT+PmIPHQ0VpviU11XlqH+O62/+JDPyLvyZWq9NO9EVhe+6MaxPx8pqvya/lRx1e29kZ5UMXXsk
	qW2ZbAww==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaER-0000000FkGB-2iB3
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 07:37:33 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2Rq8t030937;
	Wed, 18 Nov 2026 07:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nK1v63M+HYfXBSkh3
	gnJlH2MsfCwqya2MHfBbnO2HSk=; b=PLRgUoZhQ6n2FzWZaCaELQkZobDFl2a5+
	0BNnduJOE1F62MnWj6Oqyk636C0F94S4NxncNHvXfaYK9nhg04NafFpodxKp5fej
	Y4BTTm2eihQAl7ioeELkXF91WD3JFRar83ePpqSNTUIXNcidMyw1uA3rvwP1ZY5C
	Md0DX/3MocFAcjalF3LBcEo6gjuw3g1f9jzDntWsv7+IfTHrDLLKkVpIk+dAOuZ5
	PfMNUxXNIdfe3mgatw3Enz91KHNG8O42eHVF5ubJL1mp8Ht11zW4PVhEmRmJKT9/
	kTDJf56wrDZTDqJ3aNmenmpYZ7NIWIxOA62BRweGB34nHjRXEB9lA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105n9cyb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:37:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2Yus71428866;
	Wed, 18 Nov 2026 07:37:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j02dfg961-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:37:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI7bBN844040698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 07:37:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7813020040;
	Wed, 18 Nov 2026 07:37:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E868A20049;
	Wed, 18 Nov 2026 07:37:06 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.157.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 07:37:06 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, bvanassche@acm.org, sagi@grimberg.me,
        axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 16/22] nvmet: fix nvmet_ns::device_path access using nvmet_subsys::lock
Date: Wed, 18 Nov 2026 13:04:57 +0530
Message-ID: <20261118073505.288910-17-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118073505.288910-1-nilay@linux.ibm.com>
References: <20261118073505.288910-1-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX9bMv3o8Uj6SH
 Onwq/XaPvKOF7fSR0FwGsh4MoqqiqrMVGi+a/8irwAMYEYgUMnAdLVLxARe18sUoUIrkWzM0dRk
 C+ZLeWOSD+zSOFYIus4/0jk1TlueFt8g1PxU4H3/uiV2dZ44ZacmQ7QyZvH6jkxr3f6LmPJhtWK
 /ZS5UToex1cPu1K/+kW9DmixvBAAENJsF7idV3IXREQzjbgqhaS7H9mF7PVWKFLCJ9Qk5S11z4x
 0paGk9YaFRJvgvaL4a0pWH3DYUNXpwZBSdLy41TZ5uLwTYdTl1ccRS8DUSRtk/P/01OsO0XDdVn
 cB9vQJ5xsmidC3e0cjwEiAg6OIzYHxWVK0CQQ3ZvDilQPCRiroMWnJoDzYkIlSkq/SVbAasGnm1
 k6uar9bDFW0N/C7vHJ0UwvP5DSrNUm5kf8/zRoH6+7BfvETBW7LQ7/4UdQVwuiUjNz0SY0jGwH8
 iZfraYuzzB8cNva9ZCA==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afd55ac cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=naH_Sv8VKW2vHdK1hH4A:9
X-Proofpoint-GUID: 6lJfjLflrIoLaJs4ls5XsHOnHcBHm3Ff
X-Proofpoint-ORIG-GUID: ljjljn6liLxFsYJw7VOJM0N4yDM63zh1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX6t9t2bF8zBHd
 77XjjI6H5GKj0sNJoHSBtZbmMTaRG9qPeELjh+16dGFZL4bsNSjfYyvrafQ6plUTMpod6OKuuk9
 6mZBsNubyORTyPelDlQX1LHPI87b9yQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_073728_336919_5097F072 
X-CRM114-Status: GOOD (  15.37  )
X-Spam-Score: -0.7 (/)
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
index 997d0a1fa07a..a69405279fe3 100644
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
index 6b0ec84a4c09..6c22d5d97d1c 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -713,13 +713,13 @@ void nvmet_ns_free(struct nvmet_ns *ns)
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


