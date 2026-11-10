Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E738C606A32D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AhUZZNhn;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XU5FYslU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=V9O75TKfTcHeHVPMLenNiZqGn0S/SDcuL2HVenCDHeA=; b=AhUZZNhnKvrRww
	P+MUuh1Yhhn/Vb+pxHE4S0AYDc33DugXwFyijnkH9mJ2iGOioLgtfqEj7HAqaZ81aYs5Y7/VfTixO
	SthhaqZvQiFjHw9NXONUYl1TZc4D3mLJ2RatGd45+F27fTezEuifiyBpqlMRe3N2Ejx5y4VpkDTBa
	QwGsU69Tm0L5a1qmPsb1NcsakpstaCMl41otOCbwLkqTNnWd62y/GWe6hrWbmUUGb26SqRCsW6Ken
	JPJiJGt0vZNeDCXgo8dtY5Q2D8+FOt1q0cHijiktXea4RyNrFaI1b++5+Uw6uGAnU5PzNsVNgy0fi
	fqfywDNzOkxtAUv6MmWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFh9-00000007jao-43SC;
	Wed, 11 Nov 2026 21:17:27 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQi0M-00000003EeU-2LLH
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 09:19:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 52889435BA;
	Tue, 10 Nov 2026 09:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D685E1F008A1;
	Tue, 10 Nov 2026 09:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302342;
	bh=V9O75TKfTcHeHVPMLenNiZqGn0S/SDcuL2HVenCDHeA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XU5FYslUu/QycaxvYDsVfiLjksSb23n6kAsx0C4TwSSMJEdkUorbOifqhqCOqU1BZ
	 tmBnCWeUwFgQQ+4ZAkQAk/VjPzQ+RPHW3/AblZyzH50Bb47hCUnqPVxJ/GU4Mc1JiA
	 5FFUIjTt/J8XmL5z4nM4R0/u+A/O7oMn8+99R0NQQoD9YRGpBmk26SOy2wcjejpGHl
	 mr0KKFrE0VjNzX1I+Ubt/meHZXfZj8kp1B2dkcgv3kCLJkAik/ieVBt/S0jkqQRk4B
	 ZyDYntU3Wf2Vq8yKC7h12DmuYinSiJ1I+4nWRIhPcZEmr+7PkRUVFiiLnUd0MB8tP5
	 IiA+GGSFyG75Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 10 Nov 2026 10:14:43 +0100
Subject: [PATCH RFC 27/41] openpromfs: use fc_init_pseudo()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-work-loop-pseudo-v1-27-4c998976c6c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=930; i=brauner@kernel.org;
 h=from:subject:message-id; bh=HbK9i4t197PzSxP5CKS5JO7XvQ/k806ZQREmy2rg/1Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9erB5yxKrdqWdTL6/ROTOpHFZfYk8FvP4V1D53MDzH
 Vaet0xOdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyks5eRYePLZ35LS2WzX6Wn
 +D69nf1re86D6lp5E91F/Asahdd+rGb4Z1YXc0BUZ9rZoskiB0RU3Nyq0xSNReXOZtV9XNcYHfC
 bAQA=
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

Initialize openpromfs as a pseudo filesystem. This raises SB_I_PSEUDO and
also SB_I_NOEXEC and SB_I_NODEV. openpromfs never holds executables or
device nodes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/openpromfs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index fb8d84bdedfb..6cd02d456bac 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -10,6 +10,7 @@
 #include <linux/string.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/pseudo_fs.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/seq_file.h>
@@ -419,6 +420,7 @@ static const struct fs_context_operations openpromfs_context_ops = {
 
 static int openpromfs_init_fs_context(struct fs_context *fc)
 {
+	fc_init_pseudo(fc);
 	fc->ops = &openpromfs_context_ops;
 	return 0;
 }

-- 
2.53.0


