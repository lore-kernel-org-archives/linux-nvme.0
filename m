Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94360606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 03:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZVEo57ir;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=b2My/3Qy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Th0tfsBcCr4hUwSX6LyjWxp/ekAicQ1sta4iAWhyx/E=; b=ZVEo57irYc7Ub6
	8mMUnmVtFAR85eqOHFxYovx+yCF7XrIynqmxMJPptDRGq06+xeZlO46/1zNEy05Qxuvyt4bvAgt2K
	FdSSsTMxc1vgyaJapUbg3TbrGC2qPTAJ9JaGw1NEqcSCjRBz4P1ZNbaF07trnhhBmKMg0J9/HXeuw
	WL3BZNhx2ca0JHPmpOZoOFuABMaDgJgHcdE7/aC4pKE4mx4rMVqY+4qGxTUPcoI2d22QqAPJy3uV4
	7lZxL9wCYugooIQBvZ4iuKHRS+CZERNlhlQKfzlhQGfjPL1g8wIp/K1xA9LEI8Qc2xgWLJ3hJxh4I
	qKpHZxzkFohKqdzpMdLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG7a-0000000HCz6-0iP2;
	Mon, 09 Nov 2026 03:32:38 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG7X-0000000HCwr-1W8K
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 03:32:36 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90j8d71961093;
	Mon, 9 Nov 2026 03:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Th0tfsBcCr4hUwSX6
	LyjWxp/ekAicQ1sta4iAWhyx/E=; b=b2My/3QyTvkl9Phl1GrV8FmcSt07T4UZD
	8gCw923y2GSxNRqUMPgoS72VXGqYb5bTALR6S6jW/qQlrUAQkWf8DtWKtCGGl6cZ
	nUh9Q8SJPFwr+GGSJ0+5Zj3CuB2IyHChgZztuhyTK9IKV8NUx4ykR8Y0uJslxrVO
	2mw4HjS5wG2VBFgX4NgYqidtc5sAO50FCPOvmDenVuKw86bZ4TjpkVb1WRSZ1pSf
	qvZsXtBxWn50AwnMLXIszb3w1Uzsc8/yYPMusmhQjvNc4Rdq0OY+VFzLN2cHAQMO
	8iAimCdqhCauAk2c0HgRRUdl57giL2a9fdKvCv7hwzUOwNXZy2Q6w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumuj30a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:32:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A93KHqu3535443;
	Mon, 9 Nov 2026 03:32:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfajwfpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:32:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A93WNQY29622562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 03:32:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89FBF20043;
	Mon,  9 Nov 2026 03:32:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8FCF20040;
	Mon,  9 Nov 2026 03:32:18 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.101.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 03:32:18 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, bvanassche@acm.org, elver@google.com,
        linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 09/23] nvmet: add context annotation for nvmet_ns::size
Date: Mon,  9 Nov 2026 08:58:14 +0530
Message-ID: <20261109033102.982191-34-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109033102.982191-25-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX1W49nE25j53I
 YqAViOIEAZcos03ci2Q10w+MFGkPYlv9ObSru5H5Xv/Dc88sEhzAo8pSYDxxs18fC0a06C3OC7x
 ZEa479rwgyecyuSLWreBFM3VeD7A3/Q=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af13ecc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=KwJ8z0Xve6JmAVbpLWoA:9
X-Proofpoint-GUID: 2VHSkQq4c7V2TzrU-3C7hipOV0z3eMZG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX8qsch3W8SwGH
 qdXrJJ5JO5omqZQ/aXzxde6PzNdjuHeogg35p+WZrwqf20j5ujC/YDLcPvwgTGB2vUSEYBzyowg
 Td10AL/h1xF3CUyvKpkIIcJijeDmJZ0hK92KJRREPfAkcTRJgVdQrcg1IxASCzm+qqFkQeGthZt
 FYnpLNErLTTuoNX/DdD9W0CYWMMD/TnrWOzqaj99rd9qbNnEk6nARLJH6BY1EHx1BhHbM9cQx+K
 VoiSksOYXbXgGX6A7B3j6D4B0m2LuENvA68bYppgbL+3s5afjCFz1xDh63xwT/whXTNH+/4q0Cl
 pTJHopGxSXsTSWNIyiv+Kv1PoODXo8wvY2/PS6EKwVfXoEr2BRlEvy427HTL6UJh6z3C0ESdWj4
 pEbRLKc8QcZVCYTW8gG+jL7Wd4XwLSOE3AyvygKMhxtr5kR6vSfZIXoQcUmrRpHc9oV55p5HSzZ
 fZ+b5UGRXVK7mBelljg==
X-Proofpoint-ORIG-GUID: 4SPIDzZ9WgPrf7JVZD6A_XGquYPH4zpY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_193235_541661_D3F333A6 
X-CRM114-Status: GOOD (  20.54  )
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

The nvmet_ns::size field is protected by nvmet_subsys::lock. Annotate
it with __guarded_by(&subsys->lock) to allow the Clang context analyzer
to validate accesses to this field.

The I/O hotpath also accesses ns->size without holding subsys->lock.
Unlike ns->bdev, which cannot be updated while I/O is in flight due to
the namespace reference, ns->size can be modified concurrently by
nvmet_ns_revalidate_size_store() or nvmet_file_ns_revalidate().
Consequently, lockless reads may observe a transient value of ns->size,
which is acceptable for these access paths.

