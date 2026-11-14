Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C97606A8B0
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 10:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bAZNwAZ+;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Px2WgifG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ih0/1NciwlkPSH40NFmRHj+H7Yj43A5F4piAAfxz8EU=; b=bAZNwAZ+wmtytv
	g3bN1+OcGGbbd2sn4epAzmUmmIkq3mEyqAzPoDi4D8SmifAEaVfJ4FRJtJRmGd8vq0UUIj7y/Dx0k
	kg42o7Ubbo3hNel9hVaCSfHOyxYZSIiJFFxVVe3GDA9AP7i+Mz5eLMe+72XvOhjIOks8a1w/3kZKa
	9TnmmX+GakZncOiVjOzsNteuTbMo+ralLjz8VqJZpNyUM3KZ/DOVHYF+HRSCXlPEgm3duG5/y5eVM
	Qs8Hne7y7a+Q5ezfu0jRNpexA0hipsDCVO5wOKGJRNzqf320Rxt44aQzLsg4b94u+k2PwT7DhTbQ5
	3U35lCmaouixBxvBSeuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSBIl-0000000FoyY-2ssT;
	Sat, 14 Nov 2026 10:48:07 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSBIk-0000000Fowz-02Kj
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 10:48:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C116B4249B;
	Sat, 14 Nov 2026 10:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353BF1F00ADB;
	Sat, 14 Nov 2026 10:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794653285;
	bh=ih0/1NciwlkPSH40NFmRHj+H7Yj43A5F4piAAfxz8EU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Px2WgifG9tt2qa2KP702zDUxihDFuVOpxLXWLK8bZa+qbOSoYvhIT62/LM0tGjJ11
	 Um1L2TAcpXZ5HM1R7W7QHkCRBI4vl5mLaV9jpPcLCl4WGXBBjFz2sXLcONmAO5xKZv
	 JBsVUey85WGetnGnpNXXkEF7Kqbr0AUHDFo5Fo2GdIRuQ73sSxgo4z7SwJzRjd3CBY
	 568Fr2L/VfmsMDIshw1zsjAx1DYodHk/PfrCC8ro08VsW3MPIBrg4H1PIJLwtLOmxH
	 /zHrG0I3msJipOdLMgRBaCooVmi9QX1nFgCVWNPH/U0uk4UoFAbNf/g68NZ5Oq1Vqw
	 XoKSM2eKnXH+w==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 14 Nov 2026 11:47:12 +0100
Subject: [PATCH 05/12] target: fileio: take freeze protection for aio
 writes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-work-fs-frozen_writes-v1-5-f5ae61c898b1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4196; i=brauner@kernel.org;
 h=from:subject:message-id; bh=HIFHY9G/S2mY7itWBgazKm1UslrnMns868wvaV80+YI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9sHHqyrCoYtzSIJv9JehPk5dpQZ57WPdep6tOLwtl5
 ZdGrd/ZUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJGkLQz/vcQO7JsfqejBf2t5
 z7591WV/72R2vzhiuXfBqfvbz+VYdDL8Fc3qbDixUq02TvumCeulsvJPe0TVCzNeRLOUNzgFdEq
 zAAA=
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

With fd_async_io=1 the fileio backend calls ->write_iter() of the
backing file without taking freeze protection. So a write to the LUN
goes through to a filesystem that is frozen. With the backing file on
ext4:

  WARNING: fs/ext4/ext4_jbd2.c:90 at ext4_journal_check_start+0x1f6/0x2d0, CPU#0: kworker/0:2/40
  Workqueue: target_submission target_queued_submit_work
  Call Trace:
   <TASK>
   __ext4_journal_start_sb+0x7a/0x470
   ext4_dirty_inode+0xa1/0x120
   __mark_inode_dirty+0x154/0x1110
   file_update_time_flags+0x3ab/0x4b0
   ext4_file_write_iter+0xf11/0x1570
   fd_execute_rw+0xb01/0x1700
   __target_execute_cmd+0x53/0x190
   tcm_loop_write_pending+0xe/0x20
   transport_generic_new_cmd+0x612/0xdb0
   __target_submit+0x12c/0x380
   target_queued_submit_work+0x73/0x270
   process_one_work+0x946/0x1820
   worker_thread+0x4f1/0xd60
   kthread+0x364/0x460
   ret_from_fork+0x525/0x770
   ret_from_fork_asm+0x1a/0x30
   </TASK>

