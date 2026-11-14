Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62AD606A323
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BaKl3Y+a;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NsZWIZ0u
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=M+wQ9mIvjJGXRJRbFoASGD8D6MKl3oze995xCAu4PIw=; b=BaKl3Y+aaq49qP
	Lv2+F96sPxno4r4pkz1pc0ia9jtTUgOaii3SLd3yoFoMgAYyC0uTvdeLaV8rSupgDBhO+XdQKCzt7
	o/we6TifHSewONW8i46hA+pKKiAjaYhScsr8kJXyIMObVE+P2dBswgFjdBBc9N+oeAenTcAyZ2x4e
	H9o+9y7B4fXtrRttcVV21E8v2bAv9kQFx6Aw3/mXHh/MHPgS78CPONfSifcPHBHYCi2fMaMIO/HNi
	16nx1NaYNdkRYU/tlrRtCuVolGqcJL6/12oUsXsuZ5lFZVbB/4JW4UjwQEbReKjSFJXKP+73n2tjf
	HYcnVgJBlsL6WGUpipKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSEFM-0000000GBRl-3amx;
	Sat, 14 Nov 2026 13:56:48 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSDUD-0000000G4AI-1zwz
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 13:08:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3F23040ADA;
	Sat, 14 Nov 2026 13:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9255F1F000C5;
	Sat, 14 Nov 2026 13:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794661685;
	bh=M+wQ9mIvjJGXRJRbFoASGD8D6MKl3oze995xCAu4PIw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NsZWIZ0uyJ/kEeg27LNsarwDMno74uYeR1qvyZgeFqeOAzIo39kAe0MSpeaDBfyna
	 OG+SkTUFAd55NxkkZY4/tgrlFTOMIlMqstHT23WH9HmxSQHID6HZivP6RTGGasAtEv
	 ghdyrIYjK3Gq6GDN43kCLZl7rWTXSXciNlNO9nHbFmzAoVc7dcCL6Fvc9EA7GbsEHM
	 JDKJiOhvg95JFUcodZAZ1CCOfjp/PYgklweHBo4CkLN70q6kRCKVJf5HI0WMNA4lCf
	 fVobYC0NGlECT/3MARJG5ONmb7zmOAQZxfL/PpE2kk6Jb29ZnuuOdRMC+6AygDXLUO
	 SOqbbaseGw8nQ==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 14 Nov 2026 14:02:02 +0100
Subject: [PATCH RFC v2 21/42] nfsd: use fc_init_pseudo()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-work-loop-pseudo-v2-21-98639a2286fb@kernel.org>
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
 Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=938; i=brauner@kernel.org;
 h=from:subject:message-id; bh=333wt1W/Zu6jr+pk5l0cVZ7RaBW0U1/QWczclcq5D2g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9iKmLTHPo2r7Kfu7yRemXBPUWve7/actZfm6rc/k25
 jem724e6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIRR5Gho4FIlHz9++53fnK
 eYmA2xVfqS8fnermTZ72xHcPu+nShFOMDBvE1IVLnCTmP3kZv4jlPnfC5t2t7WarJxSWKke6dZS
 u5QQA
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

Initialize the nfsd filesystem as a pseudo filesystem. This raises
SB_I_PSEUDO and also SB_I_NOEXEC and SB_I_NODEV. It never holds
executables or device nodes.

Acked-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/nfsd/nfsctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index f32311f2d7cf9..ce2666deddbd9 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -9,6 +9,7 @@
 #include <linux/namei.h>
 #include <linux/ctype.h>
 #include <linux/fs_context.h>
+#include <linux/pseudo_fs.h>
 
 #include <linux/sunrpc/cache.h>
 #include <linux/sunrpc/svcsock.h>
@@ -1375,6 +1376,7 @@ static int nfsd_init_fs_context(struct fs_context *fc)
 {
 	put_user_ns(fc->user_ns);
 	fc->user_ns = get_user_ns(fc->net_ns->user_ns);
+	fc_init_pseudo(fc);
 	fc->ops = &nfsd_fs_context_ops;
 	return 0;
 }

-- 
2.53.0


