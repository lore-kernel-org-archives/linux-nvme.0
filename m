Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE492606A323
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Xb5cZ3JQ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F26xTNVz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=h/mTAJVuuQhpAVAUlFXnSBfePIty5rSPTob9a1ZdEdY=; b=Xb5cZ3JQ52pZfX
	F9D3HPIfYpAv9tn0DXdVy9dXu5O91R6VAP283w9vx3sRZeanUhWMOnx98phFqgCCR0AU6Fo8wRXDh
	xJcPsuypW/DmBPVA9y5ZOlSVjxVlWMTyxHjyxdvvqFyVUP4YbyW1fcg83yGJckL3yCDn38HbKpJSC
	MoDilEzrpPZ6fOh5XrhiXccXQLQcl2xapj07P3TMJRsoBfVKmUeLmqHB5Z1feof67CdyHUm8L1f7Y
	owdYJjnoffl8ft8mi6wT754qWXWg93mrXeDefGTy7IwXzMAoWPo8URJmrznkcMaTm6zePlk299iwV
	ii0pvstQSfmZKgkpS1tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSEFh-0000000GCVW-3uL8;
	Sat, 14 Nov 2026 13:57:09 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSDWI-0000000G4zP-35QT
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 13:10:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7DBE5418C8;
	Sat, 14 Nov 2026 13:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE741F000C8;
	Sat, 14 Nov 2026 13:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794661814;
	bh=h/mTAJVuuQhpAVAUlFXnSBfePIty5rSPTob9a1ZdEdY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=F26xTNVzW9tp8yy8ppp+Dv86UhrCHvWmEOdhHICMiXGEZk2O2+Kja+w/MuQlnOMu+
	 JzTI3R4yuU5GRr42/E3D7uDu4Cr/FBika6QDUGu74GJkDlBEAeX1YGEjS/Dlqk9bBI
	 Om+csVo3teTzJCkmRtuq/I0XgR/m20O/2c2RKOJeToz5F+wAMlJddfR2DNTckBrev0
	 DnzEWbcdtIz1gsrII6cFjNLa4arltfHbmaBXKJT4vFgnQ2RFGqTnnuIxfh6U+NKph/
	 bThJoXJ1oJU7xRahe5YNw1jmbpdofQyjA7ORrMjBcwkVSn1sj7SLDJhUkBv2Vrvutf
	 PFOJUgNRV91oA==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 14 Nov 2026 14:02:21 +0100
Subject: [PATCH RFC v2 40/42] erofs: refuse files on pseudo filesystems as
 backing files
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-work-loop-pseudo-v2-40-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
In-Reply-To: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1554; i=brauner@kernel.org;
 h=from:subject:message-id; bh=G7tJlJJnInVCqA4f4ewlrJ9rtBBg8ilw8miRJBX+0NY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9iJnCssvWLi9e2DJl4eu06dM0Y00/Tfzzb4uTU86rv
 ycsT/wK6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIUiOGn4wKuxctKVhzQK7P
 /16SfMFr0yMs67VSHrYaCJW87fifu46RYVHfjQK/wyu61EpT3J9naxxhfFH1vl3hrcymU+syTAp
 WMgMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Mailman-Approved-At: Sat, 14 Nov 2026 05:56:41 -0800
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

file_check_backing() also checks that the file is open for reading. So
a source file descriptor that erofs can't read from fails the mount
right away instead of on the first read.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/erofs/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index ce05557bd9983..517a289b9395c 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -158,7 +158,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 		if (!erofs_is_fileio_mode(sbi)) {
 			dif->dax_dev = fs_dax_get_by_bdev(file_bdev(file),
 					&dif->dax_part_off, NULL, NULL);
-		} else if (!S_ISREG(file_inode(file)->i_mode)) {
+		} else if (file_check_backing(file, FMODE_READ, 0)) {
 			fput(file);
 			return -EINVAL;
 		}
@@ -835,6 +835,9 @@ static int erofs_file_get_tree(struct fs_context *fc)
 {
 	struct erofs_sb_info *sbi = fc->s_fs_info;
 
+	if (file_check_backing(sbi->dif0.file, FMODE_READ, 0))
+		return invalfc(fc, "source can't be used as a backing file");
+
 	if (!test_opt(&sbi->opt, SUPERBLOCK_SHARE))
 		return get_tree_nodev(fc, erofs_fc_fill_super);
 

-- 
2.53.0


