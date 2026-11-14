Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FD3606B942
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EhG5rSqo;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EyWY3Wu5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=vGWTylgMIW6bDfGEy5XmpsW+u1ufCFyjkH/RKGIHXn0=; b=EhG5rSqoizQlQv
	EGXk+bhuTpkEcyfl74RFQpDCpW/SDV1297FJuGmU6KPIDIEiPVVvH+c5xqna/PkebFC9wPQTpi7vN
	u/kG/ZTkj7Weua6kNK8wiVJLb2UhhAFKcyZ9o+F2qbDglqdsaCdk9LBldkUmKOP/D8nUKNZXW/1iN
	yGgP/nCd0Sq93XyLHuHu9xU8Wfb1h/Fv/imyNk5AzxYzl3KDn6qM4ZNsfLEQ+Z+KKXaYzLx7NcMR6
	v5cbGqTZ/SRPTRZZRWs+O5aN/khmFJOz0tiJyiYj1qbRqkY92zImPXt0i6olFHlOQTDxSIP8Z5ebV
	lZIlvilB/PrBRWJZjMFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSBIt-0000000Fp5R-3scv;
	Sat, 14 Nov 2026 10:48:15 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSBIr-0000000Fp3U-3UpU
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 10:48:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9477D46576;
	Sat, 14 Nov 2026 10:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0311F000CB;
	Sat, 14 Nov 2026 10:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794653293;
	bh=vGWTylgMIW6bDfGEy5XmpsW+u1ufCFyjkH/RKGIHXn0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EyWY3Wu58zEoCxtb5WbL0z2Ayd+gjjHzDO7txKKPA1YhQJvnHL1PTS8lEZxElEB0g
	 AhNsQMCINjMgGRsbDsWmSqnGqoU/BivjjrWur8rJfE9RC4KdzGZtIXxbcAwRaYQy1Z
	 Ojr8jNew/2BX+SigNFB8Jeg4o9PAtHdyK7p+TjixfUSFc8gsOuehKilR/75pulg5Ku
	 8A1LDVvLYgkkZKd3CxnN5hvaO6JYrweaibUqtn9/amldVV+Sdg2RYsAWxawhGHPlAw
	 0aepGUp1SGgD1kRxgaGvcjRFI9MycXpizgBshWt7J8Qp+E3m0o82x/SposJHqbrp40
	 lBOq5d/aB3H+w==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 14 Nov 2026 11:47:14 +0100
Subject: [PATCH 07/12] zloop: take freeze protection when recording write
 pointers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-work-fs-frozen_writes-v1-7-f5ae61c898b1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1947; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5Gd0N7r8AM/cUjKKWUZKwiYPW9YLwh3Lgt9pJFTrtzc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9sHF1eLQz/MXHTs/t3M65XyeGd3v96FVe7iit8r9Ub
 l/uOTf+jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkUKzAyHGZ1ffnKoGL5DoGg
 3bX70xL95N/3PQtdq6f24lDi7B2Guxj+5+1u2GDgI7Jp+ewOJo1iNSNvmV2hZxYom/cdrtryavU
 PTgA=
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
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/block/zloop.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 34ed925e86f1a..a695aa8405d22 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -730,8 +730,13 @@ static int zloop_record_safe_wps(struct zloop_device *zlo)
 
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


