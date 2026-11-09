Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3DE606A320
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 03:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3saGPVoV;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CQkDQ9FE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=PkH39KngfHRH7MeSvHNKyjBCh1aAXbr5V4zaierMMZc=; b=3saGPVoVowR3E3
	VxvqZTsAposJCBvPaZWj3krcFVNXu8rdLCqt5vlbUVYVz9aAAdkm0XDwFSUPrD5zyqv8cfB9n5KX1
	aRN0JN8fqP+rl0NX3pKortkRvmRD5Pgbaor4do0dp1C5lqL0n/oRNdCjqlGfDNl6NgXZ1LIKDCKSt
	q/LxcqCHZz40ZjqT1VWWtNG8+VKsRefkq6WvTB9QKruHygYr2P90p4q/3gwCevVI9ZamorRScKsT9
	7bbiiTB4XTNQWpwrwCyqphkW9yVq6eJxOXKUqy2N5yI9qzBCuMmbxkwigHPImoyJ8CPPcHt+nq9KG
	FguFHYp0i1p56qAgAl3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG6q-0000000HCN8-0Kgn;
	Mon, 09 Nov 2026 03:31:52 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG6n-0000000HCLy-0wb4
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 03:31:50 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90i6OP2148855;
	Mon, 9 Nov 2026 03:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PkH39KngfHRH7MeSv
	HNKyjBCh1aAXbr5V4zaierMMZc=; b=CQkDQ9FE6M2jeNG+RyxX026Z6LCMQwXKP
	L16yIOPqc9jbhZri8UNz60/23Dt3yJC/G7ujzjR7rSI3UskjvIXTwCRLoKfKoHeH
	PuBVHN6TXizkvnWPkR9O1PpoKrn0Xnd6OXeQVjMPiTmyCJHevXtzO7dNwutT86jd
	/dMOBlXBa0XJuqLbx3bwHyjG2UTjXLEyU3ixMx+TBwBnhlblfKklEasUcj6zmSuC
	dBJOKROeJgraNeqrEW+Q/H1Ys0fIfKMaASI3HpNZyYALmtFRztgei/jHkDFgsxRk
	Pd4KynXI9Hm5pmf+BGiHgA7qDjThxyy6yao1FzzbtsZCOIZ/1TJwg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug5tg4t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:31:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A93JrKr3580580;
	Mon, 9 Nov 2026 03:31:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hteapwp2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:31:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A93VPaH32899376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 03:31:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCA552004B;
	Mon,  9 Nov 2026 03:31:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47A7720040;
	Mon,  9 Nov 2026 03:31:20 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.101.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 03:31:19 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, bvanassche@acm.org, elver@google.com,
        linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 01/23] nvmet: add context annotation for nvmet_ns::bdev
Date: Mon,  9 Nov 2026 08:58:06 +0530
Message-ID: <20261109033102.982191-26-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109033102.982191-25-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: dhvBiyqvOxH8IKwMUg1-D7z1ShhvEyA2
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af13e92 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=0sCugQN_XfweZRY6_x4A:9
X-Proofpoint-GUID: 9FCDpe5QQN3wg42R6Vnd-0YjEuHRuBO1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfXwP8Sd26afTrA
 eGCrlT7em58JYDPjmp6oUw5nkDIy6mygKoDFpprA8mpz+4Xa3Ubd+IFDpbHgzncBDJZBTaOUtKF
 Ymr/ShqF+HHeAQcXAjMYefnbxOTe2GBXlqtsqv6lIkTXbC80bIw93mF41nm69C95sCqlqszG+Tr
 0STuzm63jF/R3TKLql18Wdx7cVdVAAgHRs46A1XtMLAyGQdSj5iSSgSW5QxR3FGEK5xTAFgjSdl
 z4Z4a+6IQco+PKFsjxWv/2x4j7bcglMCaG3gVZ+T+zdFQKr+MNQ+9dzPcwCj7PJ1qckVfM18JLM
 vD6hIx9+sftFPaagugXjoXw3I+tjtCtja3I5KEtXrEU7HZI/rQGqXAxVC0CeBvaS9gCdFtq7Vkq
 H/LrgIR0KH8o7OhssYY6vzPP/9HHD4XAOe/wP984G+9x5sM8MkbcPKouxZwitDVOFWpWrXMuXHS
 VKKIOmKu9VwtFWcgFRw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX5yHoaD6F5a+O
 8goCvUxskBHf1VYnnEtrM9c5vjIXlk196xXid9jJsQ4HCsLB3GeGgonKznVQWDjlf6FOUgI9bg6
 9UgpHETqcHAtYv3T+S/TnMuZAkB6kHo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_193149_277641_2A76C23C 
