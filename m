Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3FF606A334
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 03:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pDVSHcsC;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bunQEUO0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=31MayTw7XoFLiR854CiPiPHt+S0T2Rc6igGvruAUqow=; b=pDVSHcsCZdt5ys
	wsR81gSW7vI8dV0HMr90bTXQ7iloQOSPqY5/9jgR38DOut9X/8M51HSFjv7jlJeNOOUpA3QALRBzV
	HTyRueMvpINK1SXTe87OH9+TH8Hq5MQa+PW5hEFC2gQkhiyAL71lOxz53e94fOc9vud8nYcEjdUEO
	RoMpyUx+epyPbNkri29roLDxwj/ppdmwZtNvDXK6XRkFxx4tMBtPSBSJOK04UWcElV5Vl3SBoAdW/
	yGLfr9wNftj2F1IIIInqf1oguSCDKmJ+O3saKEXjU15P93HEQ990iGFn4ubnngjr9PN2JkG9daU7V
	B/n9XZa2IsK3On+IYQXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG8x-0000000HEQL-38h5;
	Mon, 09 Nov 2026 03:34:03 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG8u-0000000HEMt-1ohU
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 03:34:02 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90i9tQ1945565;
	Mon, 9 Nov 2026 03:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=31MayTw7XoFLiR854
	CiPiPHt+S0T2Rc6igGvruAUqow=; b=bunQEUO0GsvzafpxdpnbF+bGtftZihmAx
	Rm8OyB+uF7o3oeubqnhqx2xfyd4t/h5OSQFyCkTTDnzc+hFPgiFsCMaskurLkesp
	9htiXI7x5dL/GLsrvhngL0lEDQ8Gutfm/XYhK63sAsM81pqlFoyO6DsSIKERU6Ec
	WWaGKYiXN+aCieNpZNtJSwtWqyYvz+n5MPCU/AzumJjvovLACOwzvSATLXP+t0XM
	XL4uozb+vCtpplA7xn8QXUEW07psJy6a2Woh1D5SUeNfEQVLNNGoEzGvSgyVnjQu
	It07IRndESD546mNZSX+gyu8hOtyjZF5FwmUTZLvyD6o0yrTy8dug==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq6jeme-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:33:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A93Jtu03535201;
	Mon, 9 Nov 2026 03:33:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfajwft9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:33:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A93XlOY27132200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 03:33:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BFC520043;
	Mon,  9 Nov 2026 03:33:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89D9F20040;
	Mon,  9 Nov 2026 03:33:41 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.101.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 03:33:40 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, bvanassche@acm.org, elver@google.com,
        linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 22/23] nvmet: add context annotation for nvmet_ns::csi
Date: Mon,  9 Nov 2026 08:58:27 +0530
Message-ID: <20261109033102.982191-47-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109033102.982191-25-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX4aZeukl9Bc/U
 0LfTMBrnEyAuAEck9FW60RQ9Ytc9i0RVgtMKj32D7ray6vhxhTBYjY04Ey6B0n/v8SrnlaAUHDb
 uS7eUHQEGq65HhWvC6ZV0iCm1X43maI=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af13f21 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=pDIm6Gb1FyeRYUyaR0YA:9
X-Proofpoint-ORIG-GUID: _b8yw8fSMLPEzdWHcxdkzqPhgrtkwbFy
X-Proofpoint-GUID: mGwssjQGGshc4qqu9_z2TExg-epPGMni
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfXzJAer81/K9f6
 1a/vu7YnprMLNo+Q1pGrQwlmQX9fUxvwxaeSrFdecSd7OqGpbdj94Wq6s+mQMtI18tY7VqiSLPb
 U5HE3VusKwTGgJcvsBG/h/RI4hQXj60rimJxGCJTmlqS9qlWDIgOAZbDcxkvwFMgspfbeWNiMaT
 1o+B8xJ4ngnXWvN+/QmDlhLQU7meyq/yEEnyQ+/tCHj+G/GCSjrspW7F94URqvfi7e+Ed6Z+Hn2
 cLYLtQa9x6p419riM15zfZTTitUPjNFJoL6zjEJTqzL2jM+ox93fXcp/2nGtF+L6epRvPFfYu6w
 YFHRPgfIlh3UIm9gPPUyw/pmP5h5gmwMi+DaaRXNaZcBJGZC2XVGK8lZYBVWLsgwEcm1aHoiIMl
 Hd5eQxvvNUV+6CXFV/0py7FjaLV69xpEMYEGi1IhJ2H+WEzgv/0SxylhtpSyhYc2PFLSD4L91OI
 s4iGM8ynuxD3fPrNqFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_193400_505959_33FB6B72 
X-CRM114-Status: GOOD (  16.48  )
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

Additionally, nvmet_ns_alloc() initializes ns->csi to NVME_CSI_NVM
outside the subsystem lock, triggering a context analyzer error.
Although this initialization could be omitted because both the nvmet_ns
is zero-allocated and NVME_CSI_NVM is also defined as zero, explicitly
initializing the ns->csi to NVME_CSI_NVM makes the intended default
value much clear. So move the ns->csi initialization into the existing
subsys->lock critical section instead.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/admin-cmd.c | 4 +++-
 drivers/nvme/target/core.c      | 5 ++---
 drivers/nvme/target/nvmet.h     | 4 +++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index e40fc361f5b6..74e76e12cf26 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1083,6 +1083,7 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 	off_t off = 0;
 	u16 status;
 	uuid_t uuid;
+	u8 csi;
 
 	status = nvmet_req_find_ns(req);
 	if (status)
@@ -1105,9 +1106,10 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
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
index 6b11beb2e2b2..1e55ca344c96 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -772,6 +772,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 
 	subsys->nr_namespaces++;
 	uuid_gen(&ns->uuid);
+	ns->csi = NVME_CSI_NVM;
 
 	__release_ctx_lock(&ns->subsys->lock);
 	mutex_unlock(&subsys->lock);
@@ -781,8 +782,6 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	nvmet_ana_group_enabled[ns->anagrpid]++;
 	up_write(&nvmet_ana_sem);
 
-	ns->csi = NVME_CSI_NVM;
-
 	return ns;
 out_exit:
 	subsys->max_nsid = nvmet_max_nsid(subsys);
@@ -1184,7 +1183,7 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 			return ret;
 	}
 
-	switch (req->ns->csi) {
+	switch (nvmet_ns_csi(req->ns)) {
 	case NVME_CSI_NVM:
 		if (nvmet_ns_file(req->ns))
 			ret = nvmet_file_parse_io_cmd(req);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 082d848ea2b0..77d518739f91 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -193,7 +193,8 @@ struct nvmet_ns {
 		__guarded_by(&subsys->lock);
 	int			metadata_size
 		__guarded_by(&subsys->lock);
-	u8			csi;
+	u8			csi
+		__guarded_by(&subsys->lock);
 	struct nvmet_pr		pr;
 	struct xarray		pr_per_ctrl_refs;
 #ifdef CONFIG_NVME_TARGET_DEBUGFS
@@ -225,6 +226,7 @@ NVMET_NS_ACCESSOR(bool, buffered_io)
 NVMET_NS_ACCESSOR(const char *, device_path)
 NVMET_NS_ACCESSOR(int, pi_type)
 NVMET_NS_ACCESSOR(int, metadata_size)
+NVMET_NS_ACCESSOR(u8, csi)
 
 /*
  * These accessors use data_race() and READ_ONCE() to allow lockless access to
-- 
2.53.0


