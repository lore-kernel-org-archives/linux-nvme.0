Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD16606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2TIovoay;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ThaPefJk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=/UpKqXd1Q8PiwEiW91lGeEUdsRaeGgHVBpYK/fx91FQ=; b=2TIovoayeABMee
	9latdEEMq6af90nWUr5jwUTys8qtYRsYmAnOWyPwiqV/r2qKad1m62hRz7uJH0q+g2i3Vogb0q0vU
	7OkECspYngwoHuQPhX26lStiGRtnnNmz6Futjnao2ibgeChR+4a9rp+F47prL4NF5vOojdsTTpUgT
	hlONAa+eYgbCZmYbCY7fXLC50/bdCC2WDVff65it3CMnUXdQGnHDYkH88wEGzzJVNO5D5DRG2K/JY
	pn5JLPuqM12WwH9XjKcVTtGpnPKRSWg1l95c6EFVwISSJBlX1ZKPVk8k1eyGActlBH/E7hnlwwTyy
	2fWZ4vzOX19Y8MI4mL7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSvzZ-00000002NqE-28ZX;
	Mon, 16 Nov 2026 12:39:25 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuZB-0000000273T-3AzZ
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:08:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 82E44462CB;
	Mon, 16 Nov 2026 11:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E153D1F000C4;
	Mon, 16 Nov 2026 11:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827285;
	bh=/UpKqXd1Q8PiwEiW91lGeEUdsRaeGgHVBpYK/fx91FQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ThaPefJkzYID6A/gJ8BD95JHrrRcoJDueFApgfCzzf6m8AFEdrOPX1V/N0Ou5MSFE
	 3MisKv2jAnh8Lq68niVuDDcQgUlU9KBmq1TWQenImwyQsFWqYvNjMCUA6JECgAVC5Z
	 eCzHZrAVshZEsT9OLL1LKL8EXLhOWYBuwDyPsI88o0Rflk04BSpkmzvraWAQ+wW1P4
	 lJTEA6hSyLJvmV54IXpt4SUS6mx/j+/M7f4C24pf7Qhx12uczYw4UemP32oaW2sS5n
	 2peCadUpW/SatJlkDR04CbDtgimV2EQJ4ss/0BvVQFYbPY9qCuNlO9CEhSFfF6dtOq
	 nUL3+tjJpm9Gg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Nov 2026 12:04:49 +0100
Subject: [PATCH RFC v3 16/44] configfs: use fc_init_pseudo()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-work-loop-pseudo-v3-16-8cbbea1cf34f@kernel.org>
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
 Breno Leitao <leitao@debian.org>, Alexander Mikhalitsyn <alex@amutable.com>, 
 Chris Down <chris@chrisdown.name>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100; i=brauner@kernel.org;
 h=from:subject:message-id; bh=arBHZovnHktbx+8dxEhh1iDCO+7a7q/uQBzsyfGCKl8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9elz4yo7/8fTyqPtLu0x0Zv8tjtQzyl68wOHUusK4U
 1piFu/4O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayW5nhn4LuCbVth/nnv61W
 jll948YM7hL1TRmv/gSG7k93fv59SRTDP6tHgrPsfflmcXKeOZ47jc/ugU3PlsV14pWbp3dNO/K
 lkwUA
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

Initialize configfs as a pseudo filesystem. This raises SB_I_PSEUDO and
also SB_I_NOEXEC and SB_I_NODEV. configfs never holds executables or
device nodes.

Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
Reviewed-by: Chris Down <chris@chrisdown.name>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/configfs/mount.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index d8cac1cbf3bd5..60ba24e7ae2b9 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <linux/fs_context.h>
+#include <linux/pseudo_fs.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -106,6 +107,7 @@ static const struct fs_context_operations configfs_context_ops = {
 
 static int configfs_init_fs_context(struct fs_context *fc)
 {
+	fc_init_pseudo(fc);
 	fc->ops = &configfs_context_ops;
 	return 0;
 }

-- 
2.53.0