X-CRM114-Status: GOOD (  23.07  )
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

The nvmet_ns::bdev field is protected by nvmet_subsys::lock. Annotate
it with __guarded_by(&subsys->lock) so that the clang context analyzer
can validate accesses to this field.

Some accesses to nvmet_ns::bdev in the I/O hotpath do not require
holding nvmet_subsys::lock, as the namespace reference guarantees that
the namespace remains valid and the field is not modified while I/O is
in flight. However, the clang context analyzer cannot express this
access pattern directly. So introduce nvmet_ns_bdev() as an inline
helper annotated with __context_unsafe() to allow these accesses
without requiring the subsystem lock. Convert the relevant accesses in
the I/O hotpath and other request-processing paths to use this helper.

Additionally, annotate namespace enable, disable, revalidation and
write protect functions with __must_hold() to make their locking
requirements explicit. This includes the block device and P2P memory
namespace operations.

When accessing the same subsystem lock through different expressions,
such as subsys->lock, ctrl->subsys->lock and ns->subsys->lock the clang
context analyzer cannot infer that they refer to the same lock. Use
__assume_ctx_lock() to explicitly assert the corresponding locking
capability at relevant call sites.

Since nvmet_ns_revalidate() requires callers to hold ns->subsys->lock,
acquire req->ns->subsys->lock before invoking it from
nvmet_execute_identify_ns() and nvmet_execute_identify_ns_zns().

Finally, update nvmet_set_feat_write_protect() to acquire
req->ns->subsys->lock instead of subsys->lock. Both expressions refer
to the same lock, but using the former allows the context analyzer to
correctly validate the locking requirement of
nvmet_write_protect_flush_sync().

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/admin-cmd.c   |  52 ++++++------
 drivers/nvme/target/core.c        |  27 +++++-
 drivers/nvme/target/io-cmd-bdev.c |  22 ++---
 drivers/nvme/target/nvmet.h       | 136 ++++++++++++++++++------------
 drivers/nvme/target/rdma.c        |   2 +-
 drivers/nvme/target/zns.c         |  44 +++++-----
 6 files changed, 170 insertions(+), 113 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 6732d6d078e3..2d4e21b3ee7d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -259,15 +259,17 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 		return status;
 
 	/* we don't have the right data for file backed ns */
-	if (!req->ns->bdev)
+	if (!nvmet_ns_bdev(req->ns))
 		return NVME_SC_SUCCESS;
 
-	host_reads = part_stat_read(req->ns->bdev, ios[READ]);
+	host_reads = part_stat_read(nvmet_ns_bdev(req->ns), ios[READ]);
 	data_units_read =
-		DIV_ROUND_UP(part_stat_read(req->ns->bdev, sectors[READ]), 1000);
-	host_writes = part_stat_read(req->ns->bdev, ios[WRITE]);
+		DIV_ROUND_UP(part_stat_read(nvmet_ns_bdev(req->ns),
+				sectors[READ]), 1000);
+	host_writes = part_stat_read(nvmet_ns_bdev(req->ns), ios[WRITE]);
 	data_units_written =
-		DIV_ROUND_UP(part_stat_read(req->ns->bdev, sectors[WRITE]), 1000);
+		DIV_ROUND_UP(part_stat_read(nvmet_ns_bdev(req->ns),
+				sectors[WRITE]), 1000);
 
 	put_unaligned_le64(host_reads, &slog->host_reads[0]);
 	put_unaligned_le64(data_units_read, &slog->data_units_read[0]);
@@ -319,7 +321,7 @@ static void nvmet_execute_get_log_page_rmi(struct nvmet_req *req)
 	if (status)
 		goto out;
 
-	if (!req->ns->bdev || !bdev_rot(req->ns->bdev)) {
+	if (!nvmet_ns_bdev(req->ns) || !bdev_rot(nvmet_ns_bdev(req->ns))) {
 		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		goto out;
 	}
@@ -336,7 +338,7 @@ static void nvmet_execute_get_log_page_rmi(struct nvmet_req *req)
 	}
 
 	log->endgid = req->cmd->get_log_page.lsi;
