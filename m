Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272C2606A323
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CLtECfWk;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hprGHgCq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Afo8ed/GIRxi34eV1UuvuxN8L56duYS4vlWsPBP1fM0=; b=CLtECfWkd8jo+k
	Z1S1rVKKBw0mTd4IGNPcm0wPGtJjrLyuM1PeeH3V65LF3Lx7+VbD47npu66k9tE5aQ4FTrVCg0fmO
	xxUiiTva55uzaESlae1MfqD8bo0n+cGo6Ie55Eh5/bUaENTH6fLA4Okrl2xRiZ2bq8izroLFLy2WG
	P5qIBogA0ItelqzNM48RyJXacZM3A/eyTS4zLMAGycD/Lvnu9RtPCOyh4vJ/g/bdmSTvakne30mXT
	YqAYiioJYZPurha6VQkNcyFRolE0Hy0NhJpkCTXVjMxtGvKsBwqv6PZ9ICmGAEEFldpPb3vE0/tTv
	oVLMwykyrp7IvdrmlYdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSEFO-0000000GBWM-1VxM;
	Sat, 14 Nov 2026 13:56:50 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSDUf-0000000G4JN-3xc4
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 13:08:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4890441144;
	Sat, 14 Nov 2026 13:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A411F000C5;
	Sat, 14 Nov 2026 13:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794661713;
	bh=Afo8ed/GIRxi34eV1UuvuxN8L56duYS4vlWsPBP1fM0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hprGHgCqljNfHaaRT8wbU+b4CvrLYNHbt2kQUNxd98TIwvCS2ehJO8vBQg6IjA/4E
	 QlB02LLCNgV15vU1lPLmWWEwlLoHBLk24m/bQPCp+Xt2+5fcmhBnJkLr6kL6tImYJl
	 SZ5FGLvBWuN4qnzeJZ1uLhmeUGELgSZ8JHePmJcS8Z1HLYwEkmf3Gob9WB7bFvIcdE
	 //xR/RRXp75B0I1ifA+qvkckh7ZeIvssKgKnFVvHN/TV1+Tdlu+VrMbzl2SBXWGzb4
	 0iiVdJi6+Q0l8uSEtN9rtD9y6ItKjTJePfdM28scvMR66rgWPwX2mkMg+R7tSuzj9r
	 yx06t2VwHiXRQ==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 14 Nov 2026 14:02:06 +0100
Subject: [PATCH RFC v2 25/42] pstore: use fc_init_pseudo()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-work-loop-pseudo-v2-25-98639a2286fb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=940; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ohaN/4o3T0nG31Sa4LtDWeOCgaFP7NFffTjYcKqsHS8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9iGl65sDr4L+lP+1LwMR9DJK+pUFszdFFZl9j357yX
 dgmd+5/RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETYjjH8Mym/V8LV8ePeaeFT
 x7u9pzw6+Fw+X1xVcs/rnm9zFByPHmP477vQ0tL7dpTko/erzdrX7rRZPvXiz6+/Z64TjvOpv/5
 wLRcA
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

Initialize pstore as a pseudo filesystem. This raises SB_I_PSEUDO and
also SB_I_NOEXEC and SB_I_NODEV. pstore never holds executables or
device nodes.

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/pstore/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index cf499ba727026..4658561cf90b7 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -18,6 +18,7 @@
 #include <linux/ramfs.h>
 #include <linux/fs_parser.h>
 #include <linux/fs_context.h>
+#include <linux/pseudo_fs.h>
 #include <linux/sched.h>
 #include <linux/magic.h>
 #include <linux/pstore.h>
@@ -491,6 +492,7 @@ static int pstore_init_fs_context(struct fs_context *fc)
 	ctx->kmsg_bytes = kmsg_bytes;
 
 	fc->fs_private = ctx;
+	fc_init_pseudo(fc);
 	fc->ops = &pstore_context_ops;
 
 	return 0;

-- 
2.53.0


