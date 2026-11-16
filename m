Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EED606AB60
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lYNCNWDB;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQFtUDoF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=jHld24Oo1MWppo8/tfsSpZWU26RUmIMv95z42v9sotY=; b=lYNCNWDBEvz/Ta
	uliT6FpY7r8KctZ+/RULoaeL0STXtJFn2KUVxGEg7vo2SxnI/DIV/yh/k6qVWAfwYQnDmdOGDUomg
	LPxY3E+Hhr/TI3quWlX09N0fdKmdUArmKAHvOqeHyxOkMtf0qO4K7nxzdlYvfnDKF1E2BpmdPLCTm
	5j1zB7AxEoVHjiRvRr9Zp9BLNcxy4A1cUlCKR3ssH/DBmufCE6pTd6KPKUfQyfqBTVGtk4ALbd3/h
	IU7hJGXqO3K7K2/zgmL/ny4Q7KC+aTwc956suKUPBPtH45oGNPp0Ip+tkuJEiXN5q5kgDXR38NuGm
	GMFSi5/rJYe1p119p0yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuWG-0000000257V-0FjI;
	Mon, 16 Nov 2026 11:05:04 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuWE-0000000255Z-3tsP
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:05:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5F9596294E;
	Mon, 16 Nov 2026 11:05:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558C11F01573;
	Mon, 16 Nov 2026 11:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827102;
	bh=jHld24Oo1MWppo8/tfsSpZWU26RUmIMv95z42v9sotY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cQFtUDoFrQUz2WcbhXtkg02LHOrOLlYpUiFModvav8ZzlPl9cVV1Hd6Mzx97pXc8E
	 uC9A9hM3FdwQDgXCii3ZlvLmTUSWghY0gyv6DTq2Bf7hrtzjJzlrZ+W9lGQazMtuR6
	 q8WK06huhLK+DSB7eBUyu8cN4jTmRbZp520sbGPQtqw1zHjXF182+fiGQ63eN4SJdt
	 yzlmcWsQK7yMX8m8MTzLT5pPVNZvCXbixSM1pKr7rj22/l5wh28GiSpnygnvBeLDgi
	 Fi53LVfO78qk7qtdkRpPavVN5CQmViQGdt0QHOZaF9kN2LMnVGvoHEn6CPtk2AAmVw
	 fjnHFGrm6VARw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Nov 2026 12:03:49 +0100
Subject: [PATCH v2 09/17] zloop: take freeze protection when recording
 write pointers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-work-fs-frozen_writes-v2-9-ecc4a2aac40e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1992; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RHFI0o15CfHlL7wXbapiTqB0SqtZl6Dvtj6uSPjdx74=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9eqyu897T6MG0jN4vHBm5s4MeGO7ISJJ2eH7JTaxHp
 Ut6woSXHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMJ3MHI0OB33ZO3h+/nCrbg
 SI0ZP5XmmskdebwqUIA9VuavjLv6FYb/WS1H99zdbuv1b83KI9OZ6g4yKabxZFuKXl4WcuH0td9
 nuQA=
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

With discard_write_cache a flush records the write pointer of each
active zone in an xattr of its zone file. zloop_record_safe_wps() uses
vfs_setxattr() for that which leaves freeze protection to the caller.
So a flush rewrites the xattrs on a filesystem that is frozen. With the
zone files on ext4:

  WARNING: fs/ext4/ext4_jbd2.c:90 at ext4_journal_check_start+0x1f6/0x2d0, CPU#0: kworker/u16:2/46
  Workqueue: zloop0 zloop_cmd_workfn
  Call Trace:
   <TASK>
   __ext4_journal_start_sb+0x7a/0x470
   ext4_xattr_set+0x20d/0x380
   __vfs_setxattr+0x10f/0x170
   __vfs_setxattr_noperm+0xf4/0x5e0
   vfs_setxattr+0x14d/0x3d0
   zloop_cmd_workfn+0x384/0x1ff0
   process_one_work+0x946/0x1820
   worker_thread+0x4f1/0xd60
   kthread+0x364/0x460
   ret_from_fork+0x525/0x770
   ret_from_fork_asm+0x1a/0x30
   </TASK>

Take freeze protection around vfs_setxattr() with mnt_want_write_file()
like fsetxattr() does.

Fixes: 829def1e35ca ("zloop: forget write cache on force removal")
Cc: stable@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/block/zloop.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 76d54c9b89c0b..d20a0d2afa855 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -719,8 +719,13 @@ static int zloop_record_safe_wps(struct zloop_device *zlo)
 
 		if (!zloop_zone_is_active(zone))
 			continue;
-		ret = vfs_setxattr(file_mnt_idmap(file), file_dentry(file),
-				"user.zloop.wp", &zone->wp, sizeof(zone->wp), 0);
+		ret = mnt_want_write_file(file);
+		if (!ret) {
+			ret = vfs_setxattr(file_mnt_idmap(file),
+					file_dentry(file), "user.zloop.wp",
+					&zone->wp, sizeof(zone->wp), 0);
+			mnt_drop_write_file(file);
+		}
 		if (ret) {
 			pr_err("%pg: failed to record write pointer (%d)\n",
 				zlo->disk->part0, ret);

-- 
2.53.0


