Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFCC606A327
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ULMYQJnn;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c/Ap+R4z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=B8RQTNfc/eWS72nZHsD5FmaXKvsQcX/MHrv0MZNEckg=; b=ULMYQJnnolJmUn
	9p4/UrhlJfYdZZ8tYBA2ONELJpemW7xolpBP347o6h//MOxsC1GpXJwtlBcTIeqW8Z2PD7KsmhBQR
	IfHz0v2CMcod9+e+gG6/YeygGUUZUdMGUbgZ0+5re6f8ElkkAPzBnEwnJQmKZOAOTk2cHyfhqB7D/
	ir7jZv4ySs0tWmnrr/Mjz2A5aODgCOqvSgXnK9E0HhFDcvL83ubC30dZI2Xh0U24INgwTYUvbiolW
	Txsp9AUuyzQO6hJ9HdKoHGAvbo5+2dWsBHHr9D+8+qJx3uRdZQTeU0GjNixVTur+XB924elzYDw7p
	SawApZoAta9eK6otXOfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFh6-00000007jSn-2D30;
	Wed, 11 Nov 2026 21:17:24 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQhzv-00000003EY3-1lHl
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 09:18:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1FE2D46A87;
	Tue, 10 Nov 2026 09:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20071F0089F;
	Tue, 10 Nov 2026 09:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302315;
	bh=B8RQTNfc/eWS72nZHsD5FmaXKvsQcX/MHrv0MZNEckg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=c/Ap+R4zFMvV3/8vcuIEPdB/Gt2XHUlHZTBEX28zCRTGUeuDJCvLmXS2bTYSdzi9R
	 0gr12Xdu/wNWC4bbLqs4TiHsR/YcW9JNs28CEkwEGUBB6TGWOirP4sbeOuKd4a7tZW
	 afM3jYlHN6+MVYSwuAcf1MRkadLxCZQa5Ry8f4ildqJfo+Wt7K+lGKrO7TizAPDeis
	 lj14KsNBHSrSqgHUxSQyH2WPPe6YEGnglY+yEWWsL8vk8c3l5TKaUlKahI+HbhISLF
	 nnD6YXeLZZD0ZUXVgvIwonj2iwv3yWDlAmtq4vfzLGXczqU+vQuxgOQWxGbajWp8T+
	 zqYWbwys3SKng==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 10 Nov 2026 10:14:39 +0100
Subject: [PATCH RFC 23/41] fuse: use fc_init_pseudo() for fusectl
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-work-loop-pseudo-v1-23-4c998976c6c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=893; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hjM1iJ4vU3paA5L4OQPDkADa3AqUdKJFLW5EmBnT+kw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9erCuT2albMuTpuPqTDYzVbc45F0XFJ6y9xJTg/iJB
 vndWrxNHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPh02ZkeGybnbLv4dlnla2P
 zh+U1FV/fVEjuEXs+QzeMzuWCLwPtWVk+PIs8Nv5vXPYWX98mZbrdj9iVbPCut91O9M+rQ7YuNr
 gHTMA
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

Initialize fusectl as a pseudo filesystem. This raises SB_I_PSEUDO and
also SB_I_NOEXEC and SB_I_NODEV. fusectl never holds executables or
device nodes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/fuse/control.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 21ffde596d61..4497362e7df0 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/fs_context.h>
+#include <linux/pseudo_fs.h>
 #include <linux/namei.h>
 
 #define FUSE_CTL_SUPER_MAGIC 0x65735543
@@ -334,6 +335,7 @@ static const struct fs_context_operations fuse_ctl_context_ops = {
 
 static int fuse_ctl_init_fs_context(struct fs_context *fsc)
 {
+	fc_init_pseudo(fsc);
 	fsc->ops = &fuse_ctl_context_ops;
 	return 0;
 }

-- 
2.53.0


