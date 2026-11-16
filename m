Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8A1606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2H2dLA99;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HIkxfGMd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=jJH2iXtlvXAQ8vmVXS7YlK1nqDuNE+Y7w/0TSEUR3RY=; b=2H2dLA99IeZn4z
	YKjKcWqDoqpidyDETdmm6QPWwa3OOve7M+6Do4fvGkuhIlql52Tr43bk2v0UXd1rIue7H9ANpAxf5
	iFuSdiLaoQ9w46/XOc4+7BLFqpW+rRyhQdjXGuBEHXqAX6IznFaJpr3qQJj+942IUmVPfyCjxriC3
	fj1PIPat3YsJF6euQHoOyhaaBrv1uEfc5SqhZjdslPiQvc+jomMgpFYku1/RdWBUBFfYPDco4iP7C
	LmlL8nGPe5Rhl9YAhnKqs/90TX4CAr8rpjjkY5K+/3168ifECh2p2Wwv+vmOmA5lF+F6u4N0aHim8
	sMjhoiDfAVwY3R5psT7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSvza-00000002NsP-0OU4;
	Mon, 16 Nov 2026 12:39:26 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuZJ-0000000275z-0kfF
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:08:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E9A35462DD;
	Mon, 16 Nov 2026 11:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5931F000C6;
	Mon, 16 Nov 2026 11:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827292;
	bh=jJH2iXtlvXAQ8vmVXS7YlK1nqDuNE+Y7w/0TSEUR3RY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HIkxfGMdUZtGdK4Kyr7o/gTlv8ZzXp4gu6qrVAb4Mi1nnN7RMCKTFnvNj6DybtLgc
	 AHpwMbgdBEBdQKvIdWkLLqy8q7+45+OXfY92P5OEXj/H4ADDnabjO5G+yBO5TuVatA
	 MFF2RA1Cy0v2VSwxx5XJ51Ix7KelG/hvQSBuRW7KHcNRzbpZWV604qauakNJhq+Vcs
	 HgtoSO3gaP3AF1V4QcL5ioNNJPbmcnLGz2POKI6AWbF0hLhNVccJR1dkh+5vgg5sRK
	 7YLeitsKwxZW+JsLiaGeRecqNKH/zqzZKp++6AhvbMTfFdhhc9eRFrchMy2yAzmJst
	 8xRA1FBIMEQ0A==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Nov 2026 12:04:50 +0100
Subject: [PATCH RFC v3 17/44] securityfs: use fc_init_pseudo()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-work-loop-pseudo-v3-17-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
In-Reply-To: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
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
 Alexander Mikhalitsyn <alex@amutable.com>, 
 Chris Down <chris@chrisdown.name>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1852; i=brauner@kernel.org;
 h=from:subject:message-id; bh=eMcnNCEpWBwKj5om0lrEeWJ5nBa2aNmgGW6gKfibtdI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9ely05XJ7OEvs8TnzdthOuj5jRmeNvcusK/wb9d009
 sqseiv+uaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiZtwM/8tXxgrFR/CedHKe
 0mA1KbT0X+dFm3JBzXc/uE6/jTfZp8XI8K/AdXL+qxbtObkKd1SmMq4za1/jJnJCs+L8dFueFAl
 3PgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Mailman-Approved-At: Mon, 16 Nov 2026 04:39:20 -0800
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

Initialize securityfs as a pseudo filesystem. This raises SB_I_PSEUDO
and SB_I_NOEXEC. securityfs never holds executables.

But securityfs needs device nodes. AppArmor puts a .null device node
into securityfs. On exec it replaces file descriptors the new profile
isn't allowed to use with that node and opens it via dentry_open() which
doesn't care about SB_I_NODEV. Such a file descriptor can still be
reopened through /proc/<pid>/fd/<nr> though and that's what opening
/dev/stderr does. The node itself can also be opened by path as
/sys/kernel/security/apparmor/.null. Both go through may_open_dev()
which refuses device nodes with SB_I_NODEV raised. So clear SB_I_NODEV
again in securityfs_fill_super().

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
Reviewed-by: Chris Down <chris@chrisdown.name>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 security/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/inode.c b/security/inode.c
index 0804023676741..edaebf0f1972d 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -14,6 +14,7 @@
 #include <linux/kobject.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/pseudo_fs.h>
 #include <linux/mount.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
@@ -49,6 +50,8 @@ static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		return error;
 
 	sb->s_op = &securityfs_super_operations;
+	/* Userspace may open AppArmor's .null device node by path. */
+	sb->s_iflags &= ~SB_I_NODEV;
 
 	return 0;
 }
@@ -64,6 +67,7 @@ static const struct fs_context_operations securityfs_context_ops = {
 
 static int securityfs_init_fs_context(struct fs_context *fc)
 {
+	fc_init_pseudo(fc);
 	fc->ops = &securityfs_context_ops;
 	return 0;
 }

-- 
2.53.0


