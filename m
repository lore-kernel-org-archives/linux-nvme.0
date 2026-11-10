Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7B7606A324
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KPHVJw/6;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PK/1xJP3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6iLMVu7/iMBDJai9Frtaq88BtgFpmQIL1GiZqP6G3sI=; b=KPHVJw/6gsnAGG
	2S+k4D7C54ufTlL8uErFjrSxM5a/QpF9rX6HTbR8GqU3b1EVjdaqUmx/weqY70qHm/1sDIHwFDk0D
	WGJo56w+CucjnYkfAq/IGmConc8gDKVoxkhuMEMNxTwoIeIEND2tzrV69iTIuTAGVA7i99XIGykS2
	Ouv3dEsI0d+2mywFzMAYB5xTNqbtqLeYADLiWExCC/iPUh6fUQEvv+p+PhmYUgwIXgeRXbGH7vROO
	nM7scYVZLRpY52mZKmmyBwaedCjKlA51DP7OFgaNbu++ej6NB8ScUbuMCwQbhGnytwa5VX6Qqho8v
	c/6hYAKOScT1q3paHgMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFgn-00000007im5-09xR;
	Wed, 11 Nov 2026 21:17:05 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQhy9-00000003E7L-2qg6
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 09:16:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6FCDD469BC;
	Tue, 10 Nov 2026 09:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40961F008A5;
	Tue, 10 Nov 2026 09:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302205;
	bh=6iLMVu7/iMBDJai9Frtaq88BtgFpmQIL1GiZqP6G3sI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PK/1xJP3LiuE+nt9clqn6XzH1ykuCvGLk3pJedYJU7MenGMVki1YReFMeqHc2zbsn
	 f172wPMgNRu0JWSTlIgtjrHD4rRAL5eo4520JocrDxATE3L3QlkqPhQ9KQk+e2lr0U
	 Z36S4rtp/Z53gBsFmJhmg4BkAtm0NXKKNbbu/pQH5R9bFuSUNl6MT1vw2mzIJB+cHB
	 GEBOatAxu+reiIAHlIkDGmUecEYVk7FAdx3uXRaXJYFCUAdz3m+wvz8PXNcaKaCVki
	 JtIsqDglq1gfmT2kaiK580I9+CfdeeDheRHydlXbZS6YOU+oHBKlCiswiLTGKFt073
	 cI6f92QGFv0dg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 10 Nov 2026 10:14:23 +0100
Subject: [PATCH RFC 07/41] binfmt_misc: use fc_init_pseudo()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-work-loop-pseudo-v1-7-4c998976c6c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1237; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UVUPWAqqIx2djk703y1XHtcvgboItkTJfb/9RmtQVkY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9ejBn84pzm65G6TrPnLRrvZZh1ewlwVPObmlaECUjK
 7ZLaeoizY5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ/NJl+MPnlu8e4KGSGHCt
 mDNIumRG+SSJIzc+6bMINy6T/Wpmeo6R4ej/ewWKW0xWbLL7tadJ5iOL4pbdcy4cKXfp5/DfHPj
 1KQ8A
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

Initialize binfmt_misc as a pseudo filesystem instead of raising
SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index d945b4f6e158..7dc233becd98 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -22,6 +22,7 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/pseudo_fs.h>
 #include <linux/init.h>
 #include <linux/kstrtox.h>
 #include <linux/limits.h>
@@ -1575,8 +1576,7 @@ static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (user_ns != current_user_ns())
 		return -EINVAL;
 
-	/* Never exec off this instance and never let anything stack on it. */
-	sb->s_iflags |= SB_I_NOEXEC | SB_I_NODEV;
+	/* Never let anything stack on this instance. */
 	sb->s_stack_depth = FILESYSTEM_MAX_STACK_DEPTH;
 
 	/*
@@ -1660,6 +1660,7 @@ static void bm_kill_sb(struct super_block *sb)
 
 static int bm_init_fs_context(struct fs_context *fc)
 {
+	fc_init_pseudo(fc);
 	fc->ops = &bm_context_ops;
 	return 0;
 }

-- 
2.53.0


