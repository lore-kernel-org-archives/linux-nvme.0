Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3805606A325
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IzfmtFqq;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=pnaVd1B4;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fJK72isX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Jg/1EqmjK+n5iePH0UhhnhrKR+fxF9xoQhglC21Y3jQ=; b=IzfmtFqq/cVxkn
	Ra2GkX/tTc3nvJ0s8CoPX+rX6ZsFUF/pwq/DE0iHaoO83DpiLC4vShHGY2jet1p1uC2w87XZPSqaV
	2fxLDgs46xwCSStQO9Ci/o6Q2o3kXHtJl+WrkO1aGPhHdbu1yprFX6zbOmcr2mm7jaPxYMb3/dlEB
	GAfX29UBIVBm9tGR8JTEAXmGib3aYVvCdzDH+wvgwKkYBhpLdT4cGrCfiUIfi2P+OQ+tdoYPZH2sx
	crJUpAWnAUt3dzw8Cf9N8uijhFZkgesgoppgGc91K7fGA0ueOQCmMD0XX4e8IDXctVQKAK8MNhCCZ
	Z5m61GBNnLoXd+lHX4BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaFE-000000082EO-2Aop;
	Wed, 18 Nov 2026 07:38:16 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaF6-000000082A1-0nGR
	for linux-nvme@bombadil.infradead.org;
	Wed, 18 Nov 2026 07:38:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Jg/1EqmjK+n5iePH0UhhnhrKR+fxF9xoQhglC21Y3jQ=; b=pnaVd1B4X9tWKCuyXT+iHkaEww
	kQtaEPf2g0qbj6uv34ZKmxTkC+s0LOxb5E5pNJF714kS68q6SkfppdtYGZBk/op72tAdkCePWLQfc
	+1sFcp5kKLv4v5wlUcZXOSFaSgeyRhpFq7XYPq4bQ2F66FSfxtZtR0f7J3mJSQFdCOAMvfxVE0921
	OzC5LiYrEvtVTFo75cb/ZcXJT8cgGRb2D1RaasaCtduTh89OWmjWN0hAcBGCEaPGrTQcKzeVOuKCt
	HJR2/11BsGzFqL+VLiYh44G4XQ1vt5WkDa/WlfElRwAT1qoGQ9Gh981l7ERslOIGAXM4bS67N4QUj
	D/PLy+QQ==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaEw-0000000FkJ5-1Aar
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 07:38:03 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2Se6j2862308;
	Wed, 18 Nov 2026 07:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Jg/1EqmjK+n5iePH0
	UhhnhrKR+fxF9xoQhglC21Y3jQ=; b=fJK72isXxx4kgIjGxGaDe+WTQR2D6zg8Y
	7/h7+sH+AAjTdcli0MtwggC7m2ffeOp6ScnNi4gWtPcZO4VkU7jz8D5jld10KfBg
	trKPkWbPsmps9Mpd1meUFH1ExcTprryChNq13RrKFRPWt07Qh3rlIjABTDsjAA1P
	xcymLgHONeUU9f/OmTzs+0ZSCk/eISYaz9AoO8KtMJ8lDWpli7YjfPQfK4GWfk/K
	xNdZBLVkTU56uV66WlDWCtpaCYvoiQP4+zFNTc7PobOgQ8OjAxnqjxoteyc0za9T
	R/k5oKfz/HOuRRuLzx3avhLVDWIG1x2pJOwNs7tuvHLqDjEIrhVMA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vsb76-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:37:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI789YG1660696;
	Wed, 18 Nov 2026 07:37:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j17c4r2cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:37:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI7bYoo8913208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 07:37:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35EA220040;
	Wed, 18 Nov 2026 07:37:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A527020049;
	Wed, 18 Nov 2026 07:37:29 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.157.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 07:37:29 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, bvanassche@acm.org, sagi@grimberg.me,
        axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 20/22] nvmet: add context annotation for nvmet_ns::csi
