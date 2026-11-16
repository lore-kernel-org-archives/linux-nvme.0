Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24625606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 12:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XDPOHW2c;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SGTpzw+u
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=yVy0s500r+s0cQTnrdL3iNQJg4cLMTqv2Ys59F9WF6I=; b=XDPOHW2cftbzJi
	azhiUegPgDGbY4f+0e1xolVFNGrdtWhqpf2l7Ck3s8CAGnKg1/zjzCdygZmH77QGJI1VqKPas4zga
	S2OejnOez4nO8jV5gpwFXX/KrtdrFCWGrsuWrI3jseSGMMPBiQvkNDCQweDHXSkaVCQ0ww6M0cxfE
	PFVTj3zja3EZOTOHv2c2V77wXCMwLPt/Marvb2iT8r7fqE2y0q58bTMxTYS8bOR5D4qZntSdxyNJm
	ay9/U0d2yWFHRzyuIUH4O23clvh7WbWrDjHPpf5wGcsYcH2fcZN/mpAjic3ojtXJDTXBUWaFS86Rm
	5Iq8qPfRJXX0/3XSFIAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSvzr-00000002OgS-0Piy;
	Mon, 16 Nov 2026 12:39:43 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSub6-000000027g9-3Qmw
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:10:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1B75362894;
	Mon, 16 Nov 2026 11:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1B01F000CC;
	Mon, 16 Nov 2026 11:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827403;
	bh=yVy0s500r+s0cQTnrdL3iNQJg4cLMTqv2Ys59F9WF6I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SGTpzw+uOaYvP/qWVmonGrGKiT2oLbT2udCcq4O82u3mG1fLwCQ9o8RLyYUJt4Z2Q
	 dpAapsEVRxr6oLO/o2rGmqb9CAmt3ErlRs8wAxbEiyz6v0DU4LBOoVm5BMqcicnomC
	 B8WEPz6Gu99rGym2zbIvLEILBo00aGvsodfuAxEMd8k/D48PrDTO0QuTGdS8US31n4
	 Vg8bRB/rVTd/Yp5SFsM+N5GWLqI4Smmmis/xMColxtYtlNVNFPYfrZpPd5XgHFtufK
	 ewpaVp+9XS6onapcIs28W27un4PxSx+n0soDqly36XgM/Z1PmufEv2uBMoEdpSk13h
	 SXrkbTRXnHaqQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Nov 2026 12:05:05 +0100
Subject: [PATCH RFC v3 32/44] usb: gadget: gadgetfs: use fc_init_pseudo()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-work-loop-pseudo-v3-32-8cbbea1cf34f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030; i=brauner@kernel.org;
 h=from:subject:message-id; bh=u0nui1vhf/EmwTq6q2RWgl78HrRK/CPPLvMnc/CZqnI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9etws9fufFq9729RbGXNDfxxYdCtSQifp+r0vMT801
 iTNP1vv21HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRn48YGT5xPd4gYXzpZPj6
 D6f+qX0Qv9TBUcF6ePfLds7DTysVTzQx/I8rXd4sEjq3bduNK/7X+v/Kqk9YyOWe3dsRZqm+TvT
 IXF4A
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

Initialize gadgetfs as a pseudo filesystem. This raises SB_I_PSEUDO and
also SB_I_NOEXEC and SB_I_NODEV. gadgetfs never holds executables or
device nodes.

Reviewed-by: Chris Down <chris@chrisdown.name>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/usb/gadget/legacy/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 7f6d8460152f9..8490e5d0351e1 100644
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


