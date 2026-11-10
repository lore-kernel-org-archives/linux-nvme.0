Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F92606A327
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lKSr1MFl;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DuW47WKH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=uO5ZhnwfrBSeMm3rjJlHHLu0PoUagP/7+NgvInBYUDY=; b=lKSr1MFlOKTe/a
	MCwNBCPx82GQiu98yiboMmlgour9zsB4HF7By7aVcjEUNi+26ZhgWI24S7/BGscVTGwtHyKAg8vrY
	KpcuMbDLEaV2QdtO4APSDW8WkCd/i3n8DVIbG/RRP1kkXr1l3sF1RFaYU7QybIWF/al6VN4Nc7MzM
	5s3mesAkRplPFUenSVDXEhq+j/mOM+37RT5cCWB+9/vB19ROhUkZUr52tuDJeFlXoGuFSG18E73/Y
	HeTGQ8QN3FSwqvwpbTg0BDEoivFkgRUw5H/1iUGEBJvCb4BxqpXDERAtFA4hnDVzG5B6vARz4vFWM
	VwLJw9phLDMRLBgnP+vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFh6-00000007jTx-40tY;
	Wed, 11 Nov 2026 21:17:24 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQi02-00000003EZS-0nRj
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 09:18:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E3D354135B;
	Tue, 10 Nov 2026 09:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751691F008A5;
	Tue, 10 Nov 2026 09:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302321;
	bh=uO5ZhnwfrBSeMm3rjJlHHLu0PoUagP/7+NgvInBYUDY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DuW47WKH0NVzTMh/ahwIWKCilxMxR/d9WzG6ER2dp1mTlW6J1MydE1ZvojfSEZmpM
	 uq0lOj+04qYr2LzZD3LTyEm/+Q92gXEaWwvE/iC7G1ulkggahwu88Ns7v4dd7rnO1G
	 naiygZWzOW8Ejr8jN4j4xWgI+lP7+fWJ/2fBG3q7EDC++MqGUBA1hoyiSEnV+fZYuw
	 hy1tvAOwTNHmlUDoF9ANy8eJuZMUnkycIQm0mbN+PVarFn8O73zcdijbpCI2OxpOxD
	 vHWGX2o5WnjZZ/WfXN04GoN3Kndnr2IYwMYmuMbejP3d/XSHugkw6zesVSwCCkxyfH
	 te+Gj4JjZD/Gw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 10 Nov 2026 10:14:40 +0100
Subject: [PATCH RFC 24/41] efivarfs: use fc_init_pseudo()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-work-loop-pseudo-v1-24-4c998976c6c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=866; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RLuH3jkZQnaQmTSPi6KhFuQtT0Hgw2AWtcSWTkbVq0M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9erDe5Gh9x1THa+rmx4Rlvmxo+ui4+yFfq7/v4xonh
 odTCnlVO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYiNoPhv8tvZb6ttrc2vz+u
 s+BZwas9Hb/lZN55FfU3872JMM9paGFkmF2qMIfj7/yA36ELzpv87npr17nsS9Y0JvUP+ZZnWlY
 l8gIA
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

Initialize efivarfs as a pseudo filesystem. This raises SB_I_PSEUDO and
also SB_I_NOEXEC and SB_I_NODEV. efivarfs never holds executables or
device nodes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/efivarfs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 12746ced6dc6..e598d42c5f42 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -8,6 +8,7 @@
 #include <linux/efi.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/pseudo_fs.h>
 #include <linux/fs_parser.h>
 #include <linux/module.h>
 #include <linux/pagemap.h>
@@ -554,6 +555,7 @@ static int efivarfs_init_fs_context(struct fs_context *fc)
 	}
 
 	fc->s_fs_info = sfi;
+	fc_init_pseudo(fc);
 	fc->ops = &efivarfs_context_ops;
 
 	return 0;

-- 
2.53.0


