Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B9E606A321
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=C4Ri87bj;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZVzmHBN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=YJdQfmNRZIjJZmJ7eXlopktH5jFS//yu5Pe53ZYQ028=; b=C4Ri87bjQENZGT
	h70DYK3qA6ve7PznHHmsgbvqeRjanfAC2mrgGaGQ+YuE6yVIzx+SGf9eFlnxWX6e3eexp5Dy/hf9F
	9UaihKyZlQDE41d51DYQ0LE1O+4Gs3/SgLoeKf0jLfkHGYvI1ET9zldSOs5m1D965RuV15cowfDkO
	zszmI75jtxo8XeCNSLVPI6+QbHXPW6eIa+3GykEEmzV1UeujDJTMTtmPQdvljX4ESZp3w79mxwghe
	J7ZJcCQ1O0rY8QJs+swDkamLaalnsMKxeyAQK6pnCTHFJ94ynN8CpFaBKXbmFMyungd4O32AvvGiA
	P3jlA2Mb+SAVMMLTz91w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFhP-00000007kIo-2Tp0;
	Wed, 11 Nov 2026 21:17:43 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQi1o-00000003F3Q-0y7G
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 09:20:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AAEFE63825;
	Tue, 10 Nov 2026 09:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AA31F008A6;
	Tue, 10 Nov 2026 09:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302431;
	bh=YJdQfmNRZIjJZmJ7eXlopktH5jFS//yu5Pe53ZYQ028=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aZVzmHBNuwJ61+F1e2oV+4dv4gNlfmbtkL/jYHqJnnAR8nxpapvLT1jaqObFS3Kt6
	 Ta83UhzRz8CvexZ0ysKoa1MoO3Zu6STABRZGed6dESQ7WUcbM2CZMcu26UAdqYXcUi
	 jGRxcd1PuvngpWsUZ9wdr1xrWLiH+HYWR1UJUrQbfn+O+Yx9/8C2d+1m8jfwdUrWlh
	 x7irI9TSUWj+2x5RTqa6GOQ9Qm8DWqqbMA4ng0XxJzOZmiUTRMHuCfCm4DvyHXloD3
	 13saqaue/D0rL6M4JYSaME0ZwZWtpV6O8u9WPkmcnvoBepeZUJpTLw5Bl66Aroqny1
	 QozwErkn3D9Og==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 10 Nov 2026 10:14:56 +0100
Subject: [PATCH RFC 40/41] erofs: refuse files on pseudo filesystems as
 backing files
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-work-loop-pseudo-v1-40-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
In-Reply-To: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, 
 target-devel@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-mm@kvack.org, bpf@vger.kernel.org, 
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
 apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, 
 netdev@vger.kernel.org, fuse-devel@lists.linux.dev, 
 linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org, 
 ocfs2-devel@lists.linux.dev, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org, 
 Amir Goldstein <amir73il@gmail.com>, linux-erofs@lists.ozlabs.org, 
 linux-kselftest@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1370; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NydLncApPlv7Xb4803UYyRsruwye9LOqDMcupA3ko3I=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9enCotFA5svjs32+5V/jKOVd3VfaxP+2o4TjJ9eAot
 9K2J1P4O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbydB0jw66Sm4EFNRm7ox68
 2SVYs2OfsAHnhYkt+fUvbmadaZ28QICR4WLbxMemdRPmu/26Zds+2yJaate+vNkOVz78PC+SI7H
 SjgcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:17:02 -0800
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

File-backed mounts take any regular file as the image and the same goes
for the extra devices of such a mount. erofs reads them with the
credentials of the mounter so this doesn't hand out anything the mounter
couldn't read anyway. But files on pseudo filesystems aren't images.
Refuse them just like loop does.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/erofs/super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index ce05557bd998..980d5fc2b576 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -158,7 +158,8 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 		if (!erofs_is_fileio_mode(sbi)) {
 			dif->dax_dev = fs_dax_get_by_bdev(file_bdev(file),
 					&dif->dax_part_off, NULL, NULL);
-		} else if (!S_ISREG(file_inode(file)->i_mode)) {
+		} else if (!S_ISREG(file_inode(file)->i_mode) ||
+			   file_is_pseudo(file)) {
 			fput(file);
 			return -EINVAL;
 		}
@@ -835,6 +836,9 @@ static int erofs_file_get_tree(struct fs_context *fc)
 {
 	struct erofs_sb_info *sbi = fc->s_fs_info;
 
+	if (file_is_pseudo(sbi->dif0.file))
+		return invalfc(fc, "source is on a pseudo filesystem");
+
 	if (!test_opt(&sbi->opt, SUPERBLOCK_SHARE))
 		return get_tree_nodev(fc, erofs_fc_fill_super);
 

-- 
2.53.0


