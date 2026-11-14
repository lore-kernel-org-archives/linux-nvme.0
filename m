Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B050606A329
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jzxdiLww;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CPIiv7kI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=YgZhtD2KV2KLabc0QJjPTehcwCNTaDbDvhsPGGFCai0=; b=jzxdiLwwXU3XOn
	HTLsx/2Z8hB1+oyQPyYl04xQyGiMJwZX2sOB9tjt8cmK8HXqMoyTeU+XvOEBo11RuN8bSNy+t6VvT
	dvbFqoKRr8UDOUeFSRYUgaYN8d0XznJNGtxHsl7C4kXH6yLzZYI39/jjSSa6NicbJsWoF2xf87FKx
	ZP2By3ORo9ysGPhH4vG+s4dXKNJ3aJEJlvELH+n4sYDMK0Tt2RcysHwsq2SAThoJpq4vHePD5RN/u
	XF3x8T5JFmC+PYWqQSVMVOQ0pNzPzLqnQ7X1cJyOsBDN523XspFPQc9gOQE/TQSF4Iul7rHWhDYlK
	uJLw73PoKUhFiGCDpKfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSEFN-0000000GBUC-2moe;
	Sat, 14 Nov 2026 13:56:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSDUR-0000000G4FB-1XK1
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 13:08:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 22816418CF;
	Sat, 14 Nov 2026 13:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858C91F000C5;
	Sat, 14 Nov 2026 13:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794661699;
	bh=YgZhtD2KV2KLabc0QJjPTehcwCNTaDbDvhsPGGFCai0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CPIiv7kIlPjOab36ov86SnfUDzmkpfa1Y92A6ehKtlVHTIqCbDbxLaSph+jONs2Tb
	 LSgZlgiffCsO/JpMzKSIo4Bqw7ro2iV+VuM8Lgw5HYeaUVevwna4ucvZdgD7CMfg37
	 v6lx11AiyHvyiNlpYuwzAkQ/BLWonAOXTguqBCXfTtmkLsbiKbpecyzp4FMvOPCc1N
	 LbJbBc74lGhQKkHAGY3nQAZK1Lpq3a+xGFZdBwSAXMAUkGq7t2V92c1ukQypIL4+WZ
	 7tsqPrdqgFICsXG2DDkikpnj/7w12eh8JiLWB/4dRGie0/g6rFv4AHXFeK0Bhpqo46
	 xlxuPo0nSGdMA==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 14 Nov 2026 14:02:04 +0100
Subject: [PATCH RFC v2 23/42] fuse: use fc_init_pseudo() for fusectl
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-work-loop-pseudo-v2-23-98639a2286fb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=951; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OTVHfr96xgBpFGFHGPd9YzWwNGICdkd4ukGHZq7+6V0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9iGnwlZ19N+BN1O05M8J1gxnSpkzRP388jOX8mec5x
 cs60+9zdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyEjYmRYeL2Rxd6LogfN6hX
 6fA32Go6kT/p6w7/aw84omwELm89xs/IcFl3m/5f38aLgdyOZ8p3FPxbt1eR64KN3frP56Qm3mJ
 4xQ0A
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

Initialize fusectl as a pseudo filesystem. This raises SB_I_PSEUDO and
also SB_I_NOEXEC and SB_I_NODEV. fusectl never holds executables or
device nodes.

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/fuse/control.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 21ffde596d611..4497362e7df06 100644
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


