Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E033CD98F8
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2026 08:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NRM2XanEsEOH6sv6WnVoUBS9VSMhSgfj9QMZzijjZOE=; b=miSB08fhOKRGnFPHYApNcFkzFr
	1Dd/uJjEgzJJRSxnUVnm563wlDN8xYrsfGiVBsjuDbXDR4oyOnBOlHF8wgNUxDgABbgRSzakQ7SgK
	X2yl8dUBl2sa47r+40R5zDkb3G7O7Ii1ydLrfkyhFUnr799vQFp/9ryWv0e5u8icERQd2z8vo9y4A
	a9/lE8eDj94TFQHvLtKIN8C6tDKarDybBKrATn+fjmXVwec4YY5Wk/2Mh3RULvQk9Ee5cODZCZg2V
	XU/VcQPX6bT0DMM1WmMnoHZxXUEEPXTElY8Hl3qO67tGjacD1mVc+bBQqhCZexWDcx10SCCpmvmgi
	m+td0pjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waUih-00000002AUr-2kCG;
	Fri, 19 Jun 2026 08:36:59 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waUif-00000002AUL-3db0
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jun 2026 08:36:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9FB6F43333;
	Fri, 19 Jun 2026 08:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3051F00A3A;
	Fri, 19 Jun 2026 08:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781858217;
	bh=NRM2XanEsEOH6sv6WnVoUBS9VSMhSgfj9QMZzijjZOE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eQ/Ne6LU6IgiqI4z47tGBrdqO8Y4J/ckzpFP40M3sEGLH8nCQ5tSXMFI9egxQMqRq
	 FcVYIEzTMTXYewYdrWoXI3UvlYa+uQ/tgv0VXUPev0SFF9NrppG5cd07Qx1uA5sCNg
	 +kAiYnIfUNd16WELGx8OSHF2LI7wv9PjoSZha7dJx50cixrvhvV95eg6PL5SKFHgK9
	 z6lu846YwLynKNgQSf5gBhF0wORc4hTLQ5uPYvwoPPez2CyMPOuGiNAIalLDayrl9a
	 DojfRr4XByiRTexeF7RUTME95T9R2YklO5WgiSqV6V92uOxRGg4LpL7U0C0U9vMF63
	 0ZYlOIqGJU5Cw==
From: hare@kernel.org
Date: Fri, 19 Jun 2026 10:36:41 +0200
Subject: [PATCH RFC v2 01/12] fs/configfs: rework configfs_is_root()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-configfs-ns-v2-1-82fd7094b8dc@kernel.org>
References: <20260619-configfs-ns-v2-0-82fd7094b8dc@kernel.org>
In-Reply-To: <20260619-configfs-ns-v2-0-82fd7094b8dc@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>, 
 Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781858211; l=1703;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=ZAltGWZlaXO+9VOilwaR6hdI8pojrV/IucS1y5gTbtY=;
 b=WbjJFZOw00P6X5hbtGF5L//h9H6OdbfJ42ANnIltcKNNfMIMKIG4cqrAfqq4RQFUzJy5VXN69
 zdDEssk4MWQAF1xh8ABV2gBLzxFlQyzM/ny1Ue6N9KnU8lnm3KdM9jh
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Hannes Reinecke <hare@suse.de>

In preparation for making configfs namespace-aware rework
configfs_is_root() to not rely on static structures but
rather use the information in the structures themselves.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 fs/configfs/configfs_internal.h | 2 +-
 fs/configfs/mount.c             | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index acdeea8e2d69ac9d621e1a42b039719811c31757..6261e1f3ec201a58a5d46b08dfbced8c2a44d82b 100644
--- a/fs/configfs/configfs_internal.h
+++ b/fs/configfs/configfs_internal.h
@@ -63,7 +63,7 @@ extern spinlock_t configfs_dirent_lock;
 
 extern struct kmem_cache *configfs_dir_cachep;
 
-extern int configfs_is_root(struct config_item *item);
+extern bool configfs_is_root(struct config_item *item);
 
 extern struct inode * configfs_new_inode(umode_t mode, struct configfs_dirent *, struct super_block *);
 extern struct inode *configfs_create(struct dentry *, umode_t mode);
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 4929f343118946eaa55a539db4192e9c6621a8dc..88da7b428e52f2f4ab139ad3907101f685d617b1 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -47,9 +47,14 @@ static struct config_group configfs_root_group = {
 	},
 };
 
-int configfs_is_root(struct config_item *item)
+bool configfs_is_root(struct config_item *item)
 {
-	return item == &configfs_root_group.cg_item;
+	struct configfs_dirent *sd;
+
+	if (!item->ci_dentry)
+		return false;
+	sd = item->ci_dentry->d_fsdata;
+	return !!(sd->s_type & CONFIGFS_ROOT);
 }
 
 static struct configfs_dirent configfs_root = {

-- 
2.51.0


