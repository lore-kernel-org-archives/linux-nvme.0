Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FA0606A326
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TTrZ1J08;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VFBfo7hd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=nwdvLDg6bh1u0DzBGVwm7FjMDeBdtqjQseAh0xTl99I=; b=TTrZ1J08i1wShz
	AwZ8yXPI4YkFgwdbnOXMlVnTLJYOHUpQ5kPZbmsKfUkhIz9SRgxA7KAoHsUV5f4yfD380n4OpbJhM
	c97uiaV8e1185yWg91Lu/M5qlyWANAa92rVradJ1VHBSjvxK3FmgRL38IFjqigLhUWkxVLi3T2Q+c
	QNjgaOvI7zDxIdEasPNq7pv1RmDU+p3eUPwlycfubY8bc8pmujZqSWmV5532upYxEcKsRYO8Mvg25
	f2GOx5el+V4Dzw3QnUuZi3jDuKV6Xn2uHOBlzs+QB/tJTzC3c38VDnBAlcxyfMhb5acumvJp4z9yb
	V2nlTtau2pnRhPr5FA0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFgo-00000007ipU-1PNH;
	Wed, 11 Nov 2026 21:17:06 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQhyo-00000003EIt-3n9j
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 09:17:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A7682455FD;
	Tue, 10 Nov 2026 09:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458491F0089F;
	Tue, 10 Nov 2026 09:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302246;
	bh=nwdvLDg6bh1u0DzBGVwm7FjMDeBdtqjQseAh0xTl99I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VFBfo7hdp6CeqpCV/lTJ2YVYrsN+l15aUN/nPrx8Rg7U/JoKUXLTS/O+qt5CD668b
	 Tvg82H2hCyRZdK0y09cJVY58Rhl/zTfH024a37WXVgI61JHTo+hhQ4sAK9pYHF9Jyc
	 DzcnFl9SoR42roIHoSyhOt3f1yUXXQ9XEu4wnL6doNmOxGOTC2UxCXLYIJjUWc61Yf
	 k2GkpKuijQrA44JhQn1HQ4PgE/MbIqiot91NvXxjd/Re5Y7uEX3vLft3JgMtpiT0CH
	 /c90C0EJy51OUlGahyRcvr5j+wOW65ab+AmNA2qoyUDajcckrSrMy8qdO+IXNuXqIq
	 YuNNlKf10iZug==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 10 Nov 2026 10:14:29 +0100
Subject: [PATCH RFC 13/41] devpts: use fc_init_pseudo()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-work-loop-pseudo-v1-13-4c998976c6c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=916; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NbjUJKnUFt4/WnttO8t6CLNMaU7LsVpFd2X5tAMzhrk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9erD4sV7JnhvtkV5xL4MZSyqkM9c3WZr+jvrmFegxf
 8Ze75f/OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyLZeR4ZqalqDRG+1nqwtL
 9i369KNsxlvXLdmFi/l7l0SdtWZQ8GL4X312nsC5iU3+AX+yRU57OepI7oo7eS8qNuHM0k+v58a
 n8QMA
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

Initialize devpts as a pseudo filesystem. This raises SB_I_PSEUDO and
SB_I_NOEXEC. devpts never holds executables. devpts_fill_super() keeps
clearing SB_I_NODEV for the pty device nodes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/devpts/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index bd1e8eb26edb..47ef12241d92 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/pseudo_fs.h>
 #include <linux/fs_parser.h>
 #include <linux/sched.h>
 #include <linux/namei.h>
@@ -438,6 +439,7 @@ static int devpts_init_fs_context(struct fs_context *fc)
 		fsi->mount_opts.reserve = true;
 
 	fc->s_fs_info = fsi;
+	fc_init_pseudo(fc);
 	fc->ops = &devpts_context_ops;
 	return 0;
 }

-- 
2.53.0


