Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197C0606A332
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 07:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AA3N1cj2;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MThAUCgE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=IhQw+U8vXOLrpyBD52gZVPDLDYM6TkV606oOtBs+frA=; b=AA3N1cj2V77dJO
	WAWxQZA2Q9D2X4HDSviKhSDLtr7WKIEM+uajL6VCD0iv/ovxCfY8b6nLCz5cEoLhrNvcW2RX83GRd
	v82XvtzaG1wiPIoEkYYV/49Lbx+5D5mlKoU4eQswMDM0xQC2JJBgSk5oH4JwVLOzwNp3E4gY+oDeU
	5IKaW0MEQID0x+jismGiaUNnifSHfnlU4Z//7wHZjCPyFFB/MW0PfBEnutokAIP89aym+UYcDqdmS
	47MDpPVPXmH8ETrz0c8gtRgPZpBscriO0nogatwrKEgOPT1i6+xn0iCf6CqEglmpKg75MU0zKtrwZ
	ddCD9UdHRzF2BaoFnBIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaDK-000000080tX-3Oke;
	Wed, 18 Nov 2026 07:36:18 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaDH-000000080rm-0Y4x
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 07:36:16 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2T4GA4084858;
	Wed, 18 Nov 2026 07:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IhQw+U8vXOLrpyBD5
	2gZVPDLDYM6TkV606oOtBs+frA=; b=MThAUCgEWYLRoW2w1bP5TfAEupxUYeJfz
	fX/dPsldBn6VNdPJENP3PTuc+KkqzyLgzMdJX6j2Yg7RgLrJ5rNmmpxGLLrmCv4c
	8Tcz5WxkExaT0Oc47TgYUl3T703o7FwUgF9t/T4KOf1ZQKJ6MJEK+ijE/jDISDGD
	tM0OIlAmJZVsd76stotYkWOtXC+zE5C1HH/mUJ60K6SYYpjAX7HU9uLrURkfI90f
	TCexnZAe0YBn2t969uPqZQLu6j7zWXo1ovc3UvLWGAOvzEXIlVEiN07Usu39pfev
	reMNj5FLviG6dNnIx7TRZV1f6pwTV3Q0K7MkB7S8AWxWtqRMQwHZw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vhbfa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:36:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2Yt3Y1428858;
	Wed, 18 Nov 2026 07:36:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j02dfg93x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:36:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI7a0lB42402058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 07:36:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E813920049;
	Wed, 18 Nov 2026 07:35:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5916520040;
	Wed, 18 Nov 2026 07:35:55 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.157.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 07:35:54 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, bvanassche@acm.org, sagi@grimberg.me,
        axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 03/22] nvmet: add context annotation for nvmet_ns::file
Date: Wed, 18 Nov 2026 13:04:44 +0530
Message-ID: <20261118073505.288910-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118073505.288910-1-nilay@linux.ibm.com>
References: <20261118073505.288910-1-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: s2F6zzIMXvHwLZLECr6Ck1qm6ylzzquZ
X-Authority-Analysis: v=2.4 cv=HL9WhYtv c=1 sm=1 tr=0 ts=6afd5564 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=RfTRem_JL4LiZ6V1CgkA:9
X-Proofpoint-ORIG-GUID: RUuZQp68MFA1zfrxOL1vj2s6DP5SpV0b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX00EXTCDUEhAe
 c8K0iZQUFVbinkG1uPDiqBXT0DcQxW+hdf0Im1LajbZPw8/VOmjgwhKJdj7uF2BQPPV+qu+6oG3
 fcFfrgqDRZrS0bwPIvZOUU+1P0wEA6Kz9USWIz6hVZAFTTkD2aZeMDJg9GXWZZFTQ2nwffyA99+
 4RM2HhOxdiZFFglCl/UBbel4/wCprB8BEL1zrzjtgfpTKsT2nJBaxuCyBvGq2kQGlpuDZSSHvbS
 pIjbzh2p3+ui1YaZo73xdvdhinoIIJWdERv/XM7oUl5lQ4lpZDroeizuYaoafJUeNo+Xo/NYPFm
 UBpLx628pzB4BwtZUh51rWWbeVMJct/fY8YzTEDiUt1PMv0tbRLLsOGpLH+omzcySa60QTfeXss
 YhwqhFpJo9+3+U+iLP0uhOL+zrlD3uYagdv1vxccwuFysZrsUDylMh4aOovsEq1dk+f258LYDU9
 nLrOpyyosGsx57GBnrw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfXw80O/lSLgPY3
 6lZkroSY2PUuNChPYGYu0D9EJAo8lfkVmqhUi9tdhv3+bu4mgDWB4/Cf1mSj+1dy3HEf8zWhmZ4
 MC4t31HAktC1uA0AnO+2vUZLYXt7ZW4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_233615_314089_9CDE1D12 
