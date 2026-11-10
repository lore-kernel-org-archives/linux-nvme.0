Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E44D606A326
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ORNi0hFT;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYHHEVUH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=JIdhS4jftRPy5dmxkGvzK/pMKfIiaESXVrYafcc8TvI=; b=ORNi0hFTsnu8Ok
	sfo4rSlfcx/R0R8mGggkvLRuZdnzSfn2Ncn0Ln57vDFhjQ06SwgzSRbpdI/S4O2Hwkrou2pB1ClC5
	cuoTksrw6RRDuOA97FzEGJuagAkaKruAuv1ht2RyELHLYgsZ8gbEjQBF6lk90i/+1ijgZBjOpm1D7
	ZQ25Gouy03EXyPGQCP3GlwVwn+7CaTc+QsLlY1AZf5h+Sfh2g73c/83/LZ1DL0+B7fTRMdQm872W1
	pRJ9V1+87pI9pLbq8o6ZdxhoZ7XIQoXZbY6OdbiGg0CHpmcbbiJeDm42f1dKgHl6sKRK1lWqwE/jc
	qzQJ3ZZwthMnbPSoAVKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFhD-00000007jm8-2dmQ;
	Wed, 11 Nov 2026 21:17:33 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQi0h-00000003EhZ-1YbB
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 09:19:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 25E2E43908;
	Tue, 10 Nov 2026 09:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C363E1F008A2;
	Tue, 10 Nov 2026 09:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302363;
	bh=JIdhS4jftRPy5dmxkGvzK/pMKfIiaESXVrYafcc8TvI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mYHHEVUHk7mqBzZMRRcGK3fZI9JsYBE1ZTG0cjDKv2LFlPJXQyDrPAKc8bfKf0tGr
	 20cWdlmj2e6r9qTNntdUZ9fi9cszimzNeELmIamI9OuH+mBqpijs9/s789F34csANJ
	 fgWDE11qgNW8E9wTIgD1km9GI/swk+tLAKgjcvqUYxAEaRLAlzh/ZKAHlBj0Ky1PjG
	 0v/WkxNUgqmlKJXpJY525QsBtQhynnTkAMo0QExBKteka4qwdTE2za1SUpdJj+FcNu
	 WkR6hVqwaMbvytyvpFnjFRkLcYmdydpW0DidQOFfml4GF2k8PUvSil9bGhPenPlkb0
	 TdQ33wkV+qEig==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 10 Nov 2026 10:14:46 +0100
Subject: [PATCH RFC 30/41] powerpc/spufs: use fc_init_pseudo()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-work-loop-pseudo-v1-30-4c998976c6c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wZMRP8kJpVwewK9De4Tzgbv2SYhdkU5PV6eswxkQBIY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9erDtr+T2Qx2zP0qG7677LHLr7pKfRQf+MM64HrclZ
 SuL9FO7KR2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATOWLA8IebTSHoxg9+k5c/
 HuRK8bM3/ZTN6c4W5XKTeHVB/4Zwcyojw/uS1Y6aDdePS9jN2MxSI7BiksRHOZ0gg9pTf6p5VkQ
 e4gIA
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

Initialize spufs as a pseudo filesystem. This raises SB_I_PSEUDO and
also SB_I_NOEXEC and SB_I_NODEV. spufs never holds executables or
device nodes.

SB_I_NOEXEC also refuses PROT_EXEC mappings. The spufs files that can
be mapped expose local store and problem state areas of the SPU,
nothing the PPU executes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index f066d9c7344d..54b45932aecd 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -11,6 +11,7 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/pseudo_fs.h>
 #include <linux/fs_parser.h>
 #include <linux/fsnotify.h>
 #include <linux/backing-dev.h>
@@ -741,6 +742,7 @@ static int spufs_init_fs_context(struct fs_context *fc)
 
 	fc->fs_private = ctx;
 	fc->s_fs_info = sbi;
+	fc_init_pseudo(fc);
 	fc->ops = &spufs_context_ops;
 	return 0;
 

-- 
2.53.0


