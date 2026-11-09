Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9179606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 03:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AwaXqftu;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Eqj03eyF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=JC7JAA8nV55CuMrUeages7Gwx6AtHgt+WpPMjoaSm2M=; b=AwaXqftuTCYUKR
	rTgifbMtsW3yhvLBGk9fBeg+Vr0mLucFOePPat5iyR6iY3FjXTSxC+IhTb3foQv9tgbqRJt+1FHq0
	7j5gErCCp5DW42mIdzfaRwuXHNXJjzav8OHTdbGAt8WjznVeQX2Qinb5GTe8wUGe2KZ2UAvhr16RP
	qb5GSPDZv2IsakwtThtdC1MoZN7CTFgbrsuEKu1enlTQVWwRKu4VLwRWGUpu3XAYDZj+x/FkaJTeM
	mJbfKDwPLdJ/b3uX2IJqM2W/izWsS1kXzkHllciHGGo2sDidCrWRurH1OQLJ8daM2Z/StG6r3C1I4
	LZFaFqweQPdTERfOFS5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG6u-0000000HCR2-2BV8;
	Mon, 09 Nov 2026 03:31:56 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG6s-0000000HCPN-3MWO
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 03:31:56 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90iAlk1945640;
	Mon, 9 Nov 2026 03:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JC7JAA8nV55CuMrUe
	ages7Gwx6AtHgt+WpPMjoaSm2M=; b=Eqj03eyFFqZis1CtjOydauECVaxNzHsIP
	b0f3fOhBc8JF7vZzOzkuK5FuinQNC/X1ol+djjTD+rstT093zWLeeGBwdVgGjo9N
	EKrKxxmwZ97/3PiLINAHvCWpkxaUlNqhSyFdJoY3/5zN9gRJTFurYexIRxA292qC
	JBoKvfsDOZDvrJe7ZpcsPFy/ysZRqIg0ArEJk6F8zLxGopytSVAgbY3ksFrg7XsT
	9q/l9yTpJ/dkFtaRVLyc5z7AOMFQMJTESX8GQHfXgSRs2QACk+8/haPbCSiihA4i
	xqdSLGvjZNTcXW+lhuUPaCaBvWaPqWWe/s0ApXxNnrZnBvJWR+YVQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq6jebw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:31:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A93K1Go3675040;
	Mon, 9 Nov 2026 03:31:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfthdbe9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:31:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A93Vf9F30147052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 03:31:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3CEE2004B;
	Mon,  9 Nov 2026 03:31:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B33320043;
	Mon,  9 Nov 2026 03:31:34 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.101.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 03:31:33 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, bvanassche@acm.org, elver@google.com,
        linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 03/23] nvmet: add context annotation for nvmet_ns::file
Date: Mon,  9 Nov 2026 08:58:08 +0530
Message-ID: <20261109033102.982191-28-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109033102.982191-25-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfXyH+sBAv2eG7D
 aqWvEKna2KAIrhXxY+R0UbfwIfyW22KrFdfXrHpl9T+OusPc8JGTzdlUz553eDGH0jdAWgHqJ0g
 yWQGdfEvF8OOJeWk63WiO1z1vtYsbhM=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af13ea3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=l1_IYcJL17Q62n-fBkoA:9
