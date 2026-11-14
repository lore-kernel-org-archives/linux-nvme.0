Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BFD606A32D
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CYf1RDq/;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hEkWoi0t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=4kkI+IPK2+Ut0+1ZoXiEi8rjJhct2bhRJIg1CarRCAo=; b=CYf1RDq/f+1tzL
	l1yarDnEkzFwmxWD3IedYU3avEITKvBZ2SSzTEOnrHe6hRLMvkSmIGSB3GZiqSfYG1YLmvN1tcfHm
	zmYNu5eDHF/q7bW8BXd6s2IhRI6SsSncN4y7eRw/nsOFMA3WOkkFr7j8GoFnepqF4+XPyG73SDgWL
	wmO4kY4ielhLab8hqJ6/EIgOm7T7fPRt836tqG0Unz9LgjwdeYCRjL5qgrTg8IyhYuTmZKFTBtNRy
	Z/SSt8vdrfzR22fmidIovEFWGni/9RgUC1mVCS1IRtkvAw29LrzDltSvSspfVXU+raMBcKBuTiPQW
	9XqG/lI7eVb/xovn3HSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSEFL-0000000GBPY-3z2Y;
	Sat, 14 Nov 2026 13:56:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSDU6-0000000G46L-1xHg
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 13:07:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3C11340C08;
	Sat, 14 Nov 2026 13:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0AC1F000C4;
	Sat, 14 Nov 2026 13:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794661678;
	bh=4kkI+IPK2+Ut0+1ZoXiEi8rjJhct2bhRJIg1CarRCAo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hEkWoi0tyCsc9zadGHLm768O7sYlLi/D+fGyMzmvsQLG0ecR+NMw+wied9l5d5Zwz
	 gXg/BXMBhAqtrrbzcnX7swbJyRTSoeXkE0/Xj4exo4chOq2rqW8u9NgVvtGNx7NQ4N
	 tXKYibjQAPgJeWrE1gEMbtIXMLXERqjMNC3NkxnywycmncD6Z6ELQskYJq/tDcjGyo
	 b7MiLG6d3/YOLC/qD+DFLTnmKp2Eap+cYDtfpnlvFm0Sd20bv+GLE20cwwAUSwJX76
	 vkqL8xuR//PPoR3nag7/4uwnKL0zHsmwqxxmbWxXcW1V6+IGZWFTG9QrabHpoz3t6k
	 wNuuL3/EHnOaw==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 14 Nov 2026 14:02:01 +0100
Subject: [PATCH RFC v2 20/42] apparmor: use fc_init_pseudo() for apparmorfs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-work-loop-pseudo-v2-20-98639a2286fb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2+D6KLg9w3laVv0BnjhP1IDdcfwT6twoVX6+ZeNTRuo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9iKmZKcpwLKbq/umvv9mCX4WuWfO/R+PnjY3u1b0xy
 aJzTtb4d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk1w1GhpYuUdG4qi+fP0qp
 P5/cI7ND32rq574Xhq4Gah0nZWLEwxj+Z3padK6OzZ+r0dD959lvmcWH1WL54+qWl5q+bm665Hu
 KCwA=
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

Initialize apparmorfs as a pseudo filesystem. This raises SB_I_PSEUDO and
also SB_I_NOEXEC and SB_I_NODEV. apparmorfs never holds executables or
device nodes.

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 security/apparmor/apparmorfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index a993664672173..351ea3a7120e3 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -21,6 +21,7 @@
 #include <linux/rcupdate.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/pseudo_fs.h>
 #include <linux/poll.h>
 #include <linux/zstd.h>
 #include <linux/string.h>
@@ -263,6 +264,7 @@ static const struct fs_context_operations apparmorfs_context_ops = {
 
 static int apparmorfs_init_fs_context(struct fs_context *fc)
 {
+	fc_init_pseudo(fc);
 	fc->ops = &apparmorfs_context_ops;
 	return 0;
 }

-- 
2.53.0


