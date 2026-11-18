Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00D9606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 07:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=w6WbNjgs;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fzuOfW/g
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=1aMstOYBXJftpiO07c2iIFOirNryCacGEndZQOVdlmo=; b=w6WbNjgslcGFOQ
	7M8RTiIQKi1XJIKChgD/1qUItkSTG7iu0fjCFl5fbH6il2H3aI3DsexjqNYhxVgMgdSGODg/h7Qtq
	KBvaCQ6afJRHI4U0ahjPkH9aQwEJjevRswHIP7wWgq431lFpVfFjnKu4VIRBnKBuFvWNn7HlKhVL2
	tvubTzb1GE0zqQ9ew4ZsYSt38mRVPQVv5EuQNCNlyQH8EC0Xh4i1HzwuSmWw1XOlUSSI1wFuAudKH
	T0mUagWB/xI7028h8HBQFPlM5SjRu45S/aS0ZS23A22r28zFNhAmB+tGeRu5lg1Izyils68TzHIp/
	rEDjP/ebec7Cy/dZ/1Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaDb-00000008166-2Hf8;
	Wed, 18 Nov 2026 07:36:35 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaDW-0000000811V-1AY7
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 07:36:34 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2TAKi4084895;
	Wed, 18 Nov 2026 07:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1aMstOYBXJftpiO07
	c2iIFOirNryCacGEndZQOVdlmo=; b=fzuOfW/gFvxOzvVLT2Ka8y2UMEue06kjA
	+lduCW81mgC3GbxpIUXI3Pid/eLIjW0hlwT9bVKZrwl+YbkSdhE2LEdLAj5XBaeT
	K7nDBDurI+iqSmAemirWp8z8267gOflptmMDW3+NqGgKw5H2vQZb1vT0RpNN/g8d
	U35VBL/55PoVZBnQ4rcxDwKbjhyZWz5mJUuj6XSRy4esPnwPD4BzVzNFGHZtpWGL
	thH7ELB80UP6oO1BTEoCup3RiDa6r9f+rqrLerEENOb5zA3akUEe6d0OboDGo2LP
	p4Rz+arujdaUPDwVzQNpqHWDkCn7w/h26woa/xs9RMba2t7UIsOiQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vhbg2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:36:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI785ZD1660661;
	Wed, 18 Nov 2026 07:36:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j17c4r29v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:36:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI7aGR143057418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 07:36:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A162E2004B;
	Wed, 18 Nov 2026 07:36:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77ACE20040;
	Wed, 18 Nov 2026 07:36:11 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.157.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 07:36:11 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, bvanassche@acm.org, sagi@grimberg.me,
        axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 06/22] nvmet: add context annotation for nvmet_ns::blksize_shift
Date: Wed, 18 Nov 2026 13:04:47 +0530
Message-ID: <20261118073505.288910-7-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118073505.288910-1-nilay@linux.ibm.com>
References: <20261118073505.288910-1-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 8Ax0OIkztTEUb8VeLh9MBI3Cpsb6MO0b
X-Authority-Analysis: v=2.4 cv=HL9WhYtv c=1 sm=1 tr=0 ts=6afd5575 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=JFbFUQ8vtAWP2KEOOfEA:9
X-Proofpoint-ORIG-GUID: -6Dd5NPidg7_dfYh60jWgnadYB1DS-_0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX2pGCInnXAPg3
 fLNX2yHWKCsFAl3E9mhbOAFYLGKZfY4BWDlJJ/0Wz+r+W6Hguf8JB9jZehT6fxCfsOiXai5lPe0
 TeDnaqIxMuUsX7tWLV6T9hD1dIGt5lznY1b5LVN2Q9WjVQxu1ZYGwCjw6Ett94TXIhu1KXPffrn
 XTdML/XIaNkk0USeUy1HynvOBgIZQQ5ACRYOx06sKOfv/vREVczAoi+/oHNdNETgz9ZvlZguEus
 mQN1A3P+DIZIaTyB/MvblsqD+CzJOLZbkgCaiyA5vzpIxzpCCJkPr3paUIAl53M80b0D+66uBZo
 3DyzaO78XKXxeU4uVHdTwRouXGMxbJ0XujoflUXC2Gys8g6wU0YNEKipLq3Hs7ENO2ij4WnIkuZ
 08wy1r4X4tg9804nbC8NEzDme1qGPuJEFAHWcT7aRlic41tcNgy0qc3FnJDlwWHNXo2465RVszZ
 +HgCaZJOVOdKXfAPhGA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfXz7rVjzvlhjOv
 OtC50YAMaeK7aU+3K6B7k0g3ZkIfAqtMDcCW/3GoOlZYTuFuhZrUzUcAUKuibYQ3R6hIJJvg49f
 t3zVUaf/BoK4OePPzKI2nHuW+u2d47w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_233630_432168_CC7EEC69 
