Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84922606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 03:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fiNgROHC;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=W1PeRcMK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=3h2sitimQICxeLw41HU8Mv15N3RXTs1j2ua5fjYnmVA=; b=fiNgROHCX0Heih
	pFZN3sf34YxfJFN6w7linvEu/SOUpme825HYyYyJbzmbX7xo4HTa88zGFOx+EUgJWVdLK1EtQBHLq
	Df3nwQvgtmmLUeZvyp1HkLaNIEkpI9thNVj+iEX89cvFMzWZEaNNU4okLshOTMWIK1Xarx6Llgz5b
	Dgj3JynAT9aUjCQIg7jMxXMd76JfBXVcq90qq4r4enJrgaQrdHLtWk2h3VK+m94ic1U6QF6QY6Jlg
	NxMuPv/xnDzLmNRLf8WAId7Pi+xkXlqt/OztbrUOjl1sOPhx/LHVDNeJYnIYnKuV6zNmxcDEc4i9U
	0y+LB6dbhtjBEH4zxzmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG7L-0000000HCiB-0VuU;
	Mon, 09 Nov 2026 03:32:23 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG7H-0000000HCfE-0HDN
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 03:32:21 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90iH5W2149591;
	Mon, 9 Nov 2026 03:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3h2sitimQICxeLw41
	HU8Mv15N3RXTs1j2ua5fjYnmVA=; b=W1PeRcMKIgvecscLMwvQ62Gx1h3P4KF4J
	PTZiOpB5rMoxwYaQPFsXTlFPtZFW4KJkthDpE6oW4q17Q03pFIgVWpUjbD+fgLaU
	7HSsgFD/7xm4bMOxEoMhpjdkat7M+/FbQcn6E6831+nQZQ2GS+iO+bX0g9+MnKnx
	GghYUVGmvQ5p6Y+jbBPbWDLJaFNwwDdMtpmpB0IcCL1PJzku/NfW1QYRIl6Dtm5x
	G8hppJFB8kxOOVr9gHgiiB7tBoEykOZAb1iVNw7b+qu39MUSscnjnp8MA4+0V99/
	ohUfFJL30mE5Yktsc5ULd1W2qAh8T7CeezKMLDNYNmiCmItoYJEBA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug5tg8j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:32:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90Z0SB3423151;
	Mon, 9 Nov 2026 03:32:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htepvnmee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:32:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A93W5JJ44695896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 03:32:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC5C520043;
	Mon,  9 Nov 2026 03:32:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30E9620040;
	Mon,  9 Nov 2026 03:31:59 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.101.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 03:31:58 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, bvanassche@acm.org, elver@google.com,
        linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 06/23] nvmet: add context annotation for nvmet_ns::nsid
Date: Mon,  9 Nov 2026 08:58:11 +0530
Message-ID: <20261109033102.982191-31-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109033102.982191-25-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: HogSeFEsLEGnhFbkK6yjxRKeKW5RTQES
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af13ebb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=PVvgHwxaEa-G4VTCBkQA:9
X-Proofpoint-GUID: dqPWDd1c0DOBI8YgKflKEnSZqwt2YTph
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX914QLt5OCInM
 ZbbE+D5pcnaP/zGi+GiObn2vJSb4tfDISOlROpNnt4iLvPp8yGq5qlBGLBzsbizGTQBzPZnM28s
 RhvZlEP4ctdvYN4VEs8BUOGVWnNyfeWwzxb+efBjMF2Tb2+qpy1tx+wny0DbDKERBlKpeVVvRzI
 apkcgjmepGcD4SaAYvLrDzYxUsuyL4zRPHlyt7evUwjp94G5aRVqdwOa0rBqN2cx3FA3lGMMoE5
 mtnlcL0O7s5HrQHjXXBBAqnSn5op5YKEhYXYE4hvEM+S4f7gNm7ILfDwMEpAWLxJ/lrxO19nHyH
 kcwzW7Qw1i4wQK9kaKaDIKeuIeZ8ANjPegZNs4XQo3vaRZAMeedO85LJoQn1CP/EdxpllqHUnPj
 VKQ6IHSs0xZtN3oQLLE1hcimETMUvEH4XhVNaCR5Vj/MqqLApcnz4i+HNQn3IWIR9jPjXR4jC7j
 QawDAeb8JJhlQQW1yrg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX165tSSAHmmcc
 NC6Eke3NVOvQjVjwyFki1KM8uhgsUB300zld0Qq/NC23PWXicg6ymlqTl2Q9dOVI7yb3ZgFhv1m
 Cibr39uRqThb7UOEOLhIZFeOvNm/PBs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_193219_120150_CBDB2AEB 