Introduce nvmet_ns_size() to perform these lockless reads using
data_race(READ_ONCE()) which would silence KCSAN splat as well as help
avoid clang context analyser warning. Use this accessor at the relevant
call sites where accessing ns->size without holding subsys->lock is
harmless despite concurrent updates.

Pair these lockless reads with WRITE_ONCE() for all updates to ns->size.
Also use READ_ONCE() in nvmet_ns_revalidate() when reading the old and
new size values to detect changes.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/admin-cmd.c   |  3 ++-
 drivers/nvme/target/core.c        |  4 ++--
 drivers/nvme/target/io-cmd-bdev.c |  4 ++--
 drivers/nvme/target/io-cmd-file.c | 10 +++++-----
 drivers/nvme/target/nvmet.h       |  4 +++-
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 4302dba7c000..7cdf13351678 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -891,7 +891,8 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	 * that out from the underlying device.
 	 */
 	id->ncap = id->nsze =
-		cpu_to_le64(req->ns->size >> nvmet_ns_blksize_shift(req->ns));
+		cpu_to_le64(nvmet_ns_size(req->ns) >>
+				nvmet_ns_blksize_shift(req->ns));
 	switch (req->port->ana_state[req->ns->anagrpid]) {
 	case NVME_ANA_INACCESSIBLE:
 	case NVME_ANA_PERSISTENT_LOSS:
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 2913ed76bc6a..77e2ef211711 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -591,14 +591,14 @@ static void nvmet_p2pmem_ns_add_p2p(struct nvmet_ctrl *ctrl,
 
 bool nvmet_ns_revalidate(struct nvmet_ns *ns)
 {
-	loff_t oldsize = ns->size;
+	loff_t oldsize = READ_ONCE(ns->size);
 
 	if (ns->bdev)
 		nvmet_bdev_ns_revalidate(ns);
 	else
 		nvmet_file_ns_revalidate(ns);
 
-	return oldsize != ns->size;
+	return oldsize != READ_ONCE(ns->size);
 }
 
 int nvmet_ns_enable(struct nvmet_ns *ns)
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index e950b442ffc6..0ed691387f1c 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -115,7 +115,7 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 		return ret;
 	}
 	ns->bdev = file_bdev(ns->bdev_file);
-	ns->size = bdev_nr_bytes(ns->bdev);
+	WRITE_ONCE(ns->size, bdev_nr_bytes(ns->bdev));
 	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
 
 	ns->pi_type = 0;
@@ -136,7 +136,7 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 
 void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)
 {
-	ns->size = bdev_nr_bytes(ns->bdev);
+	WRITE_ONCE(ns->size, bdev_nr_bytes(ns->bdev));
 }
 
 u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 90dbfbd16978..224b7423b780 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -15,7 +15,7 @@
 
 void nvmet_file_ns_revalidate(struct nvmet_ns *ns)
 {
-	ns->size = i_size_read(ns->file->f_mapping->host);
+	WRITE_ONCE(ns->size, i_size_read(ns->file->f_mapping->host));
 }
 
 void nvmet_file_ns_disable(struct nvmet_ns *ns)
@@ -68,7 +68,7 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 err:
 	fput(ns->file);
 	ns->file = NULL;
-	ns->size = 0;
+	WRITE_ONCE(ns->size, 0);
 	ns->blksize_shift = 0;
 	return ret;
 }
@@ -132,7 +132,7 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 		is_sync = true;
 
 	pos = le64_to_cpu(req->cmd->rw.slba) << nvmet_ns_blksize_shift(req->ns);
-	if (unlikely(pos + req->transfer_len > req->ns->size)) {
+	if (unlikely(pos + req->transfer_len > nvmet_ns_size(req->ns))) {
 		ret = -ENOSPC;
 		goto complete;
 	}
@@ -301,7 +301,7 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 				nvmet_ns_blksize_shift(req->ns);
 		len = le32_to_cpu(range.nlb);
 		len <<= nvmet_ns_blksize_shift(req->ns);
-		if (offset + len > req->ns->size) {
+		if (offset + len > nvmet_ns_size(req->ns)) {
 			req->error_slba = le64_to_cpu(range.slba);
 			status = errno_to_nvme_status(req, -ENOSPC);
 			break;
@@ -357,7 +357,7 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
 	len = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
 			nvmet_ns_blksize_shift(req->ns));
 
-	if (unlikely(offset + len > req->ns->size)) {
+	if (unlikely(offset + len > nvmet_ns_size(req->ns))) {
 		nvmet_req_complete(req, errno_to_nvme_status(req, -ENOSPC));
 		return;
 	}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 1ea0566b8eea..59adf99470f8 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -161,7 +161,8 @@ struct nvmet_ns {
 		__guarded_by(&subsys->lock);
 	u32			blksize_shift
 		__guarded_by(&subsys->lock);
-	loff_t			size;
+	loff_t			size
+		__guarded_by(&subsys->lock);
 	u8			nguid[16];
 	uuid_t			uuid;
 	u32			anagrpid;
@@ -222,6 +223,7 @@ static inline _type nvmet_ns_##_name(struct nvmet_ns *ns)		\
 }									\
 
 NVMET_NS_ACCESSOR_RACE(bool, readonly)
+NVMET_NS_ACCESSOR_RACE(loff_t, size)
 
 static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
 {
-- 
2.53.0