The synchronous path doesn't have that problem. vfs_iter_write() takes
freeze protection.

Take freeze protection around the write. A write that wasn't queued
drops it right away. A write that was queued drops it in the completion
callback.

Note that the completion callback can't tell from the command whether
it completes a write. COMPARE AND WRITE is a write but reads the data to
compare first. So remember the direction of the I/O in the aio command.

Fixes: 769031c92c8b ("scsi: target: target/file: Add support of direct and async I/O")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/target/target_core_file.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index 4dace29b6d662..27b266a092b18 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -246,6 +246,7 @@ struct target_core_file_cmd {
 	unsigned long	len;
 	struct se_cmd	*cmd;
 	refcount_t	ref;
+	bool		is_write;
 	struct kiocb	iocb;
 	struct bio_vec	bvecs[];
 };
@@ -256,12 +257,8 @@ static void cmd_rw_aio_put(struct target_core_file_cmd *cmd)
 		kfree(cmd);
 }
 
-static void cmd_rw_aio_complete(struct kiocb *iocb, long ret)
+static void cmd_rw_aio_done(struct target_core_file_cmd *cmd, long ret)
 {
-	struct target_core_file_cmd *cmd;
-
-	cmd = container_of(iocb, struct target_core_file_cmd, iocb);
-
 	if (ret != cmd->len)
 		target_complete_cmd(cmd->cmd, SAM_STAT_CHECK_CONDITION);
 	else
@@ -270,6 +267,19 @@ static void cmd_rw_aio_complete(struct kiocb *iocb, long ret)
 	cmd_rw_aio_put(cmd);
 }
 
+static void cmd_rw_aio_complete(struct kiocb *iocb, long ret)
+{
+	struct target_core_file_cmd *cmd;
+
+	cmd = container_of(iocb, struct target_core_file_cmd, iocb);
+
+	/* A queued write still holds freeze protection. */
+	if (cmd->is_write)
+		kiocb_end_write(iocb);
+
+	cmd_rw_aio_done(cmd, ret);
+}
+
 static sense_reason_t
 fd_execute_rw_aio(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 	      enum dma_data_direction data_direction)
@@ -300,6 +310,7 @@ fd_execute_rw_aio(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 	refcount_set(&aio_cmd->ref, 2);
 	aio_cmd->cmd = cmd;
 	aio_cmd->len = len;
+	aio_cmd->is_write = is_write;
 	aio_cmd->iocb.ki_pos = cmd->t_task_lba * dev->dev_attrib.block_size;
 	aio_cmd->iocb.ki_filp = file;
 	aio_cmd->iocb.ki_complete = cmd_rw_aio_complete;
@@ -308,13 +319,17 @@ fd_execute_rw_aio(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 	if (is_write && (cmd->se_cmd_flags & SCF_FUA))
 		aio_cmd->iocb.ki_flags |= IOCB_DSYNC;
 
-	if (is_write)
+	if (is_write) {
+		kiocb_start_write(&aio_cmd->iocb);
 		ret = file->f_op->write_iter(&aio_cmd->iocb, &iter);
-	else
+		if (ret != -EIOCBQUEUED)
+			kiocb_end_write(&aio_cmd->iocb);
+	} else {
 		ret = file->f_op->read_iter(&aio_cmd->iocb, &iter);
+	}
 
 	if (ret != -EIOCBQUEUED)
-		cmd_rw_aio_complete(&aio_cmd->iocb, ret);
+		cmd_rw_aio_done(aio_cmd, ret);
 	cmd_rw_aio_put(aio_cmd);
 
 	return 0;

-- 
2.53.0