-	disk = req->ns->bdev->bd_disk;
+	disk = nvmet_ns_bdev(req->ns)->bd_disk;
 	if (disk && disk->ia_ranges)
 		log->numa = cpu_to_le16(disk->ia_ranges->nr_ia_ranges);
 	else
@@ -537,15 +539,17 @@ static void nvmet_execute_get_log_page_endgrp(struct nvmet_req *req)
 		goto out;
 	}
 
-	if (!req->ns->bdev)
+	if (!nvmet_ns_bdev(req->ns))
 		goto copy;
 
-	host_reads = part_stat_read(req->ns->bdev, ios[READ]);
+	host_reads = part_stat_read(nvmet_ns_bdev(req->ns), ios[READ]);
 	data_units_read =
-		DIV_ROUND_UP(part_stat_read(req->ns->bdev, sectors[READ]), 1000);
-	host_writes = part_stat_read(req->ns->bdev, ios[WRITE]);
+		DIV_ROUND_UP(part_stat_read(nvmet_ns_bdev(req->ns),
+				sectors[READ]), 1000);
+	host_writes = part_stat_read(nvmet_ns_bdev(req->ns), ios[WRITE]);
 	data_units_written =
-		DIV_ROUND_UP(part_stat_read(req->ns->bdev, sectors[WRITE]), 1000);
+		DIV_ROUND_UP(part_stat_read(nvmet_ns_bdev(req->ns),
+				sectors[WRITE]), 1000);
 
 	put_unaligned_le64(host_reads, &log->hrc[0]);
 	put_unaligned_le64(data_units_read, &log->dur[0]);
@@ -859,11 +863,10 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 		goto done;
 	}
 
-	if (nvmet_ns_revalidate(req->ns)) {
-		mutex_lock(&req->ns->subsys->lock);
+	mutex_lock(&req->ns->subsys->lock);
+	if (nvmet_ns_revalidate(req->ns))
 		nvmet_ns_changed(req->ns->subsys, req->ns->nsid);
-		mutex_unlock(&req->ns->subsys->lock);
-	}
+	mutex_unlock(&req->ns->subsys->lock);
 
 	/*
 	 * nuse = ncap = nsze isn't always true, but we have no way to find
@@ -880,8 +883,8 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 		break;
 	}
 
-	if (req->ns->bdev)
-		nvmet_bdev_set_limits(req->ns->bdev, id);
+	if (nvmet_ns_bdev(req->ns))
+		nvmet_bdev_set_limits(nvmet_ns_bdev(req->ns), id);
 
 	/*
 	 * We just provide a single LBA format that matches what the
@@ -1095,8 +1098,8 @@ static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
 		status = NVME_SC_INTERNAL;
 		goto out;
 	}
-	if (req->ns->bdev)
-		nvmet_bdev_set_nvm_limits(req->ns->bdev, id);
+	if (nvmet_ns_bdev(req->ns))
+		nvmet_bdev_set_nvm_limits(nvmet_ns_bdev(req->ns), id);
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 	kfree(id);
 out:
@@ -1123,14 +1126,14 @@ static void nvmet_execute_id_cs_indep(struct nvmet_req *req)
 	id->nmic = NVME_NS_NMIC_SHARED;
 	if (req->ns->readonly)
 		id->nsattr |= NVME_NS_ATTR_RO;
-	if (req->ns->bdev && bdev_rot(req->ns->bdev))
+	if (nvmet_ns_bdev(req->ns) && bdev_rot(nvmet_ns_bdev(req->ns)))
 		id->nsfeat |= NVME_NS_ROTATIONAL;
 	/*
 	 * We need flush command to flush the file's metadata,
 	 * so report supporting vwc if backend is file, even
 	 * though buffered_io is disable.
 	 */
-	if (req->ns->bdev && !bdev_write_cache(req->ns->bdev))
+	if (nvmet_ns_bdev(req->ns) && !bdev_write_cache(nvmet_ns_bdev(req->ns)))
 		id->nsfeat |= NVME_NS_VWC_NOT_PRESENT;
 
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
@@ -1216,6 +1219,7 @@ static void nvmet_execute_abort(struct nvmet_req *req)
 }
 
 static u16 nvmet_write_protect_flush_sync(struct nvmet_req *req)
