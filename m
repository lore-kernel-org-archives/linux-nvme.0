Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4058C606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LX6BhTnW;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUIH1F6N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=JUBUitc/wTfMb7cZo0KLtSOkDXoKMBIaahrb6Pvq2WU=; b=LX6BhTnWwPksyp
	2rvLBj5q4Pf0gkZHhTOOIz5jKilsjdGM103v9jxMxKd+yqiSWP9Ly5NF1tgE6RwUMrWfIW0Xixdpz
	t9kGmgFvbhjc0//pq57z933S7kL3qHPU507Ba9+yGOa3AEXUPnGetUM04W5+8+ghPvke3Xtt240AG
	Eeyb37PO6djGWiAbiFSit/4wNB3Ygi2/4Tkju4ml9fRR+DQ+ENMsva2QhsjmwIg5D2vTp/uE+yWZ4
	TwPP482MELRKmsV4JTK7lT5MaTnZa57YZUFUOtA4koWTwzyoragn2SCa84V90JNW5GzoqRJHLVzxS
	iGM6BQKlJMW7c711WXVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSvzm-00000002OS7-2jVR;
	Mon, 16 Nov 2026 12:39:38 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuak-000000027W9-0Vpq
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:09:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DC6D0436A6;
	Mon, 16 Nov 2026 11:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6731F000C4;
	Mon, 16 Nov 2026 11:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827381;
	bh=JUBUitc/wTfMb7cZo0KLtSOkDXoKMBIaahrb6Pvq2WU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FUIH1F6NGssyVW4COeuJyW+JXf9ZOuXxGiqbs4A0riZEC9KRZSSdvKNcURoDsDRgh
	 9xYCbzX7EojI2QWlJla3qu7db5L+WQYXUZcNIeoO8I7Bq0+B09BmicfrMgxZ/Ox3on
	 bFe8B7Gi//6ibg1Rcjs9Q9iX4wuprOmsQHVd3UNmADXkOZuZMUFwH7kba1alb352e9
	 OJSNgp54/odFq5qdzwapiUJoJRaOPOoAwCSGsb7ksHyXtWMzlopVECEIT0G38kcQBE
	 pg6QF0PX4eGcaaN9wK+k7kydBrzrK2s+1vVH5dg8hQFATIYPm4jdZtaIfe7R5PvR2a
	 60xFyqANj+2cg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Nov 2026 12:05:02 +0100
Subject: [PATCH RFC v3 29/44] s390/hypfs: use fc_init_pseudo()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-work-loop-pseudo-v3-29-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
In-Reply-To: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; i=brauner@kernel.org;
 h=from:subject:message-id; bh=EnQ7f/LKwwXo6PyRpnVfj7bCGw1qYUMZQQO6IXtl1m0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9etzAs//A4QyrntTfr5Y7yH5s6yi2sbvx+oICZxt3h
 d1kbZ/4jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk8e8HIcCtlltKlLKv9RupJ
 PUs2C3cvYefO2P3yrXS3UKbMrdVTVjH8M14Z2P06RDR52paz7g98lpWbd4vzSeWeD7J7ZqRssXQ
 eDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Mailman-Approved-At: Mon, 16 Nov 2026 04:39:20 -0800
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

Initialize hypfs as a pseudo filesystem. This raises SB_I_PSEUDO and
also SB_I_NOEXEC and SB_I_NODEV. hypfs never holds executables or
device nodes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/s390/hypfs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index 559b011e68800..8662169de477a 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/pseudo_fs.h>
 #include <linux/fs_parser.h>
 #include <linux/namei.h>
 #include <linux/vfs.h>
@@ -301,6 +302,7 @@ static int hypfs_init_fs_context(struct fs_context *fc)
 	sbi->gid = current_gid();
 
 	fc->s_fs_info = sbi;
+	fc_init_pseudo(fc);
 	fc->ops = &hypfs_context_ops;
 	return 0;
 }

-- 
2.53.0


