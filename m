Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431E6606A32D
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uja8n1AI;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RP6bdqxg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=PsEZAEo2EWjwlrQyS8FDrkYLrSxc4EoXaQ3VAa3T0to=; b=uja8n1AIAUTP9B
	SWAw8w84rThpJZb/ScIXDwN5/sdY/DvidbWURWaYz9ZsXobKeSqjUC9IK9T5q3ZDLEXWbaIiHkHbm
	3waFEEYGDJJ1kuGB1BOIMRBYVCH40TcJV2hGraVGnuCDBU8QxSahDzk5DWuAaPPb+zoEkKDkf0KKA
	eH3b/fucBZzAhK/g7wfcDCkLqQUPNlQQTCTNR4qwlAdqjgkNQHzwzuA7ualW1cb3Y9ki6mjv7HJOc
	zueY0sy5Qqap8Y6pTeZOTHku6omrEMwyPzm9ORR2mU2aBmqdjINcZTwXKmVnI3p3jDFgRDAw13VuB
	Cbn/K36IvqSsWMHpsQ0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSEFL-0000000GBOI-2HBk;
	Sat, 14 Nov 2026 13:56:47 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSDTs-0000000G40i-2UMF
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 13:07:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0EA3F6272D;
	Sat, 14 Nov 2026 13:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254A51F000C4;
	Sat, 14 Nov 2026 13:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794661663;
	bh=PsEZAEo2EWjwlrQyS8FDrkYLrSxc4EoXaQ3VAa3T0to=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RP6bdqxgYdTOvKQFb6NUJlAnzP0iuFZn14JV3dopj4eOhvt4mal1MYZtl7BQYCoxt
	 w45XbT2grNM6Qg55/tsCLUdM0CQBOxLR2Kunja7yy54lP9Qfg63cbpj/uCek58LMdr
	 2g0icThdvpsN4HTsfTKz9VeiMePWjWf1Q1K5NnEjU8lTRxQrEHOb8z5qeiSteKne2v
	 cZsD/rPxnGg04mAtEBHiWHv5l/XXKkWr1ku1sBIHTZe1CFwHTqP1ghScoLp+fr2OPo
	 fJrxBzLLgHTvheGhtWCqgnNRz1198UueTs5pHbgLcHIkedb4JvrikevLf2qm5DDpBH
	 /871dihUSqoKg==
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 14 Nov 2026 14:01:59 +0100
Subject: [PATCH RFC v2 18/42] selinux: use fc_init_pseudo() for selinuxfs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-work-loop-pseudo-v2-18-98639a2286fb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1689; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Eg4JynB39S+cJriPMxPoEFKswaAikvmz7VyAKkVX+DM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9iKlyMVy9yP1TKKNxrIjSmW/cGdIrJik/frn0dv3to
 /8K4+ukO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSMIHhv2uEhSiX6eXHduxb
 hf4+qrT5tnTptBUl2zO0TXL7X/736WFkWNSWEJ/+ZOJcg73v3vA+s01c+03lUdAuJu+uVeeshCM
 ymAA=
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

Initialize selinuxfs as a pseudo filesystem. This raises SB_I_PSEUDO and
SB_I_NOEXEC. selinuxfs never holds executables. SB_I_NOEXEC also
refuses PROT_EXEC mappings but the status and policy files are only
ever mapped for reading.

But selinuxfs needs device nodes. The kernel replaces file descriptors
with /sys/fs/selinux/null on exec via dentry_open() which doesn't care
about SB_I_NODEV. Android init however opens /sys/fs/selinux/null by
path as /dev/null doesn't exist yet at that point. So clear SB_I_NODEV
again in sel_fill_super().

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 security/selinux/selinuxfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 310e19efff1d0..d7ae853b6d685 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -18,6 +18,7 @@
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/pseudo_fs.h>
 #include <linux/hex.h>
 #include <linux/mount.h>
 #include <linux/mutex.h>
@@ -1852,6 +1853,9 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 		/* last one */ {"", NULL, 0}
 	};
 
+	/* Android init opens the null device below by path. */
+	sb->s_iflags &= ~SB_I_NODEV;
+
 	ret = selinux_fs_info_create(sb);
 	if (ret)
 		goto err;
@@ -1955,6 +1959,7 @@ static const struct fs_context_operations sel_context_ops = {
 
 static int sel_init_fs_context(struct fs_context *fc)
 {
+	fc_init_pseudo(fc);
 	fc->ops = &sel_context_ops;
 	return 0;
 }

-- 
2.53.0