Date: Wed, 18 Nov 2026 13:05:01 +0530
Message-ID: <20261118073505.288910-21-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118073505.288910-1-nilay@linux.ibm.com>
References: <20261118073505.288910-1-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: XaH5pKQvaZAMm1G69TXjkViG50DHwDqr
X-Authority-Analysis: v=2.4 cv=Z8x5j3RA c=1 sm=1 tr=0 ts=6afd55c3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=wyQYIfH3qne7WvDzmQEA:9
X-Proofpoint-ORIG-GUID: NqF5feE6k5rNpI-nKVCA-tGzLU1uF4x-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfXz91YBj5tgCe4
 58ERbdDkVwr71XS92XwadGPNaQLcmYOrDTrKFOAQbon+sLWBmC5QmDcvzdJyS+hhgHqbw6x2lUk
 mdRFcfPzWDD/fq91jaleS0AI+TDx1ZY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX6kqW3Xp1d93R
 +OLskj+bJ0ID5f4UKXxDSj7VQpszs2eyYgcUXzVVpqUWN68rYpsNrvegWndDjNXgkWXE1Im3A17
 vy9GspwJ693oq5aRNaKB8HdxLJ/VFVWH5ko0FdS/1nJr8KBV7YgcHot/pxCNaDmJ2BJohcCoOTd
 FOq2nZgHuifycwu37ETYp/ddnLXbQ5vwFokdx/cL6JiR4Qr5d2X4R8CNaFN5o69VRZ07GlMpTDc
 Ejzlvja1KjNO1w3c4nTWHA7/H7/tZEV+C9grCi0A03pidb22KOCoI40g/DG9BJ2uXEhhN1h4jKf
 cPJ/PjwRJCZp/DTlNGB28u4tepX13JHmuU8Ty6HzGOzP5howSIfdAGzbVIX6mVPLbUsvWhhvaaM
 7uEj+bHCf7N2Ev8qAZe9IU7Jt6Yi7JQtpjTSn218208VlhC/z9qoU3eq6wAf52I8WujsxVEZLR3
 emnkpFZjF1VrSyKL7OQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_073802_027366_B9064927 
X-CRM114-Status: GOOD (  16.73  )
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

The nvmet_ns::csi field is protected by nvmet_subsys::lock. Annotate
it with __guarded_by(&subsys->lock) so that the clang context analyzer
can validate accesses to this field.

Some accesses to nvmet_ns::csi in the I/O hotpath do not require
holding nvmet_subsys::lock, as the namespace reference guarantees that
the namespace remains valid and the field is not modified while I/O is
in flight. However, the clang context analyzer cannot express this
access pattern directly.

Introduce nvmet_ns_csi() as an inline helper annotated with
__context_unsafe() to allow these accesses without requiring the
subsystem lock. Convert the relevant accesses in the I/O hotpath and
request-processing paths to use this helper.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/admin-cmd.c | 4 +++-
 drivers/nvme/target/core.c      | 2 +-
 drivers/nvme/target/nvmet.h     | 4 +++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index ea43d83d269b..b0ec1ed7ddfa 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1059,6 +1059,7 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 	off_t off = 0;
 	u16 status;
 	uuid_t uuid;
+	u8 csi;
 
 	status = nvmet_req_find_ns(req);
 	if (status)
@@ -1081,9 +1082,10 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 			goto out;
 	}
 
+	csi = nvmet_ns_csi(req->ns);
 	status = nvmet_copy_ns_identifier(req, NVME_NIDT_CSI,
 					  NVME_NIDT_CSI_LEN,
-					  &req->ns->csi, &off);
+					  &csi, &off);
 	if (status)
 		goto out;
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 6c22d5d97d1c..e3aab719629c 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1175,7 +1175,7 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 			return ret;
 	}
 
-	switch (req->ns->csi) {
+	switch (nvmet_ns_csi(req->ns)) {
 	case NVME_CSI_NVM:
 		if (nvmet_ns_file(req->ns))
 			ret = nvmet_file_parse_io_cmd(req);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 1da9cfacfc4c..1123c9c708df 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -192,7 +192,8 @@ struct nvmet_ns {
 		__guarded_by(&subsys->lock);
 	int			metadata_size
 		__guarded_by(&subsys->lock);
-	u8			csi;
+	u8			csi
+		__guarded_by(&subsys->lock);
 	struct nvmet_pr		pr;
 	struct xarray		pr_per_ctrl_refs;
 #ifdef CONFIG_NVME_TARGET_DEBUGFS
@@ -223,6 +224,7 @@ NVMET_NS_ACCESSOR(bool, buffered_io)
 NVMET_NS_ACCESSOR(const char *, device_path)
 NVMET_NS_ACCESSOR(int, pi_type)
 NVMET_NS_ACCESSOR(int, metadata_size)
+NVMET_NS_ACCESSOR(u8, csi)
 
 /*
  * These accessors use data_race() and READ_ONCE() marker to allow lockless
-- 
2.53.0