+	__must_hold(&req->ns->subsys->lock)
 {
 	u16 status;
 
@@ -1239,7 +1243,7 @@ static u16 nvmet_set_feat_write_protect(struct nvmet_req *req)
 	if (status)
 		return status;
 
-	mutex_lock(&subsys->lock);
+	mutex_lock(&req->ns->subsys->lock);
 	switch (write_protect) {
 	case NVME_NS_WRITE_PROTECT:
 		req->ns->readonly = true;
@@ -1257,7 +1261,7 @@ static u16 nvmet_set_feat_write_protect(struct nvmet_req *req)
 
 	if (!status)
 		nvmet_ns_changed(subsys, req->ns->nsid);
-	mutex_unlock(&subsys->lock);
+	mutex_unlock(&req->ns->subsys->lock);
 	return status;
 }
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index cc1955bc8c84..c9837263898a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -484,12 +484,14 @@ void nvmet_put_namespace(struct nvmet_ns *ns)
 }
 
 static void nvmet_ns_dev_disable(struct nvmet_ns *ns)
+	__must_hold(&ns->subsys->lock)
 {
 	nvmet_bdev_ns_disable(ns);
 	nvmet_file_ns_disable(ns);
 }
 
 static int nvmet_p2pmem_ns_enable(struct nvmet_ns *ns)
