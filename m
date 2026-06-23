Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A77CDB46F
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2026 09:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KBSboo+CA2yUF+AF4ifaQTvIYsLyMTeWL8AkYviRzUU=; b=SvKyMp1v2SCyxl6MRY3fVTGA88
	Rv277MkLEZkO+kCNabEgWDD2aNvPquJGk7/mSjwVTSHbgybP9MQyPsFXaow4jXtwly5TBM5pCwdML
	eerHu7biSt8D9QOeoYSRjbsejRnxeEhd/tayhKbYxZVh6k8PvVq8LXtvEMBlPklBydXnNoLaHTGKJ
	KU9IDl9i9QiU0RkV4NAt4yJmFFwYiL63SBKfigOcTtl0IvELptqZqCleaaJaa6fKTPoddKkrQOi7I
	64XTn6HEcRVu1ZXXOmI8TWIo2Ep+IDr9Zm+aORuqhExXxa81Z8BCESTM++dnieROMZyiqM92TyzsD
	cZuzjbhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbxEz-00000005zNU-0GKY;
	Tue, 23 Jun 2026 09:16:21 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbxEx-00000005zM4-2oXR
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jun 2026 09:16:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 21D5260212;
	Tue, 23 Jun 2026 09:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D8D1F00A3A;
	Tue, 23 Jun 2026 09:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782206178;
	bh=KBSboo+CA2yUF+AF4ifaQTvIYsLyMTeWL8AkYviRzUU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JaQ1tPrGYir00Nr8NuXwjW5F4YWHELuYwLyYX7hjYHu55xpypjus6i6tgZXOOmzPa
	 LsO1ibpjvRbl69HfV8JYVygYfDGn4Vp9hzfdMTUMyBtFAZtOs4a2we5n4T+1VX8uXg
	 waUlkiQvw9gyB00Q5Guyqpvuk7ktfPw5tQ0Mq/VF7Dl3nenMM8512jRpenbPYEIva1
	 ++mV3bg/S6BIE33Ic7p0ghrbiWHwnfNZZo09Rol7/nqt1fiUxmHPuvbRxRFcDDhRcZ
	 SO9Hyfw0u9bZVmZirE7XuKzIyiRK50IaDNT/626HYpmJk8hK4CuUJ4J2SEkl5Y1xQJ
	 69Srd6fbmASUg==
From: Hannes Reinecke <hare@kernel.org>
Date: Tue, 23 Jun 2026 11:15:51 +0200
Subject: [PATCH RFC v3 06/12] fs/namespace: implement mnt_clone_direct()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-configfs-ns-v3-6-841c100fd5dd@kernel.org>
References: <20260623-configfs-ns-v3-0-841c100fd5dd@kernel.org>
In-Reply-To: <20260623-configfs-ns-v3-0-841c100fd5dd@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782206158; l=1649;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=pIunaHgmEA4Zdll7x1jJRRd3E+yXa2T7gixz2iydD8o=;
 b=D2VnHbmfHK0vvxHmec368YA3MKqEo4rqBgcpqsA5fPGYQ1sLr98wGhHgB9fPC8ElzMrfW76Iy
 R2AFEJY+Hm1Bc7vCqSSFdIzJo54Bvn54vLqugGwQtwyLAhcuxuR2dYO
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

Implement mnt_clone_direct() to just clone an existing vfsmount.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 fs/namespace.c        | 11 +++++++++++
 include/linux/mount.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 3d5cd5bf3b05376c867281541100c6a5e599d387..e7abbf632cc70d70547e4a2483f2217c95cc0c48 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1482,6 +1482,17 @@ struct vfsmount *mnt_clone_internal(const struct path *path)
 	return &p->mnt;
 }
 
+struct vfsmount *mnt_clone_direct(struct vfsmount *mnt, struct dentry *dentry)
+{
+	struct mount *p;
+
+	p = clone_mnt(real_mount(mnt), dentry, CL_SLAVE);
+	if (IS_ERR(p))
+		return ERR_CAST(p);
+	p->mnt.mnt_flags |= MNT_INTERNAL;
+	return &p->mnt;
+}
+
 /*
  * Returns the mount which either has the specified mnt_id, or has the next
  * smallest id afer the specified one.
diff --git a/include/linux/mount.h b/include/linux/mount.h
index acfe7ef86a1b3fdd70ab460e6e731d3c532b6487..7e7e7d66c3024b907497954a247c7e35dbcfc946 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -75,6 +75,7 @@ extern void mnt_drop_write_file(struct file *file);
 extern void mntput(struct vfsmount *mnt);
 extern struct vfsmount *mntget(struct vfsmount *mnt);
 extern void mnt_make_shortterm(struct vfsmount *mnt);
+extern struct vfsmount *mnt_clone_direct(struct vfsmount *mnt, struct dentry *dentry);
 extern struct vfsmount *mnt_clone_internal(const struct path *path);
 extern bool __mnt_is_readonly(const struct vfsmount *mnt);
 extern bool mnt_may_suid(struct vfsmount *mnt);

-- 
2.51.0