X-CRM114-Status: GOOD (  20.40  )
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

The nvmet_ns::nsid field is protected by nvmet_subsys::lock.
Annotate it with __guarded_by(&subsys->lock) to allow the Clang
context analyzer to validate accesses to this field.

The I/O hotpath also accesses nvmet_ns::nsid without holding
subsys->lock. This is safe because the namespace reference held by
the I/O request ensures that the namespace cannot be modified while
the I/O is in flight.

Since the context analyzer cannot distinguish between accesses from
the I/O hotpath and the control path, introduce nvmet_ns_nsid(),
annotated with context_unsafe, to allow the I/O hotpath to access
nvmet_ns::nsid without triggering context analyzer warnings. Use
this accessor for accesses from the I/O hotpath.

Additionally, nvmet_max_nsid() and nvmet_ns_alloc() access
nvmet_ns::nsid while holding subsys->lock. Although subsys->lock
and ns->subsys->lock refer to the same lock, the context analyzer
cannot recognize this relationship. Explicitly assert the
ns->subsys->lock capability around these accesses to avoid false
positive warnings.

Annotate nvmet_ns_changed() and nvmet_debugfs_ns_setup() with
__must_hold() to make their locking requirements explicit.

Finally, nvmet_set_feat_write_protect() calls nvmet_ns_changed()
while holding ns->subsys->lock. Since the context analyzer
cannot recognize that this is the same lock as subsys->lock,
explicitly assert the subsys->lock capability before calling
nvmet_ns_changed().

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/admin-cmd.c | 12 ++++++++++--
 drivers/nvme/target/core.c      | 21 +++++++++++++++++++--
 drivers/nvme/target/debugfs.h   |  3 ++-
 drivers/nvme/target/nvmet.h     |  7 +++++--
 4 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 6b0ba383106d..590ca68588f8 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -922,7 +922,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	 * Since we don't know any better, every namespace is its own endurance
 	 * group.
 	 */
-	id->endgid = cpu_to_le16(req->ns->nsid);
+	id->endgid = cpu_to_le16(nvmet_ns_nsid(req->ns));
 
 	memcpy(&id->nguid, &req->ns->nguid, sizeof(id->nguid));
 
@@ -1268,8 +1268,16 @@ static u16 nvmet_set_feat_write_protect(struct nvmet_req *req)
 		break;
 	}
 
-	if (!status)
+	if (!status) {
+		/*
+		 * Both ns->subsys->lock and subsys->lock refers to the same
+		 * lock. However there's no way for us to annotate such locking
+		 * semantics using clang context annotation. So explicitly
+		 * assert the capability.
+		 */
+		__assume_ctx_lock(&subsys->lock);
 		nvmet_ns_changed(subsys, req->ns->nsid);
+	}
 	mutex_unlock(&req->ns->subsys->lock);
 	return status;
 }
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 116b1b500790..2913ed76bc6a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -118,13 +118,22 @@ u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len)
 }
 
 static u32 nvmet_max_nsid(struct nvmet_subsys *subsys)
