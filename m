Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAEF606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 07:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rZNK6h54;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=HNpg1TIU;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jxmM7BZt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=nt5ozwjBEMiEVEYZcSWjOO3NLkys1v29LcjFuKP5fCs=; b=rZNK6h54Wj94RW
	Oo94IcIHcs2l0957+NtlGwopya3Vtgast9rz1zE6MOalw+ZuRF3b8RPAjZY88Gb7wquvQn4cGAqhN
	LdC1iIDdt79oIFJK6wpA7CkMteiXCG+QB5wA1hYbwYn5wkyBumbeu768G/PZYtqN1teXyKCfVtGEx
	+1LBs6nCXzyA5PkKilQyKVBueePDdUAhF7XJ7xkLxYlo83r0h/UxQMx5NoCRnEjo6N6JB2yRZok7/
	mHBRtV7CKUoLLv392zh38v3zpycHirHc5en22oaDQ2oZetvh5aTQp1B0tOLMy9s8a444llaWANj9f
	ltoqxFFlZzamYX1/Fw1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaFK-000000082IP-2uy1;
	Wed, 18 Nov 2026 07:38:22 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaFJ-000000082H7-2TlJ
	for linux-nvme@bombadil.infradead.org;
	Wed, 18 Nov 2026 07:38:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=nt5ozwjBEMiEVEYZcSWjOO3NLkys1v29LcjFuKP5fCs=; b=HNpg1TIUQDZ9Xrm+U6XuLMnNtV
	fwSzB6jpEjvabj48oJgALW+JPUK7krdn1RgW7E2Czh9xLUivRIjNSe+z1G61wBzW3jfUNJrkfE045
	NtDcKiuOjhE1YXgHtUaqTaHuG6GML0wE8bqYReQMyD9lGwuOd3/NhOM720b6gxrqbniiQavzVRfCT
	pvHMR76nDsyp8/8Ke+U0WaJbHz+QnfRopBvHC2Zgj57TkhJej6mJjRvH8yl+gtv0fyiJGZ1gSqdoI
	cX/tDYNgs7bmETCuqS6kUEELfAm/Pp6S1pFEupXYLBLwerHIR8E7s5pMdjLaOZEmN8NwRiSdseFRX
	UuORoXdw==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaF8-0000000FkKZ-2UJu
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 07:38:15 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2RxZt4081513;
	Wed, 18 Nov 2026 07:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nt5ozwjBEMiEVEYZc
	SWjOO3NLkys1v29LcjFuKP5fCs=; b=jxmM7BZtF4pGZ/SdqNz+p8szg4tu8WMmK
	Le6DHF2qRAW/B9bffgZblHrAHHVxHbu8mPytXm+qs6rd+CT51Z7ngnVw1kxK3hni
	3r17LYJjM+Tvjbyi4pAFUYwJ3QPoYwLgkcyZ2H2RqRqwjnJ+J3skLdL54PuNhg0P
	cnF1y8FIObf7A/yzPlWjeQCUxODz1TNTMUeemoTEvDeNRVqcsqQxm1gRtIHjfTqS
	IttiG2C7UfWWByTD0uvQZJW4SSehNaH0hZLqpp+VYt7Via5VbFCCpp1bVZdG3U2v
	3LXNVBDWmEuWOuptcj8GvPXK+4rtsxKI1ORkDfX71LcXNuA3yN7AA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vhbj9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:36:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2YrZt1428849;
	Wed, 18 Nov 2026 07:36:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j02dfg95d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:36:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI7aorl46530892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 07:36:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F1C32004B;
	Wed, 18 Nov 2026 07:36:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44E1C2004E;
	Wed, 18 Nov 2026 07:36:44 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.157.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 07:36:43 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, bvanassche@acm.org, sagi@grimberg.me,
        axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 12/22] nvmet: fix nvmet_ns::buffered_io access using nvmet_subsys::lock
Date: Wed, 18 Nov 2026 13:04:53 +0530
Message-ID: <20261118073505.288910-13-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118073505.288910-1-nilay@linux.ibm.com>
References: <20261118073505.288910-1-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Ev0D_zKLy2oUHRAogl9D-184kmG3fMG8
X-Authority-Analysis: v=2.4 cv=HL9WhYtv c=1 sm=1 tr=0 ts=6afd5597 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=5XwtiEGi6nClZfde2SwA:9
X-Proofpoint-ORIG-GUID: HtXsUWmbCi539qoaZ5Md8z94xwSI_3ra
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfXwBD74c7GlVpk
 OJWwvqX+ocBPCHvZ2IfO8fQaz00nSufQ1ZWWbPXh9jivZoidpJ3WIWs3E1W/LbDc82xD1d74ikm
 +p8fBzLxHC6DpERxND93jQMSstNqsqNZXtPC4l8WA9iTrMFrE7z1VgG0ALZAG3Fh5BqkdBidr/A
 Ccz2MKi2OrNx86knqAsHiCNL3rYE82I20Uc6u9NPIWWjE77qyGY6Kclps1ggwR07hkjczEFv+O7
 JIMByoLzKAxEItXza+4EG7jYLc8fYRhTSx7clNRjFRLxV8p2cQt2d8CcTtBwpBN5rqOLSgdKBuy
 vBPDQJYGVaDKSuOmew3yAF+pduS8US3IbCuHCSy/6Occ1Ny8O/yn5FEP3DIKMyY+3TXC+qwcy0W
 Np4imzTNjShWYzH0fgHSIHMMrOzHJ8zGfpZ8TsGvSL3I6aBaLfdEe6/9rd2giFcXsbKAg89pAy9
 40+sdbNnTregzstwMeg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX2VNyjE4xaksr
 nUpsTfaSWVVtjj1uvRv8zEvQT4R9umXdEL3KTrAfk6ckuDXsZEV5DeqKizza9h1MSPIZ1hlUgjh
 Lrr7yTk/mArlEN8P/Xu5eXc0JK6utGo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_073813_839030_0EBD938A 
X-CRM114-Status: GOOD (  14.31  )
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

nvmet_ns::buffered_io field is protected by nvmet_subsys::lock, however
nvmet_ns_buffered_io_show() accesses nvmet_ns::buffered_io without
holding this lock, triggering a Clang context analyzer error:

drivers/nvme/target/configfs.c:773:50: error: reading variable 'buffered_io' requires holding mutex 'to_nvmet_ns(item).subsys->lock'
      [-Werror,-Wthread-safety-analysis]
  773 |         return sprintf(page, "%d\n", to_nvmet_ns(item)->buffered_io);
      |

Fix the above error by first acquiring nvmet_subsys::lock in
nvmet_ns_buffered_io_show() before accessing nvmet_ns::buffered_io.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/configfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 10249affcccc..154d917ed21d 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -770,7 +770,14 @@ CONFIGFS_ATTR(nvmet_ns_, enable);
 
 static ssize_t nvmet_ns_buffered_io_show(struct config_item *item, char *page)
 {
-	return sprintf(page, "%d\n", to_nvmet_ns(item)->buffered_io);
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	ssize_t ret;
+
+	mutex_lock(&ns->subsys->lock);
+	ret = sprintf(page, "%d\n", ns->buffered_io);
+	mutex_unlock(&ns->subsys->lock);
+
+	return ret;
 }
 
 static ssize_t nvmet_ns_buffered_io_store(struct config_item *item,
-- 
2.53.0


