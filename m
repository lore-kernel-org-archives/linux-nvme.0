Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78660606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4j/scvNJ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eWqStoTx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=QuUCHwL/BY1T2vLOc/gPlh6w5Yz8cRxgbnaJubMSr1o=; b=4j/scvNJY3cH9s
	89Ddk6li+TXrXIIyKVtwWscoDghLWqb9ggSKsBXECTJk0fKUjXAnPvPzrmYmBIimfTWYhR7/0/P6k
	MQZeTqVsmRZe+t1yhcsuIPV61V3XJUrY/4xIXxSPKH01uPlZLk/5SO/+PT5817E7A9SF2qwhepCI7
	zXdBju8xuF2S9yhtZEU8oXgBBDLDCSrzortB8GQDa894x1ERPRuuMzrq3Q+jY4ZnMB2jk1SaAUYWI
	K8N+i+Y+IrVFfPYImeFyo+eBFrZP9/vS5fnMdagUXt40ar1eVPAEKojPbEDn72LhOGAwAJUdWrvwU
	uhisN6PO0fweaTnOdpPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSvzk-00000002OM4-3ueG;
	Mon, 16 Nov 2026 12:39:36 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuaW-000000027S2-2DhZ
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:09:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 003036292C;
	Mon, 16 Nov 2026 11:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D331F000C4;
	Mon, 16 Nov 2026 11:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827367;
	bh=QuUCHwL/BY1T2vLOc/gPlh6w5Yz8cRxgbnaJubMSr1o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eWqStoTxh4NNpgnqJQAbTvc3F6THAiwGDN4VqPjGqWwxK7grKrhzbpvrlHik7rWGw
	 LmyHVzhO9Te46cFwbrOlUqPQT0oF/HXwwsXx3MMepT+0OdecMLBteD88v1YwtZDrjb
	 AXsRBPgBjWNowMrMKNpm7VyBaHOaIj2F5J1wA9g6lYlollu4Lr9qETGzAR3sI2AGOJ
	 TSaw2eCAkAKBPUtB9DzHyshTTMIy6e2o89WZ3qLFdUdLDNqsf7hoK4MdFxBxrCMMKa
	 uJI1F89qP7iitUo0oqG6za1D6pwPB3mJIgwX+N8gUTguZ5WCHqvLiCThVUudhF+1hf
	 dv7ajSbH3o8+g==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Nov 2026 12:05:00 +0100
Subject: [PATCH RFC v3 27/44] openpromfs: use fc_init_pseudo()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-work-loop-pseudo-v3-27-8cbbea1cf34f@kernel.org>
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
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=932; i=brauner@kernel.org;
 h=from:subject:message-id; bh=t/2kRMsiGpRT6NTAIUV0TfnxBeUt9A+YVEprnQjtSPo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9elx35JxdT7pgb6K/ULzwVsNHP8XWzVsVbHLnnG5L8
 e7oO9JLOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSYcjwP2Wj/4MPiqKhcgc/
 6/xyjMmNPSASpr2muGTZGal3tfctShgZfp7MXfTHwc5v6+RFB2fUhtm6Ocdt0Pvk2nTfzPHRZid
 ubgA=
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

Initialize openpromfs as a pseudo filesystem. This raises SB_I_PSEUDO and
also SB_I_NOEXEC and SB_I_NODEV. openpromfs never holds executables or
device nodes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/openpromfs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index fb8d84bdedfb2..6cd02d456bac9 100644
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


