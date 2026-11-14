Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8684606A327
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2bUl0qm0;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dlOT4YO5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=JUBUitc/wTfMb7cZo0KLtSOkDXoKMBIaahrb6Pvq2WU=; b=2bUl0qm03QBVeh
	FUZy1TNZKvaScTUuzxSTvv8fnbkUNCDq3yb3Fw7x5q4o8LzKrHoNOKynk1FngiZLkLe9j6Rcpisak
	bBYWuI0lkfhVBs7zuFb99hQbUvtTPZpOfd+XX/XiuD2d6mmqmACoMKjvYVMjRqhMCOtAH1C7RAmp5
	srYswZq+7wpzTQ8M1vVoSyNSDhY+fD+6Ryx/iNMtdZAOBPSlnKTfFbGaTmuS0Cgpy86ozX/+Cbpp8
	6aFv0K50jiZoAmupKtFb3sRUOPyfx3A8QBste1Se+kNg/zr7EUGWpeurVDI3DKOvOXBwiC7pGaP2y
	2HN9M3skFxCWg/Ya4lQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSEFU-0000000GBrD-0KRB;
	Sat, 14 Nov 2026 13:56:56 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSDV8-0000000G4SY-0TYO
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 13:09:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8C0996252F;
	Sat, 14 Nov 2026 13:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29D71F000C4;
	Sat, 14 Nov 2026 13:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794661741;
	bh=JUBUitc/wTfMb7cZo0KLtSOkDXoKMBIaahrb6Pvq2WU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dlOT4YO5RUhq//nn1mQfQ7uOlDeSIq5sssMs038ZLPvaS/NPy8Dd9kK6JgIFD36Dz
	 pbaKu0DmFSuCCYRW1H64pQ0+m6nqqsSc1Q9h1ff9ICae4VWI86+QQlpB4OVxciYpOR
	 WS2ftQrfKT4rvIwCLZSKiVCNFlea6iSt69CtGZ7qjcOt9yahpM2SqQayK7CrApgHSF
	 /ZgQ8JKhCJKGzp6iRqEmeIMd+/DRWTit4BCmJyFLKQdTK0auEDWhyzWkLdOk7NBjOR
	 dFLtiah/d1hBHwXdufprCHe9iPnbKhpmiiCOpc4bqTjZ0cGwlKuZ9Vy7R5WvJt/oit
	 calDZWfHw6uKw==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 14 Nov 2026 14:02:10 +0100
Subject: [PATCH RFC v2 29/42] s390/hypfs: use fc_init_pseudo()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-work-loop-pseudo-v2-29-98639a2286fb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; i=brauner@kernel.org;
 h=from:subject:message-id; bh=EnQ7f/LKwwXo6PyRpnVfj7bCGw1qYUMZQQO6IXtl1m0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9iGnvvPFlftQB7ZsfC97+fWh+Z+EM5e8fnz6omGjy+
 1HN40e5ch2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATidZjZFipe7RPJDUn62fQ
 /TkHXz1TvOM0nXPJoowHKhln3kV1Br9jZJiffO/flXWm6T8ffDBjOxkgvOBdhEHUvXZBZanc0td
 ivqwA
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

Initialize hypfs as a pseudo filesystem. This raises SB_I_PSEUDO and
also SB_I_NOEXEC and SB_I_NODEV. hypfs never holds executables or
device nodes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/s390/hypfs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index 559b011e68800..8662169de477a 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/pseudo_fs.h>
 #include <linux/fs_parser.h>
 #include <linux/namei.h>
 #include <linux/vfs.h>
@@ -301,6 +302,7 @@ static int hypfs_init_fs_context(struct fs_context *fc)
 	sbi->gid = current_gid();
 
 	fc->s_fs_info = sbi;
+	fc_init_pseudo(fc);
 	fc->ops = &hypfs_context_ops;
 	return 0;
 }

-- 
2.53.0


