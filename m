Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B5160A6F6F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 11:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IWK8pooQ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YrXKRoj7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=CGT6lYWV7+MTFrcd9Hkn4PROzI9r5OHEQYJ/85o2rx4=; b=IWK8pooQXfGq/P
	i0BwWebXYIbqayDfYSEm+jClZt8cdI8nDLVT4BPS02NkC1ArN99/wXK8XJGRwAWfT3NGtfNvWA8wL
	PjkkCJg/LN3LuV4dV1YFZP1ATWB07Kwdq2Lt6/fSbfAhlIcwt6GAJCUZ4Tku921oP0yX+ityyFNjj
	eig48SbPAwisFzbHgpOUAmJ/Xc9I3/vI91uK+AGVjiCJ9cGdgv4l0wwIU2JIbORsQxSehFHf7bwIT
	pIgzngfRnbJBmBIH+pOvJlwnKKFqoEbPxGr4SFLx+5sGsRl7Ft6BOZ4sBjC1Os9qxw8WQossVLns4
	hstifZ5VmE63lytEQ2GQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuW7-000000024wv-2yDM;
	Mon, 16 Nov 2026 11:04:55 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuW6-000000024vi-05LA
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:04:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C256C462A1;
	Mon, 16 Nov 2026 11:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EAD1F000D3;
	Mon, 16 Nov 2026 11:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827093;
	bh=CGT6lYWV7+MTFrcd9Hkn4PROzI9r5OHEQYJ/85o2rx4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YrXKRoj7hYn2+ZjIVHE1rFDcotZKzJGWV+gKQ6yybnV0zsnhl0EdVnEgsaxFR4vz6
	 v5Fk+DSF36PyDuzTgAAjNYwVOo4qsw7y9UF5g9GZTDM6MJPgp2mNeDYnNDQSTxdfaP
	 9LNNLGe1QXYP2BMesvZ7a049fB7AMjcJ/h+/wRx/y70ECT8kdyQw5kBx+KswtTfUDS
	 PBrr48HlhbF5Ehtm+4yZHxsyzRHSBcwIlBO7Ot9/Pz8puLYygyWBrCRbzm4/G9k/uQ
	 31fHO5+9WfinhzkFbIp1gPtrH4Q6ZRJye+Z2q1Ls5/LmVAm+w0nxbu7wT2dDSd4bGo
	 kg8Hw+7m3Paig==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Nov 2026 12:03:47 +0100
Subject: [PATCH v2 07/17] target: fileio: take freeze protection for aio
 writes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-work-fs-frozen_writes-v2-7-ecc4a2aac40e@kernel.org>
References: <20261116-work-fs-frozen_writes-v2-0-ecc4a2aac40e@kernel.org>
In-Reply-To: <20261116-work-fs-frozen_writes-v2-0-ecc4a2aac40e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2554; i=brauner@kernel.org;
 h=from:subject:message-id; bh=odczWWAJfAcRe3p+krtaO8nSx1NU1nb1y8bUX3hioHw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9eqy6Zcusfy+2fC699Tfy0oulb9drKbn+jX28cU5vB
 kOY0s9TZztKWRjEuBhkxRRZHNpNwuWW81RsNsrUgJnDygQyhIGLUwAmErKWkeHqptw+qyMfJ73Z
 xZz5ffPTKibBHNv96Z/XTVm0///tFiZRhv9OF1qF/dS/ONQIvfWyDeHlOt3mtXOa6VEXjtsaj69
 +vs4EAA==
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

Submit writes with kiocb_write_iter() and drop freeze protection in the
completion callback with kiocb_end_write_iter().

Note that the completion callback couldn't tell from the command whether
it completes a write anyway. COMPARE AND WRITE is a write but reads the
data to compare first. kiocb_write_iter() marks the kiocb with
IOCB_WRITE so the callback doesn't need to know.

Fixes: 769031c92c8b ("scsi: target: target/file: Add support of direct and async I/O")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/target/target_core_file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index 4b23fadd7bb88..e8a44ddf6f5c9 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -268,6 +268,7 @@ static void cmd_rw_aio_complete(struct kiocb *iocb, long ret)
 	struct target_core_file_cmd *cmd;
 
 	cmd = container_of(iocb, struct target_core_file_cmd, iocb);
+	kiocb_end_write_iter(iocb);
 	cmd->ret = ret;
 	cmd_rw_aio_put(cmd);
 }
@@ -311,7 +312,7 @@ fd_execute_rw_aio(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 		aio_cmd->iocb.ki_flags |= IOCB_DSYNC;
 
 	if (is_write)
-		ret = file->f_op->write_iter(&aio_cmd->iocb, &iter);
+		ret = kiocb_write_iter(&aio_cmd->iocb, &iter);
 	else
 		ret = file->f_op->read_iter(&aio_cmd->iocb, &iter);
 

-- 
2.53.0


