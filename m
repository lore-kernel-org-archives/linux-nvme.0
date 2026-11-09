Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73842606A322
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 03:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Wk0/c4aY;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TP3e+J+e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=GrTzCGkhtUfjV46iClc43BMmuTLIaWRFMhQCRYUc8tE=; b=Wk0/c4aYTfFz7y
	l1KVtmsBs2pwexCoLL4JcKfyQziZZiseP2qPNvlyEkK40nWjKnOeT0fee30mSuktQtZDrWQsMt1mD
	bxfvgNOp3xyQxsa0Yxy3JQBQ09Yq0Loi+suj8lYA1NoRgcBIW/+u2DkvqCJ0AxJWV9xYCYx5uCHnN
	OTU4ngnDi1yOKqzBbFA0Y7pWXQW6UVdRDP1yIB+X3Imt0a7tY+vQD/YlY+p3Vm9TD5pKb4fvdLrbo
	4XxbIzkgac2mA/gl6/s9sbxsoDhUebmxCKIafW0jdrW+Xp8bf8JxnkKQ2bQXOAvRP90RQDX5ZVLv5
	to7bDkmZKwYz94atfsYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG7U-0000000HCuF-3uly;
	Mon, 09 Nov 2026 03:32:33 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG7S-0000000HCrS-2dVm
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 03:32:31 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90iS2Z1945969;
	Mon, 9 Nov 2026 03:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GrTzCGkhtUfjV46iC
	lc43BMmuTLIaWRFMhQCRYUc8tE=; b=TP3e+J+erhW3HYWCjPLTzzJB3fkVatUkT
	Un3762oRdC/QbtHpoSHpuTDsuBhH7Hvb1/v93XlyRGD59+HUwOFY+rCikNrX4cmA
	jvLpigzYSks3ojyyMmLkO+cyoUTiK17Kd2zUVO97OUIiXjQAM0l8cVIlxHZth8DF
	RoycT2i8b16HbX1t1IVhpM+ZP5fZm9np2DlUK7FOOmAInaOlJdXx+RsYjZB3N1uc
	g47qRvSbMCoBGMdXYXaj0/hVwBrqdjG6N9xhhleoC98IYduWNDZQ//x+T5hu11GF
	+0OtAZkyRJGDNngSOkAgIYmY6V4Y3doxLqWtKurtNc7Ah7V+XvFpw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq6jeg5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:32:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A93Jurb3535207;
	Mon, 9 Nov 2026 03:32:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfajwfp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:32:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A93WIdF27787772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 03:32:18 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3E5420043;
	Mon,  9 Nov 2026 03:32:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 119F320040;
	Mon,  9 Nov 2026 03:32:13 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.101.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 03:32:12 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, bvanassche@acm.org, elver@google.com,
        linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 08/23] nvmet: add context annotation for nvmet_ns::blksize_shift
Date: Mon,  9 Nov 2026 08:58:13 +0530
Message-ID: <20261109033102.982191-33-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109033102.982191-25-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX3r3pj9HkHWMs
 VLeDU30TbsssWbmuN3Tbjs4VzSSM+uOkWUNXpcQKZ2+naZrNDPzwlpZ6r51+2qns7nQ8gMOEha0
 WenTcUT2KxM2XWsmxXmhEViRgbekOsI=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af13ec7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=JFbFUQ8vtAWP2KEOOfEA:9
