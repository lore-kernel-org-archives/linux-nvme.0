Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553A6606F1ED
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZbO1gvnF;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BNoGazjB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=rGbOPfT1yqUwvO1m52rPtj56PBfhsl6HwTcjr6r9MlY=; b=ZbO1gvnFXiv/iV
	J39sasYsBLSok+ss9StFpq36z4XN+vRLGupOL/FnR+fiB0gQzS9yD59ueIWgsnLzbtEe7bW1eotiz
	ISQDCLldqOEdHPD03oyPXQ7uiZQEeqb2g5GRsI9e7hTly67SseJ22E/qES0YPbKsIgwdyI/yFjAKu
	oO3BNStTKmGu63pGNS/58MbxI7/59wKCfHtEESZo8ug2IJSMA5LJHgfsa62kyjG9bnm5wnuoWTZmS
	w64g66Mx1Wjkc2z+BWugV9eNF88c2nLeZ0dJuN18rf1wf4SlM8tug4umZJIjBiInXO2geeA884R9y
	Qvm64tvzMSd7rIaaCnng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuWB-0000000251K-3tcY;
	Mon, 16 Nov 2026 11:04:59 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuWA-00000002509-2Pnw
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:04:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0A76E62954;
	Mon, 16 Nov 2026 11:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7B81F000C5;
	Mon, 16 Nov 2026 11:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827097;
	bh=rGbOPfT1yqUwvO1m52rPtj56PBfhsl6HwTcjr6r9MlY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BNoGazjBxWR+CNpzOdNZGQkEHyjMC5rjb3rqOwRQrvHhl4JuTermScglTO41V4rUK
	 hZndB2qWZxm/m+nVDVm2meccG5hgcZmAhgFPyyCKAWza6Zxtqw9x9QO5gVl2vUD0sp
	 gJmMvzERCz8KJHDDGOztHplpn6ncwf+KBAqGQ5MCdP9BCzItG0p4dUghIfRRxO01KM
	 g1NdHIXg77CPcNpQfV2xMrsoxfm32siNqfBzYGzljzXna82cJGpeIQ+DjTjuiC7Y7/
	 nXfqzRwSL4TsON4GFDoArUv9Sk5x9ALaaafE3GUxdDIaifsqEMHi1T7Q2N7xk685Dk
	 815Mk1Puw6t7w==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Nov 2026 12:03:48 +0100
Subject: [PATCH v2 08/17] loop: take freeze protection for discard and
 write zeroes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-work-fs-frozen_writes-v2-8-ecc4a2aac40e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1772; i=brauner@kernel.org;
 h=from:subject:message-id; bh=3iiZH5iMD4I3JcLZEMc4xg7xYKXAAdlzVQQRTB4v7fk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9eqxW9uBZ9rfzwnIFc5vS2rgZlu3fmji3J3qu6+xgh
 Rh+zqzXHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNJTGX4X7v2hsP5RkmlkO5/
 hxVuzfq9mtlRe6VEzwe/hP7+2lB3Tob/mS+v2z1bcumyVcktC833q/7P6ubZqyifpRq4O8p82p9
 J/AA=
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

Discard and write zeroes requests end up in lo_fallocate() which calls
->fallocate() of the backing file directly. That skips the freeze
protection vfs_fallocate() would have taken. So they go straight
through to a filesystem that is frozen. With the backing file on ext4:

  WARNING: fs/ext4/ext4_jbd2.c:90 at ext4_journal_check_start+0x1f6/0x2d0, CPU#3: kworker/u16:1/44
  Workqueue: loop1 loop_rootcg_workfn
  Call Trace:
   <TASK>
   __ext4_journal_start_sb+0x7a/0x470
   ext4_dirty_inode+0xa1/0x120
   __mark_inode_dirty+0x154/0x1110
   file_update_time_flags+0x3ab/0x4b0
   ext4_fallocate+0x286/0x3440
   lo_fallocate+0x13e/0x290
   loop_process_work+0x486/0xe70
   process_one_work+0x946/0x1820
   worker_thread+0x4f1/0xd60
   kthread+0x364/0x460
   ret_from_fork+0x525/0x770
   ret_from_fork_asm+0x1a/0x30
   </TASK>

Take freeze protection around ->fallocate() like vfs_fallocate() does.

Fixes: dfaa2ef68e80 ("loop: add discard support for loop devices")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/block/loop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a3325ceab484a..d2f29aadabcc1 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -259,7 +259,8 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 	if (!bdev_max_discard_sectors(lo->lo_device))
 		return -EOPNOTSUPP;
 
-	ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
+	scoped_guard(file_write, file)
+		ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
 	if (unlikely(ret && ret != -EINVAL && ret != -EOPNOTSUPP))
 		return -EIO;
 

-- 
2.53.0