+	__must_hold(&subsys->lock)
 {
 	struct nvmet_ns *cur;
 	unsigned long idx;
 	u32 nsid = 0;
 
-	nvmet_for_each_enabled_ns(&subsys->namespaces, idx, cur)
+	nvmet_for_each_enabled_ns(&subsys->namespaces, idx, cur) {
+		/*
+		 * Both ns->subsys->lock and subsys->lock refers to the same
+		 * lock. However there's no way for us to annotate such locking
+		 * semantics using clang context annotation. So explicitly
+		 * assert the capability.
+		 */
+		__assume_ctx_lock(&cur->subsys->lock);
 		nsid = cur->nsid;
+	}
 
 	return nsid;
 }
@@ -746,6 +755,12 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 
 	init_completion(&ns->disable_done);
 
+	/*
+	 * Both subsys->lock and ns->subsys->lock refers to the same lock.
+	 * However there's no way for us to annotate such locking semantics
+	 * using clang context annotation. So explicitly assert the capability.
+	 */
+	__assume_ctx_lock(&ns->subsys->lock);
 	ns->nsid = nsid;
 	ns->subsys = subsys;
 
@@ -757,6 +772,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 
 	subsys->nr_namespaces++;
 
+	__release_ctx_lock(&ns->subsys->lock);
 	mutex_unlock(&subsys->lock);
 
 	down_write(&nvmet_ana_sem);
@@ -1361,7 +1377,8 @@ static struct pci_dev *nvmet_req_find_p2p_dev(struct nvmet_req *req)
 	if (!IS_ENABLED(CONFIG_PCI_P2PDMA) ||
 	    !req->sq->ctrl || !req->sq->qid || !req->ns)
 		return NULL;
-	return radix_tree_lookup(&req->sq->ctrl->p2p_ns_map, req->ns->nsid);
+	return radix_tree_lookup(&req->sq->ctrl->p2p_ns_map,
+			nvmet_ns_nsid(req->ns));
 }
 
 int nvmet_req_alloc_sgls(struct nvmet_req *req)
diff --git a/drivers/nvme/target/debugfs.h b/drivers/nvme/target/debugfs.h
index b559d254fc2a..2dde79e8a2ab 100644
--- a/drivers/nvme/target/debugfs.h
+++ b/drivers/nvme/target/debugfs.h
@@ -14,7 +14,8 @@ int nvmet_debugfs_subsys_setup(struct nvmet_subsys *subsys);
 void nvmet_debugfs_subsys_free(struct nvmet_subsys *subsys);
 int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl);
 void nvmet_debugfs_ctrl_free(struct nvmet_ctrl *ctrl);
-void nvmet_debugfs_ns_setup(struct nvmet_ns *ns);
+void nvmet_debugfs_ns_setup(struct nvmet_ns *ns)
+	__must_hold(&ns->subsys->lock);
 void nvmet_debugfs_ns_free(struct nvmet_ns *ns);
 
 int __init nvmet_init_debugfs(void);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index b76671672aca..d03e059d6d16 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -157,7 +157,8 @@ struct nvmet_ns {
 		__guarded_by(&subsys->lock);
 	bool			readonly
 		__guarded_by(&subsys->lock);
-	u32			nsid;
+	u32			nsid
+		__guarded_by(&subsys->lock);
 	u32			blksize_shift;
 	loff_t			size;
 	u8			nguid[16];
@@ -205,6 +206,7 @@ static inline _type nvmet_ns_##_name(struct nvmet_ns *ns)		    \
 
 NVMET_NS_ACCESSOR(struct block_device *, bdev)
 NVMET_NS_ACCESSOR(struct file *, file)
+NVMET_NS_ACCESSOR(u32, nsid)
 
 /*
  * These accessors use data_race() and READ_ONCE() to allow lockless access to
@@ -784,7 +786,8 @@ u16 nvmet_bdev_flush(struct nvmet_req *req)
 	__must_hold(&req->ns->subsys->lock);
 u16 nvmet_file_flush(struct nvmet_req *req)
 	__must_hold(&req->ns->subsys->lock);
-void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
+void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid)
+	__must_hold(&subsys->lock);
 void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)
 	__must_hold(&ns->subsys->lock);
 void nvmet_file_ns_revalidate(struct nvmet_ns *ns)
-- 
2.53.0


