Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59CA606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CAEYXhQH;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=WcNjkHM3;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=K17WOiq8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=jxUsL2mLvtPX7YmW7bSPd8MFC9nCS8HHPkcjwMQ/J/s=; b=CAEYXhQHRwAf6a
	Peu565Gbu33qtG8DPjpwe8ETSMNgxgJvR2nX1SLGGsco+Ke9BEO84ZTsnoHuW9GrfE2NY3UmL+NcB
	lNUSlTHT6hbnUp/TdlG9HdkmLuF1XJlrh9ziKjsYpwpuW9/ZKWvAHwOsW39KYFLjpAMGvZGR6TGl+
	hA+AzuL0V75qzEHo9Pt15BesT1ViAf8WNykI6ZQNnypQopuYW1Fdfy4QP21xhdFLKeIbZs768smud
	cxjxGMbZlr6/REmiWnaFpW1SlhX4ozovmf+ooZ8McRft10OIUdY0Ks2UGWL0EcwdiphrjexKaFymM
	fGouQUdrKALlr6P4vGlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaFD-000000082Ce-3Qgp;
	Wed, 18 Nov 2026 07:38:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaF6-000000082A4-3Dcn
	for linux-nvme@bombadil.infradead.org;
	Wed, 18 Nov 2026 07:38:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=jxUsL2mLvtPX7YmW7bSPd8MFC9nCS8HHPkcjwMQ/J/s=; b=WcNjkHM37jUtJ54hor9E91FVet
	RmEb9JLmcxbyAzjRHW+bTcAlgUz8e6hkiC9PEBUn9X+X5q34c6jYyttBmulgwJRv+lEfWgyN3JhwI
	H6AD0FkavJzKdMN1wj7gBjxQakMFZbJYtoSfxGPHiSPoscjW0pyJY2B8LIWH8gJqvPS34e9SltrSC
	LFoG37JAACM0RCnn5aFlRkeOyL4jFCL2lvOvTACPi6L4WlXsMxP3yelTOMw7scDG/rD1jHdUvzmgR
	mCGwJB13rd3lCMLpepiLlwSrOzSxPBJujUeX6m3O3JAABpRIbLKgjLzjVR+TE9mbZsSFZcHybURa0
	W/Ue7O/g==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaEy-0000000FkJ1-1GMn
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 07:38:04 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2SQMd2432360;
	Wed, 18 Nov 2026 07:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jxUsL2mLvtPX7YmW7
	bSPd8MFC9nCS8HHPkcjwMQ/J/s=; b=K17WOiq8jFNOcU5F5b5ogrYpVLzpewpGr
	28Rn7p91eiNzJtaAdMXbvovtSpQri70U08pecG2eoPUY4huvJumA737sy08TPFui
	ntVCyUo0geujnn3FzFe9bUfC9jcVoBn/upFKMMcjyX3Y/ArF7afsF7uKjuTbPV0i
	YMLdwq4c+PlSlrh+DFi9NLy+aI/X4i88j5BLpap/Y9Hxblz5iVp9XuJZ5PpuwytM
	deoCdp4aKObJJlfgHQQjfn7QxMYXTqE1HM783Pdr5O9I7JKiQzjn+IWPg9Xu+C3m
	8yZxPntWX2qh2G4t2ELnc2GE9ioW9cW9VwS0Y1hSCn/3verUh66pQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105rhcvw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:37:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2Yra41428849;
	Wed, 18 Nov 2026 07:37:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j02dfg96n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:37:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI7bdbc39256546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 07:37:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 808FF20049;
	Wed, 18 Nov 2026 07:37:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E451F2004D;
	Wed, 18 Nov 2026 07:37:34 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.157.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 07:37:34 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, bvanassche@acm.org, sagi@grimberg.me,
        axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 21/22] nvmet: fix nvmet_ns::csi access using nvmet_subsys::lock
