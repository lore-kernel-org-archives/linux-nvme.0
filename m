Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DC7606A321
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rr975fOM;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z/rhUIdt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=BUOTmrjfTp1V3edmG7gNtNzcyR5ppQHZl9FL8hylfFM=; b=rr975fOMDfsV+5
	4stGjlqe8HBqqBrz292Ibz05nsDFEWKP9A3FyhPXvjgPULX9S4e1vACdrho2MLpuViQ6+Ar6RXzSx
	7i7bCu/u8dBhwqhKUd5S0HAHBq0/+u7m78cNJRLbdVBwRDtLxbm0NJh8zXxWweC2Nykk9d1Pa4DHx
	Mv4oSV4HLMdbG2G0upr/bcbAA4++Sz7dOpCtL5E8xUpfW76K7N/HMcwCpkxAX5PPcgJsEkChtyme2
	bdSuRVNtWvnYdjRLVAQI3Z4OJddy200IZtQ+rLauOh3itFysWgjW/fuUcOZsJmv+8Foe0ssLboTSG
	VT6KATlvHcFlfoMRWeRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFh5-00000007jRA-2biS;
	Wed, 11 Nov 2026 21:17:23 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQhzo-00000003EWA-2Ejs
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 09:18:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4C6CC4248A;
	Tue, 10 Nov 2026 09:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC561F008BD;
	Tue, 10 Nov 2026 09:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302308;
	bh=BUOTmrjfTp1V3edmG7gNtNzcyR5ppQHZl9FL8hylfFM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Z/rhUIdtQk+seOQ77LPhWLi0h1HQ2z43OEYnSCV//qvDOQQY0eHazzaAy54GUx8Mx
	 8OK9mCUr3KpEXeTzY4DiLfSk8l4evm0rcg5MG+ZHO1q3f2+gjSfOngnblIK2dDloDP
	 +WK6+GSTNoZaklQDEZGcF/9QgdWYzJPUOnmM9b0SlwKN7qlVlPKvfelGldE5Fl2bZq
	 JX98mYm4OGqMZKkfdmwuQV/pEXKpVF4ZPuDqWxolPUJwv7mAgjzXljkKCK82NenbeL
	 eIEFZnStffm2ZpLfOJ/AEIbn+CZ9LM0bc0AUxEiBMv53oXud1Vog9u11hUGToZKfGe
	 0TNk0TnU30pYw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 10 Nov 2026 10:14:38 +0100
Subject: [PATCH RFC 22/41] sunrpc: use fc_init_pseudo() for rpc_pipefs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-work-loop-pseudo-v1-22-4c998976c6c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=934; i=brauner@kernel.org;
 h=from:subject:message-id; bh=HtfAKXnCso4ldD33NV35qBTF+UjT1cN7QubZI9DMCIE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9erBWvWPi53s6BltWb/lTc4Zf/LbV2zVLS/PuNTwys
 NpTVK11t6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAic/QYGSYY+3T8qY1dKXP/
 avJlZZapb1UX7tkXkrYvfWun7ZXF048yMlyV0He+V+u+/2+YguYEho8MZedCVq0SsT9y8ZnhI4f
 FWnwA
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

Initialize rpc_pipefs as a pseudo filesystem. This raises SB_I_PSEUDO and
also SB_I_NOEXEC and SB_I_NODEV. rpc_pipefs never holds executables or
device nodes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 net/sunrpc/rpc_pipe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 9d349cfbc483..37277a6d2415 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -15,6 +15,7 @@
 #include <linux/pagemap.h>
 #include <linux/mount.h>
 #include <linux/fs_context.h>
+#include <linux/pseudo_fs.h>
 #include <linux/namei.h>
 #include <linux/fsnotify.h>
 #include <linux/kernel.h>
@@ -1181,6 +1182,7 @@ static int rpc_init_fs_context(struct fs_context *fc)
 {
 	put_user_ns(fc->user_ns);
 	fc->user_ns = get_user_ns(fc->net_ns->user_ns);
+	fc_init_pseudo(fc);
 	fc->ops = &rpc_fs_context_ops;
 	return 0;
 }

-- 
2.53.0


