Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C56606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=karjyZzU;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ApAW8mvI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=e7Xf/q0YdYNKT2pliNp65/qzLLmVGTQJhtvNXwy/Qs4=; b=karjyZzU97yMuY
	IkljVDUrekG62Ue1Zl1C/6EriJC5WfSNWYVBMvXm3uQHbmDFKP4+cn63Oq+JDHwnDeop3A/AuDuD7
	5E6UQY1n4S5LeO5Zs6BUf9YSaEnufu1RlR3uWUKJgnXkH1JvE8tLptGG3oxpSw3tG1e/0FhGL1vUd
	7DO6/ZUd81Qkdo+JQhGp5tQKk391u0SCl4JR2ObXYPXk6q+XO879/JiEsewHfoj80eJHDPRg6EwKj
	tyOQXLnwXtvkQ632rnV0CdREzUSqheSQlPQ4MlknMRsDgpLmshb4QM3k2bTenT7nSuSYRzr7bSTQx
	iG4CwYODx36WxcfsjvIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSvzp-00000002OaW-30ZM;
	Mon, 16 Nov 2026 12:39:41 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuay-000000027cI-3BOz
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:09:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 810EA4144C;
	Mon, 16 Nov 2026 11:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711F71F000C5;
	Mon, 16 Nov 2026 11:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827396;
	bh=e7Xf/q0YdYNKT2pliNp65/qzLLmVGTQJhtvNXwy/Qs4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ApAW8mvIJJifAjWYMUb5gxMXy16DRqJm4u8pkiJ8hSizBB/4pLJGRptA/5U9yNxIa
	 xMZTa/pyHHSLFSat1QRBXQMIvBBOH46bkiSC+wCMJ30SJAwiKXLJPAdoQxzZ9SEOBZ
	 G3vlURHcW/ctidW9VnUlrwd1CDDFJU9ArynxTn+S/n0TzxhpLUFcGQr0wD8t5rq7s2
	 rDIEi8/j9EeeO+fKzBSz/q63y3Cnlcjn2qFJEho4HKBhrjQbr4WZA5duS6SFL965ai
	 O9BL7oLYto2CBKxBiOiCC10Wh16aWVflnMPiReBgzJqRNlSQVYcwVO7QDBJErdunlS
	 BdqXVb3PPTzKQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Nov 2026 12:05:04 +0100
Subject: [PATCH RFC v3 31/44] usb: gadget: f_fs: use fc_init_pseudo()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-work-loop-pseudo-v3-31-8cbbea1cf34f@kernel.org>
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
 Chris Down <chris@chrisdown.name>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1005; i=brauner@kernel.org;
 h=from:subject:message-id; bh=X0J/CLc/AEot0Nag6LzWBIr3X5UH9CZnU81QaK4NiqA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9etwULH6lXr7MsEdu38TG/l+zfsnXlD8WUt5sYCZW3
 Vn9ScCwo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIBCxkZ2p4+qzvcFp18tPiI
 rT/b+7tri/fcdp/2x+vkHoEL9zk/72H4w7PD3/nLRDHRrO6+e50bLORVnr+V233sXs/Uay9DlQN
 bWAE=
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

Initialize functionfs as a pseudo filesystem. This raises SB_I_PSEUDO and
also SB_I_NOEXEC and SB_I_NODEV. functionfs never holds executables or
device nodes.

Reviewed-by: Chris Down <chris@chrisdown.name>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index c64a268e98a43..a6b3788399a56 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -15,6 +15,7 @@
 /* #define VERBOSE_DEBUG */
 
 #include <linux/blkdev.h>
+#include <linux/pseudo_fs.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-fence.h>
 #include <linux/dma-resv.h>
@@ -2166,6 +2167,7 @@ static int ffs_fs_init_fs_context(struct fs_context *fc)
 	ctx->no_disconnect = false;
 
 	fc->fs_private = ctx;
+	fc_init_pseudo(fc);
 	fc->ops = &ffs_fs_context_ops;
 	return 0;
 }

-- 
2.53.0