X-Proofpoint-ORIG-GUID: XAMI90jDZrUg3Dh3oZ005EJr6IMGt82M
X-Proofpoint-GUID: YcJq2lqfIBk0Srkt3z5T6WD9DMEVDul7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfXyQl0gbu06FDZ
 wOhbGBnDsOmS4PZezyTNBjQFj7J660etqyoDHuPlOcJ6s8bm5CDiwE5WD+nQ/v27sI//g4vG2a7
 ZYPKt/EomfkbQoawBUWO9qUkDwfiXPwb/psluBkPrsaQJ7AJy9BL6rQh5Oabb4ikWxB8LYgidaD
 XcA8OxIwsqWehYotGelrB6hgTQJZak6M1EMs8t6+NvdDLOk0+eyv3FpwC/G3aWgm5nk3v3tvoPe
 3o8dQCwTiX173jGzECzcRrI7PtwQJ8uH/M4dfvaZZCv/N6irdkIjtewlD2FIfpZkConfuU9Xx/k
 1SjjdOPfWIS4ebS6M3ErYnHivFrPmlpUMQDpBgcAeR9bAG1CATjDcTyzLQJUWrKOquWPQ0S5K4F
 ipIf38/HpFNW6/cFlrmL7AqZjojq+szEIidKa9zytD+e08cN56MELqIILyPQ/WQ40GY740teyix
 P6o/1PIA01OpsqRr3Bw==
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
X-CRM114-CacheID: sfid-20261108_193154_976158_79EBB026 
X-CRM114-Status: GOOD (  19.29  )
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

The nvmet_ns::file field is protected by nvmet_subsys::lock.
Annotate it with __guarded_by(&subsys->lock) so that the clang
context analyzer can validate accesses to this field.

Some accesses to nvmet_ns::file in the I/O hotpath do not require
holding nvmet_subsys::lock, as the namespace reference guarantees
that the namespace remains valid and the field is not modified while
I/O is in flight. However, the clang context analyzer cannot express
this access pattern directly.

Introduce nvmet_ns_file() as an inline helper annotated with
__context_unsafe() to allow these accesses without requiring the
subsystem lock. Convert the relevant accesses in the I/O hotpath and
request-processing paths to use this helper.

Additionally, annotate nvmet_file_ns_enable(), nvmet_file_ns_disable()
nvmet_file_flush() and nvmet_file_ns_revalidate() with
__must_hold(&ns->subsys->lock) to document and validate their locking
requirements.

