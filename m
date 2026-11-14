Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BBD606B94B
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aymglX7w;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WUWMqCg0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=CI9BXHoSo4hfYw6MSGjf+jziOWIqLjAx8eHfXINQv1I=; b=aymglX7wKY4Ulr
	zXHiq4fvNQjaKDK/gvL+AWewaop/0EpLM7JVIBhVHrn9VUKpGbUSGhY0Iv8mNugbH9tN/OPV9FvkP
	jXJoN3Ac9LjE4u7HlxIONt1FNSIsivICv/2bpAzCOq76h7QVXFN1G33ot1WbTX3jXOY9hTCcnH/OZ
	LKdv+p7LZdX0DvcPKg/i+nAvRMJFRGflwDApFkPKDkHTeccLXo7gltdl7okM7mH+hTz8p9OqnJd10
	JKc9Kdb6IyRJRMp9s/uMSbyOess6+AE7lLw87BmWGBXddP042Sy1QnYeWH+hxFraYutYHnneHaROG
	NQXQqFEuinKm8BQ1SMmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSBIa-0000000Fopo-10rk;
	Sat, 14 Nov 2026 10:47:56 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSBIY-0000000FopF-40MW
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 10:47:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 344B561EE1;
	Sat, 14 Nov 2026 10:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7C21F000C5;
	Sat, 14 Nov 2026 10:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794653273;
	bh=CI9BXHoSo4hfYw6MSGjf+jziOWIqLjAx8eHfXINQv1I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WUWMqCg0MvjwxhosjPVlLW35iERwAuMI0IOvHnB7Ic1LxGRTErr4mATbmvotIsQ13
	 wxit1TVX2KhvGp6mQCTPm4c324g1i9+7kwUAqOHBFZLPWIXABURfhbX0r36mFouSgQ
	 dpytERSs58TQBzUDr9CKM7yW13D/di1MWetZd3UUW+Ih/J7/+4x8BIXHsIRmNaRpoL
	 juCKNWZuzdjpWFD9w5+pWWu2u9rRR479wFDmsSahAqQxjWKTfCcqbJIwksAy65muiy
	 aRTyUEfcITCc0DRWrmzIhzkZgR2aB5pwvdPgA1WPhXKo7CVSc0M+sY2mrIhhABxHfH
	 zyB7fOETtqPjA==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 14 Nov 2026 11:47:09 +0100
Subject: [PATCH 02/12] zloop: take freeze protection for writes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-work-fs-frozen_writes-v1-2-f5ae61c898b1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3149; i=brauner@kernel.org;
 h=from:subject:message-id; bh=r1h5MgSQFDBwFsX7xlLDHP8qbFBtss93W1Z6lJbarq0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9sLEPPNaw/ZshOxczp1jiz3tVL+a3H0uZ+kkw+e6f1
 U378j9+7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI8QZGhvtz3Hb3C62o9b+e
 WsnbbGwstOf6LN38A/Y13xfVbdf5fYfhr/C37Mk/+5IVlycUiPwyudAc3BH5Q/1FvAZLrAJnwLz
 NXAA=
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

zloop calls ->write_iter() of the zone files without taking freeze
protection. So a write to a zloop device goes through to a filesystem
that is frozen. With the zone files on ext4:

  WARNING: fs/ext4/ext4_jbd2.c:90 at ext4_journal_check_start+0x1f6/0x2d0, CPU#3: kworker/u16:4/507
  Workqueue: zloop0 zloop_cmd_workfn
  Call Trace:
   <TASK>
   __ext4_journal_start_sb+0x7a/0x470
   ext4_dirty_inode+0xa1/0x120
   __mark_inode_dirty+0x154/0x1110
   file_update_time_flags+0x3ab/0x4b0
   ext4_buffered_write_iter+0x143/0x630
   ext4_file_write_iter+0x7b9/0x1570
   zloop_do_rw+0x8ac/0xe10
   zloop_cmd_workfn+0xac5/0x1ff0
   process_one_work+0x946/0x1820
   worker_thread+0x4f1/0xd60
   kthread+0x364/0x460
   ret_from_fork+0x525/0x770
   ret_from_fork_asm+0x1a/0x30
   </TASK>

Take freeze protection around the write like loop does. A write that
wasn't queued drops it right away. A write that was queued drops it in
the completion callback.

Note that zloop_rw() also called the completion callback for I/O that
wasn't queued or that failed before it was submitted. It completes
these itself now so the callback only ever sees queued I/O.

Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/block/zloop.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 65634a39b0bfc..34ed925e86f1a 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -514,6 +514,10 @@ static void zloop_rw_complete(struct kiocb *iocb, long ret)
 {
 	struct zloop_cmd *cmd = container_of(iocb, struct zloop_cmd, iocb);
 
+	/* A queued write still holds freeze protection. */
+	if (req_op(blk_mq_rq_from_pdu(cmd)) != REQ_OP_READ)
+		kiocb_end_write(iocb);
+
 	cmd->ret = ret;
 	zloop_put_cmd(cmd);
 }
@@ -527,6 +531,7 @@ static int zloop_do_rw(struct zloop_cmd *cmd)
 	struct zloop_zone *zone = &zlo->zones[rq_zone_no(rq)];
 	struct req_iterator rq_iter;
 	struct iov_iter iter;
+	int ret;
 
 	if (rq->bio != rq->biotail) {
 		struct bio_vec tmp, *bvec;
@@ -566,9 +571,14 @@ static int zloop_do_rw(struct zloop_cmd *cmd)
 		cmd->iocb.ki_flags = IOCB_DIRECT;
 	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
 
-	if (rw == ITER_SOURCE)
-		return zone->file->f_op->write_iter(&cmd->iocb, &iter);
-	return zone->file->f_op->read_iter(&cmd->iocb, &iter);
+	if (rw == ITER_DEST)
+		return zone->file->f_op->read_iter(&cmd->iocb, &iter);
+
+	kiocb_start_write(&cmd->iocb);
+	ret = zone->file->f_op->write_iter(&cmd->iocb, &iter);
+	if (ret != -EIOCBQUEUED)
+		kiocb_end_write(&cmd->iocb);
+	return ret;
 }
 
 static int zloop_seq_write_prep(struct zloop_cmd *cmd)
@@ -690,8 +700,10 @@ static void zloop_rw(struct zloop_cmd *cmd)
 		ret = zloop_do_rw(cmd);
 	}
 out:
-	if (ret != -EIOCBQUEUED)
-		zloop_rw_complete(&cmd->iocb, ret);
+	if (ret != -EIOCBQUEUED) {
+		cmd->ret = ret;
+		zloop_put_cmd(cmd);
+	}
 	zloop_put_cmd(cmd);
 }
 

-- 
2.53.0