X-CRM114-Status: GOOD (  19.84  )
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
and nvmet_file_ns_revalidate() with __must_hold(&ns->subsys->lock) to
document and validate their locking requirements.

Since nvmet_file_flush() accesses the namespace file, change its
interface to accept a struct file pointer as an argument. This allows
callers to obtain the file pointer using the appropriate access
mechanism before invoking the helper:
- nvmet_file_flush_work() runs in the I/O hotpath after acquiring a
  namespace reference, so it uses nvmet_ns_file() to obtain the file
  pointer without holding the subsystem lock.
- nvmet_write_protect_flush_sync() already holds the subsystem lock,
  so it can directly access ns->file and pass the pointer to
  nvmet_file_flush().

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/admin-cmd.c   |  5 +++--
 drivers/nvme/target/core.c        |  2 +-
 drivers/nvme/target/io-cmd-file.c | 19 ++++++++++---------
 drivers/nvme/target/nvmet.h       | 15 ++++++++++-----
 4 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 70b52a43156b..756bf627c16e 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1236,9 +1236,10 @@ static u16 nvmet_write_protect_flush_sync(struct nvmet_req *req)
 	__must_hold(&req->ns->subsys->lock)
 {
 	u16 status;
+	struct file *file = req->ns->file;
 
-	if (req->ns->file)
-		status = nvmet_file_flush(req);
+	if (file)
+		status = nvmet_file_flush(req, file);
 	else
 		status = nvmet_bdev_flush(req);
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index bc7f7eef2b1c..0cf0f311ed10 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1163,7 +1163,7 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 
 	switch (req->ns->csi) {
 	case NVME_CSI_NVM:
-		if (req->ns->file)
+		if (nvmet_ns_file(req->ns))
 			ret = nvmet_file_parse_io_cmd(req);
 		else
 			ret = nvmet_bdev_parse_io_cmd(req);
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 3098b902f519..b7c5c7ecf470 100644
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
@@ -258,7 +258,7 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 
 	if (req->ns->buffered_io) {
 		if (likely(!req->f.mpool_alloc) &&
-		    (req->ns->file->f_mode & FMODE_NOWAIT) &&
+		    (nvmet_ns_file(req->ns)->f_mode & FMODE_NOWAIT) &&
 		    nvmet_file_execute_io(req, IOCB_NOWAIT))
 			return;
 		nvmet_file_submit_buffered_io(req);
@@ -266,16 +266,17 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 		nvmet_file_execute_io(req, 0);
 }
 
-u16 nvmet_file_flush(struct nvmet_req *req)
+u16 nvmet_file_flush(struct nvmet_req *req, struct file *file)
 {
-	return errno_to_nvme_status(req, vfs_fsync(req->ns->file, 1));
+	return errno_to_nvme_status(req, vfs_fsync(file, 1));
 }
 
 static void nvmet_file_flush_work(struct work_struct *w)
 {
 	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
+	struct file *file = nvmet_ns_file(req->ns);
 
-	nvmet_req_complete(req, nvmet_file_flush(req));
+	nvmet_req_complete(req, nvmet_file_flush(req, file));
 }
 
 static void nvmet_file_execute_flush(struct nvmet_req *req)
@@ -313,7 +314,7 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 		}
 		len = len64;
 
-		ret = vfs_fallocate(req->ns->file, mode, offset, len);
+		ret = vfs_fallocate(nvmet_ns_file(req->ns), mode, offset, len);
 		if (ret && ret != -EOPNOTSUPP) {
 			req->error_slba = le64_to_cpu(range.slba);
 			status = errno_to_nvme_status(req, ret);
@@ -368,7 +369,7 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
 	}
 	len = len64;
 
-	ret = vfs_fallocate(req->ns->file, mode, offset, len);
+	ret = vfs_fallocate(nvmet_ns_file(req->ns), mode, offset, len);
 	nvmet_req_complete(req, ret < 0 ? errno_to_nvme_status(req, ret) : 0);
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index fc2ccf992d30..20b87de18054 100644
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
@@ -759,17 +761,20 @@ bool nvmet_host_allowed(struct nvmet_subsys *subsys, const char *hostnqn);
 
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
+u16 nvmet_file_flush(struct nvmet_req *req, struct file *file);
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


