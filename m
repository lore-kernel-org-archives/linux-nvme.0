Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62366606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RmbZfwYI;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9B5RaEQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=WZa8raruWf4jzyZcy4zjAHZiv8qEDUIon9hD96nRur0=; b=RmbZfwYIPXiw1y
	aERBeydbkogP4z1r88fcyR310ciqShN+X9oXxuqGkOgi5xn9Ykr1Fz5wfVumbVM20lAVb4IMmla5W
	mr5dYX29cTcmjSPZSR2Aghl4+Z2ALOjjVNRnN4cjSna5kafxEehyXEFx7PNCSeNoigWyZj882r+lb
	gM0NxAlkfdAEFDLbLN9Zkj2fu+40pWsxk48iDlG6XuKK/15LIMEzvytj/qm2jFhnppWBiQ6/T8LeK
	VtL4qleIUX880qmabsEXPJebBVlxUXz93tCIfLuL2xKHpcjZttWU5bQnwYAk6kklRzwR525YQBLoT
	z2OHae32vgHjl67MCQNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSvzi-00000002ODJ-2I3v;
	Mon, 16 Nov 2026 12:39:34 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSua9-000000027MS-3T9Z
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:09:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 92ADC41233;
	Mon, 16 Nov 2026 11:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643CC1F000C7;
	Mon, 16 Nov 2026 11:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827345;
	bh=WZa8raruWf4jzyZcy4zjAHZiv8qEDUIon9hD96nRur0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=R9B5RaEQmiwsAP1jIczB2zWH7HySjdmMzkng/+3APaCz2aIiR/5pA6QHlhTGPsx8z
	 CRzgX8ndXpYp0sjoyAbMIp1+MxGD+2DAlrY7udq0z+KNdGy7F3kxcIwyC6zbTjxhWm
	 yirFYavZHEFP6gIEwpXBYIN6SxBglphEPLbBaCq7FRAcuqs7D0l1JDGItjul5ABdHB
	 d9KuKk4ck+bWHEQ7LhylcskCqFiUIBf3v15nKwFrhNFGCCv2wRxQdpOvT+/bHvNnrt
	 DnN5kVqm7vTrOkR80gnd3fRgFIsX/hlTkS2T+BoxTB5bUiUfAjvwd6zlckKAgcRgHy
	 1qyB+N2C8a43g==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Nov 2026 12:04:57 +0100
Subject: [PATCH RFC v3 24/44] efivarfs: use fc_init_pseudo()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-work-loop-pseudo-v3-24-8cbbea1cf34f@kernel.org>
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
 Alexander Mikhalitsyn <alex@amutable.com>, 
 Chris Down <chris@chrisdown.name>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=972; i=brauner@kernel.org;
 h=from:subject:message-id; bh=U3c0nafflYvUbB7XCWz+41zdupMknG85VhFAzpOuQl4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9elxl0evIXDdr63nf8LI7X+5e612rf6tTU7lporhxj
 mdZts/6jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl0/WL4K3elzLjM+M6M+brf
 9/5bG75Vlvfsk9/+7EWxqyIett05Vc/wP8X9yuP865WvUu2fte80N+1KFXWeciZ+5nF3c9snSkG
 ZTAA=
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

Initialize efivarfs as a pseudo filesystem. This raises SB_I_PSEUDO and
also SB_I_NOEXEC and SB_I_NODEV. efivarfs never holds executables or
device nodes.

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
Reviewed-by: Chris Down <chris@chrisdown.name>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/efivarfs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 12746ced6dc63..e598d42c5f42c 100644
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