Finally, nvmet_file_flush_work() invokes nvmet_file_flush() from the
I/O hotpath after acquiring a namespace reference. Explicitly assert
the ns->subsys->lock capability using __assume_ctx_lock() to satisfy
the context analyzer, since nvmet_file_flush() requires callers to
hold this lock.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/core.c        |  2 +-
 drivers/nvme/target/io-cmd-file.c | 25 +++++++++++++++++++------
 drivers/nvme/target/nvmet.h       | 16 +++++++++++-----
 3 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index c9837263898a..ef99c45f0f37 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1171,7 +1171,7 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 
 	switch (req->ns->csi) {
 	case NVME_CSI_NVM:
-		if (req->ns->file)
+		if (nvmet_ns_file(req->ns))
 			ret = nvmet_file_parse_io_cmd(req);
 		else
 			ret = nvmet_bdev_parse_io_cmd(req);
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 695963dd932e..4307232c9160 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -84,17 +84,17 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 	if (req->cmd->rw.opcode == nvme_cmd_write) {
 		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
 			ki_flags |= IOCB_DSYNC;
-		call_iter = req->ns->file->f_op->write_iter;
+		call_iter = nvmet_ns_file(req->ns)->f_op->write_iter;
 		rw = ITER_SOURCE;
 	} else {
-		call_iter = req->ns->file->f_op->read_iter;
+		call_iter = nvmet_ns_file(req->ns)->f_op->read_iter;
 		rw = ITER_DEST;
 	}
 
 	iov_iter_bvec(&iter, rw, req->f.bvec, nr_segs, count);
 
 	iocb->ki_pos = pos;
-	iocb->ki_filp = req->ns->file;
+	iocb->ki_filp = nvmet_ns_file(req->ns);
 	iocb->ki_flags = ki_flags | iocb->ki_filp->f_iocb_flags;
 
 	return call_iter(iocb, &iter);
@@ -241,7 +241,7 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 
 	if (req->ns->buffered_io) {
 		if (likely(!req->f.mpool_alloc) &&
-		    (req->ns->file->f_mode & FMODE_NOWAIT) &&
+		    (nvmet_ns_file(req->ns)->f_mode & FMODE_NOWAIT) &&
 		    nvmet_file_execute_io(req, IOCB_NOWAIT))
 			return;
 		nvmet_file_submit_buffered_io(req);
@@ -258,6 +258,19 @@ static void nvmet_file_flush_work(struct work_struct *w)
 {
 	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
 
+	/*
+	 * The flush work is scheduled from the I/O hotpath after acquiring
+	 * a reference to the namespace. This ensures that the namespace
+	 * cannot be modified while the I/O is in flight.
+	 *
+	 * nvmet_file_flush() requires callers to hold ns->subsys->lock.
+	 * Since we already hold a namespace reference, explicitly assert
+	 * the lock capability here to satisfy the context analyzer.
+	 *
+	 * Other callers of nvmet_file_flush() that do not hold a namespace
+	 * reference must acquire ns->subsys->lock before invoking it.
+	 */
+	__assume_ctx_lock(&req->ns->subsys->lock);
 	nvmet_req_complete(req, nvmet_file_flush(req));
 }
 
@@ -293,7 +306,7 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 			break;
 		}
 
-		ret = vfs_fallocate(req->ns->file, mode, offset, len);
+		ret = vfs_fallocate(nvmet_ns_file(req->ns), mode, offset, len);
 		if (ret && ret != -EOPNOTSUPP) {
 			req->error_slba = le64_to_cpu(range.slba);
 			status = errno_to_nvme_status(req, ret);
@@ -347,7 +360,7 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
 		return;
 	}
 
-	ret = vfs_fallocate(req->ns->file, mode, offset, len);
+	ret = vfs_fallocate(nvmet_ns_file(req->ns), mode, offset, len);
 	nvmet_req_complete(req, ret < 0 ? errno_to_nvme_status(req, ret) : 0);
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 41912877ade3..74b066ce9ab0 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -152,7 +152,8 @@ struct nvmet_ns {
 	struct file		*bdev_file;
 	struct block_device	*bdev
 		__guarded_by(&subsys->lock);
-	struct file		*file;
+	struct file		*file
+		__guarded_by(&subsys->lock);
 	bool			readonly;
 	u32			nsid;
 	u32			blksize_shift;
@@ -201,6 +202,7 @@ static inline _type nvmet_ns_##_name(struct nvmet_ns *ns)		    \
 }
 
 NVMET_NS_ACCESSOR(struct block_device *, bdev)
+NVMET_NS_ACCESSOR(struct file *, file)
 
 static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
 {
@@ -757,17 +759,21 @@ bool nvmet_host_allowed(struct nvmet_subsys *subsys, const char *hostnqn);
 
 int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 	__must_hold(&ns->subsys->lock);
-int nvmet_file_ns_enable(struct nvmet_ns *ns);
+int nvmet_file_ns_enable(struct nvmet_ns *ns)
+	__must_hold(&ns->subsys->lock);
 void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
 	__must_hold(&ns->subsys->lock);
-void nvmet_file_ns_disable(struct nvmet_ns *ns);
+void nvmet_file_ns_disable(struct nvmet_ns *ns)
+	__must_hold(&ns->subsys->lock);
 u16 nvmet_bdev_flush(struct nvmet_req *req)
 	__must_hold(&req->ns->subsys->lock);
-u16 nvmet_file_flush(struct nvmet_req *req);
+u16 nvmet_file_flush(struct nvmet_req *req)
+	__must_hold(&req->ns->subsys->lock);
 void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
 void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)
 	__must_hold(&ns->subsys->lock);
-void nvmet_file_ns_revalidate(struct nvmet_ns *ns);
+void nvmet_file_ns_revalidate(struct nvmet_ns *ns)
+	__must_hold(&ns->subsys->lock);
 bool nvmet_ns_revalidate(struct nvmet_ns *ns)
 	__must_hold(&ns->subsys->lock);
 u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts);
-- 
2.53.0


