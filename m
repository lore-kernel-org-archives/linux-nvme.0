Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381A5606A32D
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XszVgrmE;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DJFe+GHm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=vEUQcwW4egCFJ1K26houNDRkryaQ/QAvUlLdf7LIxfA=; b=XszVgrmEVPmB7n
	Kev4P5VP7RG+2n9qt45FCtLew/lT1q1uUKFKTfWZM9H3l3LD/3fxVq5BAlWKVr9b/WxZ21G04qB2s
	djg8O4QKdAOSGNERafwwhPhVo+jrtrUDtEH3Yn87dOZe5YxnpOYI6qESkhmoL9zFtN0mZ9UexnV3t
	yWptAmhSLXEKgp9LGuVuKaqjNdW6iSD1joSQd4dH6vJfLBnMwCqKDj8dXfgAE3wfyCH+xyg1hzEKj
	yCuhsqQuLXbPxesBVBMSVTXJ0efInfGKjIKW8vAu53NGwL8NwHtpygcceH6ysrqlmzkyZ8u8VOkL6
	z7vzKvBlN4vnECUfRtCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSEFH-0000000GBEN-2oXH;
	Sat, 14 Nov 2026 13:56:43 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSDSj-0000000G3jK-1BkV
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 13:06:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0EBD8406EB;
	Sat, 14 Nov 2026 13:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2ED1F000C4;
	Sat, 14 Nov 2026 13:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794661592;
	bh=vEUQcwW4egCFJ1K26houNDRkryaQ/QAvUlLdf7LIxfA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DJFe+GHm923QnX6Y5soo7AJQ8SdH4x0drSIbnUS2OWssnfwJSQUV2IZe3ob/XB55y
	 HGpRKJon2FGC5GmKiKtWRgG+aMur8IjXtGeM7NDvCjs8HeoWosaYHGhW7xvQNJxHnj
	 V4RGXfeiw/5d9W+tWBHjJSDYHShB/CzKIkoMMvKbF/QdHP9BEN1PAP6X0fpbq+Dajm
	 CXmweTwa8ua3L0aVTYAucEIcFCy3WE3wxr/DXYLuLhhFs+aHqTQXXM/VppEQlnuEaL
	 lTMHA2EAW1JBgJmg/Y9PCfE+UFz0cUy0VBh0Br+5g/y+MUzPdQgQ7kbV5gr8gtumMk
	 0iV1JBfnD/jCA==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 14 Nov 2026 14:01:49 +0100
Subject: [PATCH RFC v2 08/42] mqueue: use fc_init_pseudo()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-work-loop-pseudo-v2-8-98639a2286fb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1301; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qF0TT28NFfI9TLhhCqBLUWCBoYJ0XY66UkmFCoZwvwQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9iMk78utTVQKnnZ/L9apqi1Ijq5VX3P9v+Dhp6pbtz
 hPnh+z92VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRpqWMDHO2fHNRqMw6vLBd
 svjftwLHIIbl/BEPDSTTuNUk47nebGL4K/l/b+Gahb+vMDEwHLnCfPthSuHM++uyg1evCA3JnNr
 lzgQA
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

Initialize mqueue as a pseudo filesystem instead of raising
SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 ipc/mqueue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 322c3dd98c447..8bbe32d0881f2 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -18,6 +18,7 @@
 #include <linux/file.h>
 #include <linux/mount.h>
 #include <linux/fs_context.h>
+#include <linux/pseudo_fs.h>
 #include <linux/namei.h>
 #include <linux/sysctl.h>
 #include <linux/poll.h>
@@ -405,7 +406,6 @@ static int mqueue_fill_super(struct super_block *sb, struct fs_context *fc)
 	struct inode *inode;
 	struct ipc_namespace *ns = sb->s_fs_info;
 
-	sb->s_iflags |= SB_I_NOEXEC | SB_I_NODEV;
 	sb->s_blocksize = PAGE_SIZE;
 	sb->s_blocksize_bits = PAGE_SHIFT;
 	sb->s_magic = MQUEUE_MAGIC;
@@ -457,6 +457,7 @@ static int mqueue_init_fs_context(struct fs_context *fc)
 	put_user_ns(fc->user_ns);
 	fc->user_ns = get_user_ns(ctx->ipc_ns->user_ns);
 	fc->fs_private = ctx;
+	fc_init_pseudo(fc);
 	fc->ops = &mqueue_fs_context_ops;
 	return 0;
 }

-- 
2.53.0


