Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9AB606A329
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 10:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aEcKBCRK;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DakOD7A1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=EPXfSvBCYCPKb/RAX3GCQEpLV4ev3a42UOQga3sf9mQ=; b=aEcKBCRKpFNlHK
	/1i711qLsEaz3RfAawSNTxaOqVdJgjN10MEYvhcAvMUzU2HrczMAyacPMI1M8cR+UwEpXQBvtK/ko
	xNKL4wFeDkbh+kw42ADB3/TAQdfNlgdMMpYSglO+pSij7PCAQpK9yDywZkQDafSlBe3YBX0P2RN4Y
	TsgPZTpuMqVWDl6JFyEaiOkRRzHLjtiRiN+AxZmfiRziDERM4HAqeOQgv2DOGantbh57evZ6sHruP
	9rxspLw3GENCzWYoEgt/GAg35SYGKrfb96yBHkzUEF1A6UF6ZvgqqkiF3PGUIW3o4KYTuS++4gbFn
	TPg24j4jeqJu90vX0UHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSBIf-0000000FosN-0IlL;
	Sat, 14 Nov 2026 10:48:01 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSBId-0000000Forq-0UDm
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 10:47:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2C6D561DB2;
	Sat, 14 Nov 2026 10:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1161F000C6;
	Sat, 14 Nov 2026 10:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794653277;
	bh=EPXfSvBCYCPKb/RAX3GCQEpLV4ev3a42UOQga3sf9mQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DakOD7A1n3IwqMYolCiPetDw15uh3sm7RVPBY43kM2NYOc+qn3vhRPYwb8szRRAmQ
	 jv92DwWqAz2F0TNUfjZBwyk7JDnEKCPiOMBQZhohvxm3R0z7RtQeZsPwQZxURAAlPu
	 5manaU69aDlpz59ajGmPJAFiijZjYz8EoowbPxVGi4mZhn5NHtsKW3wY6NSvoc2BkJ
	 /KZkmnSbRcqC1DmQ72gjw/GC+XCY/48V+VRWijzOvnfA/VsSElGPBf7kPHJvWD/xrb
	 9Q57wmAjqVi15M9QDrRTgGz4JMcotHqRweJq851hy99NQBd2DfMK3eb4yZOLkI3NXd
	 t4TBWDY19rQRg==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 14 Nov 2026 11:47:10 +0100
Subject: [PATCH 03/12] nvmet: take freeze protection for writes to files
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-work-fs-frozen_writes-v1-3-f5ae61c898b1@kernel.org>
References: <20261114-work-fs-frozen_writes-v1-0-f5ae61c898b1@kernel.org>
In-Reply-To: <20261114-work-fs-frozen_writes-v1-0-f5ae61c898b1@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, bpf@vger.kernel.org, 
 linux-nfs@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4272; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YSrX1zIKRv3jJ31B+unsoiKy8FJYqJOmxZhrDtaDVhQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9sHHIuxawSj37dst58ZS0yX/DJ0mr/V4R8OpUeHfK6
 pDpKtKBHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZ7cbIcDg/RayD2V9XXvqx
 1tHyY0v2Jd9bb/dLITVra/O7mapcagx/xR58zN99qfGwwar5wu+2SaqxBk9kM2jiFVu95eSL3DP
 xzAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The file backend calls ->write_iter() of the backing file without
taking freeze protection. So a write to a namespace goes through to a
filesystem that is frozen. With the backing file on ext4 and
buffered_io:

  WARNING: fs/ext4/ext4_jbd2.c:90 at ext4_journal_check_start+0x1f6/0x2d0, CPU#1: kworker/1:1/56
  Workqueue: nvmet-buffered-io-wq nvmet_file_buffered_io_work
  Call Trace:
   <TASK>
   __ext4_journal_start_sb+0x7a/0x470
   ext4_dirty_inode+0xa1/0x120
   __mark_inode_dirty+0x154/0x1110
   file_update_time_flags+0x3ab/0x4b0
   ext4_buffered_write_iter+0x143/0x630
   ext4_file_write_iter+0x7b9/0x1570
   nvmet_file_submit_bvec+0x2e7/0x590
   nvmet_file_execute_io+0x460/0x830
   process_one_work+0x946/0x1820
   worker_thread+0x4f1/0xd60
   kthread+0x364/0x460
   ret_from_fork+0x525/0x770
   ret_from_fork_asm+0x1a/0x30
   </TASK>

