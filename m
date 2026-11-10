Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEF3606A339
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CbSB+j1Z;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bev5vsoQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6F6bixX9VLJl6u/N0LxDxdpy5DWNAw9MIo1FfuiWwlg=; b=CbSB+j1ZhCzuTL
	i1AuuJyrzHOARipyUE+N+2my4jfH0o0wZyeKbMWWfJ1PAIzyJv3/TgJf06hThS40vH5ivVeX9a/nm
	wcfJJEEsSyL/sXrbyVI98RxbSRdG55yXvpMdj6f0/Erurs6iE9mgF3w1OsRjkh/JQUOXCOYfE9FsM
	Ty4e74I5SbNWSDHaE5aqf8EKCDj5bRHU4w+kDaeH45OJtZLZj627jA1r09tuSoiJ4yRg7uOadqSvZ
	K3mpzcSdu13nMUP77lQpQtUik9tYB8HCc6iSeJZzDpietLaLBLKz5mFQhVB73D+VDPeruGZ8w+Nof
	2PX8yIxaIJAc4JRe2lOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFhI-00000007jxm-2L4o;
	Wed, 11 Nov 2026 21:17:36 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQi0v-00000003ElP-1WtN
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 09:19:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B8C0063823;
	Tue, 10 Nov 2026 09:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F84A1F008A3;
	Tue, 10 Nov 2026 09:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302376;
	bh=6F6bixX9VLJl6u/N0LxDxdpy5DWNAw9MIo1FfuiWwlg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Bev5vsoQXMD/2z11W7fF7gnr2WOAFCcu91VLKw23i7E0hkqCe1dVrhYy0+KtPJYmF
	 7SwxXGH2SnKEaJ3Gz1JJnuTNJfiSNXCHsVfu0NtJiKPNIwpXKj4acpNvaSgQsC1nOn
	 v9D9W8uBh3avkK864v96nnYuhV8CQ/YD06yiqjObPD/ts1Fa3Yra+s2JNGu1CbzXmf
	 lPoZDKOPKjIY0m0OaT8lZr1lUKx7GexmZFGHwmRV5+QIhPZ8mbIcDCb3vCEt/G7Jt7
	 jjMDsVbCi3OviaEyzsMqCkhdh4WJddoN0LSF4ef8DVIGv0E0SDkQwiCi9hK2AdSt56
	 Gfxo6evUdhVLw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 10 Nov 2026 10:14:48 +0100
Subject: [PATCH RFC 32/41] usb: gadget: gadgetfs: use fc_init_pseudo()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-work-loop-pseudo-v1-32-4c998976c6c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=980; i=brauner@kernel.org;
 h=from:subject:message-id; bh=HoqM8TovkVWXxEHW73GnjomtfEF10WO79IJ99ILFhZo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9erDTyDeb75KLVcD+3CmXFA8amrwrV9AreTDj+7Lby
 8T6ktIfdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkdS8jw7y61UWZSuzH/CUD
 K7cIZcU05XC2Bbk5/nEKXnZy8lbXBob/3nwJfl+n25nnXWg+epP78Jz1HcW8OwRzuVKbKsKnfvB
 hBAA=
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

Initialize gadgetfs as a pseudo filesystem. This raises SB_I_PSEUDO and
also SB_I_NOEXEC and SB_I_NODEV. gadgetfs never holds executables or
device nodes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/usb/gadget/legacy/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 7f6d8460152f..8490e5d0351e 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/pseudo_fs.h>
 #include <linux/pagemap.h>
 #include <linux/uts.h>
 #include <linux/wait.h>
@@ -2223,6 +2224,7 @@ static const struct fs_context_operations gadgetfs_context_ops = {
 
 static int gadgetfs_init_fs_context(struct fs_context *fc)
 {
+	fc_init_pseudo(fc);
 	fc->ops = &gadgetfs_context_ops;
 	return 0;
 }

-- 
2.53.0


