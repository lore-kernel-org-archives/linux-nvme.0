Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C399CD98C5
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Jun 2026 11:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=enu0oEF3LXmeUPjGHZKMvCmWJka+oA1qiFhWuHovgvA=; b=xK390DBHXRsSc5XMy5L4jgorAC
	yETWDpOuukmxqyHJSqeaE8m7XSmRnepJu4Jw4h4RBEKlemi4JyIqlYt+JtRcWcGwQbvBgRrYIvPf9
	1LOCyxs8kI+5wd2ACYQaY84HFu3KQ8Q2zmZQxSmQAt2EPHXAdVtoHbjc8cUIbm/j3DMhePqRJhYus
	UOzRZTHYUVQEmAnxoI8Ve9DeglQAZ5qYNXRYd7OgrUgmaZC33dbvU/lPrul3geDMndD2iXBJznFti
	ypBh2volrHon96Y19joX4gM5Lm60IN05cvLYvBI7TM2KC2FB6elWEbdNyZxEAQnbrAzO+PheBgN7f
	R/eW3BNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYMKG-0000000CE2Y-3BWd;
	Sat, 13 Jun 2026 11:14:56 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYMKF-0000000CE1v-23mt
	for linux-nvme@lists.infradead.org;
	Sat, 13 Jun 2026 11:14:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EE715601F2;
	Sat, 13 Jun 2026 11:14:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313691F000E9;
	Sat, 13 Jun 2026 11:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781349294;
	bh=enu0oEF3LXmeUPjGHZKMvCmWJka+oA1qiFhWuHovgvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YDgTWQqDn3JC+QLsuyzCnHN+nYoVvw54BXEw+g3gFhchqAyIhdZhVbMPH2PVU1AnR
	 OQqXrcL8IMyCrwwjyaiKVzHRg2v+WUmzUS86hBk4FEOfrqe3iUO+qkJBfVk4zz/lR/
	 lM4295g5lCapZWBRVIphYb2HkJ96FrrxYcqXKYP68k8C+DIyhytvHy/W3YoANriruf
	 fqjzQ1/18e9IQ6zbAUhjpMjl6qC45zkKxf8ZYeAE2VWd1hx9JUPSGn3s3fYeaOWzmm
	 imvQ1nHczCUQrRj2cEDVhmXRjaIvvsIY0fhwVeqrvz+37VE8P/TKQ9XZQpULd6MoAr
	 Y2cCefYJzQOfg==
From: Hannes Reinecke <hare@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 4/8] fs/namespace: implement mnt_clone_direct()
Date: Sat, 13 Jun 2026 13:14:33 +0200
Message-ID: <20260613111437.101763-5-hare@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260613111437.101763-1-hare@kernel.org>
References: <20260613111437.101763-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index fe919abd2f01..dfde8e3c7131 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1477,6 +1477,17 @@ struct vfsmount *mnt_clone_internal(const struct path *path)
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
index acfe7ef86a1b..7e7e7d66c302 100644
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