The same happens with direct I/O.

Take freeze protection around the write. A write that wasn't queued
drops it right away. A write that was queued drops it in the completion
callback. nvmet_file_io_done() is also called for I/O that wasn't queued
so queued I/O gets its own callback.

Note that buffered I/O is tried with IOCB_NOWAIT first. That attempt
must not wait until the filesystem is thawed. So it only tries to get
freeze protection and fails with -EAGAIN otherwise. The write is then
retried from the workqueue like any other write that would have
blocked.

Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/nvme/target/io-cmd-file.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 695963dd932ee..2a2be95263733 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -77,27 +77,39 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 		unsigned long nr_segs, size_t count, int ki_flags)
 {
 	struct kiocb *iocb = &req->f.iocb;
-	ssize_t (*call_iter)(struct kiocb *iocb, struct iov_iter *iter);
+	struct file *file = req->ns->file;
 	struct iov_iter iter;
+	ssize_t ret;
 	int rw;
 
 	if (req->cmd->rw.opcode == nvme_cmd_write) {
 		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
 			ki_flags |= IOCB_DSYNC;
-		call_iter = req->ns->file->f_op->write_iter;
 		rw = ITER_SOURCE;
 	} else {
-		call_iter = req->ns->file->f_op->read_iter;
 		rw = ITER_DEST;
 	}
 
 	iov_iter_bvec(&iter, rw, req->f.bvec, nr_segs, count);
 
 	iocb->ki_pos = pos;
-	iocb->ki_filp = req->ns->file;
-	iocb->ki_flags = ki_flags | iocb->ki_filp->f_iocb_flags;
+	iocb->ki_filp = file;
+	iocb->ki_flags = ki_flags | file->f_iocb_flags;
 
-	return call_iter(iocb, &iter);
+	if (rw == ITER_DEST)
+		return file->f_op->read_iter(iocb, &iter);
+
+	/* The IOCB_NOWAIT attempt must not wait for a thaw. */
+	if (ki_flags & IOCB_NOWAIT) {
+		if (!kiocb_start_write_trylock(iocb))
+			return -EAGAIN;
+	} else {
+		kiocb_start_write(iocb);
+	}
+	ret = file->f_op->write_iter(iocb, &iter);
+	if (ret != -EIOCBQUEUED)
+		kiocb_end_write(iocb);
+	return ret;
 }
 
 static void nvmet_file_io_done(struct kiocb *iocb, long ret)
@@ -117,6 +129,17 @@ static void nvmet_file_io_done(struct kiocb *iocb, long ret)
 	nvmet_req_complete(req, status);
 }
 
+static void nvmet_file_io_complete(struct kiocb *iocb, long ret)
+{
+	struct nvmet_req *req = container_of(iocb, struct nvmet_req, f.iocb);
+
+	/* A queued write still holds freeze protection. */
+	if (req->cmd->rw.opcode == nvme_cmd_write)
+		kiocb_end_write(iocb);
+
+	nvmet_file_io_done(iocb, ret);
+}
+
 static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 {
 	ssize_t nr_bvec = req->sg_cnt;
@@ -175,7 +198,7 @@ static bool nvmet_file_execute_io(struct nvmet_req *req, int ki_flags)
 	 * for the IOCB_NOWAIT case.
 	 */
 	if (!(ki_flags & IOCB_NOWAIT))
-		req->f.iocb.ki_complete = nvmet_file_io_done;
+		req->f.iocb.ki_complete = nvmet_file_io_complete;
 
 	ret = nvmet_file_submit_bvec(req, pos, bv_cnt, total_len, ki_flags);
 

-- 
2.53.0


