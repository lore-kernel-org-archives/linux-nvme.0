Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF8A606A334
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=s+Qj8UAo;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hCKnpX2L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=h94mIi/imn4D3waXvt8ZAO8zbcvNeSGH9zaPuRN/zFo=; b=s+Qj8UAoEbsb8B
	sKEPR/oA44Wt/2EpHieao/3CXJibl8gZ9qbKz8RArRRnsBu26+dvzDE3sNmizq30y+iJ+HXiUle/9
	NGEbJCsAEj26VpzZOKgL+fm+8aAqewUETXP8NqSNSzEOHxDUqiq//SJtFOaGukNpiv4b77cY/uG0T
	7q915RjrGmKam7ZdnW1dVLruqJuJdUxbJF8ardSbffMqJzTpuDU7YBK47rDM4MIAG+nRSIiqKgljL
	3XXwVe4tCOExaU5IA4ZpIT55nckzo9JXUwWdIHmSFgvJx+cBGkHc7qR2CSS7w+eSqABm+wu+D0VKN
	Utz2OUYQSQ4nuzb1WgOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFgo-00000007iqN-3UBT;
	Wed, 11 Nov 2026 21:17:06 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQhz2-00000003ELW-3kF5
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 09:17:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 575206351D;
	Tue, 10 Nov 2026 09:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD6F1F0089F;
	Tue, 10 Nov 2026 09:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302260;
	bh=h94mIi/imn4D3waXvt8ZAO8zbcvNeSGH9zaPuRN/zFo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hCKnpX2LMq/yIBVu+3fedTSWRzmEiUKg05k70/cabSsZyN0V70DQNw0habLh5Rp3N
	 c956FUO8f5KMtGhmwZF6JaNrD5YNWgtZGhi2tRzcc2lZ8L4JIxwL79H0b3tBFB4IaO
	 XmqyiHmmqPdau5vX2eMWUrlPCMnRhkbqwrhqOEqbuhQuSJxQhgZLHlWLkOa387kF87
	 c2QE631FmWh521q0EDzd1BLKeXN0jM2x4hEbJfjU0RuxAt/DbvL2B4RJaNxjRNgwuN
	 sRHkcU5kSCaIM/R/aSWv3TJjb6hXOJ6l+gef1isFdWoX5RRm93+0TI6pGc9yKYqXGJ
	 EIZJjyG5YAQyg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 10 Nov 2026 10:14:31 +0100
Subject: [PATCH RFC 15/41] tracefs: use fc_init_pseudo()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-work-loop-pseudo-v1-15-4c998976c6c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1051; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nNHku2orMRQhrPcnxhaESkf9+5yEVey8qH80JYuUurA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9erD0RXLTJKNzrh5L9mkY/O9J+HRKY33C443/9A4Lr
 21xrLd+1VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR+R0M/72Fl4jGuvHt3/5x
 u7NfzPNpdcsMM67cPHfs9ommtv7O3i+MDBdi/75YKJwQsP/1zN8L3y7I88yZX64y724L9xZhYx+
 hQ6wA
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

Initialize tracefs as a pseudo filesystem. This raises SB_I_PSEUDO and
also SB_I_NOEXEC and SB_I_NODEV. tracefs never holds executables or
device nodes.

SB_I_NOEXEC also refuses PROT_EXEC mappings. The only tracefs files
that can be mapped are the ring buffers and __rb_map_vma() refuses
VM_EXEC already.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/tracefs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 5020365ca704..e04febd868eb 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/pseudo_fs.h>
 #include <linux/fs_parser.h>
 #include <linux/kobject.h>
 #include <linux/namei.h>
@@ -510,6 +511,7 @@ static int tracefs_init_fs_context(struct fs_context *fc)
 	fsi->mode = TRACEFS_DEFAULT_MODE;
 
 	fc->s_fs_info = fsi;
+	fc_init_pseudo(fc);
 	fc->ops = &tracefs_context_ops;
 	return 0;
 }

-- 
2.53.0


