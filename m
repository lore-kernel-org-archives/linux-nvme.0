Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79879606A339
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lgCEwa3Y;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KN56aSxE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=V5BWJw5fa84POo80x3ibKreEFrHi8L/+0M4nKiAomaU=; b=lgCEwa3Y/esHee
	qGjmJTY5VN7JCSMOb3hgYsedrTQoQh2CGE+E7YvTYK3um9KFn54EDXgQAq361wQmkaCkpUgEgGVJh
	HqR5lzbCNZ0A6pPIP1dIC4OfkP4Bfl2Ug+fESjedZEpf0/vfm45bo04sDTEZZ27GbdCaIStdPNPLL
	NqufNULl1QDOJnEpBjFjGkANl2GvErB2nhhHm/xwoU69ikWHYT8W57K5+O7LRl2hxIf0guZCCsUN9
	vtmCa7D/PEuI3D6GNs2SMs7R7yge4Gec7v2TM1ZK4PLiawosfpNsPBICesLdX1VbulYqeNgKk0DN2
	LlfkOnWbPGtOum6wtrLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFgp-00000007it8-27Z9;
	Wed, 11 Nov 2026 21:17:07 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQhzG-00000003EOs-0UwQ
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 09:17:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DB08A4359C;
	Tue, 10 Nov 2026 09:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BC01F0089F;
	Tue, 10 Nov 2026 09:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302273;
	bh=V5BWJw5fa84POo80x3ibKreEFrHi8L/+0M4nKiAomaU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KN56aSxEcIL4HezFtJpqamXDQkWCizrnZgnkUMIpPJsU7rRuUGbPuKCmoeZKs9Z8T
	 KX8yIwO5M/hIAuohYYoYuaalWbYYVGCWyj3OPI2eTlBmHabq5gQXT0Q9S0rZ4F3ut5
	 C4zEnhc+UMJ2cgIQGGeaEL+qrQxNqtC4KAdzr1uwPXxDiu2A5V9MYGtecJfiijcWEU
	 2ZNMp5ydhnhMaivDafrR5m7QBhsQux+h3Tx/1FbSjFTpvpg7tD2QL9hYdoAqvzBL6y
	 XALD9so6bBSasGgjOreqMXh2TJ7gKHcAOMhp27y+3npGTFNV3GX8PCI5KY5SzKdsrT
	 HZkVBu2EyzxNA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 10 Nov 2026 10:14:33 +0100
Subject: [PATCH RFC 17/41] securityfs: use fc_init_pseudo()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-work-loop-pseudo-v1-17-4c998976c6c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MwHP9YE6cjEfGAuH1dNASl/A50wevLh7f7bfLWi2WsQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9erD8krTE09Ofz2cIRrPJrvxZXfW5i2mz60HLaz3/t
 aacvaGV01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR0ceMDF3dd12/pYZrKTE8
 Ycgt3jlH/vK/wh9r1zpfPu+pqC78O4rhJ+MXzsV8icqCDBsCp8j+vcN8x+XyLeYvblvbTnJ6hSb
 MZgMA
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

Initialize securityfs as a pseudo filesystem. This raises SB_I_PSEUDO and
also SB_I_NOEXEC and SB_I_NODEV. securityfs never holds executables or
device nodes.

AppArmor puts a .null device node into securityfs but only ever opens
it via dentry_open() which doesn't care about SB_I_NODEV.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 security/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/inode.c b/security/inode.c
index 080402367674..93997a9f16fc 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -14,6 +14,7 @@
 #include <linux/kobject.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/pseudo_fs.h>
 #include <linux/mount.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
@@ -64,6 +65,7 @@ static const struct fs_context_operations securityfs_context_ops = {
 
 static int securityfs_init_fs_context(struct fs_context *fc)
 {
+	fc_init_pseudo(fc);
 	fc->ops = &securityfs_context_ops;
 	return 0;
 }

-- 
2.53.0