X-CRM114-Status: GOOD (  18.17  )
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

The nvmet_ns::blksize_shift field is protected by nvmet_subsys::lock.
Annotate it with __guarded_by(&subsys->lock) to allow the Clang context
analyzer to validate accesses to this field.

The I/O hotpath also accesses nvmet_ns::blksize_shift without holding
subsys->lock. This is safe because the namespace reference held by the
I/O request prevents the namespace from being modified while the I/O is
in flight.

Introduce nvmet_ns_blksize_shift(), annotated with __context_unsafe(),
to allow these lockless accesses without triggering context analyzer
warnings. Use this accessor at all relevant call sites that access
blksize_shift without holding subsys->lock, including the namespace
identify, block I/O, file I/O, ZNS, and common LBA/sector conversion
paths.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/admin-cmd.c   |  4 ++--
 drivers/nvme/target/io-cmd-bdev.c |  4 ++--
 drivers/nvme/target/io-cmd-file.c |  7 ++++---
 drivers/nvme/target/nvmet.h       | 10 ++++++----
 drivers/nvme/target/zns.c         |  2 +-
 5 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 1f553ff3800c..940ba0e14449 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -887,7 +887,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	 * that out from the underlying device.
 	 */
 	id->ncap = id->nsze =
-		cpu_to_le64(req->ns->size >> req->ns->blksize_shift);
+		cpu_to_le64(req->ns->size >> nvmet_ns_blksize_shift(req->ns));
 	switch (req->port->ana_state[req->ns->anagrpid]) {
 	case NVME_ANA_INACCESSIBLE:
 	case NVME_ANA_PERSISTENT_LOSS:
@@ -931,7 +931,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
 	memcpy(&id->nguid, &req->ns->nguid, sizeof(id->nguid));
 
-	id->lbaf[0].ds = req->ns->blksize_shift;
+	id->lbaf[0].ds = nvmet_ns_blksize_shift(req->ns);
 
 	if (req->sq->ctrl->pi_support && nvmet_ns_has_pi(req->ns)) {
 		id->dpc = NVME_NS_DPC_PI_FIRST | NVME_NS_DPC_PI_LAST |
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 7c263cb169a8..e950b442ffc6 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -393,7 +393,7 @@ static void nvmet_bdev_execute_discard(struct nvmet_req *req)
 			break;
 
 		nr_sects = (sector_t)le32_to_cpu(range.nlb) <<
-			   (ns->blksize_shift - 9);
+			   (nvmet_ns_blksize_shift(ns) - 9);
 		__blkdev_issue_discard(nvmet_ns_bdev(ns),
 				nvmet_lba_to_sect(ns, range.slba), nr_sects,
 				GFP_KERNEL, &bio);
@@ -442,7 +442,7 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 
 	sector = nvmet_lba_to_sect(req->ns, write_zeroes->slba);
 	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
-		(req->ns->blksize_shift - 9));
+		(nvmet_ns_blksize_shift(req->ns) - 9));
 
 	ret = __blkdev_issue_zeroout(nvmet_ns_bdev(req->ns), sector, nr_sector,
 			GFP_KERNEL, &bio, 0);
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index b7c5c7ecf470..e1e02f5f5efb 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -122,7 +122,7 @@ static bool nvmet_file_check_lba_range(struct nvmet_req *req, u64 slba,
 {
 	u64 pos64;
 
-	if (check_shl_overflow(slba, req->ns->blksize_shift, &pos64) ||
+	if (check_shl_overflow(slba, nvmet_ns_blksize_shift(req->ns), &pos64) ||
 	    pos64 > req->ns->size || len > req->ns->size - pos64)
 		return false;
 
@@ -305,7 +305,8 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 			break;
 
 		if (check_shl_overflow((u64)le32_to_cpu(range.nlb),
-				       req->ns->blksize_shift, &len64) ||
+				       nvmet_ns_blksize_shift(req->ns),
+				       &len64) ||
 		    !nvmet_file_check_lba_range(req, le64_to_cpu(range.slba),
 					len64, &offset)) {
 			req->error_slba = le64_to_cpu(range.slba);
@@ -361,7 +362,7 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
 	int ret;
 
 	if (check_shl_overflow((u64)le16_to_cpu(write_zeroes->length) + 1,
-			       req->ns->blksize_shift, &len64) ||
+			       nvmet_ns_blksize_shift(req->ns), &len64) ||
 	    !nvmet_file_check_lba_range(req, le64_to_cpu(write_zeroes->slba),
 				len64, &offset)) {
 		nvmet_req_complete(req, errno_to_nvme_status(req, -ENOSPC));
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 5598edf53b76..6204dcfb82dc 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -158,7 +158,8 @@ struct nvmet_ns {
 	bool			readonly
 		__guarded_by(&subsys->lock);
 	u32			nsid;
-	u32			blksize_shift;
+	u32			blksize_shift
+		__guarded_by(&subsys->lock);
 	loff_t			size;
 	u8			nguid[16];
 	uuid_t			uuid;
@@ -205,6 +206,7 @@ static inline _type nvmet_ns_##_name(struct nvmet_ns *ns)		    \
 
 NVMET_NS_ACCESSOR(struct block_device *, bdev)
 NVMET_NS_ACCESSOR(struct file *, file)
+NVMET_NS_ACCESSOR(u32, blksize_shift)
 
 /*
  * These accessors use data_race() and READ_ONCE() marker to allow lockless
@@ -807,7 +809,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req);
 static inline u32 nvmet_rw_data_len(struct nvmet_req *req)
 {
 	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) <<
-			req->ns->blksize_shift;
+			nvmet_ns_blksize_shift(req->ns);
 }
 
 static inline u32 nvmet_rw_metadata_len(struct nvmet_req *req)
@@ -1000,12 +1002,12 @@ static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
 
 static inline __le64 nvmet_sect_to_lba(struct nvmet_ns *ns, sector_t sect)
 {
-	return cpu_to_le64(sect >> (ns->blksize_shift - SECTOR_SHIFT));
+	return cpu_to_le64(sect >> (nvmet_ns_blksize_shift(ns) - SECTOR_SHIFT));
 }
 
 static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
 {
-	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
+	return le64_to_cpu(lba) << (nvmet_ns_blksize_shift(ns) - SECTOR_SHIFT);
 }
 
 static inline bool nvmet_use_inline_bvec(struct nvmet_req *req)
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index ce5309453668..9afea37862ef 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -122,7 +122,7 @@ void nvmet_execute_identify_ns_zns(struct nvmet_req *req)
 	}
 
 	zsze = (bdev_zone_sectors(nvmet_ns_bdev(req->ns)) << 9) >>
-					req->ns->blksize_shift;
+					nvmet_ns_blksize_shift(req->ns);
 	id_zns->lbafe[0].zsze = cpu_to_le64(zsze);
 
 	mor = bdev_max_open_zones(nvmet_ns_bdev(req->ns));
-- 
2.53.0


