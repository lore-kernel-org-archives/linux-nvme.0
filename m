Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40FB606A32F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2XCFazcp;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CBYYTwmq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=K02XzgiVey8Gk03FTq4yCzsjgwwRpaqpi89MgT4x0oA=; b=2XCFazcpvStRCl
	XvhlV9+0dK+FQzqZt1yAv8Op3pYaeifRCTe/jNdc6QrK8Yt1cPQgS5mV/3UbrK+SSLskY8DFEGEVB
	d8EVxtf9pEZ6Kw7gWKuXEyrM6v/z1aQn3zBSjc2OdAcP1f9HIfHn/HB+u753rA3IM3gR6HjPI0UOQ
	NX+HzGyHIVniA34jIu7aqjhUA7lnV0VZztviPn74xKiAlPbcYi6EZTfps0WCXGKohelnVevOlZLWi
	ojbudjPTdpRIS8Qgccrh7TCkzSHBdY8xC1i/IURVY2XmhJ8Z9Zban71WHygvdTAXUocTleyfX0vVO
	ip/HgqpX6Ywljv4islOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSvzc-00000002NxJ-17pR;
	Mon, 16 Nov 2026 12:39:28 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuZn-000000027Ed-1FdM
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:08:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 13153438FD;
	Mon, 16 Nov 2026 11:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65B61F000C4;
	Mon, 16 Nov 2026 11:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827323;
	bh=K02XzgiVey8Gk03FTq4yCzsjgwwRpaqpi89MgT4x0oA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CBYYTwmqvG/X7Q1l09jl1lt6vhCiE5IixemW81zB87kv5VWwVCu+tjT7HIpe5m/Ic
	 rxTmpOcLM7fWrYpsIwJ8v9k3Sf119xYtmjZcCDB7XbSsd4ABWeI+YsnncIXfWZ+/TI
	 xyQQQn1PI1wVSECNnc86kj2hevZ5aF/XcQ3GcJYqC9a2J3KgM2w1fVfu9HwheK/PA8
	 hisUgw9t5Yl5+t7FmbOe624VXKlLm9W5/RFSY8WmooHM6Yob3+/hUP5CSs0+2NwMPt
	 KJfFm8q2GyauIZaZ2VNRQuWbKCc6Y0kY+1prHY800HPVjDEQbg/XtxqDqCAofCoKqG
	 B6ZtxIV9ZkJ9g==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Nov 2026 12:04:54 +0100
Subject: [PATCH RFC v3 21/44] nfsd: use fc_init_pseudo()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-work-loop-pseudo-v3-21-8cbbea1cf34f@kernel.org>
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
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Chuck Lever <cel@kernel.org>, Chris Down <chris@chrisdown.name>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=986; i=brauner@kernel.org;
 h=from:subject:message-id; bh=d+yGSgu2S03C9xQeqDtaPfOPhebk0oACv2/eOKg0Vkc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9elyumnaqyWZxzLXpTtpXJb5GHHixO+VpRKQ1z1run
 Tz5M3cVdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkzktGhrd93+pWM9fyhmS/
 MygPf3Z2QtHdrz7etVe7fpe0f5yn2MzI8OdsYFzH1ZNi1otv3d/007j7z8WC0v3yYseyfBnuV32
 aygQA
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

Initialize the nfsd filesystem as a pseudo filesystem. This raises
SB_I_PSEUDO and also SB_I_NOEXEC and SB_I_NODEV. It never holds
executables or device nodes.

Acked-by: Chuck Lever <cel@kernel.org>
Reviewed-by: Chris Down <chris@chrisdown.name>
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