Date: Wed, 18 Nov 2026 13:05:02 +0530
Message-ID: <20261118073505.288910-22-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118073505.288910-1-nilay@linux.ibm.com>
References: <20261118073505.288910-1-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: oNclroGVaGA8Fqg1LiQPdnhD0si8k5Fg
X-Authority-Analysis: v=2.4 cv=e8uT2qp/ c=1 sm=1 tr=0 ts=6afd55c9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=MMLL3j20_zw5vxwgO4QA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX5ubkLhyougvi
 p3GVtQTzgaqWXqsitUrrtd+LciPhArwSRVcihrSzctJx9qhjNYELt68PguYzkYU5G7xsQbf8XxN
 DgFgnSQ6cduqScRVHzeMqNymK6q5RaI=
X-Proofpoint-ORIG-GUID: NWDiV0pNAMgyjSH6Tm-Pgx0MWVe4APFm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX0wN1huzDXwth
 bJh+zG8NeijjofyoGkA6+ReKAfRm9jAWkP1+o/NCuto/54pUQUlNkuUyuw5HrWB2cntIlEHxBa0
 aQ4dVPQE3SRvkUQ+YqulYbTJhMubpha6AEZmRm0S+SJiDnWXmX7XdkNFAEJt6OYp/RKP1YqNLqr
 x0m7Zq3veYcgWB6w1X/1kYQcx/+ohLYafpWSGgCs0DoMPK81A/Tc78tzB8D7X9R76/fVQns8vir
 pcNxIOf+64HWUQgmunMBOYpT7JV88j7/eBdvqh81f62mVwHnVdAPpH97APda0SdVmbDVUkEcjXr
 RSkmmWAmdrMGwy2hjJnyMTxkpuSspx5kVvYVxo3xJDmyxJ7eHHVc5eXwyGgMOvIOADBq/qjlzFc
 J0+qjC/kRYu6HAUJMZroAeL66cjQTDRthcmUKYOH2Sn7aPYk7rhMa47UW+eoBdp69vlqTSAlAw/
 RP2bLRtWkZeI7XKKUbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_073802_970725_2492409A 
X-CRM114-Status: GOOD (  15.92  )
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

The nvmet_ns::csi field is protected by nvmet_subsys::lock.
However, nvmet_execute_identify_nslist() accesses ns->csi without
holding the corresponding lock, triggering a Clang context analyzer
error:

drivers/nvme/target/admin-cmd.c:1016:24: error: reading variable 'csi' requires holding mutex 'ns->subsys->lock'
      [-Werror,-Wthread-safety-analysis]
 1016 |                 if (match_css && ns->csi != req->cmd->identify.csi)
      |                                      ^

Fix this by acquiring ctrl->subsys->lock before iterating over the
enabled namespaces.

Although ctrl->subsys->lock and ns->subsys->lock refer to the same
mutex, the Clang context analyzer cannot recognize that they represent
the same lock because they are accessed through different expressions.
Explicitly assert the ns->subsys->lock capability using
__assume_ctx_lock() before accessing ns->csi, and release the assumed
capability using __release_ctx_lock() afterward.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/admin-cmd.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index b0ec1ed7ddfa..de13614b3cb0 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1015,15 +1015,26 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req, bool match_css)
 		goto out;
 	}
 
+	mutex_lock(&ctrl->subsys->lock);
 	nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {
-		if (ns->nsid <= min_nsid)
-			continue;
-		if (match_css && ns->csi != req->cmd->identify.csi)
-			continue;
-		list[i++] = cpu_to_le32(ns->nsid);
+		/*
+		 * Both ctrl->subsys->lock and ns->subsys->lock refer to the
+		 * same lock. However, there's no way to annotate such locking
+		 * semantics using clang context annotation. So explicitly
+		 * assert the capability.
+		 */
+		__assume_ctx_lock(&ns->subsys->lock);
+
+		if (ns->nsid > min_nsid &&
+		    (!match_css || ns->csi == req->cmd->identify.csi))
+			list[i++] = cpu_to_le32(ns->nsid);
+
+		__release_ctx_lock(&ns->subsys->lock);
+
 		if (i == buf_size / sizeof(__le32))
 			break;
 	}
+	mutex_unlock(&ctrl->subsys->lock);
 
 	status = nvmet_copy_to_sgl(req, 0, list, buf_size);
 
-- 
2.53.0


