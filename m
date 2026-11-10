Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A79606A32D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WFnWP3tB;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BW8cSBu5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ZmsVWE65gHf0tYCZOotZ2fbgGfTg77o991kqs+Fgm8I=; b=WFnWP3tBQP1VKm
	yZe3Z/aMN1i4Av5kDsQSjJUSBaW9ZUkU2ShSAfj34l5OyQIY+hxNSIcLa8KKEJX6tO1q6iT1q7ihB
	Le1uAmsG1xpIe5JI+yh9lgUiHOn6vViN3LBXZzK6js99cxhpAblMJWrt2PWKPPN2a5RtGz90oKwdC
	l8ab7wIgc7+45LSZ/ovr2wbYhaFGeI3mSfowckDwxr9hb/wzJYMsN74XuWP2CZajrCfGurikBR/fr
	An75ofx4zG3gLBlM7A3RYO9ev7sKIgVNKA3esEJfD0zcp63iv8rAS1oREoivqIlf/O5nfgJwBXPx3
	6/Ktq2LlY7tyCYlq5w5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFgn-00000007ioa-3bCJ;
	Wed, 11 Nov 2026 21:17:05 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQhyU-00000003ED4-3nfJ
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 09:17:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5851463803;
	Tue, 10 Nov 2026 09:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977E81F008A3;
	Tue, 10 Nov 2026 09:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302226;
	bh=ZmsVWE65gHf0tYCZOotZ2fbgGfTg77o991kqs+Fgm8I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BW8cSBu5u5r410tEcT+zMEpXHphJlFpdpAvRKAvEiKkqyi0xID6vk2b0Tbjr4F3K7
	 awaBsefdY+MBphndwr9KbPvoSGcCvsFqAgttwi2fLxH3+R18Qt4275it2lfQHkFKW3
	 UWJSti38mAmdmLS3tX3vRlC5H3kzbz/lg2YywjKPfSIrMY163nLZvxRzgh12Gfu740
	 fCVYcWuwLy19s6iKyC6ZAEcLuBFbK0G08kyGDUPlYe/7HLPPSEk9rvbQ36ZpaFxa7H
	 vhskSHci2E1kOmUw3DCi+DzAu6HlXgBa1yUahbo2TZ2iHpM1c2csxa56tO5nlkWHht
	 owe5/3f9zcJNw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 10 Nov 2026 10:14:26 +0100
Subject: [PATCH RFC 10/41] nullfs: use fc_init_pseudo()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-work-loop-pseudo-v1-10-4c998976c6c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=901; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sE5h4xDpaVEC2u2QAThbBNjL9uzfl1yRVOrJAX0MUt4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9ejD//EYdt1/rJsiFfvkoZ/8qOqx4q8M6HwH1m6/ZZ
 AI224nydZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykdCnDPxurz9VH1LyPmPhq
 vwyuY532xsvTcZ32qt+q1sFHglVuuzD8D18Z213yU2Sl5aU3uX8PWyTKlr/7O0218syUZaL+TwX
 WcgEA
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

Initialize nullfs as a pseudo filesystem instead of raising
SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/nullfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nullfs.c b/fs/nullfs.c
index 319c2f5c5a67..2fe24cb97160 100644
--- a/fs/nullfs.c
+++ b/fs/nullfs.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2026 Christian Brauner <brauner@kernel.org> */
 #include <linux/fs/super_types.h>
 #include <linux/fs_context.h>
+#include <linux/pseudo_fs.h>
 #include <linux/magic.h>
 #include <linux/splice.h>
 #include <linux/uio.h>
@@ -174,7 +175,7 @@ static int nullfs_init_fs_context(struct fs_context *fc)
 {
 	fc->ops		= &nullfs_fs_context_ops;
 	fc->sb_flags	|= SB_NOUSER;
-	fc->s_iflags	|= SB_I_NOEXEC | SB_I_NODEV;
+	fc_init_pseudo(fc);
 	return 0;
 }
 

-- 
2.53.0