X-Proofpoint-ORIG-GUID: pRyuYiTlf4nJDhd3YFbx3NciTLMKM5Il
X-Proofpoint-GUID: T3pXpQf3RW3khRw6546LYDiAJMlWmhXO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX/jlCTJQlyeia
 57zKxeWoKzH9omohtlznLr4PR0RP5jvjx4YuO3f8G3pHW8v4OnUge/YBa/36dg3WQFEFnIvIiqQ
 Pmyb2KNJAYeWoR9NK9nnH6XNZnjZ2hWCfmrA4UIcGqy99u4JjreDuHyxWdlcmVsL6R0rsjp/USZ
 svEIr5q62At3bZqxwrZ9n5djf6yiCBx4uFLlAvWIPBFzI4zt0pA7XAGpT9umH7NITHkvSadNzG6
 S3Z+QIEQt5SAnvl1y1zb4DTds7HQPhm5vXZuyb8f5t1K842ojiWkpgHt/8RCgLYDC3DucswzjyR
 dSEum7guHGgQNIm/9QG0avXyuNpyGUmoopeiMG0gW6Uk+wt+7ZeK7G2z/M6iq8rPq9uUvXVO3CT
 hjqSvv7TwPkh/EE4HGG7zaOew6r/tGJyVVkru/jJplJSWFid1dmaAiUcc8Fk+Ok0LmXXAS4ASNx
 cE9Say/gBahdCing2MA==
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
X-CRM114-CacheID: sfid-20261108_193230_677058_185CC9E0 
X-CRM114-Status: GOOD (  18.24  )
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
 drivers/nvme/target/io-cmd-file.c | 12 +++++++-----
 drivers/nvme/target/nvmet.h       | 10 ++++++----
 drivers/nvme/target/zns.c         |  2 +-
 5 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 761caac84255..4302dba7c000 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -891,7 +891,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	 * that out from the underlying device.
 	 */
 	id->ncap = id->nsze =
-		cpu_to_le64(req->ns->size >> req->ns->blksize_shift);
+		cpu_to_le64(req->ns->size >> nvmet_ns_blksize_shift(req->ns));
 	switch (req->port->ana_state[req->ns->anagrpid]) {
 	case NVME_ANA_INACCESSIBLE:
 	case NVME_ANA_PERSISTENT_LOSS:
@@ -935,7 +935,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
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
index 4307232c9160..90dbfbd16978 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -131,7 +131,7 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 	if (req->f.mpool_alloc && nr_bvec > NVMET_MAX_MPOOL_BVEC)
 		is_sync = true;
 
-	pos = le64_to_cpu(req->cmd->rw.slba) << req->ns->blksize_shift;
+	pos = le64_to_cpu(req->cmd->rw.slba) << nvmet_ns_blksize_shift(req->ns);
 	if (unlikely(pos + req->transfer_len > req->ns->size)) {
 		ret = -ENOSPC;
 		goto complete;
@@ -297,9 +297,10 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 		if (status)
 			break;
 
-		offset = le64_to_cpu(range.slba) << req->ns->blksize_shift;
+		offset = le64_to_cpu(range.slba) <<
+				nvmet_ns_blksize_shift(req->ns);
 		len = le32_to_cpu(range.nlb);
-		len <<= req->ns->blksize_shift;
+		len <<= nvmet_ns_blksize_shift(req->ns);
 		if (offset + len > req->ns->size) {
 			req->error_slba = le64_to_cpu(range.slba);
 			status = errno_to_nvme_status(req, -ENOSPC);
@@ -351,9 +352,10 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
 	loff_t len;
 	int ret;
 
-	offset = le64_to_cpu(write_zeroes->slba) << req->ns->blksize_shift;
+	offset = le64_to_cpu(write_zeroes->slba) <<
+			nvmet_ns_blksize_shift(req->ns);
 	len = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
-			req->ns->blksize_shift);
+			nvmet_ns_blksize_shift(req->ns));
 
 	if (unlikely(offset + len > req->ns->size)) {
 		nvmet_req_complete(req, errno_to_nvme_status(req, -ENOSPC));
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index d03e059d6d16..1ea0566b8eea 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -159,7 +159,8 @@ struct nvmet_ns {
 		__guarded_by(&subsys->lock);
 	u32			nsid
 		__guarded_by(&subsys->lock);
-	u32			blksize_shift;
+	u32			blksize_shift
+		__guarded_by(&subsys->lock);
 	loff_t			size;
 	u8			nguid[16];
 	uuid_t			uuid;
@@ -207,6 +208,7 @@ static inline _type nvmet_ns_##_name(struct nvmet_ns *ns)		    \
 NVMET_NS_ACCESSOR(struct block_device *, bdev)
 NVMET_NS_ACCESSOR(struct file *, file)
 NVMET_NS_ACCESSOR(u32, nsid)
+NVMET_NS_ACCESSOR(u32, blksize_shift)
 
 /*
  * These accessors use data_race() and READ_ONCE() to allow lockless access to
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


