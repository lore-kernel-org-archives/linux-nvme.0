Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C56B606A323
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=C8upFpId;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HWC8lhcR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=JKEebM2B/rTWfHQRxsgcjHqOhGI+gUjJB4wKvnue758=; b=C8upFpId3D1Hq2
	wLnBuYfYX3Ly928mHaUcew56DxoetxNga7uC3zcULa4VRBm3oAENJofbhZ5Zb9zGpYivcl96jtG2k
	Wujs7VwGt7FR0NS+fX8jUCNbl66HKRFbtHjEDbAGUKUzSf8i5V095VbZG04Ls+OCFxKarEWIIyyAf
	jlZJ1L+qk61I4GZEaIBcnv9l4OxXnbYZlba7X7uvV1+fns59xbtGKC2JzRuPuj8tkefMGCvEOQnTa
	qi/c3BAQafG5nrgoaBsymSmJ57tQsWqy6nGYlkQbVI474LdhEZMtkGx3qBA5TqkCb2IaRMQ/XRHcP
	1q64sYRmDPvt+8SNSFCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSEFH-0000000GBDw-0sOb;
	Sat, 14 Nov 2026 13:56:43 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSDSO-0000000G3f1-2p1X
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 13:06:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0C94B625F7;
	Sat, 14 Nov 2026 13:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9DB1F000C4;
	Sat, 14 Nov 2026 13:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794661571;
	bh=JKEebM2B/rTWfHQRxsgcjHqOhGI+gUjJB4wKvnue758=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HWC8lhcRxYRCVLn3TpoIzDZ0r6knLI/+VKra9y0LMZUdf9y2SW8kRjug2+6ll4TFw
	 sFMjM36I+HTVQCiYKOXtD3DCl934UGrWmg6qnVTWAkdS8Qs4hfZxLEQ5cd0s8oJ9C9
	 fUhCdYxXyKWUMiBhpguIoYbC0o3ATeajksXbxx0xoSufrfGJhGbAI/UAksPOhTc/HT
	 K2qcgoXt7i4qs6W+rhzztnxXhcqqn/HrLZCQg2St4BiABC53+ogrC53+NpAn2uKl/P
	 uu8arH/6EFYPXQYJcwPTBER+wepJOnNDlC6o2SSf6lebRTXyPpqWofrAf4PX4YP6mn
	 uEvTMIXHZBFPw==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 14 Nov 2026 14:01:46 +0100
Subject: [PATCH RFC v2 05/42] kernfs: use fc_init_pseudo()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-work-loop-pseudo-v2-5-98639a2286fb@kernel.org>
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
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alex@amutable.com>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1449; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ir2ppogbuqLEOPNYev9c+66l6T/T0A3wuXIOqOu3yTk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9iMl+Jvtl/aO5Ua4ZJd1uQa9EV+geipFK+mptcsVm/
 q0Yo1fBHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNp72BkWP7iOsveCMP+z1P2
 GCRNU/Nzrztw1ed3WOnr6aEc868WTGVkuF6+JnT7X6/USnPOeU/ZmFOmTf/1ZgfTrUK/ZbdrryW
 2MAIA
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

Initialize all kernfs based filesystems as pseudo filesystems in
kernfs_get_tree() instead of raising SB_I_NOEXEC and SB_I_NODEV by hand
in kernfs_fill_super(). This adds SB_I_PSEUDO for sysfs, cgroupfs and
resctrl.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/kernfs/mount.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index a0be784bfb064..6b60d212b003d 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/pseudo_fs.h>
 #include <linux/mount.h>
 #include <linux/init.h>
 #include <linux/magic.h>
@@ -298,8 +299,6 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
 	struct dentry *root;
 
 	info->sb = sb;
-	/* Userspace would break if executables or devices appear on sysfs */
-	sb->s_iflags |= SB_I_NOEXEC | SB_I_NODEV;
 	sb->s_blocksize = PAGE_SIZE;
 	sb->s_blocksize_bits = PAGE_SHIFT;
 	sb->s_magic = kfc->magic;
@@ -388,6 +387,7 @@ int kernfs_get_tree(struct fs_context *fc)
 	info->ns = kfc->ns_tag;
 	INIT_LIST_HEAD(&info->node);
 
+	fc_init_pseudo(fc);
 	fc->s_fs_info = info;
 	sb = sget_fc(fc, kernfs_test_super, kernfs_set_super);
 	if (IS_ERR(sb))

-- 
2.53.0


