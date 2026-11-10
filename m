Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20944606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FVFeXN2p;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LlMaKIGP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=WY71Uo54gYhZKR4pKqr/19QlXycB+RRfAfSK6SBkMOo=; b=FVFeXN2pnarI83
	MgavPLFxkQt+ueCTM7Rufb6MN4kbrGGOE812E2+tR4WNEdORqeR3kqQiXFkbaypcwm6hvangpnQc2
	zQRYNhYEHJO8AUckWEnv+1AEmmxJdYNXyoJ4RtGeVmoZucC1tZOecMao4+sHT3zxTT3M3ah+0eeSK
	U1Us87zwf+rvxiZLK2YEcz1H0TCSvNEB407R02+E5kazibTV+E5bexBWaWHM7yojd4389IAcM3Q4G
	wrpV4y7QuCN21x/uIWiblyUYYuftjL0ahJWsRyhYCnE9elJKjnLsmDrLtQJeJ/Q5GVTei/ePH0iaz
	NHgsZyhLgAcKzUt7Ykng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFgn-00000007imJ-2K5R;
	Wed, 11 Nov 2026 21:17:05 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQhyO-00000003EBK-0MQl
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 09:17:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6DE5F6302C;
	Tue, 10 Nov 2026 09:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02601F008A1;
	Tue, 10 Nov 2026 09:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302219;
	bh=WY71Uo54gYhZKR4pKqr/19QlXycB+RRfAfSK6SBkMOo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LlMaKIGPglPkcvGNxGDrg7KApXX+gHKG5SrrawRrOpvdcrBWjo8TZvaYC/dVHXPkL
	 o7Q4vzGLaTH3tPVI6EK6P52H//aWm8LX6LNA9wx7GzZylS8Tm5t7Uihc8gqN/tYIDQ
	 PP3rUbIEqyxUIjeAdPOxrVHEdBQihQ2084RfxCjhwr5G5bFc0E6zHMFFmmj7AzSVaR
	 tXO6WvEI79qn/4DPL9toj7+CN6z0DqQ1WOgva9FN1PkhAS1Orh3mr0q9GB2K5qslXC
	 scXEvlIXqJ5srN3BcqIAjqdwqr7UK9xIGt0dTlwV0MKzMAeX4GxKcYRYlOYndv3UdD
	 j0+mmKCFyRsXw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 10 Nov 2026 10:14:25 +0100
Subject: [PATCH RFC 09/41] bpf: use fc_init_pseudo() for bpffs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-work-loop-pseudo-v1-9-4c998976c6c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NuPA4jHbua+UQUqvE1NH9WnvUCJeB7nsXYSG49yrfac=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9ejBv9qN9iY0qd75n8gck3laXYJGcP/Xvwpp6nhV1l
 +fz+Fhu7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIHQmGvyJmG6+tnBjH3qJw
 I1e/7XGpNFv1HyWFz9buJ/bVbr2pzsjIsPmDUI3mIZewOZLzrAJLZy6ad+vu3j8/r72fuW2C0oR
 /b/kA
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

Initialize bpffs as a pseudo filesystem instead of raising
SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/bpf/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index c6f328e4752e..57cf3775c076 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -15,6 +15,7 @@
 #include <linux/namei.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/pseudo_fs.h>
 #include <linux/fs_parser.h>
 #include <linux/kdev_t.h>
 #include <linux/filter.h>
@@ -1197,8 +1198,6 @@ static int bpf_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_magic = BPF_FS_MAGIC;
 	sb->s_op = &bpf_super_ops;
 	sb->s_xattr = bpf_fs_xattr_handlers;
-	sb->s_iflags |= SB_I_NOEXEC;
-	sb->s_iflags |= SB_I_NODEV;
 	sb->s_time_gran = 1;
 
 	inode = bpf_get_inode(sb, NULL, S_IFDIR | 0777);
@@ -1261,6 +1260,7 @@ static int bpf_init_fs_context(struct fs_context *fc)
 	opts->delegate_attachs = 0;
 
 	fc->s_fs_info = opts;
+	fc_init_pseudo(fc);
 	fc->ops = &bpf_context_ops;
 	return 0;
 }

-- 
2.53.0


