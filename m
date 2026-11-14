Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BCF606A32E
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ilzwVRko;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XT6Tzz65
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=fL5qL7JYOP9BGMrgZwawKOkNR34gS09nbbxdAESC5AY=; b=ilzwVRkoFVuJWs
	/zDPCIOJUQ9qT16DH2WP7v9pFzyHYpdxNeualq3GrdzUZ5YAJVazcKH55JB67AYx/78J+lyvERVdI
	/2RjE7EJQ5wdEZN6QP9s+dN2hrphrThXMpUqkiphOrH/ZgpY1x4GI/cxH55swkenMabM33FMTSOs2
	fcPp0IhVHkGJhThgcEgVycg1HzJT4SvZLqogWj9wQonIh8sH1rxMHpDYRhPBI3/QoBlOduSV6QdnN
	stul3n6YfdWrvUXRPR9k+qFhKxsGMr2GhWziB3Bvs0GKJWYtbdPDeLQI+5Q4PG5E95thSllwMVluM
	O6u0i7dP1MVcvB6haUMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSEFK-0000000GBKc-15Ky;
	Sat, 14 Nov 2026 13:56:46 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSDTW-0000000G3uT-2vrx
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 13:07:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 734B645DC8;
	Sat, 14 Nov 2026 13:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32C21F000C4;
	Sat, 14 Nov 2026 13:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794661642;
	bh=fL5qL7JYOP9BGMrgZwawKOkNR34gS09nbbxdAESC5AY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XT6Tzz65LCASVZ47tnM9EdK03t2mFYcw5Wfu4oufgcBgXnbaOuckTDE94B5ZXV+Va
	 EU1Hf7/L5yVuBKj4y88q1JGFQui+kFHrJJu7lnns7s22U3Gs5ZcvsCcJTG0I2EyW3Q
	 KDKAn8ifYEBsZ2B7CrL21bmgUbpdyqHWaiX9WluNWeXrhcyYELynQmFzM5mWkYnC0K
	 zpVL3Gebr3O9VCG64/CDLTlwkC6MFMkAzn4mz3EOe5xNvAgcqW17IAQzQdSPmuWMkG
	 /v0whbvR9pbXyF9a4Ry1WJns8QKC3IBONTMY+4RwPAvzY7FdiKnzRHvhdFNFhLYf64
	 ce7gMdf7ac8/Q==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 14 Nov 2026 14:01:56 +0100
Subject: [PATCH RFC v2 15/42] tracefs: use fc_init_pseudo()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-work-loop-pseudo-v2-15-98639a2286fb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OLdUHvbro/9NsaPkdx9SBi3MWAKl0be+fpwCoTKnM0g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9iCk/X7VxtazYZu/77yKX3Lh0lO+Fb1pg5oS3DhfiF
 sop1B6L7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIniMjwzQz1Rr/RW/fHJCR
 aP8X8LL8wFk5r+qdurqGgnf6i89UfGNkmML0ZNu1mkT3zPW72uZLPX/ovVd5gtESM71HojlJH6K
 WsQMA
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

Initialize tracefs as a pseudo filesystem. This raises SB_I_PSEUDO and
also SB_I_NOEXEC and SB_I_NODEV. tracefs never holds executables or
device nodes.

SB_I_NOEXEC also refuses PROT_EXEC mappings. The only tracefs files
that can be mapped are the ring buffers and __rb_map_vma() refuses
VM_EXEC already.

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/tracefs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 5020365ca7048..e04febd868eb4 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/pseudo_fs.h>
 #include <linux/fs_parser.h>
 #include <linux/kobject.h>
 #include <linux/namei.h>
@@ -510,6 +511,7 @@ static int tracefs_init_fs_context(struct fs_context *fc)
 	fsi->mode = TRACEFS_DEFAULT_MODE;
 
 	fc->s_fs_info = fsi;
+	fc_init_pseudo(fc);
 	fc->ops = &tracefs_context_ops;
 	return 0;
 }

-- 
2.53.0


