Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751BA606A8A1
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 11:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ztwpGui7;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PafvJE3d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=EWEQe50Q7bYbdLpYkYQap52GI3LJt8CnLN09OmwuI1w=; b=ztwpGui7bm1a9v
	02T3+afJ5cM55mohNM9gp9MXrgmOx6sdd+Dgbaz1KgnHwAd2If31P4anAkS4TBY56eIank7Jok64B
	kbwBjF6baD3EMm7q7FQrawhwa2a/1PaCzqiXXc4s78W3ZRZpQIhxfIFnI1re3+jl0bMh0AdG1BqXf
	BwN92UTmPM0Zw8IIyVGM1Ly8INKJ1q3QEjuCFCkGDzEqRYI9+dR7ii9Vt9xj+NckcHbEVst5MXYLK
	kSjWS+fMjnMOrltYmyRq4loA3CnDkwpW4sTFZ8xYyqY9XraUTRdZZoZUhGNaEjp6RGGuEdCiXarmE
	u4mOGGcIxUVf2hj+2bew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuVv-000000024ja-0llK;
	Mon, 16 Nov 2026 11:04:43 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuVt-000000024hq-2zO9
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:04:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 76BF945D13;
	Mon, 16 Nov 2026 11:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBF11F000C7;
	Mon, 16 Nov 2026 11:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827081;
	bh=EWEQe50Q7bYbdLpYkYQap52GI3LJt8CnLN09OmwuI1w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PafvJE3dQs6OTj/LdjhOhzqOr8zu4Rs9a7Ti00DrfRgIuCxFWcDacjwO97FZyLBpA
	 jYuevIl9DI19bSn0Dks4p3CjhVQmBu6Z+C7G8ENMP1klGGbVePVvTGDHCDF7A+ebFP
	 XtfrWPtHqIXMmG/6Kj0eF8f//xIYX+bNePhsW8jQoTvZe6wjtCrp7lhxsxP1u/ZMD9
	 tCLsB93fgShCrx0f7WKCB7/FLREZcuLsc4J2cx6WRMz1EgSjBwk2VCNISg3+w/XOaI
	 fywy9B8wP7688ExWLyowqIdnXq89PA9+A4QMQLzwFt6nlWWDckBl2QObVHEs1Siq9V
	 wUyIGDmt6hkHg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Nov 2026 12:03:44 +0100
Subject: [PATCH v2 04/17] zloop: take freeze protection for writes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-work-fs-frozen_writes-v2-4-ecc4a2aac40e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2086; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Stx5DC9HTEHrmNCMj043d8T1E73IV+TuEjjoB5nUMbU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9eqwkwjJ7qdD/d/tmPhEu3TXrtdNe/Y6eqY90e8UC1
 MtfOqbkdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEOJyRYUZe6+87LsIq6vVh
 2wTC/brNP3r6LxPumf/tZGXY86+iIowMd0+sVF+47/Yzxxfbm9SmN0lN/u6uMlfrXojIv7uPXb3
 l+QA=
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

Submit writes with kiocb_write_iter() and drop freeze protection in the
completion callback with kiocb_end_write_iter(). zloop_rw() also calls
the completion callback for I/O that wasn't queued or that failed before
it was submitted. kiocb_end_write_iter() does nothing for these.

Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/block/zloop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 65634a39b0bfc..76d54c9b89c0b 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -514,6 +514,7 @@ static void zloop_rw_complete(struct kiocb *iocb, long ret)
 {
 	struct zloop_cmd *cmd = container_of(iocb, struct zloop_cmd, iocb);
 
+	kiocb_end_write_iter(iocb);
 	cmd->ret = ret;
 	zloop_put_cmd(cmd);
 }
@@ -567,7 +568,7 @@ static int zloop_do_rw(struct zloop_cmd *cmd)
 	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
 
 	if (rw == ITER_SOURCE)
-		return zone->file->f_op->write_iter(&cmd->iocb, &iter);
+		return kiocb_write_iter(&cmd->iocb, &iter);
 	return zone->file->f_op->read_iter(&cmd->iocb, &iter);
 }
 

-- 
2.53.0