+	__must_hold(&ns->subsys->lock)
 {
 	int ret;
 	struct pci_dev *p2p_dev;
@@ -535,12 +537,19 @@ static int nvmet_p2pmem_ns_enable(struct nvmet_ns *ns)
 
 static void nvmet_p2pmem_ns_add_p2p(struct nvmet_ctrl *ctrl,
 				    struct nvmet_ns *ns)
+	__must_hold(&ctrl->subsys->lock)
 {
 	struct device *clients[2];
 	struct pci_dev *p2p_dev;
 	int ret;
 
 	lockdep_assert_held(&ctrl->subsys->lock);
+	/*
+	 * Both ctrl->subsys->lock and ns->subsys->lock refers to the same lock.
+	 * However there's no way for us to annotate such locking semantics
+	 * using clang context annotation. So explicitly assert the capability.
+	 */
+	__assume_ctx_lock(&ns->subsys->lock);
 
 	if (!ctrl->p2p_client || !ns->use_p2pmem)
 		return;
@@ -615,8 +624,16 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	if (ret)
 		goto out_dev_disable;
 
-	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		/*
+		 * Both subsys->lock and ctrl->subsys->lock refers to the same
+		 * lock. However there's no way for us to annotate such locking
+		 * semantics using clang context annotation. So explicitly
+		 * assert the capability.
+		 */
+		__assume_ctx_lock(&ctrl->subsys->lock);
 		nvmet_p2pmem_ns_add_p2p(ctrl, ns);
+	}
 
 	if (ns->pr.enable) {
 		ret = nvmet_pr_init_ns(ns);
@@ -1576,6 +1593,7 @@ bool nvmet_host_allowed(struct nvmet_subsys *subsys, const char *hostnqn)
 
 static void nvmet_setup_p2p_ns_map(struct nvmet_ctrl *ctrl,
 		struct device *p2p_client)
+	__must_hold(&ctrl->subsys->lock)
 {
 	struct nvmet_ns *ns;
 	unsigned long idx;
@@ -1733,6 +1751,13 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	if (ret)
 		goto init_pr_fail;
 	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
+
+	/*
+	 * Both subsys->lock and ctrl->subsys->lock refers to the same lock.
+	 * However there's no way for us to annotate such locking semantics
+	 * using clang context annotation. So explicitly assert the capability.
+	 */
+	__assume_ctx_lock(&ctrl->subsys->lock);
 	nvmet_setup_p2p_ns_map(ctrl, args->p2p_client);
 	nvmet_debugfs_ctrl_setup(ctrl);
 	mutex_unlock(&subsys->lock);
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 72618dced191..7c263cb169a8 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -73,6 +73,7 @@ void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
 }
 
 static void nvmet_bdev_ns_enable_integrity(struct nvmet_ns *ns)
+	__must_hold(&ns->subsys->lock)
 {
 	struct blk_integrity *bi = bdev_get_integrity(ns->bdev);
 
@@ -206,7 +207,7 @@ static int nvmet_bdev_alloc_bip(struct nvmet_req *req, struct bio *bio,
 	int rc;
 	size_t resid, len;
 
-	bi = bdev_get_integrity(req->ns->bdev);
+	bi = bdev_get_integrity(nvmet_ns_bdev(req->ns));
 	if (unlikely(!bi)) {
 		pr_err("Unable to locate bio_integrity\n");
 		return -ENODEV;
@@ -291,11 +292,11 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 
 	if (nvmet_use_inline_bvec(req)) {
 		bio = &req->b.inline_bio;
-		bio_init(bio, req->ns->bdev, req->inline_bvec,
+		bio_init(bio, nvmet_ns_bdev(req->ns), req->inline_bvec,
 			 ARRAY_SIZE(req->inline_bvec), opf);
 	} else {
-		bio = bio_alloc(req->ns->bdev, bio_max_segs(sg_cnt), opf,
-				GFP_KERNEL);
+		bio = bio_alloc(nvmet_ns_bdev(req->ns), bio_max_segs(sg_cnt),
+				opf, GFP_KERNEL);
 	}
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_private = req;
@@ -320,8 +321,9 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 				}
 			}
 
-			bio = bio_alloc(req->ns->bdev, bio_max_segs(sg_cnt),
-					opf, GFP_KERNEL);
+			bio = bio_alloc(nvmet_ns_bdev(req->ns),
+					bio_max_segs(sg_cnt), opf,
+					GFP_KERNEL);
 			bio->bi_iter.bi_sector = sector;
 
 			bio_chain(bio, prev);
@@ -349,7 +351,7 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 {
 	struct bio *bio = &req->b.inline_bio;
 
-	if (!bdev_write_cache(req->ns->bdev)) {
+	if (!bdev_write_cache(nvmet_ns_bdev(req->ns))) {
 		nvmet_req_complete(req, NVME_SC_SUCCESS);
 		return;
 	}
@@ -357,7 +359,7 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 	if (!nvmet_check_transfer_len(req, 0))
 		return;
 
-	bio_init(bio, req->ns->bdev, req->inline_bvec,
+	bio_init(bio, nvmet_ns_bdev(req->ns), req->inline_bvec,
 		 ARRAY_SIZE(req->inline_bvec), REQ_OP_WRITE | REQ_PREFLUSH);
 	bio->bi_private = req;
 	bio->bi_end_io = nvmet_bio_done;
@@ -392,7 +394,7 @@ static void nvmet_bdev_execute_discard(struct nvmet_req *req)
 
 		nr_sects = (sector_t)le32_to_cpu(range.nlb) <<
 			   (ns->blksize_shift - 9);
-		__blkdev_issue_discard(ns->bdev,
+		__blkdev_issue_discard(nvmet_ns_bdev(ns),
 				nvmet_lba_to_sect(ns, range.slba), nr_sects,
 				GFP_KERNEL, &bio);
 	}
@@ -442,7 +444,7 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
 		(req->ns->blksize_shift - 9));
 
-	ret = __blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
+	ret = __blkdev_issue_zeroout(nvmet_ns_bdev(req->ns), sector, nr_sector,
 			GFP_KERNEL, &bio, 0);
 	if (bio) {
 		bio->bi_private = req;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 2c2460ef5e2b..41912877ade3 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -98,10 +98,60 @@ struct nvmet_pr_per_ctrl_ref {
 	uuid_t			hostid;
 };
 
+struct nvmet_subsys {
+	enum nvme_subsys_type	type;
+
+	struct mutex		lock;
+	struct kref		ref;
+
+	struct xarray		namespaces;
+	unsigned int		nr_namespaces;
+	u32			max_nsid;
+	u16			cntlid_min;
+	u16			cntlid_max;
+
+	struct list_head	ctrls;
+
+	struct list_head	hosts;
+	bool			allow_any_host;
+#ifdef CONFIG_NVME_TARGET_DEBUGFS
+	struct dentry		*debugfs_dir;
+#endif
+	u16			max_qid;
+
+	u64			ver;
+	char			serial[NVMET_SN_MAX_SIZE];
+	bool			subsys_discovered;
+	char			*subsysnqn;
+	bool			pi_support;
+	bool			tbkas;
+
+	struct config_group	group;
+
+	struct config_group	namespaces_group;
+	struct config_group	allowed_hosts_group;
+
+	u16			vendor_id;
+	u16			subsys_vendor_id;
+	char			*model_number;
+	u32			ieee_oui;
+	char			*firmware_rev;
+
+#ifdef CONFIG_NVME_TARGET_PASSTHRU
+	struct nvmet_passthru	*passthru;
+	struct config_group	passthru_group;
+#endif /* CONFIG_NVME_TARGET_PASSTHRU */
+
+#ifdef CONFIG_BLK_DEV_ZONED
+	u8			zasl;
+#endif /* CONFIG_BLK_DEV_ZONED */
+};
+
 struct nvmet_ns {
 	struct percpu_ref	ref;
 	struct file		*bdev_file;
-	struct block_device	*bdev;
+	struct block_device	*bdev
+		__guarded_by(&subsys->lock);
 	struct file		*file;
 	bool			readonly;
 	u32			nsid;
@@ -136,12 +186,29 @@ struct nvmet_ns {
 #endif
 };
 
+/*
+ * The accessors generated by this macro are annotated with __context_unsafe()
+ * because they are intended for use in I/O hotpaths and request-processing
+ * paths where a namespace reference is held. These paths access namespace
+ * fields that are guaranteed not to change while the reference is held and the
+ * I/O or request processing is in progress.
+ */
+#define NVMET_NS_ACCESSOR(_type, _name)					    \
+static inline _type nvmet_ns_##_name(struct nvmet_ns *ns)		    \
+	__context_unsafe(/* access _name after getting ns reference */)	    \
+{									    \
+	return ns->_name;						    \
+}
+
+NVMET_NS_ACCESSOR(struct block_device *, bdev)
+
 static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
 {
 	return container_of(to_config_group(item), struct nvmet_ns, group);
 }
 
 static inline struct device *nvmet_ns_dev(struct nvmet_ns *ns)
+	__must_hold(&ns->subsys->lock)
 {
 	return ns->bdev ? disk_to_dev(ns->bdev->bd_disk) : NULL;
 }
@@ -336,55 +403,6 @@ struct nvmet_passthru {
 	unsigned int		clear_ids;
 };
 
-struct nvmet_subsys {
-	enum nvme_subsys_type	type;
-
-	struct mutex		lock;
-	struct kref		ref;
-
-	struct xarray		namespaces;
-	unsigned int		nr_namespaces;
-	u32			max_nsid;
-	u16			cntlid_min;
-	u16			cntlid_max;
-
-	struct list_head	ctrls;
-
-	struct list_head	hosts;
-	bool			allow_any_host;
-#ifdef CONFIG_NVME_TARGET_DEBUGFS
-	struct dentry		*debugfs_dir;
-#endif
-	u16			max_qid;
-
-	u64			ver;
-	char			serial[NVMET_SN_MAX_SIZE];
-	bool			subsys_discovered;
-	char			*subsysnqn;
-	bool			pi_support;
-	bool			tbkas;
-
-	struct config_group	group;
-
-	struct config_group	namespaces_group;
-	struct config_group	allowed_hosts_group;
-
-	u16			vendor_id;
-	u16			subsys_vendor_id;
-	char			*model_number;
-	u32			ieee_oui;
-	char			*firmware_rev;
-
-#ifdef CONFIG_NVME_TARGET_PASSTHRU
-	struct nvmet_passthru	*passthru;
-	struct config_group	passthru_group;
-#endif /* CONFIG_NVME_TARGET_PASSTHRU */
-
-#ifdef CONFIG_BLK_DEV_ZONED
-	u8			zasl;
-#endif /* CONFIG_BLK_DEV_ZONED */
-};
-
 static inline struct nvmet_subsys *to_subsys(struct config_item *item)
 {
 	return container_of(to_config_group(item), struct nvmet_subsys, group);
@@ -737,19 +755,25 @@ extern struct rw_semaphore nvmet_ana_sem;
 
 bool nvmet_host_allowed(struct nvmet_subsys *subsys, const char *hostnqn);
 
-int nvmet_bdev_ns_enable(struct nvmet_ns *ns);
+int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
+	__must_hold(&ns->subsys->lock);
 int nvmet_file_ns_enable(struct nvmet_ns *ns);
-void nvmet_bdev_ns_disable(struct nvmet_ns *ns);
+void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
+	__must_hold(&ns->subsys->lock);
 void nvmet_file_ns_disable(struct nvmet_ns *ns);
-u16 nvmet_bdev_flush(struct nvmet_req *req);
+u16 nvmet_bdev_flush(struct nvmet_req *req)
+	__must_hold(&req->ns->subsys->lock);
 u16 nvmet_file_flush(struct nvmet_req *req);
 void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
-void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns);
+void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)
+	__must_hold(&ns->subsys->lock);
 void nvmet_file_ns_revalidate(struct nvmet_ns *ns);
-bool nvmet_ns_revalidate(struct nvmet_ns *ns);
+bool nvmet_ns_revalidate(struct nvmet_ns *ns)
+	__must_hold(&ns->subsys->lock);
 u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts);
 
-bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);
+bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
+	__must_hold(&ns->subsys->lock);
 void nvmet_execute_identify_ctrl_zns(struct nvmet_req *req);
 void nvmet_execute_identify_ns_zns(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index f386c388da18..0b351d39340c 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -594,7 +594,7 @@ static void nvmet_rdma_set_sig_attrs(struct nvmet_req *req,
 	u8 pi_type = req->ns->pi_type;
 	struct blk_integrity *bi;
 
-	bi = bdev_get_integrity(req->ns->bdev);
+	bi = bdev_get_integrity(nvmet_ns_bdev(req->ns));
 
 	memset(sig_attrs, 0, sizeof(*sig_attrs));
 
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index cea05b4bc740..ce5309453668 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -110,30 +110,29 @@ void nvmet_execute_identify_ns_zns(struct nvmet_req *req)
 	if (status)
 		goto out;
 
-	if (nvmet_ns_revalidate(req->ns)) {
-		mutex_lock(&req->ns->subsys->lock);
+	mutex_lock(&req->ns->subsys->lock);
+	if (nvmet_ns_revalidate(req->ns))
 		nvmet_ns_changed(req->ns->subsys, req->ns->nsid);
-		mutex_unlock(&req->ns->subsys->lock);
-	}
+	mutex_unlock(&req->ns->subsys->lock);
 
-	if (!req->ns->bdev || !bdev_is_zoned(req->ns->bdev)) {
+	if (!nvmet_ns_bdev(req->ns) || !bdev_is_zoned(nvmet_ns_bdev(req->ns))) {
 		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		req->error_loc = offsetof(struct nvme_identify, nsid);
 		goto out;
 	}
 
-	zsze = (bdev_zone_sectors(req->ns->bdev) << 9) >>
+	zsze = (bdev_zone_sectors(nvmet_ns_bdev(req->ns)) << 9) >>
 					req->ns->blksize_shift;
 	id_zns->lbafe[0].zsze = cpu_to_le64(zsze);
 
-	mor = bdev_max_open_zones(req->ns->bdev);
+	mor = bdev_max_open_zones(nvmet_ns_bdev(req->ns));
 	if (!mor)
 		mor = U32_MAX;
 	else
 		mor--;
 	id_zns->mor = cpu_to_le32(mor);
 
-	mar = bdev_max_active_zones(req->ns->bdev);
+	mar = bdev_max_active_zones(nvmet_ns_bdev(req->ns));
 	if (!mar)
 		mar = U32_MAX;
 	else
@@ -151,7 +150,7 @@ static u16 nvmet_bdev_validate_zone_mgmt_recv(struct nvmet_req *req)
 	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
 	u32 out_bufsize = (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
 
-	if (sect >= get_capacity(req->ns->bdev->bd_disk)) {
+	if (sect >= get_capacity(nvmet_ns_bdev(req->ns)->bd_disk)) {
 		req->error_loc = offsetof(struct nvme_zone_mgmt_recv_cmd, slba);
 		return NVME_SC_LBA_RANGE | NVME_STATUS_DNR;
 	}
@@ -247,7 +246,8 @@ static unsigned long nvmet_req_nr_zones_from_slba(struct nvmet_req *req)
 {
 	unsigned int sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
 
-	return bdev_nr_zones(req->ns->bdev) - bdev_zone_no(req->ns->bdev, sect);
+	return bdev_nr_zones(nvmet_ns_bdev(req->ns)) -
+			bdev_zone_no(nvmet_ns_bdev(req->ns), sect);
 }
 
 static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bufsize)
@@ -291,8 +291,8 @@ static void nvmet_bdev_zone_zmgmt_recv_work(struct work_struct *w)
 		goto out;
 	}
 
-	ret = blkdev_report_zones(req->ns->bdev, start_sect, req_slba_nr_zones,
-				 nvmet_bdev_report_zone_cb, &rz_data);
+	ret = blkdev_report_zones(nvmet_ns_bdev(req->ns), start_sect,
+			req_slba_nr_zones, nvmet_bdev_report_zone_cb, &rz_data);
 	if (ret < 0) {
 		status = NVME_SC_INTERNAL;
 		goto out;
@@ -415,7 +415,7 @@ static int zmgmt_send_scan_cb(struct blk_zone *z, unsigned i, void *d)
 
 static u16 nvmet_bdev_zone_mgmt_emulate_all(struct nvmet_req *req)
 {
-	struct block_device *bdev = req->ns->bdev;
+	struct block_device *bdev = nvmet_ns_bdev(req->ns);
 	unsigned int nr_zones = bdev_nr_zones(bdev);
 	struct bio *bio = NULL;
 	sector_t sector = 0;
@@ -471,8 +471,9 @@ static u16 nvmet_bdev_execute_zmgmt_send_all(struct nvmet_req *req)
 
 	switch (zsa_req_op(req->cmd->zms.zsa)) {
 	case REQ_OP_ZONE_RESET:
-		ret = blkdev_zone_mgmt(req->ns->bdev, REQ_OP_ZONE_RESET, 0,
-				       get_capacity(req->ns->bdev->bd_disk));
+		ret = blkdev_zone_mgmt(nvmet_ns_bdev(req->ns),
+				REQ_OP_ZONE_RESET, 0,
+				get_capacity(nvmet_ns_bdev(req->ns)->bd_disk));
 		if (ret < 0)
 			return blkdev_zone_mgmt_errno_to_nvme_status(ret);
 		break;
@@ -494,7 +495,7 @@ static void nvmet_bdev_zmgmt_send_work(struct work_struct *w)
 	struct nvmet_req *req = container_of(w, struct nvmet_req, z.zmgmt_work);
 	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->zms.slba);
 	enum req_op op = zsa_req_op(req->cmd->zms.zsa);
-	struct block_device *bdev = req->ns->bdev;
+	struct block_device *bdev = nvmet_ns_bdev(req->ns);
 	sector_t zone_sectors = bdev_zone_sectors(bdev);
 	u16 status = NVME_SC_SUCCESS;
 	int ret;
@@ -560,13 +561,14 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 	u32 data_len = nvmet_rw_data_len(req);
 	struct bio *bio;
 	int sg_cnt;
+	struct block_device *bdev = nvmet_ns_bdev(req->ns);
 
 	/* Request is completed on len mismatch in nvmet_check_transfer_len() */
 	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
 		return;
 
 	if (data_len >
-	    bdev_max_zone_append_sectors(req->ns->bdev) << SECTOR_SHIFT) {
+	    bdev_max_zone_append_sectors(bdev) << SECTOR_SHIFT) {
 		req->error_loc = offsetof(struct nvme_rw_command, length);
 		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		goto out;
@@ -577,13 +579,13 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 		return;
 	}
 
-	if (sect >= get_capacity(req->ns->bdev->bd_disk)) {
+	if (sect >= get_capacity(bdev->bd_disk)) {
 		req->error_loc = offsetof(struct nvme_rw_command, slba);
 		status = NVME_SC_LBA_RANGE | NVME_STATUS_DNR;
 		goto out;
 	}
 
-	if (sect & (bdev_zone_sectors(req->ns->bdev) - 1)) {
+	if (sect & (bdev_zone_sectors(bdev) - 1)) {
 		req->error_loc = offsetof(struct nvme_rw_command, slba);
 		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		goto out;
@@ -591,10 +593,10 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 
 	if (nvmet_use_inline_bvec(req)) {
 		bio = &req->z.inline_bio;
-		bio_init(bio, req->ns->bdev, req->inline_bvec,
+		bio_init(bio, bdev, req->inline_bvec,
 			 ARRAY_SIZE(req->inline_bvec), opf);
 	} else {
-		bio = bio_alloc(req->ns->bdev, req->sg_cnt, opf, GFP_KERNEL);
+		bio = bio_alloc(bdev, req->sg_cnt, opf, GFP_KERNEL);
 	}
 
 	bio->bi_end_io = nvmet_bdev_zone_append_bio_done;
-- 
2.53.0


