Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3F8606A323
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uxGenEk5;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ahGg+gbK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=OdlKWawwdwZpGTfkQNHBk5b32jOSAzRsLtI4xTW1vDQ=; b=uxGenEk5DsB2+B
	peePbiwGjcFf1wuWfqEBilK5RVk69zX0wNuVcyU7VPYFQd+TGa7c5oaLSDqf8Dg1MWhD9NwxmFlMp
	ndohpN9dzlsWkB5sIpUTiLSXKe3icVBhqbUyDrn2BIJwGg1qRL4oVctO4TaN6uXmblRnXG/cNhefS
	u2VM2NvpLGy7nuiWDWJbFinKhmmziXLfN9nv7aaWMBnXABgbqPblto4WaIJc4XYnnYjQUnBlF8S7g
	3nC0KoUcegWIh67Nn5z5H75A9juQ9SgbaalibpqgjpbDFPVVlup0+heAQvD3XGYTS7QXRoFMVxELb
	EktbWlrS7YWCdixsjR2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSEFW-0000000GByZ-3d1o;
	Sat, 14 Nov 2026 13:56:58 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSDVS-0000000G4as-0OgF
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 13:09:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D370B406B8;
	Sat, 14 Nov 2026 13:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEE61F000C7;
	Sat, 14 Nov 2026 13:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794661761;
	bh=OdlKWawwdwZpGTfkQNHBk5b32jOSAzRsLtI4xTW1vDQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ahGg+gbKJXxbgqkOcSvuZjZ7iPlwqVzDb7EoxKqbMYLfnwG2b1ybTE6823Yt3K+6g
	 6pxGQrYoIqiTMRS2KhVum/gBvAKYjwtRqLYJCBO/9ug+3ibc96rUKSQG8oL+uPM/Cp
	 otj/ItmyYhEy+iuvYfxXHkC9TxP25a1aDbikvQC0LaWKFqqkHfvi1rF3sXkQx5MRrH
	 gup6EgTCHwl6mcX33AkMw33YPKcSKfn9nILfmzWaqX+7hRwWvA8CVF1JFBWIvMizqB
	 9iaDWPBWP9dpOG/jN3GKX5YzZjKL84UtGahKm/OO3Hrc5uHtCRmGPTFTPgEI2L+fkM
	 4xc2owYmq/A9A==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 14 Nov 2026 14:02:13 +0100
Subject: [PATCH RFC v2 32/42] usb: gadget: gadgetfs: use fc_init_pseudo()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-work-loop-pseudo-v2-32-98639a2286fb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=982; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YWRf7GOro6drmYRPuYvYnNI62ZxquNzo3CA3o8p8z3k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9iOkuXt19v9szNHxy/sSShDNHi+s1AhW1jvfPOLx+v
 43t+vdHOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZi95Dhn+K7b5fV2hevnL5D
 2vJ8vvv+x1/kZkmvkvsmunJ/0t+X6ZmMDDeNr0oHP1bwdTnx7e2hwBWKTidX/diQpKYmvejZFYN
 lK7gB
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

Initialize gadgetfs as a pseudo filesystem. This raises SB_I_PSEUDO and
also SB_I_NOEXEC and SB_I_NODEV. gadgetfs never holds executables or
device nodes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/usb/gadget/legacy/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 7f6d8460152f9..8490e5d0351e1 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/pseudo_fs.h>
 #include <linux/pagemap.h>
 #include <linux/uts.h>
 #include <linux/wait.h>
@@ -2223,6 +2224,7 @@ static const struct fs_context_operations gadgetfs_context_ops = {
 
 static int gadgetfs_init_fs_context(struct fs_context *fc)
 {
+	fc_init_pseudo(fc);
 	fc->ops = &gadgetfs_context_ops;
 	return 0;
 }

-- 
2.53.0


