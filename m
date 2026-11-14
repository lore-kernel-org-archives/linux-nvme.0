Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5882E606A327
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qmqeMv24;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVaFfwiA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=NVjzjsuRRB2UDEz9oF8zpvzwY092/ejVSFo+HtliIvc=; b=qmqeMv24r1G1ie
	TfhxAopZ77P02utsoc5s1Q1eWk7vsP8W0Fl8VMIkrUkXWm5o3JLohDU8EexNqQakBXzodnjhusGzE
	Rnp2rhZSqkvPf3/p3SLFTPFUmKueYFWOQifyWic6gD4oH6LXu2Hk6JPQeXN0KXiPscJMJB92+/sLi
	YbKmua6izHl0nGDtslfZz/b/1EQNZzo3tg/dNEOb3rVbYvlPxPufKKh5wDeAcjYvqF6VuhvDzLfzP
	TaB/I5r8qWufVunkQorobh/vh2uRg2uVOkqGUUkeJrsrqPrAnALxexYL/ChsJzdfZMjrWkk1/UvXM
	6EaUCEhfafE99TQSjfbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSEFT-0000000GBpl-2gLL;
	Sat, 14 Nov 2026 13:56:55 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSDV0-0000000G4Qg-2o0U
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 13:08:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6BCE543CBA;
	Sat, 14 Nov 2026 13:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93491F000C5;
	Sat, 14 Nov 2026 13:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794661734;
	bh=NVjzjsuRRB2UDEz9oF8zpvzwY092/ejVSFo+HtliIvc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UVaFfwiA5zRIimVEAgzAS5LMrrD01HUXKaMpbor+Rz5AOd2vHoPXCqbvdwGWBTrIB
	 m5kX7dz7AGGAwjJjuW0l/5mNTBXOF7cquK+ncIk4FTMBAgz4L/swi8yUiHI0e2qgAr
	 6bp+zKbJsJ9HY/cYKdz1lp/ddP0/dfUVi5m/8oneZVxiQWMDTgO2bliKT++Ie3Uv6a
	 8l0UllhuQ7TbovBebBzVOisEiB4Ok49OQ9H6KpFib98QFm6PM9KhfCivOUR1UsxvCZ
	 9aPQWq9qVax1nQI6TBMVoXocUs+GlzxhB7TqjHWemtwD7yZ1EJQ9uSokpve4k0Q1J0
	 aujFNglRVEFlA==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 14 Nov 2026 14:02:09 +0100
Subject: [PATCH RFC v2 28/42] ocfs2: use fc_init_pseudo() for dlmfs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-work-loop-pseudo-v2-28-98639a2286fb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=949; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+FO4Y1ymqMYAnXNVc9VhiJCBK4eGvv0E7gd9oyLRaz4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9iGk7WjSP46SwS3e7d4Kv6MyOb6bppW3Xqv6V7uHTL
 Jc4cvtcRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESUxBgZnt04pCb0syGDj0eq
 f4e31jfLPX8LHQNWd/7buu8nC9PpW4wMu0Xb+E2Xc3o2TOOI4xToZ91mWvKBzUnka3RtdNyx738
 4AQ==
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

Initialize dlmfs as a pseudo filesystem. This raises SB_I_PSEUDO and
also SB_I_NOEXEC and SB_I_NODEV. dlmfs never holds executables or
device nodes.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/ocfs2/dlmfs/dlmfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index d3bfcada3e3bf..1789ec96dc130 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/pseudo_fs.h>
 #include <linux/pagemap.h>
 #include <linux/types.h>
 #include <linux/slab.h>
@@ -563,6 +564,7 @@ static const struct fs_context_operations dlmfs_context_ops = {
 
 static int dlmfs_init_fs_context(struct fs_context *fc)
 {
+	fc_init_pseudo(fc);
 	fc->ops = &dlmfs_context_ops;
 
 	return 0;

-- 
2.53.0


