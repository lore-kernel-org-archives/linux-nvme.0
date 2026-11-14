Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C07606A32D
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iFOAPkfB;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NT+C8ZSk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=B+REGYiia6M8Fehy1eJYg2qJvRlaeD0xlyLGCXMkuNE=; b=iFOAPkfBQ1yuIz
	xyBZQy6zVnfmM1T8P/ddYcEL5HjdaTrfiSYf/pfZGoc9rRlzQl7XnoAzf+U/4c9jVLbRyYnxJr7Lx
	3k8Zs8SBJcWTj2eL8LAgriouzgiafQh3CU4KzKwL26tW6t2mPWLWDkPJlfabxiCVgvpBqeRRGlu6D
	MEtXm+kMwwJnEaRRUmatT2C7IJSYfXz73846Mi/zUFpeEcVoAYFN/yHsAnR9C7ZJHp6/vb8hM6R3d
	UgkxRlEpL+yXSa47wAu4o/Obn8NztIXw6U8sJSV3IE98dUIZ9tLiY3fR6pKVX2egOm2MiarNTjibH
	7eq5zYu3rXhk21mq32+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSEFN-0000000GBSs-0saN;
	Sat, 14 Nov 2026 13:56:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSDUK-0000000G4Cq-1mGi
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 13:08:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3033B4248F;
	Sat, 14 Nov 2026 13:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA771F000C6;
	Sat, 14 Nov 2026 13:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794661692;
	bh=B+REGYiia6M8Fehy1eJYg2qJvRlaeD0xlyLGCXMkuNE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NT+C8ZSk21Aekq5VpPMLkN5lXE041tWb53E/PFyXaS8JnOZjtpnhN/IJ5tqRBCBZC
	 KbDWuq3IEQ7OtXMgE2LPkypVXS8WxlXMdHd2O7GYRa0mZLLaBUF9g7tJe1IuR9z/Tu
	 tpgNbPJ7ubYsE+wigZ6X/juKus/SI/ItMQcN8NWKa2MZFuLxGtDjcGrhIpixMheCao
	 YiLG/S/BH17O8QK6M3uLoFs/iFFdot437NsUY+7gBXIKoXeJXJDLpLDXP3MV3ZMPM5
	 FBITgDJULpAf7m6rj/Ojk/eIFB5uKGaQlYZTJdDB6wrEWsHVvT0rUR1LjVlBkf4syv
	 9ViLnD0DFgZ3w==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 14 Nov 2026 14:02:03 +0100
Subject: [PATCH RFC v2 22/42] sunrpc: use fc_init_pseudo() for rpc_pipefs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-work-loop-pseudo-v2-22-98639a2286fb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=992; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+3Y7mk0/f7poY8fBlt8WQG/1XBQtDGWNLTeokeIQsBw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9iKkv9T4fyqbzi23jmztf3H8nMwUrtfHJ3V29bbKqZ
 4Be8ZHXHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNpnc3wv871ae8ZnnvGH04d
 t2zw0Px9bvK8I1+KT3s+2d58956GViojw/+7R89LrYnhN/wbudL+frVNceDzmi1V3lf5GFd/y2I
 14gcA
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

Initialize rpc_pipefs as a pseudo filesystem. This raises SB_I_PSEUDO and
also SB_I_NOEXEC and SB_I_NODEV. rpc_pipefs never holds executables or
device nodes.

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 net/sunrpc/rpc_pipe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 9d349cfbc4831..37277a6d24156 100644
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


